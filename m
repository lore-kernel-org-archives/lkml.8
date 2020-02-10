Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230FCC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8CE2051A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338684;
	bh=woxeyLAkwlgmJvJtTrHq6llJqKOshHaPE8L5XUAZeeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uW+/7UVtUxsunGEm5o1B+s721gpA83W6pukMy1Q40iO+hv+Tsl2gdvujBCWTY/cXv
	 XNCQ5uGSaxz/IJz7kmZz+xwthGpOBd9GWeP+QXDWrSS0BoLvNjEZqvYF85Y6cxSjF4
	 Bhq8uyLnUhQVuChurvl/MYJSrsx8XafzAYtm0O2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbgBJMon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:44:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:41448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729788AbgBJMkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:40:45 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 144B92465D;
        Mon, 10 Feb 2020 12:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338444;
        bh=woxeyLAkwlgmJvJtTrHq6llJqKOshHaPE8L5XUAZeeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DPaZgdKLePTyHElxVrMOqO4eUQhBiqmA52vhwt8XiHdVKNUz0kZat0F5DnX1GQ1e2
         KCVHRKOGtmlF4cG5T1oddURXVIIVQUl+nBQqN/EQMc5VSyVMn5MhTEQv+evb8YTWIs
         dL98lFysEKX5t+KnIgVadLftzACbQUbu/InzBbdI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.5 184/367] crypto: atmel-aes - Fix counter overflow in CTR mode
Date:   Mon, 10 Feb 2020 04:31:37 -0800
Message-Id: <20200210122441.685289605@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
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
@@ -89,7 +89,6 @@
 struct atmel_aes_caps {
 	bool			has_dualbuff;
 	bool			has_cfb64;
-	bool			has_ctr32;
 	bool			has_gcm;
 	bool			has_xts;
 	bool			has_authenc;
@@ -1015,8 +1014,9 @@ static int atmel_aes_ctr_transfer(struct
 	struct atmel_aes_ctr_ctx *ctx = atmel_aes_ctr_ctx_cast(dd->ctx);
 	struct skcipher_request *req = skcipher_request_cast(dd->areq);
 	struct scatterlist *src, *dst;
-	u32 ctr, blocks;
 	size_t datalen;
+	u32 ctr;
+	u16 blocks, start, end;
 	bool use_dma, fragmented = false;
 
 	/* Check for transfer completion. */
@@ -1028,27 +1028,17 @@ static int atmel_aes_ctr_transfer(struct
 	datalen = req->cryptlen - ctx->offset;
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
@@ -2533,7 +2523,6 @@ static void atmel_aes_get_cap(struct atm
 {
 	dd->caps.has_dualbuff = 0;
 	dd->caps.has_cfb64 = 0;
-	dd->caps.has_ctr32 = 0;
 	dd->caps.has_gcm = 0;
 	dd->caps.has_xts = 0;
 	dd->caps.has_authenc = 0;
@@ -2544,7 +2533,6 @@ static void atmel_aes_get_cap(struct atm
 	case 0x500:
 		dd->caps.has_dualbuff = 1;
 		dd->caps.has_cfb64 = 1;
-		dd->caps.has_ctr32 = 1;
 		dd->caps.has_gcm = 1;
 		dd->caps.has_xts = 1;
 		dd->caps.has_authenc = 1;
@@ -2553,7 +2541,6 @@ static void atmel_aes_get_cap(struct atm
 	case 0x200:
 		dd->caps.has_dualbuff = 1;
 		dd->caps.has_cfb64 = 1;
-		dd->caps.has_ctr32 = 1;
 		dd->caps.has_gcm = 1;
 		dd->caps.max_burst_size = 4;
 		break;


