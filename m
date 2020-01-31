Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B791C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 16:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33AB6214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 16:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580488995;
	bh=hHKzqvOSq4QPPeuz3N7dN9CkLNuC6IH23w3s//vJPHI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=eE2cXGZ/+f+vR3JN9UyOQ8s7OKLTreQ5Y3UVg8fbZ0RjvPyFUWItzY7UPrK9hcknZ
	 jTrI2XZ9IAfDg2oUQqMp7DTSlHsa73WFkYMzdZCBHi0tl7qsfNgvQPnovNP+3Lfatc
	 57C5en53CGHxBk9k9Ts5e4+ErKJj6n3dLfqdUrcY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgAaQnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 11:43:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:32926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbgAaQnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 11:43:14 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0E5D206F0;
        Fri, 31 Jan 2020 16:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580488993;
        bh=hHKzqvOSq4QPPeuz3N7dN9CkLNuC6IH23w3s//vJPHI=;
        h=Date:From:To:Cc:Subject:From;
        b=w7kEy2wVsluR4k+4Rv29HNE3tkubymRytuEWPimy6JuRNvHwhJnYEJRXwIzzwK94t
         8BDJUquBWk56MX8621sOD8nBKcddW/b0DAR0QAuMdPPgDFGC0k8Xhy1qhCBeEwrujX
         3HgMI7u/emGPflroz8i/KAkZrR/5UnApSE1yRdjw=
Date:   Fri, 31 Jan 2020 16:43:09 +0000
From:   Will Deacon <will@kernel.org>
To:     edumazet@google.com, tglx@linutronix.de, paulmck@kernel.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: Confused about hlist_unhashed_lockless()
Message-ID: <20200131164308.GA5175@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I just ran into c54a2744497d ("list: Add hlist_unhashed_lockless()")
but I'm a bit confused about what it's trying to achieve. It also seems
to have been merged without any callers (even in -next) -- was that
intentional?

My main source of confusion is the lack of memory barriers. For example,
if you look at the following pair of functions:


static inline int hlist_unhashed_lockless(const struct hlist_node *h)
{
	return !READ_ONCE(h->pprev);
}

static inline void hlist_add_before(struct hlist_node *n,
				    struct hlist_node *next)
{
	WRITE_ONCE(n->pprev, next->pprev);
	WRITE_ONCE(n->next, next);
	WRITE_ONCE(next->pprev, &n->next);
	WRITE_ONCE(*(n->pprev), n);
}


Then running these two concurrently on the same node means that
hlist_unhashed_lockless() doesn't really tell you anything about whether
or not the node is reachable in the list (i.e. there is another node
with a next pointer pointing to it). In other words, I think all of
these outcomes are permitted:

	hlist_unhashed_lockless(n)	n reachable in list
	0				0 (No reordering)
	0				1 (No reordering)
	1				0 (No reordering)
	1				1 (Reorder first and last WRITE_ONCEs)

So I must be missing some details about the use-case here. Please could
you enlighten me? The RCU implementation permits only the first three
outcomes afaict, why not use that and leave non-RCU hlist as it was?

Cheers,

Will
