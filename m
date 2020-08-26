Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7683C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 00:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E64C20786
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 00:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598402580;
	bh=GQlLj22PHNu4N2tC0wyjXvzJ8I9QqXfye6YxJQk0AoI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SKN2iKu07yq3rK8aw+KF83HNwYpv+CbQnS+WpiDzQPXqAg74SkCucgphlUMxm4B+G
	 jFNKk7QDWHAwTCz1SSaQyxNphWGaQfg+sFR70PtqzTHfi1hjq0NFoZ2YvdKA0yXZFu
	 NSL0YqlXJ2aCvyFwktUmJ6oXWpQri5NBpj8UyHGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgHZAm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 20:42:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbgHZAm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 20:42:58 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0049A2074A;
        Wed, 26 Aug 2020 00:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598402578;
        bh=GQlLj22PHNu4N2tC0wyjXvzJ8I9QqXfye6YxJQk0AoI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OxYZSN59BtoftXpHxY2VztXYGvH7IvTYtN7mbBPS/DtafZaujOxpL7Tk5uQSKIuc3
         gZsUpzoMJhC3HvsUMPwoZu3veTLFPErcRXGX3asPMRUK22zZEx/lPNQfrklr/ek5Fr
         bax8IkLeW5HbCKNyrxIK+QndxGbWYdXHimqKbgqo=
Date:   Tue, 25 Aug 2020 17:42:57 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        kernel-team@lge.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH for v5.9] mm/page_alloc: handle a missing case for
 memalloc_nocma_{save/restore} APIs
Message-Id: <20200825174257.5b48a5dd24b5e08a915b101e@linux-foundation.org>
In-Reply-To: <CAAmzW4MYQsRoR-q8tUmwPYLvCbiMq_zt19_AgorAQHnbwnu37g@mail.gmail.com>
References: <1598331582-19923-1-git-send-email-iamjoonsoo.kim@lge.com>
        <20200824221049.edb3c540bbfc859a6806600d@linux-foundation.org>
        <CAAmzW4MYQsRoR-q8tUmwPYLvCbiMq_zt19_AgorAQHnbwnu37g@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Aug 2020 14:34:32 +0900 Joonsoo Kim <js1304@gmail.com> wrote:

> >
> > That's a bunch more code on a very hot path to serve an obscure feature
> > which has a single obscure callsite.
> >
> > Can we instead put the burden on that callsite rather than upon
> > everyone?  For (dumb) example, teach __gup_longterm_locked() to put the
> > page back if it's CMA and go get another one?
> 
> Hmm... Unfortunately, it cannot ensure that we eventually get the non-CMA page.
> I think that the only way to ensure it is to implement the
> functionality here. We can
> use 'unlikely' or 'static branch' to reduce the overhead for a really
> rare case but
> for now I have no idea how to completely remove the overhead.

Gee, there must be something?  Provide the gup code with a special
entry point which takes the page straight from __rmqueue() and bypasses
the pcp lists?

