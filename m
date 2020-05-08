Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD996C47255
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4405218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgEHVfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 17:35:55 -0400
Received: from gentwo.org ([3.19.106.255]:33674 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbgEHVfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 17:35:55 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 98CBA3FED9; Fri,  8 May 2020 21:35:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 9788F3ED24;
        Fri,  8 May 2020 21:35:54 +0000 (UTC)
Date:   Fri, 8 May 2020 21:35:54 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Roman Gushchin <guro@fb.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/19] mm: slub: implement SLUB version of
 obj_to_index()
In-Reply-To: <20200504182922.GA20009@carbon.dhcp.thefacebook.com>
Message-ID: <alpine.DEB.2.22.394.2005082130570.65713@www.lameter.com>
References: <20200422204708.2176080-5-guro@fb.com> <alpine.DEB.2.21.2004222349280.20021@www.lameter.com> <20200423000530.GA63356@carbon.lan> <alpine.DEB.2.21.2004250208500.7624@www.lameter.com> <20200425024625.GA107755@carbon.lan>
 <alpine.DEB.2.21.2004271618340.27701@www.lameter.com> <20200427164638.GC114719@carbon.DHCP.thefacebook.com> <alpine.DEB.2.21.2004301625490.1693@www.lameter.com> <20200430171558.GA339283@carbon.dhcp.thefacebook.com> <alpine.DEB.2.22.394.2005022353330.1987@www.lameter.com>
 <20200504182922.GA20009@carbon.dhcp.thefacebook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 May 2020, Roman Gushchin wrote:

> On Sat, May 02, 2020 at 11:54:09PM +0000, Christoph Lameter wrote:
> > On Thu, 30 Apr 2020, Roman Gushchin wrote:
> >
> > > Sorry, but what exactly do you mean?
> >
> > I think the right approach is to add a pointer to each slab object for
> > memcg support.
> >
>
> As I understand, embedding the memcg pointer will hopefully make allocations
> cheaper in terms of CPU, but will require more memory. And you think that
> it's worth it. Is it a correct understanding?

It definitely makes the code less complex. The additional memory is
minimal. In many cases you have already some space wasted at the end of
the object that could be used for the pointer.

> Can you, please, describe a bit more detailed how it should be done
> from your point of view?

Add it to the metadata at the end of the object. Like the debugging
information or the pointer for RCU freeing.

> I mean where to store the pointer, should it be SLAB/SLUB-specific code
> or a generic code, what do to with kmallocs alignments, should we
> merge slabs which had a different size before and now have the same
> because of the memcg pointer and aligment, etc.

Both SLAB and SLUB have the same capabilities there. Slabs that had
different sizes before will now have different sizes as well. So the
merging does not change.

> I'm happy to follow your advice and perform some tests to get an idea of
> how significant the memory overhead is and how big are CPU savings.
> I guess with these numbers it will be easy to make a decision.

Sure. The main issue are the power of two kmalloc caches and how to add
the pointer to these caches in order not to waste memory. SLAB has done
this in the past by creating additional structues in a page frame.


