Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5845C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B948208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="miO76mbv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbgCJNY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:24:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34449 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgCJNXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:23:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id z15so15878595wrl.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RlyocVmr085QMwL0jiuz19fAxzTAbVPfaHxRDTjAc+c=;
        b=miO76mbvR2e/+wDNWEcs5jywnrkXSZtWUJGpTFNcQrqQmVHKP++NI7zFm56aIZCNTv
         6Z3smUsqSWUA/4fxvRVqtDeOGhswYGrEWaRbEq32XhJpHVUUNN5akpzsQYmQiJfiTkxE
         rQs4dlEzoW0PwJpeiww4HUwkaBsmka55AIazsAVL987eECTxwqXRDaU/wi5/0+bLp7Rq
         V+QNed4Zzf+lL/58VQ3NUR7n895BL5/OUVpB94kGzXXBCEZL30mAiew5ssiuY7voFfZ+
         v/2o10SDgFRR0O6GZUyRff3OiJIqQt53edsYVZTtp7UmAOUw5vODKbbkrHZ9nBd4ucmi
         7VAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RlyocVmr085QMwL0jiuz19fAxzTAbVPfaHxRDTjAc+c=;
        b=nw/LW1xXd7b0UkA4mygq/0Ri/T2y72l78kJjp97hZzVB6kXZzw0f6v7ARPwIEf62XN
         UuJTJ831BwTBRU9EWznmqcZJPPNtjEurUEDCnZriTz6ZsjzNn5fUvJlNq1NDWkeuSL7Z
         CVJGn1NudwEFdCoHAJ1bqFoQc5NkKYaoJyAa/YZDQOFdbjVkNnGGjm4vndzWvyrEkwLh
         ToMh2CpW2GBtrNMhlVHd+XuREIrvK79d5LcA/NCVfjG5Q3G83uWx6p0DZRMTQIY3jJi6
         yqU73uBWEqNa9KkQBWevk/f+PM+gSwVsfC651xkIwoLOD+f0lU9niAoxJo3/kL+Hllv1
         hSKQ==
X-Gm-Message-State: ANhLgQ1Xg6DICJQZB5xzi2LCtiooWgx7Rkje6X3F2llf2aRzikLYb5oi
        G+A8+jmRvV2uLW0jNN6UYb9FJA==
X-Google-Smtp-Source: ADFU+vu6dTk5YZVRx44KayOEzBSdbaVovwMTsJ5m2ruhAswL8pNpgSTT+vjoosmdR3cx4a59o07idg==
X-Received: by 2002:a5d:414d:: with SMTP id c13mr28797562wrq.40.1583846612780;
        Tue, 10 Mar 2020 06:23:32 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id s22sm3761199wmc.16.2020.03.10.06.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:23:31 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 02/14] nvmem: core: add nvmem_cell_read_common
Date:   Tue, 10 Mar 2020 13:22:45 +0000
Message-Id: <20200310132257.23358-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200310132257.23358-1-srinivas.kandagatla@linaro.org>
References: <20200310132257.23358-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

Now there are nvmem_cell_read_u16 and nvmem_cell_read_u32.
They are very similar, let's strip out a common part.

And use nvmem_cell_read_common to simplify their implementation.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 54 ++++++++++++++++----------------------------
 1 file changed, 19 insertions(+), 35 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index ef326f243f36..b3619f335693 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1088,16 +1088,8 @@ int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len)
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_write);
 
-/**
- * nvmem_cell_read_u16() - Read a cell value as an u16
- *
- * @dev: Device that requests the nvmem cell.
- * @cell_id: Name of nvmem cell to read.
- * @val: pointer to output value.
- *
- * Return: 0 on success or negative errno.
- */
-int nvmem_cell_read_u16(struct device *dev, const char *cell_id, u16 *val)
+static int nvmem_cell_read_common(struct device *dev, const char *cell_id,
+				  void *val, size_t count)
 {
 	struct nvmem_cell *cell;
 	void *buf;
@@ -1112,17 +1104,31 @@ int nvmem_cell_read_u16(struct device *dev, const char *cell_id, u16 *val)
 		nvmem_cell_put(cell);
 		return PTR_ERR(buf);
 	}
-	if (len != sizeof(*val)) {
+	if (len != count) {
 		kfree(buf);
 		nvmem_cell_put(cell);
 		return -EINVAL;
 	}
-	memcpy(val, buf, sizeof(*val));
+	memcpy(val, buf, count);
 	kfree(buf);
 	nvmem_cell_put(cell);
 
 	return 0;
 }
+
+/**
+ * nvmem_cell_read_u16() - Read a cell value as an u16
+ *
+ * @dev: Device that requests the nvmem cell.
+ * @cell_id: Name of nvmem cell to read.
+ * @val: pointer to output value.
+ *
+ * Return: 0 on success or negative errno.
+ */
+int nvmem_cell_read_u16(struct device *dev, const char *cell_id, u16 *val)
+{
+	return nvmem_cell_read_common(dev, cell_id, val, sizeof(*val));
+}
 EXPORT_SYMBOL_GPL(nvmem_cell_read_u16);
 
 /**
@@ -1136,29 +1142,7 @@ EXPORT_SYMBOL_GPL(nvmem_cell_read_u16);
  */
 int nvmem_cell_read_u32(struct device *dev, const char *cell_id, u32 *val)
 {
-	struct nvmem_cell *cell;
-	void *buf;
-	size_t len;
-
-	cell = nvmem_cell_get(dev, cell_id);
-	if (IS_ERR(cell))
-		return PTR_ERR(cell);
-
-	buf = nvmem_cell_read(cell, &len);
-	if (IS_ERR(buf)) {
-		nvmem_cell_put(cell);
-		return PTR_ERR(buf);
-	}
-	if (len != sizeof(*val)) {
-		kfree(buf);
-		nvmem_cell_put(cell);
-		return -EINVAL;
-	}
-	memcpy(val, buf, sizeof(*val));
-
-	kfree(buf);
-	nvmem_cell_put(cell);
-	return 0;
+	return nvmem_cell_read_common(dev, cell_id, val, sizeof(*val));
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_read_u32);
 
-- 
2.21.0

