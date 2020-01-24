Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00D7C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719B0208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859270;
	bh=9MKGgbGkktR6LgpRauOiAnZovKnboxbvvj4O2cBM3+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rD0JdE7jJHeE/EI0HSoGrf+k/+7jaF2o1ws99fyep86waTn4b9V29cP5Fv/xfGm+p
	 oXlPNv6comB6gmOEyflEyuje4TGigv5eKTECJVPqeVYBjZ0npY4/XVSvupjCyaIyoA
	 SH3hsedOdcb8F3WcagUNr/clvMToUQFupWYcmHqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387679AbgAXJrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:47:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:47676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387666AbgAXJrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:47:45 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8446D206D5;
        Fri, 24 Jan 2020 09:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859265;
        bh=9MKGgbGkktR6LgpRauOiAnZovKnboxbvvj4O2cBM3+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TVocfg3tRkfrK/pkvNAF8ADQIN5TQysqE0XsM8hEiywWffiXBPWtW06PQoCunFMdb
         Pbgf5GMaq9AVFyCqBJyDrh4t9fq0WKy7HUKSgYVTWQhUzKa4jdS2cx4XfqOhuPap/p
         JeGgfUZI0SWKclFWOGKFymep5OTly6bgEmn1lPYA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 080/343] crypto: crypto4xx - Fix wrong ppc4xx_trng_probe()/ppc4xx_trng_remove() arguments
Date:   Fri, 24 Jan 2020 10:28:18 +0100
Message-Id: <20200124092930.452092737@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corentin Labbe <clabbe@baylibre.com>

[ Upstream commit 6e88098ca43a3d80ae86908f7badba683c8a0d84 ]

When building without CONFIG_HW_RANDOM_PPC4XX, I hit the following build failure:
drivers/crypto/amcc/crypto4xx_core.c: In function 'crypto4xx_probe':
drivers/crypto/amcc/crypto4xx_core.c:1407:20: error: passing argument 1 of 'ppc4xx_trng_probe' from incompatible pointer type [-Werror=incompatible-pointer-types]
In file included from drivers/crypto/amcc/crypto4xx_core.c:50:0:
drivers/crypto/amcc/crypto4xx_trng.h:28:20: note: expected 'struct crypto4xx_device *' but argument is of type 'struct crypto4xx_core_device *'
drivers/crypto/amcc/crypto4xx_core.c: In function 'crypto4xx_remove':
drivers/crypto/amcc/crypto4xx_core.c:1434:21: error: passing argument 1 of 'ppc4xx_trng_remove' from incompatible pointer type [-Werror=incompatible-pointer-types]
In file included from drivers/crypto/amcc/crypto4xx_core.c:50:0:
drivers/crypto/amcc/crypto4xx_trng.h:30:20: note: expected 'struct crypto4xx_device *' but argument is of type 'struct crypto4xx_core_device *'

This patch fix the needed argument of ppc4xx_trng_probe()/ppc4xx_trng_remove() in that case.

Fixes: 5343e674f32f ("crypto4xx: integrate ppc4xx-rng into crypto4xx")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/amcc/crypto4xx_trng.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/amcc/crypto4xx_trng.h b/drivers/crypto/amcc/crypto4xx_trng.h
index 931d22531f515..7bbda51b7337c 100644
--- a/drivers/crypto/amcc/crypto4xx_trng.h
+++ b/drivers/crypto/amcc/crypto4xx_trng.h
@@ -26,9 +26,9 @@ void ppc4xx_trng_probe(struct crypto4xx_core_device *core_dev);
 void ppc4xx_trng_remove(struct crypto4xx_core_device *core_dev);
 #else
 static inline void ppc4xx_trng_probe(
-	struct crypto4xx_device *dev __maybe_unused) { }
+	struct crypto4xx_core_device *dev __maybe_unused) { }
 static inline void ppc4xx_trng_remove(
-	struct crypto4xx_device *dev __maybe_unused) { }
+	struct crypto4xx_core_device *dev __maybe_unused) { }
 #endif
 
 #endif
-- 
2.20.1



