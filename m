Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253B2C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5849214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="k0UgxfLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgHZO6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:58:32 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37835 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbgHZO6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:58:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Bc8BD4W0sz9sTj;
        Thu, 27 Aug 2020 00:58:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1598453909;
        bh=892/U6xU/zXzNeaF88c010Kk8eMNVMf1LHOMRICOCNo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=k0UgxfLHuY+25qrK+FhYOHDSjva/DV0RO9s8C6oopeFcoxsBe6MAuCxvJy4IIRv3D
         yLE1b+tMZRFspqxJVmLe7lFGPoL0u9oHNnva80oC5Zn4exvh+mRcwtNZW3aWfnXhK7
         lIECUS1fa/iFQijprpyacT0HJ+Op0ez3UAQA9mcR4ybDdSGOZ3izGLvlGl1YesFVbj
         CLedfwFUXk2re6j53FdonZApyp9qX4EU07rgEYHZx5yyew08SZJyaJccElwfRNR4CX
         eWCVkGo9PLjzcI0EFEo0YsASKmq5jG3TEydWoeKDuRGrv8aq6fDhy7IQ3y2UxAbhwb
         V3a4UTj78rdjw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1 4/9] powerpc/vdso: Remove unnecessary ifdefs in vdso_pagelist initialization
In-Reply-To: <834f362626e18bc36226f46ed4113c461a3ad032.1598363608.git.christophe.leroy@csgroup.eu>
References: <df48ed76cf8a756a7f97ed42a1a39d0a404014bc.1598363608.git.christophe.leroy@csgroup.eu> <834f362626e18bc36226f46ed4113c461a3ad032.1598363608.git.christophe.leroy@csgroup.eu>
Date:   Thu, 27 Aug 2020 00:58:26 +1000
Message-ID: <87ft89h2st.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
> index daef14a284a3..bbb69832fd46 100644
> --- a/arch/powerpc/kernel/vdso.c
> +++ b/arch/powerpc/kernel/vdso.c
> @@ -718,16 +710,14 @@ static int __init vdso_init(void)
...
>  
> -
> -#ifdef CONFIG_VDSO32
>  	vdso32_kbase = &vdso32_start;
>  
>  	/*
> @@ -735,8 +725,6 @@ static int __init vdso_init(void)
>  	 */
>  	vdso32_pages = (&vdso32_end - &vdso32_start) >> PAGE_SHIFT;
>  	DBG("vdso32_kbase: %p, 0x%x pages\n", vdso32_kbase, vdso32_pages);
> -#endif

This didn't build for ppc64le:

  /opt/cross/gcc-8.20_binutils-2.32/powerpc64-unknown-linux-gnu/bin/powerpc64-unknown-linux-gnu-ld: arch/powerpc/kernel/vdso.o:(.toc+0x0): undefined reference to `vdso32_end'
  /opt/cross/gcc-8.20_binutils-2.32/powerpc64-unknown-linux-gnu/bin/powerpc64-unknown-linux-gnu-ld: arch/powerpc/kernel/vdso.o:(.toc+0x8): undefined reference to `vdso32_start'
  make[1]: *** [/scratch/michael/build/maint/Makefile:1166: vmlinux] Error 1
  make: *** [Makefile:185: __sub-make] Error 2

So I just put that ifdef back.

cheers
