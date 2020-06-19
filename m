Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB27DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 821FC2158C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592579506;
	bh=HYSVE/1juFSqORM3IGHffuIE4Q+k2VgOnbKSYKG6VWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JjB6+P49SE5ekZMNxQuI/1NSgjRfRVBu+51oIEwL+XEzlXjWP+AvF08eRMWNnAcdO
	 xI7VMkki+fQOVaW3V0m3d+YzXJE/z1oyAGYLwVceaCqU6tQ809KEa53k/b4UQHBwXn
	 lXyjFD49mUA/M2po4fmaaa8EFgH7kAo1wck2/Rs8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403839AbgFSPLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:11:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391244AbgFSPLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:11:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4C79206FA;
        Fri, 19 Jun 2020 15:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579494;
        bh=HYSVE/1juFSqORM3IGHffuIE4Q+k2VgOnbKSYKG6VWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yLd9oNtZoh9D/KICR3L9H4fr6nW3j3DY9S6JGLhk5P7kHam3T9ETe6GqjSB8hFGVy
         DzZzpMsZj8Urkr2LWNzCDMBXl8/2kez2fsolFCFL2wJ6/4HAbUc1tozqsfnPYRGCf8
         XF7x/KykAKQBsYvVGhUPSlqElNvqlOHLSFG1NzSM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicolas Toromanoff <nicolas.toromanoff@st.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 126/261] crypto: stm32/crc32 - fix multi-instance
Date:   Fri, 19 Jun 2020 16:32:17 +0200
Message-Id: <20200619141655.900667131@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141649.878808811@linuxfoundation.org>
References: <20200619141649.878808811@linuxfoundation.org>
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
index 93969d23a4a8..e68b856d03b6 100644
--- a/drivers/crypto/stm32/stm32-crc32.c
+++ b/drivers/crypto/stm32/stm32-crc32.c
@@ -93,16 +93,29 @@ static int stm32_crc_setkey(struct crypto_shash *tfm, const u8 *key,
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
@@ -127,9 +140,9 @@ static int stm32_crc_update(struct shash_desc *desc, const u8 *d8,
 	struct stm32_crc_ctx *mctx = crypto_shash_ctx(desc->tfm);
 	struct stm32_crc *crc;
 
-	spin_lock_bh(&crc_list.lock);
-	crc = list_first_entry(&crc_list.dev_list, struct stm32_crc, list);
-	spin_unlock_bh(&crc_list.lock);
+	crc = stm32_crc_get_next_crc();
+	if (!crc)
+		return -ENODEV;
 
 	pm_runtime_get_sync(crc->dev);
 
@@ -202,6 +215,8 @@ static int stm32_crc_digest(struct shash_desc *desc, const u8 *data,
 	return stm32_crc_init(desc) ?: stm32_crc_finup(desc, data, length, out);
 }
 
+static unsigned int refcnt;
+static DEFINE_MUTEX(refcnt_lock);
 static struct shash_alg algs[] = {
 	/* CRC-32 */
 	{
@@ -292,12 +307,18 @@ static int stm32_crc_probe(struct platform_device *pdev)
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
 
@@ -318,7 +339,10 @@ static int stm32_crc_remove(struct platform_device *pdev)
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



