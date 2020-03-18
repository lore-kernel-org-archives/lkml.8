Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75CAC10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D89620757
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pVCUV9xK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgCRSFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 14:05:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59984 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgCRSFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 14:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3lxbSHPSpczSPFKFN2dQCzE+1ezVIPKjlI0fNsiPOb0=; b=pVCUV9xKi5LTbEfAtBIhzqrxRL
        RpOI22dH3CuzwYht8TEyhdJ+0AiAH/qjvV4DwAcyo75nE5z07CLo5Zui88LLBZo1aRplo3Yn95IkT
        S5Y6UiqhR1Brlh1au6sX2e95Z2qzT3ZcVEUPQw+ET0dTN5auvSc8Pasc/aOMwoAFYynF/Bl/3NePW
        VkZWNG59TIE5ruuO6U0fDqKxbrDwBD3eFOXDHnH32SmlHKPh6D7hdpyvV/yc4DhQIyBVyAnVVbnd6
        E+Cq05BQXCjibLLA+TMuSLJBy7P7Dxyx46rarAL/cp6n8MnfxMKx99JouDg/XSvVcpNFrYOEXxjqC
        BrZLsK8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEd4U-0000qh-K7; Wed, 18 Mar 2020 18:05:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 732163010C2;
        Wed, 18 Mar 2020 19:05:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5CEC0284DBF7A; Wed, 18 Mar 2020 19:05:35 +0100 (CET)
Date:   Wed, 18 Mar 2020 19:05:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Andi Kleen <andi@firstfloor.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] perf/core: install cgroup events to correct cpuctx
Message-ID: <20200318180535.GJ20730@hirez.programming.kicks-ass.net>
References: <20200122195027.2112449-1-songliubraving@fb.com>
 <20200124091552.GB14914@hirez.programming.kicks-ass.net>
 <83AF3F97-7F98-4D52-A230-F04A0AB67284@fb.com>
 <7BA78C8F-9D71-4BDB-BCCE-3036DCF3C653@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7BA78C8F-9D71-4BDB-BCCE-3036DCF3C653@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 07:07:29AM +0000, Song Liu wrote:
> Hi Peter, 
> 
> > On Mar 5, 2020, at 11:48 PM, Song Liu <songliubraving@fb.com> wrote:
> > 
> > 
> > 
> >> On Jan 24, 2020, at 1:15 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> >> 
> >> On Wed, Jan 22, 2020 at 11:50:27AM -0800, Song Liu wrote:
> >>> cgroup events are always installed in the cpuctx. However, when it is not
> >>> installed via IPI, list_update_cgroup_event() adds it to cpuctx of current
> >>> CPU, which triggers the following with CONFIG_DEBUG_LIST:
> >>> 
> >> 
> >>> [   31.777570] list_add double add: new=ffff888ff7cf0db0, prev=ffff888ff7ce82f0, next=ffff888ff7cf0db0.
> >> 
> >>> To reproduce this, we can simply run:
> >>> perf stat -e cs -a &
> >>> perf stat -e cs -G anycgroup
> >>> 
> >>> Fix this by installing it to cpuctx that contains event->ctx, and the
> >>> proper cgrp_cpuctx_list.
> >>> 
> >>> Fixes: db0503e4f675 ("perf/core: Optimize perf_install_in_event()")
> >>> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >>> Cc: Andi Kleen <andi@firstfloor.org>
> >>> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> >>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> >>> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> >>> Cc: Jiri Olsa <jolsa@redhat.com>
> >>> Cc: Namhyung Kim <namhyung@kernel.org>
> >>> Cc: Thomas Gleixner <tglx@linutronix.de>
> >>> Signed-off-by: Song Liu <songliubraving@fb.com>
> >> 
> >> Thanks!
> > 
> > I just realized this won't fully fix the problem, because later in 
> > list_update_cgroup_event() we use "current":
> > 
> > 	struct perf_cgroup *cgrp = perf_cgroup_from_task(current, ctx);
> 
> Could you please share your thoughts on this? I think we cannot use current
> in list_update_cgroup_event(), unless we call it on the target CPU. 

Bah, that cgroup crap is 'wrong'. It's pointless to track the
cpuctx->cgrp state for disabled events.

Let me see if I can unravel that crud.
