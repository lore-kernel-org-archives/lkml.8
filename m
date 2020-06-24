Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63E2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A13E8206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fDNdhuKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404421AbgFXPHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404150AbgFXPHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:07:17 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDB3C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:07:17 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h5so2634465wrc.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mWlJbsdlqYw5jcyMhAAPjydUuATe963bkCaEYyUu7rs=;
        b=fDNdhuKb0j3VVPDO8tDSy54CPULXaYK08sbKQIDy3ep1JOR9nBbVcUbCnIFZr5CSGA
         3eEaUEy+1pLOj1z8WJl90MkZZFGGT9kDKYYvy3RI+KX1vuVVu04bxyv83MTjlwzOuWzF
         3ZZ83AAafizu+5VZcyLjnzxd75QECfrxUTAwAfV1BnF1c01lu0M5M14g6I5rQJls58v5
         STkDxI2Abl7qHAmtVyhd1iATdTFvFTyzTTPld5HJVriQgOMSNPGl/F7gMLR4eKX7QO6Q
         kTZFbd3qnehapxU5N/pyDV/KutSTw85dKRtaeRBtU3HYGlLQ7Pg8Gg33Pb89SizVNWQa
         lxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mWlJbsdlqYw5jcyMhAAPjydUuATe963bkCaEYyUu7rs=;
        b=ZhCQzIDuENXfoxvIVN67DTsqlKl8TNguW4SbCcvbhx02p4C8lmr/LXT+TJdRTmKoP9
         9jyw0CIxlmajMSI+THABizL6wx33SHNP5kx2alSBhd/hCWFSNjVmve9ce5ISvDBM0TO1
         s4c1p4o1YPAjDgAXdovkI61u5C5OH5ZmuzZYpSIryyEA43vy9bO1w8wW3CeHY650Snxh
         7D4Zpfg3S36f/Rz5B9mmBmQ3kZ0LZpM00oX/CoMzRXSkE+BJfQ46m2Am1R/1GpjTO/0Z
         PAXIpCIRI+ojmLKIcca+Z4UhPPCu7iDO5d/Glca4SFNFA/1WrdfPwuJksWCbQ8aONWbV
         OBhA==
X-Gm-Message-State: AOAM531iptOZ8LGvKl8WqmbOaYsjz+580tX5uqYFQm2s3W6jC/dpup6q
        wcVA43wO1SUJYccnSMPsXqiY+w==
X-Google-Smtp-Source: ABdhPJy49Vio8rN9TQgC04M3RFdu5P/cZgoeUXhk9TTIv8QmZvoFN4fYe2L0VShsjN01Oh8SpVe4+A==
X-Received: by 2002:adf:e4cc:: with SMTP id v12mr3692714wrm.92.1593011236167;
        Wed, 24 Jun 2020 08:07:16 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id h14sm11543361wrt.36.2020.06.24.08.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:07:15 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCH 04/10] mfd: altera-sysmgr: Fix physical address storing hacks
Date:   Wed, 24 Jun 2020 16:06:58 +0100
Message-Id: <20200624150704.2729736-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200624150704.2729736-1-lee.jones@linaro.org>
References: <20200624150704.2729736-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports:

 drivers/mfd/altera-sysmgr.c:150:30: warning: incorrect type in assignment (different address spaces)
 drivers/mfd/altera-sysmgr.c:150:30:    expected unsigned int [usertype] *base
 drivers/mfd/altera-sysmgr.c:150:30:    got void [noderef] <asn:2> *
 drivers/mfd/altera-sysmgr.c:156:26: warning: incorrect type in argument 3 (different address spaces)
 drivers/mfd/altera-sysmgr.c:156:26:    expected void [noderef] <asn:2> *regs
 drivers/mfd/altera-sysmgr.c:156:26:    got unsigned int [usertype] *base

It appears as though the driver data property 'resource_size_t *base'
was being used to store 2 different types of addresses (physical and
IO-mapped) under a single declared type.

Fortunately, no value is recalled from the driver data entry, so it
can be easily omitted.  Instead we can use the value obtained directly
from the platform resource to pass through  Regmap into the call-backs
to be used for the SMCC call and use a local dedicated __iomem
variable for IO-remapping.

Cc: <stable@vger.kernel.org>
Cc: Thor Thayer <thor.thayer@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/altera-sysmgr.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/altera-sysmgr.c b/drivers/mfd/altera-sysmgr.c
index d2a13a547a3ca..83f0765f819b0 100644
--- a/drivers/mfd/altera-sysmgr.c
+++ b/drivers/mfd/altera-sysmgr.c
@@ -22,11 +22,9 @@
 /**
  * struct altr_sysmgr - Altera SOCFPGA System Manager
  * @regmap: the regmap used for System Manager accesses.
- * @base  : the base address for the System Manager
  */
 struct altr_sysmgr {
 	struct regmap   *regmap;
-	resource_size_t *base;
 };
 
 static struct platform_driver altr_sysmgr_driver;
@@ -127,6 +125,7 @@ static int sysmgr_probe(struct platform_device *pdev)
 	struct regmap_config sysmgr_config = altr_sysmgr_regmap_cfg;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
+	void __iomem *base;
 
 	sysmgr = devm_kzalloc(dev, sizeof(*sysmgr), GFP_KERNEL);
 	if (!sysmgr)
@@ -139,22 +138,19 @@ static int sysmgr_probe(struct platform_device *pdev)
 	sysmgr_config.max_register = resource_size(res) -
 				     sysmgr_config.reg_stride;
 	if (of_device_is_compatible(np, "altr,sys-mgr-s10")) {
-		/* Need physical address for SMCC call */
-		sysmgr->base = (resource_size_t *)res->start;
 		sysmgr_config.reg_read = s10_protected_reg_read;
 		sysmgr_config.reg_write = s10_protected_reg_write;
 
-		regmap = devm_regmap_init(dev, NULL, sysmgr->base,
+		/* Need physical address for SMCC call */
+		regmap = devm_regmap_init(dev, NULL, (void *)res->start,
 					  &sysmgr_config);
 	} else {
-		sysmgr->base = devm_ioremap(dev, res->start,
-					    resource_size(res));
-		if (!sysmgr->base)
+		base = devm_ioremap(dev, res->start, resource_size(res));
+		if (!base)
 			return -ENOMEM;
 
 		sysmgr_config.max_register = res->end - res->start - 3;
-		regmap = devm_regmap_init_mmio(dev, sysmgr->base,
-					       &sysmgr_config);
+		regmap = devm_regmap_init_mmio(dev, base, &sysmgr_config);
 	}
 
 	if (IS_ERR(regmap)) {
-- 
2.25.1

