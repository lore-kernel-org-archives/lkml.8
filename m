Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDA6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5280B20B80
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592581697;
	bh=7McYIa9P3Rh28JO6FRRv8eTfuuEGvhSv6QQoypGjkZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v+nbuC5hMzjV094YzZLvZgb4dxIUwidA0eqoyTMiIaZ7bxh/OJvOY+fPJ5ZB6I6V/
	 vPnEsO9LcJNGmfk/FH6OL26i+KFL7urd1s2nFq1gYROCh+emeteMClVxeoVBVhRW+F
	 tyjInYpon0uuRNqNTjw7cIlRAsMch2QPjdu/pvRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405334AbgFSPsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:48:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393434AbgFSPZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:25:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73A1D217A0;
        Fri, 19 Jun 2020 15:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580333;
        bh=7McYIa9P3Rh28JO6FRRv8eTfuuEGvhSv6QQoypGjkZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=smi4g954Rgayf18pqQgbEDALgq7+eQbGslJjkaRxorLaHxaY9rvJ4pld4CqqekACj
         m2rlEQQIJZlVJqqf3VRwUJuvaQgdr5u4g38L3jTFBVR58lRalMYfHR6gLOLwt5jpA+
         SDX+lL7Ru2J4endizjBeJeMU3ghxjdbq6y6napOQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicolas Toromanoff <nicolas.toromanoff@st.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 208/376] crypto: stm32/crc32 - fix multi-instance
Date:   Fri, 19 Jun 2020 16:32:06 +0200
Message-Id: <20200619141720.181167428@linuxfoundation.org>
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

[ Upstream commit 10b89c43a64eb0d236903b79a3bc9d8f6cbfd9c7 ]

Ensure CRC algorithm is registered only once in crypto framework when
there are several instances of CRC devices.

Update the CRC device list management to avoid that only the first CRC
instance is used.

Fixes: b51dbe90912a ("crypto: stm32 - Support for STM32 CRC32 crypto module")

Signed-off-by: Nicolas Toromanoff <nicolas.toromanoff@st.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/stm32/stm32-crc32.c | 48 ++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/crypto/stm32/stm32-crc32.c b/drivers/crypto/stm32/stm32-crc32.c
index 1c3e411b7acb..10304511f9b4 100644
--- a/drivers/crypto/stm32/stm32-crc32.c
+++ b/drivers/crypto/stm32/stm32-crc32.c
@@ -91,16 +91,29 @@ static int stm32_crc_setkey(struct crypto_shash *tfm, const u8 *key,
 	return 0;
 }
 
-static int stm32_crc_init(struct shash_desc *desc)
+static struct stm32_crc *stm32_crc_get_next_crc(void)
 {
-	struct stm32_crc_desc_ctx *ctx = shash_desc_ctx(desc);
-	struct stm32_crc_ctx *mctx = crypto_shash_ctx(desc->tfm);
 	struct stm32_crc *crc;
 
 	spin_lock_bh(&crc_list.lock);
 	crc = list_first_entry(&crc_list.dev_list, struct stm32_crc, list);
+	if (crc)
+		list_move_tail(&crc->list, &crc_list.dev_list);
 	spin_unlock_bh(&crc_list.lock);
 
+	return crc;
+}
+
+static int stm32_crc_init(struct shash_desc *desc)
+{
+	struct stm32_crc_desc_ctx *ctx = shash_desc_ctx(desc);
+	struct stm32_crc_ctx *mctx = crypto_shash_ctx(desc->tfm);
+	struct stm32_crc *crc;
+
+	crc = stm32_crc_get_next_crc();
+	if (!crc)
+		return -ENODEV;
+
 	pm_runtime_get_sync(crc->dev);
 
 	/* Reset, set key, poly and configure in bit reverse mode */
@@ -125,9 +138,9 @@ static int stm32_crc_update(struct shash_desc *desc, const u8 *d8,
 	struct stm32_crc_ctx *mctx = crypto_shash_ctx(desc->tfm);
 	struct stm32_crc *crc;
 
-	spin_lock_bh(&crc_list.lock);
-	crc = list_first_entry(&crc_list.dev_list, struct stm32_crc, list);
-	spin_unlock_bh(&crc_list.lock);
+	crc = stm32_crc_get_next_crc();
+	if (!crc)
+		return -ENODEV;
 
 	pm_runtime_get_sync(crc->dev);
 
@@ -200,6 +213,8 @@ static int stm32_crc_digest(struct shash_desc *desc, const u8 *data,
 	return stm32_crc_init(desc) ?: stm32_crc_finup(desc, data, length, out);
 }
 
+static unsigned int refcnt;
+static DEFINE_MUTEX(refcnt_lock);
 static struct shash_alg algs[] = {
 	/* CRC-32 */
 	{
@@ -290,12 +305,18 @@ static int stm32_crc_probe(struct platform_device *pdev)
 	list_add(&crc->list, &crc_list.dev_list);
 	spin_unlock(&crc_list.lock);
 
-	ret = crypto_register_shashes(algs, ARRAY_SIZE(algs));
-	if (ret) {
-		dev_err(dev, "Failed to register\n");
-		clk_disable_unprepare(crc->clk);
-		return ret;
+	mutex_lock(&refcnt_lock);
+	if (!refcnt) {
+		ret = crypto_register_shashes(algs, ARRAY_SIZE(algs));
+		if (ret) {
+			mutex_unlock(&refcnt_lock);
+			dev_err(dev, "Failed to register\n");
+			clk_disable_unprepare(crc->clk);
+			return ret;
+		}
 	}
+	refcnt++;
+	mutex_unlock(&refcnt_lock);
 
 	dev_info(dev, "Initialized\n");
 
@@ -316,7 +337,10 @@ static int stm32_crc_remove(struct platform_device *pdev)
 	list_del(&crc->list);
 	spin_unlock(&crc_list.lock);
 
-	crypto_unregister_shashes(algs, ARRAY_SIZE(algs));
+	mutex_lock(&refcnt_lock);
+	if (!--refcnt)
+		crypto_unregister_shashes(algs, ARRAY_SIZE(algs));
+	mutex_unlock(&refcnt_lock);
 
 	pm_runtime_disable(crc->dev);
 	pm_runtime_put_noidle(crc->dev);
-- 
2.25.1



