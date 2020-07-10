Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628C1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B43120767
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nL1GgAFk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgGJJvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgGJJvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:51:53 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D878C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G4BQT5YZ6inbLMuZQGrLBTNmes4SMbEIAYTL3fFnjd8=; b=nL1GgAFk6IYwBe46ttmYv8O7nG
        rvYyF+J4PaTz0D//ecTD3ylx6iQsEMH40ZQVIQnOT5shMx9mlu4Qkp1+y41jDZTy3TSugnuWrQWwa
        VaYPREM9p8qY0Yeva7s5Q3XifD25hLBngkCeixWsKCX0ulLyBJw2KFPJTEXanblmaKvPeNce4GBFb
        rnqejhBoZgr62cr7KiT7SSERVKhauR6NGMdmMgeqwZP5m0LfXSBDxd/z4joIO8E/DDVf8sS5UFo3c
        AyxwnW8EMLFYScEGknbWt5edrDAoKvodIM9MDrgtsaeFOHG2PdeQddBALrD50EBwKcm/iYx7P1zHw
        tpJduwNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtph3-0007iQ-Tm; Fri, 10 Jul 2020 09:51:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 793083003E5;
        Fri, 10 Jul 2020 11:51:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0C3802B515301; Fri, 10 Jul 2020 11:51:44 +0200 (CEST)
Date:   Fri, 10 Jul 2020 11:51:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>, x86 <x86@kernel.org>
Subject: Re: [tip: perf/core] x86/cpufeatures: Add Architectural LBRs feature
 bit
Message-ID: <20200710095144.GC4800@hirez.programming.kicks-ass.net>
References: <1593780569-62993-2-git-send-email-kan.liang@linux.intel.com>
 <159420191583.4006.10876391642907607745.tip-bot2@tip-bot2>
 <e231263a-76f8-326a-ae47-0ae785137c9a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e231263a-76f8-326a-ae47-0ae785137c9a@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 04:00:48PM -0700, Dave Hansen wrote:
> On 7/8/20 2:51 AM, tip-bot2 for Kan Liang wrote:
> > diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> > index 02dabc9..72ba4c5 100644
> > --- a/arch/x86/include/asm/cpufeatures.h
> > +++ b/arch/x86/include/asm/cpufeatures.h
> > @@ -366,6 +366,7 @@
> >  #define X86_FEATURE_MD_CLEAR		(18*32+10) /* VERW clears CPU buffers */
> >  #define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* "" TSX_FORCE_ABORT */
> >  #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
> > +#define X86_FEATURE_ARCH_LBR		(18*32+19) /* Intel ARCH LBR */
> >  #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
> >  #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
> >  #define X86_FEATURE_FLUSH_L1D		(18*32+28) /* Flush L1D cache */
> 
> Are architectural LBRs useful *without* XSAVE?  If not, should we add an
> entry in arch/x86/kernel/cpu/cpuid-deps.c::cpuid_deps[] for this?

Yes, look at patch 22, without the XSAVE thing it'll fall back to poking
at MSRs lots.
