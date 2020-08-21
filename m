Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D85C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6356020714
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgHUTb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:31:27 -0400
Received: from orcam.me.uk ([81.187.245.177]:40872 "EHLO orcam.me.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgHUTb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:31:27 -0400
X-Greylist: delayed 478 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Aug 2020 15:31:26 EDT
Received: from bugs.linux-mips.org (eddie.linux-mips.org [IPv6:2a01:4f8:201:92aa::3])
        by orcam.me.uk (Postfix) with ESMTPS id 688F72BE086;
        Fri, 21 Aug 2020 20:23:17 +0100 (BST)
Date:   Fri, 21 Aug 2020 20:23:16 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Paul Cercueil <paul@crapouillou.net>
cc:     Zhou Yanjie <zhouyanjie@wanyeetech.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, od@zcrc.me,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        =?UTF-8?B?5ryG6bmP5oyv?= <aric.pzqi@ingenic.com>,
        dongsheng.qiu@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, xuwanhao@wanyeetech.com
Subject: Re: [PATCH 00/13] MIPS: Convert Ingenic to a generic board
In-Reply-To: <L8DPEQ.71Z8YA0QXBJA@crapouillou.net>
Message-ID: <alpine.LFD.2.21.2008211949220.3460685@eddie.linux-mips.org>
References: <20200803170124.231110-1-paul@crapouillou.net>        <ab985296-8441-4006-210d-a71503bd01f0@wanyeetech.com> <L8DPEQ.71Z8YA0QXBJA@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Aug 2020, Paul Cercueil wrote:

> > I'm not too sure if remove "cpu-feature-overrides.h" will cause some
> > problems for X2000, because according to my current test on X2000, I found
> > that it is somewhat different from the SoCs using XBurst1 CPU core, with the
> > kernel source code provided by Ingenic, for example, we must configure
> > "#define cpu_has_tlbinv 1" in "cpu-feature-overrides.h" to make the X2000
> > work normally, otherwise the kernel will get stuck. And X2000's interrupt
> > controller has also been redesigned. If these differences make it impossible
> > to share code, should we set a subdirectory of "xburst" and "xburst2" in
> > "arch/mips/ingenic"? (I am just worried about this situation, so far I have
> > not been able to successfully run the mainline kernel on X2000).
> 
> The <cpu-feature-overrides.h> is kind of a hack, to hardcode settings in case
> the CPU is not properly detected. The cpu-probe.c should be able to
> auto-detect these settings, including the inverted TLB that the X2000 has,
> reading from the CPU config registers ("TLB INV" info should be in config4).
> Right now cpu_probe_ingenic() doesn't read config4 (not present on older SoCs)
> but that's trivial to add.

 FAOD <cpu-feature-overrides.h> is not a hack, but an optimisation measure 
so that features known to be hardwired for a given machine/CPU do not have 
to be dynamically queried every time referred.  In some cases that results 
in large portions of code being optimised away by the compiler as well. 

 The hardcoded value for a feature defined in <cpu-feature-overrides.h> 
always has to be the same as one in the corresponding bit of the `options' 
member of `struct cpuinfo_mips', in this case MIPS_CPU_TLBINV.

  Maciej
