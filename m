Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF46DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 21:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD80F2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 21:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgEOVpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 17:45:31 -0400
Received: from gentwo.org ([3.19.106.255]:33900 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbgEOVpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 17:45:31 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id D25713EBE5; Fri, 15 May 2020 21:45:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id D01E83EA5E;
        Fri, 15 May 2020 21:45:30 +0000 (UTC)
Date:   Fri, 15 May 2020 21:45:30 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Roman Gushchin <guro@fb.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/19] mm: slub: implement SLUB version of
 obj_to_index()
In-Reply-To: <20200513005741.GA67541@carbon.dhcp.thefacebook.com>
Message-ID: <alpine.DEB.2.22.394.2005152142570.119998@www.lameter.com>
References: <20200423000530.GA63356@carbon.lan> <alpine.DEB.2.21.2004250208500.7624@www.lameter.com> <20200425024625.GA107755@carbon.lan> <alpine.DEB.2.21.2004271618340.27701@www.lameter.com> <20200427164638.GC114719@carbon.DHCP.thefacebook.com>
 <alpine.DEB.2.21.2004301625490.1693@www.lameter.com> <20200430171558.GA339283@carbon.dhcp.thefacebook.com> <alpine.DEB.2.22.394.2005022353330.1987@www.lameter.com> <20200504182922.GA20009@carbon.dhcp.thefacebook.com> <alpine.DEB.2.22.394.2005082130570.65713@www.lameter.com>
 <20200513005741.GA67541@carbon.dhcp.thefacebook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020, Roman Gushchin wrote:

> > Add it to the metadata at the end of the object. Like the debugging
> > information or the pointer for RCU freeing.
>
> Enabling debugging metadata currently disables the cache merging.
> I doubt that it's acceptable to sacrifice the cache merging in order
> to embed the memcg pointer?

Well then keep the merging even if you have a memcg pointer.

The disabling for debugging is only to simplify debugging. You dont have
to deal with multiple caches actually using the same storage structures.

> Figuring out all these details will likely take several weeks, so the whole
> thing will be delayed for one-two major releases (in the best case). Given that
> the current implementation saves ~40% of slab memory, I think there is some value
> in delivering it as it is. So I wonder if the idea of embedding the pointer
> should be considered a blocker, or it can be implemented of top of the proposed
> code (given it's not a user-facing api or something like this)?

Sorry no idea from my end here.

