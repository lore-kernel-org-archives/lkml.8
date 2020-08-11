Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FA9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 12:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A08D2076B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 12:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgHKMwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 08:52:36 -0400
Received: from gentwo.org ([3.19.106.255]:35610 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbgHKMwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 08:52:35 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 15CC43F447; Tue, 11 Aug 2020 12:52:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 1310B3F043;
        Tue, 11 Aug 2020 12:52:35 +0000 (UTC)
Date:   Tue, 11 Aug 2020 12:52:35 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Pekka Enberg <penberg@gmail.com>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        Xunlei Pang <xlpang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 1/2] mm/slub: Introduce two counters for the partial
 objects
In-Reply-To: <CAOJsxLGqrCTgQhdOTTWKcCz0TsVfh_AxTCVWNGj6Mo4hyE5E2Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2008111250170.86069@www.lameter.com>
References: <1593678728-128358-1-git-send-email-xlpang@linux.alibaba.com> <a53f9039-5cba-955b-009e-12e8c5ffb345@suse.cz> <CAOJsxLHX62P0yvHZcXdje41zm_2demzTraqvHXAvfhVPp2HKsA@mail.gmail.com> <alpine.DEB.2.22.394.2008071258020.55871@www.lameter.com>
 <CAOJsxLGqrCTgQhdOTTWKcCz0TsVfh_AxTCVWNGj6Mo4hyE5E2Q@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Aug 2020, Pekka Enberg wrote:

> Why do you consider this to be a fast path? This is all partial list
> accounting when we allocate/deallocate a slab, no? Just like
> ___slab_alloc() says, I assumed this to be the slow path... What am I
> missing?

I thought these were per object counters? If you just want to count the
number of slabs then you do not need the lock at all. We already have a
counter for the number of slabs.

> No objections to alternative fixes, of course, but wrapping the
> counters under CONFIG_DEBUG seems like just hiding the actual issue...

CONFIG_DEBUG is on by default. It just compiles in the debug code and
disables it so we can enable it with a kernel boot option. This is because
we have had numerous issues in the past with "production" kernels that
could not be recompiled with debug options. So just running the prod
kernel with another option will allow you to find hard to debug issues in
a full scale producton deployment with potentially proprietary modules
etc.

