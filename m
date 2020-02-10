Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A0EC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EEF520714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581341559;
	bh=pUTgc9vfXhOT789ZOzPvjouHgEGCB7uEMTg61ozmV8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VY20iy5foIYKXgISfdQQO9yc/D43B1PfG0waBLMBAsphqaExbxWdLPMEm48h0vERa
	 Apu7Hn2d95iWxgRNhPARadDekhkbZ22+LtcsovhUn47IsW2KR6Std1N8KwPloBqBJ9
	 HApjTWqrMEDRY0l5Cg7YcO69dq/3eWXGGuzyWT7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731459AbgBJNci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:32:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:53510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728083AbgBJMfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:35:43 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B2FF24650;
        Mon, 10 Feb 2020 12:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338142;
        bh=pUTgc9vfXhOT789ZOzPvjouHgEGCB7uEMTg61ozmV8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bB2TAWpeFflrIzlQD7EeuwowBpJ96j3Nkvzi4rLAakSIIfy68AccufV523qelwewe
         CDq9P4MNFg6nNjwrDmU8lBCFXSIMvwMJaebX55ICSiUQd1K5BPcxUhE19tBuO13Tax
         CU9/dPCnUaIJH8Rc762F7SG06CsUI2b3rSg3gKfw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 099/195] crypto: atmel-aes - Fix counter overflow in CTR mode
Date:   Mon, 10 Feb 2020 04:32:37 -0800
Message-Id: <20200210122314.873840533@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
References: <20200210122305.731206734@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

commit 781a08d9740afa73357f1a60d45d7c93d7cca2dd upstream.

32 bit counter is not supported by neither of our AES IPs, all implement
a 16 bit block counter. Drop the 32 bit block counter logic.

Fixes: fcac83656a3e ("crypto: atmel-aes - fix the counter overflow in CTR mode")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/atmel-aes.c |   37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

--- a/drivers/crypto/atmel-aes.c
+++ b/drivers/crypto/atmel-aes.c
@@ -91,7 +91,6 @@
 struct atmel_aes_caps {
 	bool			has_dualbuff;
 	bool			has_cfb64;
-	bool			has_ctr32;
 	bool			has_gcm;
 	bool			has_xts;
 	bool			has_authenc;
@@ -1016,8 +1015,9 @@ static int atmel_aes_ctr_transfer(struct
 	struct atmel_aes_ctr_ctx *ctx = atmel_aes_ctr_ctx_cast(dd->ctx);
 	struct ablkcipher_request *req = ablkcipher_request_cast(dd->areq);
 	struct scatterlist *src, *dst;
-	u32 ctr, blocks;
 	size_t datalen;
+	u32 ctr;
+	u16 blocks, start, end;
 	bool use_dma, fragmented = false;
 
 	/* Check for transfer completion. */
@@ -1029,27 +1029,17 @@ static int atmel_aes_ctr_transfer(struct
 	datalen = req->nbytes - ctx->offset;
 	blocks = DIV_ROUND_UP(datalen, AES_BLOCK_SIZE);
 	ctr = be32_to_cpu(ctx->iv[3]);
-	if (dd->caps.has_ctr32) {
-		/* Check 32bit counter overflow. */
-		u32 start = ctr;
-		u32 end = start + blocks - 1;
-
-		if (end < start) {
-			ctr |= 0xffffffff;
-			datalen = AES_BLOCK_SIZE * -start;
-			fragmented = true;
-		}
-	} else {
-		/* Check 16bit counter overflow. */
-		u16 start = ctr & 0xffff;
-		u16 end = start + (u16)blocks - 1;
-
-		if (blocks >> 16 || end < start) {
-			ctr |= 0xffff;
-			datalen = AES_BLOCK_SIZE * (0x10000-start);
-			fragmented = true;
-		}
+
+	/* Check 16bit counter overflow. */
+	start = ctr & 0xffff;
+	end = start + blocks - 1;
+
+	if (blocks >> 16 || end < start) {
+		ctr |= 0xffff;
+		datalen = AES_BLOCK_SIZE * (0x10000 - start);
+		fragmented = true;
 	}
+
 	use_dma = (datalen >= ATMEL_AES_DMA_THRESHOLD);
 
 	/* Jump to offset. */
@@ -2553,7 +2543,6 @@ static void atmel_aes_get_cap(struct atm
 {
 	dd->caps.has_dualbuff = 0;
 	dd->caps.has_cfb64 = 0;
-	dd->caps.has_ctr32 = 0;
 	dd->caps.has_gcm = 0;
 	dd->caps.has_xts = 0;
 	dd->caps.has_authenc = 0;
@@ -2564,7 +2553,6 @@ static void atmel_aes_get_cap(struct atm
 	case 0x500:
 		dd->caps.has_dualbuff = 1;
 		dd->caps.has_cfb64 = 1;
-		dd->caps.has_ctr32 = 1;
 		dd->caps.has_gcm = 1;
 		dd->caps.has_xts = 1;
 		dd->caps.has_authenc = 1;
@@ -2573,7 +2561,6 @@ static void atmel_aes_get_cap(struct atm
 	case 0x200:
 		dd->caps.has_dualbuff = 1;
 		dd->caps.has_cfb64 = 1;
-		dd->caps.has_ctr32 = 1;
 		dd->caps.has_gcm = 1;
 		dd->caps.max_burst_size = 4;
 		break;


