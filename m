Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0113C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EE97218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 16:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="HxkA0/Ti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgEHQ6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 12:58:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49151 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbgEHQ6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 12:58:01 -0400
Received: from [IPv6:2601:646:8600:3281:8cbc:9d8:e4de:b815] ([IPv6:2601:646:8600:3281:8cbc:9d8:e4de:b815])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 048GvlYi3909245
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 8 May 2020 09:57:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 048GvlYi3909245
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020042201; t=1588957069;
        bh=fuU7l9L9FTo19LB/f6E7H1c2FNKhZq+MrZtIfIv1AnU=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=HxkA0/Ti3YhHEIf3+Ah0hboS84JR+0TCE6dNAtPMBXL/iZHdgEoXW240oAuHMP89r
         29AdLVLWOezF3qOV2A9Ju2JGtSJvlrrYg/qpfUKa558uT9OLRgbWkrDPG+MJ4LVmbX
         D34OjABaLYp2+4fKxpPc9KC7SfGecMY9hws2JRC2e/hJfLBawpcnwZocSQCtmpLuxl
         n/XJeIKPc9KJwPrA/ZDnFldbaVSFoueBnwNv7ds9bVPuL/e+MJ8t9eJHt9eN9ldSck
         xlrOJTiqbpGmzo079CaOu5VRWKl5mTIVRta2qcMmsTxmSHuKmpOLsGrRv0Meolc1ZG
         1o5IiUOYkZt6Q==
Date:   Fri, 08 May 2020 09:57:40 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20200508105817.207887-1-ubizjak@gmail.com>
References: <20200508105817.207887-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] x86: Use RDRAND and RDSEED mnemonics in archrandom.h
To:     Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
CC:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
From:   hpa@zytor.com
Message-ID: <BACCC7C6-D456-4FAF-A11B-213995FE356A@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 8, 2020 3:58:17 AM PDT, Uros Bizjak <ubizjak@gmail=2Ecom> wrote:
>Current minimum required version of binutils is 2=2E23,
>which supports RDRAND and RDSEED instruction mnemonics=2E
>
>Replace the byte-wise specification of RDRAND and
>RDSEED with these proper mnemonics=2E
>
>Signed-off-by: Uros Bizjak <ubizjak@gmail=2Ecom>
>CC: "H=2E Peter Anvin" <hpa@zytor=2Ecom>
>CC: Ingo Molnar <mingo@redhat=2Ecom>
>CC: Thomas Gleixner <tglx@linutronix=2Ede>
>---
> arch/x86/include/asm/archrandom=2Eh | 26 ++++++++------------------
> 1 file changed, 8 insertions(+), 18 deletions(-)
>
>diff --git a/arch/x86/include/asm/archrandom=2Eh
>b/arch/x86/include/asm/archrandom=2Eh
>index 7a4bb1bd4bdb=2E=2Eebc248e49549 100644
>--- a/arch/x86/include/asm/archrandom=2Eh
>+++ b/arch/x86/include/asm/archrandom=2Eh
>@@ -15,16 +15,6 @@
>=20
> #define RDRAND_RETRY_LOOPS	10
>=20
>-#define RDRAND_INT	"=2Ebyte 0x0f,0xc7,0xf0"
>-#define RDSEED_INT	"=2Ebyte 0x0f,0xc7,0xf8"
>-#ifdef CONFIG_X86_64
>-# define RDRAND_LONG	"=2Ebyte 0x48,0x0f,0xc7,0xf0"
>-# define RDSEED_LONG	"=2Ebyte 0x48,0x0f,0xc7,0xf8"
>-#else
>-# define RDRAND_LONG	RDRAND_INT
>-# define RDSEED_LONG	RDSEED_INT
>-#endif
>-
> /* Unconditional execution of RDRAND and RDSEED */
>=20
> static inline bool __must_check rdrand_long(unsigned long *v)
>@@ -32,9 +22,9 @@ static inline bool __must_check rdrand_long(unsigned
>long *v)
> 	bool ok;
> 	unsigned int retry =3D RDRAND_RETRY_LOOPS;
> 	do {
>-		asm volatile(RDRAND_LONG
>+		asm volatile("rdrand %[out]"
> 			     CC_SET(c)
>-			     : CC_OUT(c) (ok), "=3Da" (*v));
>+			     : CC_OUT(c) (ok), [out] "=3Dr" (*v));
> 		if (ok)
> 			return true;
> 	} while (--retry);
>@@ -46,9 +36,9 @@ static inline bool __must_check rdrand_int(unsigned
>int *v)
> 	bool ok;
> 	unsigned int retry =3D RDRAND_RETRY_LOOPS;
> 	do {
>-		asm volatile(RDRAND_INT
>+		asm volatile("rdrand %[out]"
> 			     CC_SET(c)
>-			     : CC_OUT(c) (ok), "=3Da" (*v));
>+			     : CC_OUT(c) (ok), [out] "=3Dr" (*v));
> 		if (ok)
> 			return true;
> 	} while (--retry);
>@@ -58,18 +48,18 @@ static inline bool __must_check rdrand_int(unsigned
>int *v)
> static inline bool __must_check rdseed_long(unsigned long *v)
> {
> 	bool ok;
>-	asm volatile(RDSEED_LONG
>+	asm volatile("rdseed %[out]"
> 		     CC_SET(c)
>-		     : CC_OUT(c) (ok), "=3Da" (*v));
>+		     : CC_OUT(c) (ok), [out] "=3Dr" (*v));
> 	return ok;
> }
>=20
> static inline bool __must_check rdseed_int(unsigned int *v)
> {
> 	bool ok;
>-	asm volatile(RDSEED_INT
>+	asm volatile("rdseed %[out]"
> 		     CC_SET(c)
>-		     : CC_OUT(c) (ok), "=3Da" (*v));
>+		     : CC_OUT(c) (ok), [out] "=3Dr" (*v));
> 	return ok;
> }
>=20

Reviewed-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
