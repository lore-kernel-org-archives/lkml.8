Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1558DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 19:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CED206F0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 19:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgNFjdx/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgAZT4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 14:56:22 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44474 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgAZT4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 14:56:22 -0500
Received: by mail-pg1-f193.google.com with SMTP id x7so4061937pgl.11
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 11:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Lx1fQhTve1nbBbru9uKUTlLAi6KD+OaXiH29kpBKzw0=;
        b=WgNFjdx/K7Oy/gpkIYTgTsheoRoGp2nIhySKj8a/8UX4/1M6tLWcoKsUHu7xQ/HeIe
         1CWo7n6wb4uWi51iaAT9/8/+JXQKPJ8NfG3IpVdr+89a/EuczEtX6M5BlxKGtbBre69U
         vjsRtx/uAiii2dQUjQNGfdQr3v2RVU6hfs9Yw5EE/h3tAhgMG73tbgtB4aM9ZxjuFjoB
         1OgpUPigqw/raAe2TVKMAFCUcyIwnP82/OPICazQdL96x1iEpGicpo2dqIwI5in7GQYx
         +WpHogXZC1doDocZkGwdg+rlf08NjdpHn8H7H++eeTNUNuJO8nJewcwp6MP7+sIygqbX
         mWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Lx1fQhTve1nbBbru9uKUTlLAi6KD+OaXiH29kpBKzw0=;
        b=IXfPaZfDeNPwtCMniQkt9cstPvCQpl1k+QrJcv42OwOWBe5s7nlkAYAPQ1VJ5fR92D
         S96ceesCH5Sr7LpMKDH7E8Mmv+Kkx+CFKV/j0IdMqzPxWN2t2VZw6VbMLFJlEd5wnTy5
         W4Iopqcb6b96mVvSayAgHc1+XP3zkcFzrOjq5NYM1nxhrtWoM18iOC1yYWHHJidb5El3
         iQxV4DGeWmrMr7Hf8iO0n6DJX52iFFI+Rg9AoTSeN450QDraYdgBBXNDhUHQEdFH6e6w
         LDPQ8GViYBJUQxAPJoEgNPsaqXrv3qPkN8qApEObbsX/TBGOOupbX1hZ/Li10bjstex8
         qqQA==
X-Gm-Message-State: APjAAAUmwIWcEMzRJKqBFJQjxKIbRjr7Hpo62hayyZZsHBYRgTN4hG4g
        0bNZVRLAbcBd+UVYUrW1f3E=
X-Google-Smtp-Source: APXvYqxNbAge+qbKl/OMHMp4ZC4cw1Wn9B/QaZDJDuYPRekG3MsKXMuItfp47oBUMs89ypHMVrq09Q==
X-Received: by 2002:a63:4282:: with SMTP id p124mr15182237pga.155.1580068581923;
        Sun, 26 Jan 2020 11:56:21 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id a2sm13219989pgv.64.2020.01.26.11.56.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Jan 2020 11:56:21 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 1/2] nvmem: core: add nvmem_cell_read_common
Date:   Sun, 26 Jan 2020 19:56:18 +0000
Message-Id: <20200126195619.27596-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now there are nvmem_cell_read_u16 and nvmem_cell_read_u32.
They are very similar, let's strip out a common part.

And use nvmem_cell_read_common to simplify their implementation.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/nvmem/core.c | 54 ++++++++++++++++----------------------------
 1 file changed, 19 insertions(+), 35 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 9f1ee9c766ec..f4226546e49a 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1071,16 +1071,8 @@ int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len)
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
@@ -1095,17 +1087,31 @@ int nvmem_cell_read_u16(struct device *dev, const char *cell_id, u16 *val)
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
@@ -1119,29 +1125,7 @@ EXPORT_SYMBOL_GPL(nvmem_cell_read_u16);
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
2.17.1

