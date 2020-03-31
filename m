Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88FDC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8471B21556
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YAzpmToC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgCaSi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 14:38:59 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38769 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgCaSiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 14:38:54 -0400
Received: by mail-lf1-f67.google.com with SMTP id c5so18205883lfp.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 11:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KW3Lbde0NrLlMFOPBVL9VFr/xqlRRv5C9s8T2uV/EC8=;
        b=YAzpmToCHjPKwhVBcWenpASCnFKvzdesYgGqqYMRCP6llJmlm7Y0lj5BXG7cxcVRIl
         1fQhsBHrIpdVSutqQJVbpCEti0sA06lsT2dwQTcMRT/nIwMMC4O94hZhauz+WI9GJO6p
         12WAtAAApshg2SASKYHsA3S/db71nblcaq3R52IYHCxiGj7rIDzrt1M+tKgLtq7iTSFU
         aODeaHftNj89LL0xeI0W+Hei2+iJIAT2joCgO2P38SQDfWP6+Ktk5uEgbg+CJVvx4E49
         ZrGqhnUVONAeEWgjWrVaZ3BhXiqrh+R/IFaUyAlqH2Zjkgh2qY9Z0AkIAL6AblS6MrhU
         Y3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KW3Lbde0NrLlMFOPBVL9VFr/xqlRRv5C9s8T2uV/EC8=;
        b=Kh73BcCih/XGz6m2wMqGCV+dsB5X0Fe4jNy1Kvte34ZL8OxARf4GPkILWGPKTD+nqE
         HEIoHYr9l3lUIYLRl3k/6dv0oXgmxyUjltjfBXPuTsWSTRZd2wFxsR3bq9eWJr1szcYW
         exM95KXcqPKW57jMnzE/xmwidpJUnuczFhwqKZNOLzJalgPyOCm58gNEa9EfpOiIN86C
         W0MldNSEQeqVpVfQCMpmjGqJHUv2Cd+IwjxJoDkgIAVlC5NM6n8/CbpDcvqUPmGmFv5L
         Ul3m49WYMBBAKEoPvoFKKXnS79dLYd+2YVhpPU9HJx7M9XsWCprLJ/NosCenTvuoT3Qh
         jVmA==
X-Gm-Message-State: AGi0PubltkwFXIVoSa1g+2zoLZfHH2laxbHCXmx6+25ZSEW9ciC9YnFC
        FMsh/6ZKtB6GXnaxSEzmcyTtrQ==
X-Google-Smtp-Source: APiQypJ8E6I5iZxeoPH0TWIB8ALP7NCLvCUGTgJRpQtCJG/xvf6AdHVA3ceds7R25cl2FPBp6aBIHA==
X-Received: by 2002:a05:6512:3091:: with SMTP id z17mr12711035lfd.42.1585679932325;
        Tue, 31 Mar 2020 11:38:52 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b28sm10331849ljp.90.2020.03.31.11.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 11:38:51 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Vinod Koul <vkoul@kernel.org>, Haibo Chen <haibo.chen@nxp.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>, stable@vger.kernel.org
Subject: [PATCH v2 2/2] amba: Initialize dma_parms for amba devices
Date:   Tue, 31 Mar 2020 20:38:44 +0200
Message-Id: <20200331183844.30488-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200331183844.30488-1-ulf.hansson@linaro.org>
References: <20200331183844.30488-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's currently the amba driver's responsibility to initialize the pointer,
dma_parms, for its corresponding struct device. The benefit with this
approach allows us to avoid the initialization and to not waste memory for
the struct device_dma_parameters, as this can be decided on a case by case
basis.

However, it has turned out that this approach is not very practical. Not
only does it lead to open coding, but also to real errors. In principle
callers of dma_set_max_seg_size() doesn't check the error code, but just
assumes it succeeds.

For these reasons, let's do the initialization from the common amba bus at
the device registration point. This also follows the way the PCI devices
are being managed, see pci_device_add().

Suggested-by: Christoph Hellwig <hch@lst.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: <stable@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Move initialization to amba_device_initialize() to be more consistent
	with how we manage platform devices.

---
 drivers/amba/bus.c       | 1 +
 include/linux/amba/bus.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index fe1523664816..8558b629880b 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -645,6 +645,7 @@ static void amba_device_initialize(struct amba_device *dev, const char *name)
 	dev->dev.release = amba_device_release;
 	dev->dev.bus = &amba_bustype;
 	dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
+	dev->dev.dma_parms = &dev->dma_parms;
 	dev->res.name = dev_name(&dev->dev);
 }
 
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index 26f0ecf401ea..0bbfd647f5c6 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -65,6 +65,7 @@ struct amba_device {
 	struct device		dev;
 	struct resource		res;
 	struct clk		*pclk;
+	struct device_dma_parameters dma_parms;
 	unsigned int		periphid;
 	unsigned int		cid;
 	struct amba_cs_uci_id	uci;
-- 
2.20.1

