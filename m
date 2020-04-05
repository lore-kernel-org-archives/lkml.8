Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1692EC2BA19
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 12:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E274120709
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 12:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgDEMGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 08:06:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55519 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgDEMGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 08:06:09 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jL42N-0005PM-8V; Sun, 05 Apr 2020 12:06:03 +0000
From:   Colin King <colin.king@canonical.com>
To:     Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
        linux-wimax@intel.com, "David S . Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] wimax: remove some redundant assignments to variable result
Date:   Sun,  5 Apr 2020 13:06:02 +0100
Message-Id: <20200405120603.369405-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In function i2400m_bm_buf_alloc there is no need to use a variable
'result' to return -ENOMEM, just return the literal value. In the
function i2400m_setup the variable 'result' is initialized with a
value that is never read, it is a redundant assignment that can
be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/wimax/i2400m/driver.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wimax/i2400m/driver.c b/drivers/net/wimax/i2400m/driver.c
index f66c0f8f6f4a..ecb3fccca603 100644
--- a/drivers/net/wimax/i2400m/driver.c
+++ b/drivers/net/wimax/i2400m/driver.c
@@ -740,9 +740,6 @@ EXPORT_SYMBOL_GPL(i2400m_error_recovery);
 static
 int i2400m_bm_buf_alloc(struct i2400m *i2400m)
 {
-	int result;
-
-	result = -ENOMEM;
 	i2400m->bm_cmd_buf = kzalloc(I2400M_BM_CMD_BUF_SIZE, GFP_KERNEL);
 	if (i2400m->bm_cmd_buf == NULL)
 		goto error_bm_cmd_kzalloc;
@@ -754,7 +751,7 @@ int i2400m_bm_buf_alloc(struct i2400m *i2400m)
 error_bm_ack_buf_kzalloc:
 	kfree(i2400m->bm_cmd_buf);
 error_bm_cmd_kzalloc:
-	return result;
+	return -ENOMEM;
 }
 
 
@@ -843,7 +840,7 @@ EXPORT_SYMBOL_GPL(i2400m_reset);
  */
 int i2400m_setup(struct i2400m *i2400m, enum i2400m_bri bm_flags)
 {
-	int result = -ENODEV;
+	int result;
 	struct device *dev = i2400m_dev(i2400m);
 	struct wimax_dev *wimax_dev = &i2400m->wimax_dev;
 	struct net_device *net_dev = i2400m->wimax_dev.net_dev;
-- 
2.25.1

