Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A38BC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F77924649
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OirDP6rQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbgCJNXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:23:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35006 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730253AbgCJNXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:23:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id r7so15886146wro.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PrREAxTpNvUhqA5kFmd0641ibA5jgK8LQb5x4GN7wWI=;
        b=OirDP6rQxQYMZ9m9BAlp5e5xPu03JEcpkFWpfgAq8RTrOMMail6nnhq157kIXeLDEb
         DxJqgcdsrgO3EK56P2eIDpnVILD9PHalCkeYp1IX6+F44P+UVh2U8t9RFaB+T+m5k7MK
         j642LkDes9fxNt782nC9EdMzuyATFu1EMmdFa3jJBHOdzTzeX27uFuqzb/QRwUvOxImp
         35Wkd+02rwidtGhuaAqiD5bcuV/0w+d7cngsyDNy0K5J56J69TSzS5ulgTJOK40+p8AJ
         VeKx3ovJiZzbe7ZKqRnQgDeMqUXwzHruuTrodrHrjrXJEymn8CLwASNMZVa25g6EsmlF
         ZP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PrREAxTpNvUhqA5kFmd0641ibA5jgK8LQb5x4GN7wWI=;
        b=XNOSbqu02lz7iZ0t2y2hYZ4WFU7cwcliRhMDA2Vz8BOBYzIXAu/jVPkpMON763Gerk
         4Jk0gHuobEOO4xACB33sAyyOW2sKYi3FuLSBZt4O8ty4B+qiix6326r7XUPKJn+08vm0
         KyOQoSzvej37D1XLkEpiIpAXgkQmEVRonu9g/hsD57F8DvpGc0JPz140UtREcWKq+TIt
         sCvEwLqRggf6Y18Nf7ER55MWN1o783BfgyQ4qFCScIUyMC+/YsmiVPTn/L2ODMuwHN88
         j5qjbJhWQPbUHkAJIhQoh0FN6oHb0/z3nbMW2lP0X6fJXVvZYM+SSSP36oPmwUH5JZ2S
         9r3Q==
X-Gm-Message-State: ANhLgQ0AbWvaLvT3CIESrISDnOFUDWblbaimjrWoDsbvqMeR1GF3B+tW
        JIAH0uZL/PqBsl7g2cCMEe95mA==
X-Google-Smtp-Source: ADFU+vuhuwNcPJxP7Ty4lYagJjdSpQ28Ye/Po35yaX2WOBNt5ORf12exAOitZqqFMLNiTrCF/0tJaA==
X-Received: by 2002:adf:de84:: with SMTP id w4mr20873723wrl.350.1583846614292;
        Tue, 10 Mar 2020 06:23:34 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id s22sm3761199wmc.16.2020.03.10.06.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:23:33 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 03/14] nvmem: core: add nvmem_cell_read_u64
Date:   Tue, 10 Mar 2020 13:22:46 +0000
Message-Id: <20200310132257.23358-4-srinivas.kandagatla@linaro.org>
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

Add nvmem_cell_read_u64() helper to ease read of an u64 value on consumer
side. This helper is useful on some sunxi platform that has 64 bits data
cells stored in no volatile memory.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 15 +++++++++++++++
 include/linux/nvmem-consumer.h |  7 +++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index b3619f335693..4634af1f6341 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1146,6 +1146,21 @@ int nvmem_cell_read_u32(struct device *dev, const char *cell_id, u32 *val)
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
2.21.0

