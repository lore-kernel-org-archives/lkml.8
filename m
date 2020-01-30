Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC78AC33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 04:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED15206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 04:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7t3Sa0+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgA3Eln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 23:41:43 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52902 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbgA3Eld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 23:41:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so2242455wmc.2;
        Wed, 29 Jan 2020 20:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5EBoa/11BC9T7X5//l8eeEjFWiZ834E6/s6B9Dz4ejw=;
        b=T7t3Sa0+D/j2xCXwhefagh+pCBoeRqBP6Mallm4E/gnjg7Y5K4iscb1lQyGQYiFeOw
         RM4ncvQlFbhlZWuRtQs+bZzyapPBNOPEjTQsTWXoLBkFf28BhN/jNsivWXJ6HW0LhPUg
         fO0oWy9uLHplTLVc6SAU+ZUUSgG7UDcGi2QEYLU/kHnxRBc1k+3mhS9WndOOulqHNCoh
         CTCxmJRsSxCsku9JXCYDmJhJaB92dkDYlubgCow3l+iNJCVlCr0i4FQFzXY3WXA84s7v
         ySPjTkJ3Lr/AzyECsrTJ+Z7VbEsNKLEhr1Mh4u+NgIgoy4RiXcu2uZ+1vSOnK2MVc586
         tg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5EBoa/11BC9T7X5//l8eeEjFWiZ834E6/s6B9Dz4ejw=;
        b=aRIn1b1E2mtIEgV7dSFlTv+ytKuaGc63hQkMHN20st5p7zWiKWytsQ7N5wWQCN+qud
         BclPtmQIHAVVUl6RpjepI4HrtBaNsJpT4ICcYV+2DuJK0eiJnF7vP6ALzbjtTdUmtOQR
         zqbrNhfJUZcsnuZUPU9Kw5Jaol9GsKATSliGDgXiEmYJN0XhCPMRPhdAFnhbkW0KupXe
         IIB7m2TFOtwJKMvn8e1WqD22CGYuk78cQJz1GcXlI4rh8btGwFgB+a+1Wl1roOrHd6PS
         hpiFzbvoqpjKp4c+Ss4Zowv8Jx/+h4f+uCC9Lj7hgjWyPfOqGe/gAfXlMteKR23MOJha
         Dfqg==
X-Gm-Message-State: APjAAAXgg8t59uFpCRrLeZGIUh+bRzqw3UYnmhxiPGvnmxTlA394+Mgi
        o+Q+9dW9gibacgb5d2CgJZc=
X-Google-Smtp-Source: APXvYqzWGrOP/XZbWMYROui9UuHCoc7MMRJdWy1NKRHioIGJ/mYfvcIN2TPMSNlIYDk/K2aXfabiPw==
X-Received: by 2002:a05:600c:24d2:: with SMTP id 18mr468223wmu.149.1580359290393;
        Wed, 29 Jan 2020 20:41:30 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g128sm4494672wme.47.2020.01.29.20.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 20:41:30 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 16/16] dmaengine: tegra-apb: Support COMPILE_TEST
Date:   Thu, 30 Jan 2020 07:38:04 +0300
Message-Id: <20200130043804.32243-17-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200130043804.32243-1-digetx@gmail.com>
References: <20200130043804.32243-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is nothing arch-specific in the driver's code, so let's enable
compile-testing for the driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 98daf3aafdcc..7fc725d928b2 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -617,7 +617,7 @@ config TXX9_DMAC
 
 config TEGRA20_APB_DMA
 	tristate "NVIDIA Tegra20 APB DMA support"
-	depends on ARCH_TEGRA
+	depends on ARCH_TEGRA || COMPILE_TEST
 	select DMA_ENGINE
 	help
 	  Support for the NVIDIA Tegra20 APB DMA controller driver. The
-- 
2.24.0

