Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEE9C33CB1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 12:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5200E206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 12:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="NyPxHY1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgARMqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 07:46:10 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:38465 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727459AbgARMqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 07:46:10 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 480HjW0nc3z9s1x;
        Sat, 18 Jan 2020 23:46:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1579351568;
        bh=gqPYNeS2exoxqfo0y6nSLXdl3WItA/rkMscwL22uFjk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NyPxHY1GrZe6EuxL1v7qz8SPgZc7Pibfz+2hurvb+daChsK+3EtjyKLlXUIzCSEj3
         5ctHnFxgvTMJ78ujZoVBJizUpBTRscNkDIA9kw7Vsvr19fg5SmWW5ZjMtBy6zvOCH3
         ESDJLBlE/T1xbP+S3kTmPZUMFoZM5OGo9Nurm5dUBZF/YOWxNGqwMjIscynRnM4qLo
         4ZfcwtUysuagKsHQ+nutZMnYb3+3zAlLlauybF+PWGfDCEzH73TIPja7es70iMC5ky
         WjzApNDUlVcnqmST86U7mmBddd6Hc2mCkBqmH2/Ck5phY23y9bxYyDRiIST4MHH6DK
         DeZvMOOeLmZUA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, dja@axtens.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v5 17/17] powerpc/32s: Enable CONFIG_VMAP_STACK
In-Reply-To: <2e2509a242fd5f3e23df4a06530c18060c4d321e.1576916812.git.christophe.leroy@c-s.fr>
References: <cover.1576916812.git.christophe.leroy@c-s.fr> <2e2509a242fd5f3e23df4a06530c18060c4d321e.1576916812.git.christophe.leroy@c-s.fr>
Date:   Sat, 18 Jan 2020 22:46:13 +1000
Message-ID: <87zhel6iga.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
> index 90ef355e958b..3be041166db4 100644
> --- a/arch/powerpc/kernel/head_32.S
> +++ b/arch/powerpc/kernel/head_32.S
> @@ -272,14 +272,20 @@ __secondary_hold_acknowledge:
>   */
>  	. = 0x200
>  	DO_KVM  0x200
> +MachineCheck:
>  	EXCEPTION_PROLOG_0
> +#ifdef CONFIG_VMAP_STACK
> +	li	r11, MSR_KERNEL & ~(MSR_IR | MSR_RI) /* can take DTLB miss */
> +	mtmsr	r11
> +#endif
>  #ifdef CONFIG_PPC_CHRP
>  	mfspr	r11, SPRN_SPRG_THREAD
> +	tovirt_vmstack(r11, r11)

This didn't build:

    arch/powerpc/kernel/head_32.S:283: Error: syntax error; found `r', expected `,'
    arch/powerpc/kernel/head_32.S:283: Error: found 'r', expected: ')'
    arch/powerpc/kernel/head_32.S:283: Error: bad expression
    arch/powerpc/kernel/head_32.S:283: Error: junk at end of line: `r11,%r11),0xc0000000@h'


I fixed it by dropping the brackets.

cheers
