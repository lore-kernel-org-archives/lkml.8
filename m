Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6092DC47257
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3970120675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="AYudScwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgEEO1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729275AbgEEO1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:27:49 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68BFC061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:27:48 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49Ghrw1s5zz9sTp;
        Wed,  6 May 2020 00:27:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1588688864;
        bh=tKWmkjZzDQuTCUpYsJT44pgEzBrMuLquVBArlnJPTok=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=AYudScwgGeF513DR39+vld/7XBnzPx/RmHX/ZpsMbR2xXEUEL2wuQW4p4g7Kvsisv
         9BkStSD8LskDREEIZEUcnucf5n8bIAP/kQu2rNGVG4fIKIdYaiLi+vc3W32DET/0hz
         5nsmqgrX3/E2FGtgYlYHZLqT5wY+S9qw+8b60lg/xiFk9lQCri05hPLII8zOg03WtG
         PzAzrymQXDPh8UfjPGwC7IuvwSJwXnjW1UDF04L9jrzlQAsxufL0jpsgaVkvW/fPcm
         FkzgDihqutVRnj1lbOzrs8G2my6pLc9rXtAY5CntiQp+YF12WDNjpeIJ+Iwrq2Q2bI
         9B+Cn2SIClkKg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com,
        segher@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 1/2] powerpc/uaccess: Implement unsafe_put_user() using 'asm goto'
In-Reply-To: <23e680624680a9a5405f4b88740d2596d4b17c26.1587143308.git.christophe.leroy@c-s.fr>
References: <23e680624680a9a5405f4b88740d2596d4b17c26.1587143308.git.christophe.leroy@c-s.fr>
Date:   Wed, 06 May 2020 00:27:58 +1000
Message-ID: <87sggecv81.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> unsafe_put_user() is designed to take benefit of 'asm goto'.
>
> Instead of using the standard __put_user() approach and branch
> based on the returned error, use 'asm goto' and make the
> exception code branch directly to the error label. There is
> no code anymore in the fixup section.
>
> This change significantly simplifies functions using
> unsafe_put_user()
>
...
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/uaccess.h | 61 +++++++++++++++++++++++++-----
>  1 file changed, 52 insertions(+), 9 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index 9cc9c106ae2a..9365b59495a2 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -196,6 +193,52 @@ do {								\
>  })
>  
>  
> +#define __put_user_asm_goto(x, addr, label, op)			\
> +	asm volatile goto(					\
> +		"1:	" op "%U1%X1 %0,%1	# put_user\n"	\
> +		EX_TABLE(1b, %l2)				\
> +		:						\
> +		: "r" (x), "m<>" (*addr)				\

The "m<>" here is breaking GCC 4.6.3, which we allegedly still support.

Plain "m" works, how much does the "<>" affect code gen in practice?

A quick diff here shows no difference from removing "<>".

cheers
