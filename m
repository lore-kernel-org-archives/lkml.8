Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B90C433EA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92997206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tylk89Y9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731970AbgGVKI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731827AbgGVKIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:08:17 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80790C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:08:17 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q5so1311562wru.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b7MHzZy3dLUbUKgFsuoCa2haBWbgdsFC/rkxBf0pOCE=;
        b=tylk89Y9R/WsK1vHSa15PqrZHOFhBR0CRu9KY18pz/omNvuM2CHoEE6LWu36LoUuT1
         mej7PLQjvWB8T/yZ9bObTIBHJAGiBHufiKUFgqCekidPKOju7n951eHQKn1CjVLcufPs
         Xr46TRJox8AFb0hEWTjbeVi7JUbC5s+1OdnLJN8NE9Nqun1cEVsB+rHKsa0bdrFjssgj
         UHcQrc0E5GLjGAO2N0GPwshyYWFtybG9t68qTayXB9B6GLB63lyYvOx8tX/sqLGsXGLQ
         DvBgNKOm6We3GUXKMm1eRYxu1A9mPSspxNb0MVAA5jnkuU/swCdfeX3w29dalDId6LpS
         RlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b7MHzZy3dLUbUKgFsuoCa2haBWbgdsFC/rkxBf0pOCE=;
        b=BrSvTw24OjGutp12rufvwWUgiJ/DD6qEt6+K3K6kJ5J7hraoKwPeIg7iYrlh7pcSYP
         ncVMYEpu6yvq8YOZq5vh2/a9Qz6vJ1UJpxZossGHQLYZL+uwCyO1mL0KhBlZDGYbcUJ4
         /iakK1tLL4ANss6tac3j6V1ME/p/1HrfFGYrsb+v+kkx7FoPLTt9dvcNXbzO4VgjNGcJ
         VyezQIi1CE82eZea3AZWMI/mYysTXQNwWulxnEe1EHVSFIQTQa5qP7Devvvx2skQjwmT
         v+ri/TWHaGAYNUC/MYK1ey6C5UuxH4ktmKQrZ48GmEj1j+p9WsPEHMjsKdlfobMkUuOq
         tO3Q==
X-Gm-Message-State: AOAM533w5cyvV/+uuKkG73QfqZtOwj9YUBjcLM8/udOeAaCk9+gWXpzF
        /FwimuR+7dIhkX/dzQI+6Ynegw==
X-Google-Smtp-Source: ABdhPJw5NX+3YS7bKnYW1y7+mhlDsZpx2T5bYmvlBREVySZL13To636OIvpkomV+FXJBeQHF+KYejA==
X-Received: by 2002:adf:82f6:: with SMTP id 109mr9487741wrc.25.1595412496224;
        Wed, 22 Jul 2020 03:08:16 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t13sm17098623wru.65.2020.07.22.03.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 03:08:15 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 05/14] nvmem: core: Grammar fixes for help text
Date:   Wed, 22 Jul 2020 11:06:56 +0100
Message-Id: <20200722100705.7772-6-srinivas.kandagatla@linaro.org>
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

It's "an unsigned" but "a U".
Similarly, "an entry" but "a binary entry".

While at it, also drop superfluous articles for negative and zero.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index fc480d636be2..95bed31391cd 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -573,7 +573,7 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 
 /**
  * nvmem_register() - Register a nvmem device for given nvmem_config.
- * Also creates an binary entry in /sys/bus/nvmem/devices/dev-name/nvmem
+ * Also creates a binary entry in /sys/bus/nvmem/devices/dev-name/nvmem
  *
  * @config: nvmem device configuration with which nvmem device is created.
  *
@@ -728,7 +728,7 @@ static void devm_nvmem_release(struct device *dev, void *res)
 /**
  * devm_nvmem_register() - Register a managed nvmem device for given
  * nvmem_config.
- * Also creates an binary entry in /sys/bus/nvmem/devices/dev-name/nvmem
+ * Also creates a binary entry in /sys/bus/nvmem/devices/dev-name/nvmem
  *
  * @dev: Device that uses the nvmem device.
  * @config: nvmem device configuration with which nvmem device is created.
@@ -772,7 +772,7 @@ static int devm_nvmem_match(struct device *dev, void *res, void *data)
  * @dev: Device that uses the nvmem device.
  * @nvmem: Pointer to previously registered nvmem device.
  *
- * Return: Will be an negative on error or a zero on success.
+ * Return: Will be negative on error or zero on success.
  */
 int devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
 {
@@ -1375,7 +1375,7 @@ static int nvmem_cell_read_common(struct device *dev, const char *cell_id,
 }
 
 /**
- * nvmem_cell_read_u16() - Read a cell value as an u16
+ * nvmem_cell_read_u16() - Read a cell value as a u16
  *
  * @dev: Device that requests the nvmem cell.
  * @cell_id: Name of nvmem cell to read.
@@ -1390,7 +1390,7 @@ int nvmem_cell_read_u16(struct device *dev, const char *cell_id, u16 *val)
 EXPORT_SYMBOL_GPL(nvmem_cell_read_u16);
 
 /**
- * nvmem_cell_read_u32() - Read a cell value as an u32
+ * nvmem_cell_read_u32() - Read a cell value as a u32
  *
  * @dev: Device that requests the nvmem cell.
  * @cell_id: Name of nvmem cell to read.
@@ -1405,7 +1405,7 @@ int nvmem_cell_read_u32(struct device *dev, const char *cell_id, u32 *val)
 EXPORT_SYMBOL_GPL(nvmem_cell_read_u32);
 
 /**
- * nvmem_cell_read_u64() - Read a cell value as an u64
+ * nvmem_cell_read_u64() - Read a cell value as a u64
  *
  * @dev: Device that requests the nvmem cell.
  * @cell_id: Name of nvmem cell to read.
-- 
2.21.0

