Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530D1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C422206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vuRTp0pw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406250AbgFYQcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406198AbgFYQbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:31:43 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8AFC08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:31:43 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z13so6503886wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k8LHcx9qvNOxdNgpbKyrwuZ34KPVZZIgrr7AZi6KeZA=;
        b=vuRTp0pwkrASLzZlEd7t4bzVTihvDKzr6q/V1/a5h2KOgNHNmLVb3LCRQs3fqx6eDs
         g066CUVbKbA1D6tXqZLZP15dAlDHHd/sUfhuhsXQ6mq6VPWr2PWIipubrFXNm+EPZlZS
         4DB3EK9bHiHFNPdNdKLwfjNFwx5IrjiTWbthsvgfnUVdVMvUA/cCOZMgBzPblB7y9Wk2
         bwQvt4Wb13Js+kWH1OQ7tjj7UY7JaBPIA9Pc3xO2lYp5vxkZUGtBd49ngrtmOqeWcXHL
         voXi/mVlWJiM4sQoRJ4ilt5yTDUEBXzrNxdxa2qjofTn7ZAy96MtnSiItN21r4dAfPa1
         9pcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k8LHcx9qvNOxdNgpbKyrwuZ34KPVZZIgrr7AZi6KeZA=;
        b=h6CLt4clPoWdzMH8SM9AKujVpnHKgXM3z1nAXy/ey5jv1NHX1092hLaS8W1KW2FRFR
         FlpxDMz4BtbvJP24N0+1mZVRNQeuhFUlUbaKdlom3vjNqmwc4DwbtURh/9vfCx594mQV
         6XkpBfWFeaGmVubu00ThEH+lWIMlF7IyVeh4G/OZHhgyOAChei7MqMbbe8YoiLcWR7ax
         mCqDjS0gRFJ08H2fFh9sYEJNv6tHHOfoDpXBQhgjxOmsRX4/X8mqypk2GWppU6wo4ngE
         mZkCZJZd39zvWKVi5OUOJyvavgTxN1GxPgeulF7hIKJQtsadDtGhnTb8yyWIrscctbFE
         cEoA==
X-Gm-Message-State: AOAM532kHWxBYF/ZxInG3Q9i9wPGhw/QGvYV3IO/NJg3bpcieGPE5tGJ
        N4VaNIFGfPyiH7eEMlyd9oFABg==
X-Google-Smtp-Source: ABdhPJyDBx8MGsajh2N8dhN8HkgjNiO+zy04k92leLBktFBwL31ExA1tkRhJDISfX6ialHdYh3QUng==
X-Received: by 2002:a5d:4b41:: with SMTP id w1mr425998wrs.27.1593102702205;
        Thu, 25 Jun 2020 09:31:42 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id l8sm32090847wrq.15.2020.06.25.09.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 09:31:41 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 08/10] mfd: si476x-i2c: Add description for si476x_core_fwver_to_revision()'s arg 'func'
Date:   Thu, 25 Jun 2020 17:31:25 +0100
Message-Id: <20200625163127.4000462-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625163127.4000462-1-lee.jones@linaro.org>
References: <20200625163127.4000462-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc syntax is used, but not complete.

Descriptions are required for all arguments.

Fixes the following W=1 build warning:

 drivers/mfd/si476x-i2c.c:550: warning: Function parameter or member 'func' not described in 'si476x_core_fwver_to_revision'

Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/si476x-i2c.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mfd/si476x-i2c.c b/drivers/mfd/si476x-i2c.c
index c8d28b844def8..517d49bcd667b 100644
--- a/drivers/mfd/si476x-i2c.c
+++ b/drivers/mfd/si476x-i2c.c
@@ -534,6 +534,11 @@ static irqreturn_t si476x_core_interrupt(int irq, void *dev)
 /**
  * si476x_firmware_version_to_revision()
  * @core: Core device structure
+ * @func: Selects the boot function of the device:
+ *         *_BOOTLOADER  - Boot loader
+ *         *_FM_RECEIVER - FM receiver
+ *         *_AM_RECEIVER - AM receiver
+ *         *_WB_RECEIVER - Weatherband receiver
  * @major:  Firmware major number
  * @minor1: Firmware first minor number
  * @minor2: Firmware second minor number
-- 
2.25.1

