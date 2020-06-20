Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15B0C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 09:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CAEB21582
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 09:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="DTzrTbxZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgFTJfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 05:35:14 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:25135 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgFTJfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 05:35:13 -0400
Date:   Sat, 20 Jun 2020 09:35:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1592645711; bh=ZqCBGivQpOR7bWQOuKEUf/s+T102VDiFA/V/fTLFZqc=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=DTzrTbxZrXttoZLXPKtH8AZoe5YO3WXyoqCLvHbdez2+t565T/Lerh1pRuOpcAicl
         dN7Z3iUCq8Figxs+3Fy917O08s5P3fzo56FUgsPf5Vn7SM3E0PeK2fVFYQSLTv3z0E
         mhXIceiqbwYrdsbtgR9BDoExCrJl4OHiV49wH3of+5YrB9ejbIHW75CgL9a3L+HOTQ
         a/IX+yb7G6/CDg9uyl48vNFxC64jo8/CwI8j2wDOAnPC3af6QWVgACKp7/UFt3X6yq
         bBeclz7JT1yB5tW59NbaOyXSL2utlZBcC7BZBFJbPq7l/FpmpUxbpTFUoL2lshYJRj
         IFNKA8M+uYmyg==
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Paul Burton <paulburton@kernel.org>,
        Alexander Lobakin <alobakin@pm.me>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH mips-next 3/3] MIPS: checksum: fix sparse flooding on asm/checksum.h
Message-ID: <WDTCGAs6T_1WrYWzhajhKbTIXfzTBLg0bGDdJpUkGxVMdTG4pu3AzSorhGtletaoPhEf43qQ_F6kO0dndfIfhZsc2MGwcU9indtM80T4cI0=@pm.me>
In-Reply-To: <OXAnLrccR2GxIpepN5IUjppNnjyVAnjQmCIx2RmgpMLsOzOBgXMKYvmjivy4Rq0bAVf11R5V9_FwfGx-MML3dShuOOoPUtAHUHUedlVrW_g=@pm.me>
References: <OXAnLrccR2GxIpepN5IUjppNnjyVAnjQmCIx2RmgpMLsOzOBgXMKYvmjivy4Rq0bAVf11R5V9_FwfGx-MML3dShuOOoPUtAHUHUedlVrW_g=@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

csum_fold() in MIPS' asm/checksum.h is another source of sparse flooding
when building different networking source code.
The thing is that only half of __wsum <--> u32 casts inside the funtion
is forced, which is insufficient.
Add all necessary forced typecasting to stop floods and simplify actual
bug hunting.

Signed-off-by: Alexander Lobakin <alobakin@pm.me>
---
 arch/mips/include/asm/checksum.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/checksum.h b/arch/mips/include/asm/check=
sum.h
index dcebaaf8c862..181f7d14efb9 100644
--- a/arch/mips/include/asm/checksum.h
+++ b/arch/mips/include/asm/checksum.h
@@ -113,9 +113,9 @@ static inline __sum16 csum_fold(__wsum csum)
 =09u32 sum =3D (__force u32)csum;
=20
 =09sum +=3D (sum << 16);
-=09csum =3D (sum < csum);
+=09csum =3D (__force __wsum)(sum < (__force u32)csum);
 =09sum >>=3D 16;
-=09sum +=3D csum;
+=09sum +=3D (__force u32)csum;
=20
 =09return (__force __sum16)~sum;
 }
--=20
2.27.0


