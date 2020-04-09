Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4739AC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 16:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D0C20753
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 16:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgDIQP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 12:15:29 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:41152 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbgDIQP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 12:15:29 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23994898AbgDIQP1Q4MN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org> + 1 other);
        Thu, 9 Apr 2020 18:15:27 +0200
Date:   Thu, 9 Apr 2020 17:15:27 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
cc:     YunQiang Su <wzssyqa@gmail.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips <linux-mips@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH] MIPS: Limit check_bugs32() under CONFIG_32BIT
In-Reply-To: <7A98E39B-EDCF-496D-9525-0160A368361B@flygoat.com>
Message-ID: <alpine.LFD.2.21.2004091704570.596385@eddie.linux-mips.org>
References: <1586401829-22242-1-git-send-email-yangtiezhu@loongson.cn> <CAKcpw6XywbOs-rh5ko0uz9vLz9nkgrJ0LiRTSkQQaU9dZbg7oQ@mail.gmail.com> <20200409150923.5b224361@flygoat-x1e> <alpine.LFD.2.21.2004091540450.596385@eddie.linux-mips.org>
 <7A98E39B-EDCF-496D-9525-0160A368361B@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Apr 2020, Jiaxun Yang wrote:

> > Why is using Kconfig supposed to be better?  Several configurations 
> >support multiple processor types (e.g. swappable CPU daugthercards or
> >FPGA 
> >soft-cores) and having to list CPU types across platforms as CPUs are 
> >added is going to be a maintenance nightmare.  Whereas having
> >workarounds 
> >or panics associated with run-time determination of the actual CPU type
> >
> >guarantees they will trigger where necessary.  The use of `init'
> >sections 
> >assures the reclaim of memory for use after bootstrap.
> 
> Actually I meant let bug checks depends on Kconfig's CPU selection.
> 
> It's guaranteed that you can only select one kind of CPU one time,
> to prevent the overhead of checking bugs on irrelevant processors.

 That makes no sense to me sorry.  When you select say a MIPS32r2 CPU for 
a Malta configuration, you can run it with a 4KE, 24K, 24KE, 34K, 74K, 
1004K, M14K, and probably a few other CPUs I have forgotten about.  Are 
you suggesting now that you want to require a separate kernel 
configuration for each of these CPUs?

> And we still have to check PRID/CPUTYPE during boot to enable
> proper workarounds, because the Kconfig options are telling about the possibility,
> which means a processor potentially has some kinds of bug.
> 
> In this case, M34K's errata should depends on or selected by 
> CPU_MIPS32_R2 in Kconfig.
> 
> So there won't be any nightmare, but only reduced code :-)

 You'll need to manually maintain CPU assignment to configurations, which 
is not needed now.

 Anyway, please show your patch to let us see any improvement brought by 
it and we can discuss it then.

  Maciej
