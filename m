Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DDBC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 23:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DCD32065E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 23:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="fiF0C/7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbgIJX4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 19:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgIJX4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 19:56:16 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D61C061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 16:56:15 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BnbPl66bTz9sTH;
        Fri, 11 Sep 2020 09:56:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1599782172;
        bh=fhFJZ8tEpaeqeNQqQJBDCnkVPmjyjoBOeg1MMkx7t98=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fiF0C/7y/PY6O3hcXo1Lr0G8h2KUoVOQ0yVIE95pe3SzigpO7zLBaU0q7fC52lQHE
         fDUggJ33LnNs+9gSvqqzLLLfb5FBEou6AgsTAkNP8Kw6cP0RBT5OFuFVmXly5iGAq6
         gu4ynJxXjgXP7uc6eJs6G3p/JctST3uW7jly9pOqoofjEgHRsK8DxCKyttV8upoKgq
         R/UQplVajVpJdw0Od7AmphrWhKG4QyireE9PHNQqxnIL6TNJDu2UXMU9CB/pAjASSH
         l8GnvM2fyZZ/+ewjYZlQVdYudyZ/dgbEgWOATDzulYjrbbe6gRrPj1Tt1QWvph2+TH
         df2raJL1uDicw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powermac: Fix low_sleep_handler with KUAP and KUEP
In-Reply-To: <74472ea2a7e8698273643cde7d382bd9f31cd1dd.1598945727.git.christophe.leroy@csgroup.eu>
References: <74472ea2a7e8698273643cde7d382bd9f31cd1dd.1598945727.git.christophe.leroy@csgroup.eu>
Date:   Fri, 11 Sep 2020 09:56:10 +1000
Message-ID: <871rj9rxt1.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> low_sleep_handler() has an hardcoded restore of segment registers
> that doesn't take KUAP and KUEP into account.
>
> Use head_32's load_segment_registers() routine instead.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Fixes: a68c31fc01ef ("powerpc/32s: Implement Kernel Userspace Access Protection")
> Fixes: 31ed2b13c48d ("powerpc/32s: Implement Kernel Userspace Execution Prevention.")
> Cc: stable@vger.kernel.org
> ---
>  arch/powerpc/platforms/powermac/sleep.S | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

Doesn't build? pmac32_defconfig, gcc 9.3.0:

ld: arch/powerpc/platforms/powermac/sleep.o: in function `core99_wake_up':
(.text+0x25c): undefined reference to `load_segment_registers'

Missing _GLOBAL() presumably?

cheers

> diff --git a/arch/powerpc/platforms/powermac/sleep.S b/arch/powerpc/platforms/powermac/sleep.S
> index f9a680fdd9c4..51bfdfe85058 100644
> --- a/arch/powerpc/platforms/powermac/sleep.S
> +++ b/arch/powerpc/platforms/powermac/sleep.S
> @@ -294,14 +294,7 @@ grackle_wake_up:
>  	 * we do any r1 memory access as we are not sure they
>  	 * are in a sane state above the first 256Mb region
>  	 */
> -	li	r0,16		/* load up segment register values */
> -	mtctr	r0		/* for context 0 */
> -	lis	r3,0x2000	/* Ku = 1, VSID = 0 */
> -	li	r4,0
> -3:	mtsrin	r3,r4
> -	addi	r3,r3,0x111	/* increment VSID */
> -	addis	r4,r4,0x1000	/* address of next segment */
> -	bdnz	3b
> +	bl	load_segment_registers
>  	sync
>  	isync
>  
> -- 
> 2.25.0
