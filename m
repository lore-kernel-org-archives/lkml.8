Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701F4CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51D0920753
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589363748;
	bh=jBWitMYFdNu0214x8a7VCY4Sq+QrJC98y5VwtH5igU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o+oSezj40cvXvIqQT4ueHT6ETebfzETtqr/u7NbAe0FLDewUu7XNME2DPE93Nb5eW
	 JDY/iVRmhh+9FW2WaCGhe1tMIi/ESJy0lGb0tLRycYGApx8VRCJom/1F+qpw+/NNJ5
	 pb9lg1l9eMpkj2Xwm/JyFY4CxXWlnFwQ018Y1xeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388313AbgEMJzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:55:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388299AbgEMJzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:55:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7270A20753;
        Wed, 13 May 2020 09:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363743;
        bh=jBWitMYFdNu0214x8a7VCY4Sq+QrJC98y5VwtH5igU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SHQ5rOCEqXBs0maeZWtTCY8XTo0vf20aLgNKyD6fnHAz+0/jP8t1dOay80InMws2i
         TXOGzOluB/eXPyG03fBKjL1NizzR/XaQ26dMRMrnDANG3tXjglRFKHZYdTIQ9nq6Zx
         ozfrxu2XqtsDGEyy04L5TAjmf4BOL3qoRDA7Pn7g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.6 069/118] crypto: arch/nhpoly1305 - process in explicit 4k chunks
Date:   Wed, 13 May 2020 11:44:48 +0200
Message-Id: <20200513094423.857357935@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094417.618129545@linuxfoundation.org>
References: <20200513094417.618129545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason A. Donenfeld <Jason@zx2c4.com>

commit a9a8ba90fa5857c2c8a0e32eef2159cec717da11 upstream.

Rather than chunking via PAGE_SIZE, this commit changes the arch
implementations to chunk in explicit 4k parts, so that calculations on
maximum acceptable latency don't suddenly become invalid on platforms
where PAGE_SIZE isn't 4k, such as arm64.

Fixes: 0f961f9f670e ("crypto: x86/nhpoly1305 - add AVX2 accelerated NHPoly1305")
Fixes: 012c82388c03 ("crypto: x86/nhpoly1305 - add SSE2 accelerated NHPoly1305")
Fixes: a00fa0c88774 ("crypto: arm64/nhpoly1305 - add NEON-accelerated NHPoly1305")
Fixes: 16aae3595a9d ("crypto: arm/nhpoly1305 - add NEON-accelerated NHPoly1305")
Cc: stable@vger.kernel.org
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/crypto/nhpoly1305-neon-glue.c   |    2 +-
 arch/arm64/crypto/nhpoly1305-neon-glue.c |    2 +-
 arch/x86/crypto/nhpoly1305-avx2-glue.c   |    2 +-
 arch/x86/crypto/nhpoly1305-sse2-glue.c   |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

--- a/arch/arm/crypto/nhpoly1305-neon-glue.c
+++ b/arch/arm/crypto/nhpoly1305-neon-glue.c
@@ -30,7 +30,7 @@ static int nhpoly1305_neon_update(struct
 		return crypto_nhpoly1305_update(desc, src, srclen);
 
 	do {
-		unsigned int n = min_t(unsigned int, srclen, PAGE_SIZE);
+		unsigned int n = min_t(unsigned int, srclen, SZ_4K);
 
 		kernel_neon_begin();
 		crypto_nhpoly1305_update_helper(desc, src, n, _nh_neon);
--- a/arch/arm64/crypto/nhpoly1305-neon-glue.c
+++ b/arch/arm64/crypto/nhpoly1305-neon-glue.c
@@ -30,7 +30,7 @@ static int nhpoly1305_neon_update(struct
 		return crypto_nhpoly1305_update(desc, src, srclen);
 
 	do {
-		unsigned int n = min_t(unsigned int, srclen, PAGE_SIZE);
+		unsigned int n = min_t(unsigned int, srclen, SZ_4K);
 
 		kernel_neon_begin();
 		crypto_nhpoly1305_update_helper(desc, src, n, _nh_neon);
--- a/arch/x86/crypto/nhpoly1305-avx2-glue.c
+++ b/arch/x86/crypto/nhpoly1305-avx2-glue.c
@@ -29,7 +29,7 @@ static int nhpoly1305_avx2_update(struct
 		return crypto_nhpoly1305_update(desc, src, srclen);
 
 	do {
-		unsigned int n = min_t(unsigned int, srclen, PAGE_SIZE);
+		unsigned int n = min_t(unsigned int, srclen, SZ_4K);
 
 		kernel_fpu_begin();
 		crypto_nhpoly1305_update_helper(desc, src, n, _nh_avx2);
--- a/arch/x86/crypto/nhpoly1305-sse2-glue.c
+++ b/arch/x86/crypto/nhpoly1305-sse2-glue.c
@@ -29,7 +29,7 @@ static int nhpoly1305_sse2_update(struct
 		return crypto_nhpoly1305_update(desc, src, srclen);
 
 	do {
-		unsigned int n = min_t(unsigned int, srclen, PAGE_SIZE);
+		unsigned int n = min_t(unsigned int, srclen, SZ_4K);
 
 		kernel_fpu_begin();
 		crypto_nhpoly1305_update_helper(desc, src, n, _nh_sse2);


