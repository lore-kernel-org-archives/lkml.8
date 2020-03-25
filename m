Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E99C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B75920722
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aXIfbdqk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgCYLeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 07:34:31 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35505 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbgCYLeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 07:34:31 -0400
Received: by mail-lf1-f68.google.com with SMTP id t16so649723lfl.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 04:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QPegYuSfHcA3EBvl8rBN548IrIHva7Siiqx3+i9i/fk=;
        b=aXIfbdqkfrWHNMJxk7rgpfQnHosJstUgv+nPJg8nxRo+9pKouM26WAI5jitlKG5zYm
         dZx7N6OfzJ8B8lp5AR5Z/nKynJm5BIZo5mfsjpnAouFOVrITTq+MpsKOdTK1TnVZGr6J
         ZXD2xs25UMtjG5Seqi4Yh5xID9TbudX70og/9CFMxinK3V+PWmxJYgvnCCYaBfOylFDU
         sGLI80eAP38UiXXmS6eBcqtzZVijLUoii6AuDKzHfZGoxLxCvXIxIjGTYuwjdAwTyjxy
         RcJsKyFXDpgd4yPdbiI4DwWjQrdAE5T9nhViX9NpC7LDGEGvjepXCx2QLRJr9XWlR41n
         bh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QPegYuSfHcA3EBvl8rBN548IrIHva7Siiqx3+i9i/fk=;
        b=To1HJf/zvm0mQrmHpgwRFN7xIJ0kbkC3SLCiA22w3gJaTYCjjrqTAu9cupwD+MbqUR
         ULuNc3zSl+JMvmXmRBNbJewbO8rolhivmLLeO8633zIyMNo1+sJQ8Qa4eJb3eJvanLW7
         k3im5iRBynibzmZn/eeZR6hWhETgg8QcLd/opH+geAYpdCpG6s+C4TB5JtvlPphO0n1E
         Gu+T/zYZLPlGM11mrtaXeD3rbx1MfmcFaKRPMpOP/PApV6ys+TjBA1tl9T4VnvdIJ3+v
         C/UiUOqIMHtKdLwxjYjeAbwbmpvdL63sh+z9kaGypkXYOKOZJ45nGrx38A3Fi7p/pkz6
         YVcA==
X-Gm-Message-State: ANhLgQ25Ng8XJcAe7PiwSsxdtsm+rM0c094OKWS4e1HGs39tW81qWMpO
        f3eBENk7TFbN5VRUjIKDO1xOuA==
X-Google-Smtp-Source: ADFU+vuRSm6/etAQz80VrEgGUDZc5VTTv9FpBEJTzRn3gDVEDfDCfTlInPIezeIUpXLoXiDhoHUYOw==
X-Received: by 2002:a19:4cc2:: with SMTP id z185mr2098414lfa.0.1585136068643;
        Wed, 25 Mar 2020 04:34:28 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id v22sm3920009ljc.79.2020.03.25.04.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 04:34:28 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Haibo Chen <haibo.chen@nxp.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>, stable@vger.kernel.org
Subject: [PATCH 1/2] driver core: platform: Initialize dma_parms for platform devices
Date:   Wed, 25 Mar 2020 12:34:06 +0100
Message-Id: <20200325113407.26996-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325113407.26996-1-ulf.hansson@linaro.org>
References: <20200325113407.26996-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's currently the platform driver's responsibility to initialize the
pointer, dma_parms, for its corresponding struct device. The benefit with
this approach allows us to avoid the initialization and to not waste memory
for the struct device_dma_parameters, as this can be decided on a case by
case basis.

However, it has turned out that this approach is not very practical.  Not
only does it lead to open coding, but also to real errors. In principle
callers of dma_set_max_seg_size() doesn't check the error code, but just
assumes it succeeds.

For these reasons, let's do the initialization from the common platform bus
at the device registration point. This also follows the way the PCI devices
are being managed, see pci_device_add().

Suggested-by: Christoph Hellwig <hch@lst.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/platform.c         | 1 +
 include/linux/platform_device.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index b5ce7b085795..46abbfb52655 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -512,6 +512,7 @@ int platform_device_add(struct platform_device *pdev)
 		pdev->dev.parent = &platform_bus;
 
 	pdev->dev.bus = &platform_bus_type;
+	pdev->dev.dma_parms = &pdev->dma_parms;
 
 	switch (pdev->id) {
 	default:
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 041bfa412aa0..81900b3cbe37 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -25,6 +25,7 @@ struct platform_device {
 	bool		id_auto;
 	struct device	dev;
 	u64		platform_dma_mask;
+	struct device_dma_parameters dma_parms;
 	u32		num_resources;
 	struct resource	*resource;
 
-- 
2.20.1

