Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0A2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65C4120809
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592581710;
	bh=ulf2SztqD35ITArIHACtWdmO6AcDVM1Uqldkqoc+rQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B8gHBPAU8mhtRUmHJAucw96YQ4LalaPMnX5CGv0AnVf/KAwWQ17xqyXdTx6XwuxaR
	 T85dNPFrB7EzFKiorXap3Ciq852NnUdXh/O+Zs14Sna+Dm6leYm0yj71j3QbpDvFyq
	 0ILPHCL19q9G9QEnnisGca3RSDBBV1vSQTX+Lcus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393432AbgFSPs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:48:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390899AbgFSPZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:25:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 037AC20734;
        Fri, 19 Jun 2020 15:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580330;
        bh=ulf2SztqD35ITArIHACtWdmO6AcDVM1Uqldkqoc+rQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qwImjx6e+/Kvy9E0LvlHBbqjkRXY1yZdMEfyHfp59ZgXa68qV8vHqlkgwacvg9vyK
         GeK8qzKKpPD0j6alD3VHcXSDE8tKDhBioyiW9/ICGCQ30lwpptSr3UB5zIZC2xcSAK
         Ouln5MzBroDWxhwvJBOQjF+14S2rSprRgLO/DOzY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicolas Toromanoff <nicolas.toromanoff@st.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 207/376] crypto: stm32/crc32 - fix run-time self test issue.
Date:   Fri, 19 Jun 2020 16:32:05 +0200
Message-Id: <20200619141720.135061621@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Toromanoff <nicolas.toromanoff@st.com>

[ Upstream commit a8cc3128bf2c01c4d448fe17149e87132113b445 ]

Fix wrong crc32 initialisation value:
"alg: shash: stm32_crc32 test failed (wrong result) on test vector 0,
cfg="init+update+final aligned buffer"
cra_name="crc32c" expects an init value of 0XFFFFFFFF,
cra_name="crc32" expects an init value of 0.

Fixes: b51dbe90912a ("crypto: stm32 - Support for STM32 CRC32 crypto module")

Signed-off-by: Nicolas Toromanoff <nicolas.toromanoff@st.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/stm32/stm32-crc32.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/stm32/stm32-crc32.c b/drivers/crypto/stm32/stm32-crc32.c
index c6156bf6c603..1c3e411b7acb 100644
--- a/drivers/crypto/stm32/stm32-crc32.c
+++ b/drivers/crypto/stm32/stm32-crc32.c
@@ -28,10 +28,10 @@
 
 /* Registers values */
 #define CRC_CR_RESET            BIT(0)
-#define CRC_INIT_DEFAULT        0xFFFFFFFF
 #define CRC_CR_REV_IN_WORD      (BIT(6) | BIT(5))
 #define CRC_CR_REV_IN_BYTE      BIT(5)
 #define CRC_CR_REV_OUT          BIT(7)
+#define CRC32C_INIT_DEFAULT     0xFFFFFFFF
 
 #define CRC_AUTOSUSPEND_DELAY	50
 
@@ -65,7 +65,7 @@ static int stm32_crc32_cra_init(struct crypto_tfm *tfm)
 {
 	struct stm32_crc_ctx *mctx = crypto_tfm_ctx(tfm);
 
-	mctx->key = CRC_INIT_DEFAULT;
+	mctx->key = 0;
 	mctx->poly = CRC32_POLY_LE;
 	return 0;
 }
@@ -74,7 +74,7 @@ static int stm32_crc32c_cra_init(struct crypto_tfm *tfm)
 {
 	struct stm32_crc_ctx *mctx = crypto_tfm_ctx(tfm);
 
-	mctx->key = CRC_INIT_DEFAULT;
+	mctx->key = CRC32C_INIT_DEFAULT;
 	mctx->poly = CRC32C_POLY_LE;
 	return 0;
 }
-- 
2.25.1



