Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76688C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F262087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859213;
	bh=UpmcHSnUc8E62hyYWj8ClyaU2/BTlDYrix38raABp5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RgaJeaGBQvUAdQJCCs01CBwOa598xhgxFXtjxmWgJiZjNCEnzc+nBxV7qEVaY0I0H
	 2Ov7VYq6Jc60pA+561G148vw/SZjucjnLGxVVhHvmU0xrW33eEX32UvLrk8+czfDDs
	 Br6psAobZTV3g8KYeMSzv+UGEwbH4OGO1htb969s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387603AbgAXJqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:46:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:46366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730743AbgAXJqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:46:49 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6683B206D5;
        Fri, 24 Jan 2020 09:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859209;
        bh=UpmcHSnUc8E62hyYWj8ClyaU2/BTlDYrix38raABp5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BFvBV76sqW+gcG2cAno69+XZVNMIqU9Iv3hO322jgJtO+mmq0a+k/RTsKpvPukKSl
         0fFDPGg5H/hIcom2tdD1QCTTaO8LlTpTjP4xK8rTG7NU6/bCZnux7usdbs5XXBKDOt
         Yuvb9TQOhbsH8JdJXAXnzysRPLKDLZ7rPrcD4gmo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 067/343] crypto: brcm - Fix some set-but-not-used warning
Date:   Fri, 24 Jan 2020 10:28:05 +0100
Message-Id: <20200124092928.617723961@linuxfoundation.org>
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

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 707d0cf8f7cff6dfee9197002859912310532c4f ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/crypto/bcm/cipher.c: In function 'handle_ahash_req':
drivers/crypto/bcm/cipher.c:720:15: warning:
 variable 'chunk_start' set but not used [-Wunused-but-set-variable]

drivers/crypto/bcm/cipher.c: In function 'spu_rx_callback':
drivers/crypto/bcm/cipher.c:1679:31: warning:
 variable 'areq' set but not used [-Wunused-but-set-variable]

drivers/crypto/bcm/cipher.c:1678:22: warning:
 variable 'ctx' set but not used [-Wunused-but-set-variable]

Fixes: 9d12ba86f818 ("crypto: brcm - Add Broadcom SPU driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/bcm/cipher.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/crypto/bcm/cipher.c b/drivers/crypto/bcm/cipher.c
index 84422435f39b4..279e907590e98 100644
--- a/drivers/crypto/bcm/cipher.c
+++ b/drivers/crypto/bcm/cipher.c
@@ -718,7 +718,7 @@ static int handle_ahash_req(struct iproc_reqctx_s *rctx)
 	 */
 	unsigned int new_data_len;
 
-	unsigned int chunk_start = 0;
+	unsigned int __maybe_unused chunk_start = 0;
 	u32 db_size;	 /* Length of data field, incl gcm and hash padding */
 	int pad_len = 0; /* total pad len, including gcm, hash, stat padding */
 	u32 data_pad_len = 0;	/* length of GCM/CCM padding */
@@ -1676,8 +1676,6 @@ static void spu_rx_callback(struct mbox_client *cl, void *msg)
 	struct spu_hw *spu = &iproc_priv.spu;
 	struct brcm_message *mssg = msg;
 	struct iproc_reqctx_s *rctx;
-	struct iproc_ctx_s *ctx;
-	struct crypto_async_request *areq;
 	int err = 0;
 
 	rctx = mssg->ctx;
@@ -1687,8 +1685,6 @@ static void spu_rx_callback(struct mbox_client *cl, void *msg)
 		err = -EFAULT;
 		goto cb_finish;
 	}
-	areq = rctx->parent;
-	ctx = rctx->ctx;
 
 	/* process the SPU status */
 	err = spu->spu_status_process(rctx->msg_buf.rx_stat);
-- 
2.20.1



