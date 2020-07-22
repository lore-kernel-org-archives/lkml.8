Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57815C433ED
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C4F920729
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AWkmOFEN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732086AbgGVKI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731846AbgGVKIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:08:18 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EABDC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:08:18 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y3so1316478wrl.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A5OyaDKazB9R0G5RFCOuxIA9I8H8rA5wRtI5qxedDLM=;
        b=AWkmOFENuGxlgm20HEjydkPvslOX3oGwjR3KF/ZAEBdeKMzzbfwTt0wGynwt1wZ3qc
         QAAUaBeYd3z1sHUeQAyPWP7XMvQCT1Y0EpzbVgDeS16UANAn3X839Fj4KDW1gNacxK49
         OuBRJMAOPSxTNO60xUuc15pPBCeRUtCADQLB278Plwp2zT9BMWsl0WoE5HGDoFvp6Xfv
         rCgGp4XA8NkE89K8OAA92Cz2skzTIU9lk7kHepDjDfDiKxXAZ7oLD/U8Cj+fC4AkNM2m
         agBkI1cP2ZOnukdm9a0Zwy9RsI86NVq1aYrFCnRFJNmVQOd9/9K+AmeTwsWX60P+sgVs
         eGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A5OyaDKazB9R0G5RFCOuxIA9I8H8rA5wRtI5qxedDLM=;
        b=XeAXzVAQto/08Eyh+BRhO5/rwQ+NmNlKcBWF4XF2FvViBw6Lo7c75WP/FjAbEf7LrG
         CXp7jJSVfB9m5u6mClQz4X8dRYzu3F0/MOvtCCTSgyinJPHmYrgQxv9Q3HQi51mz2Om+
         nbLAEVaZ7FXIYti6zFsaj/jdUUvrR3GHh2QE1gqhRg3pxAtp0TgQpL65qrr+0fH4HcCE
         kX7dSdAp4m/V7u0eZ5+npnHlVq92/EHZPuOQvLLCa7NWM5J4B7wu7Rulo4N/VVJfNf08
         w3i0L6Qf2F0ymYOo6+8+8rrmWtUaRW7I7unSYjcASeD2Yjttw5mZh01dASChmqnXBcrq
         z8qw==
X-Gm-Message-State: AOAM530+3GdpSt2Nr62Ikg1fNMc6gehalZ/F+IbhfqfaCvrrKKWoIlxT
        kiPN2gxUz7BdYbA5FtMLeH/suw==
X-Google-Smtp-Source: ABdhPJwm2kjoQc9ihWHv0VlE/0oihzewOO8+TnZja0V1rUhp5ZndjI4gaMiZ1uSWMVejAVcPv45RSA==
X-Received: by 2002:adf:9f12:: with SMTP id l18mr17693457wrf.35.1595412497232;
        Wed, 22 Jul 2020 03:08:17 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t13sm17098623wru.65.2020.07.22.03.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 03:08:16 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 06/14] nvmem: core: Add nvmem_cell_read_u8()
Date:   Wed, 22 Jul 2020 11:06:57 +0100
Message-Id: <20200722100705.7772-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200722100705.7772-1-srinivas.kandagatla@linaro.org>
References: <20200722100705.7772-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Färber <afaerber@suse.de>

Complement the u16, u32 and u64 helpers with a u8 variant to ease
accessing byte-sized values.

This helper will be useful for Realtek Digital Home Center platforms,
which store some byte and sub-byte sized values in non-volatile memory.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 15 +++++++++++++++
 include/linux/nvmem-consumer.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 95bed31391cd..d6bacc878500 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1374,6 +1374,21 @@ static int nvmem_cell_read_common(struct device *dev, const char *cell_id,
 	return 0;
 }
 
+/**
+ * nvmem_cell_read_u8() - Read a cell value as a u8
+ *
+ * @dev: Device that requests the nvmem cell.
+ * @cell_id: Name of nvmem cell to read.
+ * @val: pointer to output value.
+ *
+ * Return: 0 on success or negative errno.
+ */
+int nvmem_cell_read_u8(struct device *dev, const char *cell_id, u8 *val)
+{
+	return nvmem_cell_read_common(dev, cell_id, val, sizeof(*val));
+}
+EXPORT_SYMBOL_GPL(nvmem_cell_read_u8);
+
 /**
  * nvmem_cell_read_u16() - Read a cell value as a u16
  *
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 1b311d27c9b8..052293f4cbdb 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -61,6 +61,7 @@ void nvmem_cell_put(struct nvmem_cell *cell);
 void devm_nvmem_cell_put(struct device *dev, struct nvmem_cell *cell);
 void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len);
 int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len);
+int nvmem_cell_read_u8(struct device *dev, const char *cell_id, u8 *val);
 int nvmem_cell_read_u16(struct device *dev, const char *cell_id, u16 *val);
 int nvmem_cell_read_u32(struct device *dev, const char *cell_id, u32 *val);
 int nvmem_cell_read_u64(struct device *dev, const char *cell_id, u64 *val);
-- 
2.21.0

