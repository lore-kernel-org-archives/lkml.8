Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE9BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D44D5206E2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="EepktTXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgFQIdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 04:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQIdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 04:33:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA10C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 01:33:23 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0bb0009537e5b82667a549.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:b000:9537:e5b8:2667:a549])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 42A401EC03E3;
        Wed, 17 Jun 2020 10:33:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592382802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IZY6q1xLb46Qw2A0y/61CE7mLrcbuaJLnqA/2DXo42k=;
        b=EepktTXRU8hLQXOmORsTXLXG5gkWlapk4a4Mv0/3VWR9m18DJ4wpejAdo2Gnj8rzdrYVHC
        AFtQegr/Ru/HsI3Aq6G4UcuXAfjTZKffZd2gTQryrOcgSDnODy4zu8PHZFYERnkM7VSYmS
        7QvNqgI/FSwHNjXpBtJgeQyQ431za1Q=
Date:   Wed, 17 Jun 2020 10:33:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     x86-ml <x86@kernel.org>, jpa@kernelbug.mail.kapsi.fi,
        Dave Hansen <dave.hansen@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/fpu: Reset MXCSR to default in kernel_fpu_begin()
Message-ID: <20200617083314.GC10118@zn.tnic>
References: <20200616180123.GL13515@zn.tnic>
 <1D569B6B-B8C3-497E-8A74-2E1A3D46299E@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1D569B6B-B8C3-497E-8A74-2E1A3D46299E@amacapital.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 02:17:16PM -0700, Andy Lutomirski wrote:
> We definitely need to sanitize MXCSR for kernel fpu if kernel fpu
> means SSE2. If kernel fpu means x87, we need to fix the fpu control
> word.

Bah, there's no need to beat around the bush - let's just do:

        if (boot_cpu_has(X86_FEATURE_XMM))
                ldmxcsr(MXCSR_DEFAULT);

        if (boot_cpu_has(X86_FEATURE_FPU))
                asm volatile ("fninit");

and be sure that kernel users get a squeaky-clean FPU.

> On x86_64, I suspect the UEFI ABI technically requires a clean x87
> control word too. If we’re willing to declare that the kernel proper
> won’t use x87, then we could shove that into the UEFI code.

Nah, we don't trust the firmware.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
