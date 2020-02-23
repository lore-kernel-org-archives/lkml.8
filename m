Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A9AC35669
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E27C21741
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582424802;
	bh=rT/guU/aACRynQqnHmNwjF9jC3hiPxcb+PyGiqR+f/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OJZxxWdEQV9pPOhRIUdYhwPlTezqW7W+iG9XwaFO5QMB/yWX97zoAP3aUHAV1iXPT
	 AyTOkMZJrfx9oU3NEPKDxpwlJOPMyMomkspAsrLpX1mcHu5ucxswHDjT0OYU/b1PXI
	 xDdVV45Ik5GA0uyPxn4p8p1LjP90s5SFvdz5rPQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgBWC0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 21:26:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729436AbgBWCYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:24:48 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56D8724673;
        Sun, 23 Feb 2020 02:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582424688;
        bh=rT/guU/aACRynQqnHmNwjF9jC3hiPxcb+PyGiqR+f/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lHOe/U/q744Apo+ABIIAWBUjmNxKpnyD7S7FEH3NBEvWstLXB+A2FzJDh/dmZqD8s
         /dEBjsfRYOc65Y3oc3yCgZ+KhmpNIV/bjmSWXNrxcp/8lGoQTQFKA0LjSW+jJIfKYi
         7r3xYdGK4UPsLBEM9iu9nBeYpAzSJbZcOvegxf1Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arthur Kiyanovski <akiyano@amazon.com>,
        Sameeh Jubran <sameehj@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 07/16] net: ena: fix potential crash when rxfh key is NULL
Date:   Sat, 22 Feb 2020 21:24:29 -0500
Message-Id: <20200223022438.2398-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200223022438.2398-1-sashal@kernel.org>
References: <20200223022438.2398-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arthur Kiyanovski <akiyano@amazon.com>

[ Upstream commit 91a65b7d3ed8450f31ab717a65dcb5f9ceb5ab02 ]

When ethtool -X is called without an hkey, ena_com_fill_hash_function()
is called with key=NULL, which is passed to memcpy causing a crash.

This commit fixes this issue by checking key is not NULL.

Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
Signed-off-by: Sameeh Jubran <sameehj@amazon.com>
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_com.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index 912dc09bc7a74..f09b7887039a2 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -2034,15 +2034,16 @@ int ena_com_fill_hash_function(struct ena_com_dev *ena_dev,
 
 	switch (func) {
 	case ENA_ADMIN_TOEPLITZ:
-		if (key_len > sizeof(hash_key->key)) {
-			pr_err("key len (%hu) is bigger than the max supported (%zu)\n",
-			       key_len, sizeof(hash_key->key));
-			return -EINVAL;
+		if (key) {
+			if (key_len != sizeof(hash_key->key)) {
+				pr_err("key len (%hu) doesn't equal the supported size (%zu)\n",
+				       key_len, sizeof(hash_key->key));
+				return -EINVAL;
+			}
+			memcpy(hash_key->key, key, key_len);
+			rss->hash_init_val = init_val;
+			hash_key->keys_num = key_len >> 2;
 		}
-
-		memcpy(hash_key->key, key, key_len);
-		rss->hash_init_val = init_val;
-		hash_key->keys_num = key_len >> 2;
 		break;
 	case ENA_ADMIN_CRC32:
 		rss->hash_init_val = init_val;
-- 
2.20.1

