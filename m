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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67746C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 19:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A182206F0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 19:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TK7rCol0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgAZT41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 14:56:27 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53705 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgAZT40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 14:56:26 -0500
Received: by mail-pj1-f65.google.com with SMTP id n96so2113841pjc.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 11:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uRTTE+nTirMrsG9ZMkgyE6DsmQ5+Ci7/AMF0UcAnWa8=;
        b=TK7rCol0z2YVc0JiR3qVmbwoMnMzkXeTKwlYR+ktBEweZXXAzgOKn/BqCWIv2MLaq4
         WzY+bnLHfudF+pswfc1wjtRM8AmoFA2lvDg9N96eAa2dn2CtAm31QcawzW7/USyHTSME
         ETFC+FXhh1M/s3e+vk9FkJg/ixGnZp5zZ/p/YfMQj1LQuSX03NtXDXlXnnyKjuSN42OS
         ZkYNKfASNf6K1lFgVL82+eO8QtwMVpKPwcGsvw0uNB623ZOuR0wks2XqYTV7C/cQa++s
         CMr8Df+A7bfEQ0gOidKdpNc3GhHtygRGHQMhwkG2z0p00fgPh64jFDL+WBKocywBB0su
         CxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uRTTE+nTirMrsG9ZMkgyE6DsmQ5+Ci7/AMF0UcAnWa8=;
        b=iD8v8JmlZ/mRRUpvFcxLTKF+sradmR7w6jOQMJepzcS1W5uO6W7ES0JpW8MVb6pbtk
         ICOMEXMfO7fUXPfzr/9J4WwfscebxCBZzo0rBNkgf3kE9EFF70itNNQTqAZz9KKatijF
         Vnteo7Ex1DCXebnuGAvs43OHyv1kg+ZCi5O3PV5zLlnxFxqJEIRTrzM7DnwdtolScl3W
         fSuymeunZw4eVUX48VMOOAlTlfNJkFZnI0LmX1xFAL5AGqWk2OMWrYqLrO0sZ/sCPcg2
         BiplrE6yqu5qo/RacNgCql5NaRvpXBiTT/gK0+wBu2828Lpi8JVoXYjOraeuSVgfHcx2
         m6sg==
X-Gm-Message-State: APjAAAU7nz5YftA2s28pOj6tYutpkbtwOJvGIIlmbDC3283jXkOGyAI8
        Oe5OHaxdCmHeTwjEN+ozI7E=
X-Google-Smtp-Source: APXvYqxN2palFqUGHdQIZAAoUEfuzTj6tUcy8kGeMa1Pm19U/g83mroOLIZyd3wIFoal/b6T8vONkw==
X-Received: by 2002:a17:90a:db48:: with SMTP id u8mr10769192pjx.54.1580068586045;
        Sun, 26 Jan 2020 11:56:26 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id w5sm12894616pjt.32.2020.01.26.11.56.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Jan 2020 11:56:25 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 2/2] nvmem: core: add nvmem_cell_read_u64
Date:   Sun, 26 Jan 2020 19:56:19 +0000
Message-Id: <20200126195619.27596-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200126195619.27596-1-tiny.windzz@gmail.com>
References: <20200126195619.27596-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nvmem_cell_read_u64() helper to ease read of an u64 value on consumer
side. This helper is useful on some sunxi platform that has 64 bits data
cells stored in no volatile memory.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/nvmem/core.c           | 15 +++++++++++++++
 include/linux/nvmem-consumer.h |  7 +++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index f4226546e49a..6c9ad0f75847 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1129,6 +1129,21 @@ int nvmem_cell_read_u32(struct device *dev, const char *cell_id, u32 *val)
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_read_u32);
 
+/**
+ * nvmem_cell_read_u64() - Read a cell value as an u64
+ *
+ * @dev: Device that requests the nvmem cell.
+ * @cell_id: Name of nvmem cell to read.
+ * @val: pointer to output value.
+ *
+ * Return: 0 on success or negative errno.
+ */
+int nvmem_cell_read_u64(struct device *dev, const char *cell_id, u64 *val)
+{
+	return nvmem_cell_read_common(dev, cell_id, val, sizeof(*val));
+}
+EXPORT_SYMBOL_GPL(nvmem_cell_read_u64);
+
 /**
  * nvmem_device_cell_read() - Read a given nvmem device and cell
  *
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index d3776be48c53..1b311d27c9b8 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -63,6 +63,7 @@ void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len);
 int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len);
 int nvmem_cell_read_u16(struct device *dev, const char *cell_id, u16 *val);
 int nvmem_cell_read_u32(struct device *dev, const char *cell_id, u32 *val);
+int nvmem_cell_read_u64(struct device *dev, const char *cell_id, u64 *val);
 
 /* direct nvmem device read/write interface */
 struct nvmem_device *nvmem_device_get(struct device *dev, const char *name);
@@ -138,6 +139,12 @@ static inline int nvmem_cell_read_u32(struct device *dev,
 	return -EOPNOTSUPP;
 }
 
+static inline int nvmem_cell_read_u64(struct device *dev,
+				      const char *cell_id, u64 *val)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline struct nvmem_device *nvmem_device_get(struct device *dev,
 						    const char *name)
 {
-- 
2.17.1

