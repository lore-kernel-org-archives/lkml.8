Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F37C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 16:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949D920656
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 16:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgCGQOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 11:14:52 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:49562 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgCGQOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 11:14:52 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 03AA08050E;
        Sat,  7 Mar 2020 17:14:46 +0100 (CET)
Date:   Sat, 7 Mar 2020 17:14:45 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     tang pengchuan <kevin3.tang@gmail.com>
Cc:     Emil Velikov <emil.l.velikov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Dave Airlie <airlied@linux.ie>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Orson Zhai <orsonzhai@gmail.com>, Sean Paul <sean@poorly.run>
Subject: Re: [PATCH RFC v4 4/6] drm/sprd: add Unisoc's drm display controller
 driver
Message-ID: <20200307161445.GA7524@ravnborg.org>
References: <1582710377-15489-1-git-send-email-kevin3.tang@gmail.com>
 <1582710377-15489-5-git-send-email-kevin3.tang@gmail.com>
 <CACvgo53dME1ioYebimSzdOMvjAudtmzpz_-5Q7rNqQnZoBpaqA@mail.gmail.com>
 <CAFPSGXaN1SHCK1QqEca3XcYxTV45fdRBzj5KejW6zr3z4dx_aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFPSGXaN1SHCK1QqEca3XcYxTV45fdRBzj5KejW6zr3z4dx_aw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=XpTUx2N9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=OIW1Wx_ocpC4raMFu88A:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin

> > > +
> > > +ifdef CONFIG_ARM64
> > > +KBUILD_CFLAGS += -mstrict-align
> >
> >
> > There are many other drivers that do not use readl/writel for register access,
> > yet none has this workaround... Even those that they are exclusively ARM64.
> >
> > Have you tried that it's not a buggy version of GCC? At the very least, I'd
> > encourage you to add a brief comment about the problem + setup.
> >
> > ... In general I think one should follow the suggestions from Rob Herring.
> >
> Yocto v2.5
> aarch64-linaro-linux-gcc (Linaro GCC 7.2-2017.11) 7.2.1 20171011
> 
> Crash Stack:
> /sprd/drv/dispc/dpu_r2p0.c:729
> 1796256 ffffff8008486650:       f803c043        stur    x3, [x2,#60]
> =>Unhandled fault: alignment fault (0x96000061) at 0xffffff80098b883c
> 
> 729         reg->mmu_min_ppn1 = 0;
> 730         reg->mmu_ppn_range1 = 0xffff;
> 731         reg->mmu_min_ppn2 = 0;
> 732         reg->mmu_ppn_range2 = 0xffff;
> 
> The above C code operation are continuous. The compiler may think that
> the access can be completed by directly using two 64-bit assignment
> operations, so it is optimized to 64-bit operation.

What you see is a side-effect of using a sturct for register access.
When you ave your code change to use readl()/writel() and friends
this is no logner a problem, and you can drop the cc flag.

	Sam
