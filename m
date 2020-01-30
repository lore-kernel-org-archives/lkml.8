Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2212C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 04:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9795206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 04:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEujdBvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgA3Elv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 23:41:51 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39278 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbgA3Ela (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 23:41:30 -0500
Received: by mail-wm1-f67.google.com with SMTP id c84so2568998wme.4;
        Wed, 29 Jan 2020 20:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VT2b3DIhkLrsXocDLVqwdbb9fFwHJxhRiEwuiWhammQ=;
        b=dEujdBvSGXigXKTZeieECdLC03pvqTxvVxP5H0d13rtCVuaiaGP8ooRgEI/GrKbzmR
         DD0eEEjBt99Lbmn9+k/CKJ6L/0wzsn7S2iKh4JKkuc3rGfrCuJnWewsn11FekI9ErhU2
         TS4HCpiBrpIuifE4CpKfuflpZ8Z5cRE20yN4AJPj8+6dhTKS3yjgm/MK5du7/MIYY6k/
         R0TjBFnpWH06WK5LZM0ZIy2oI/zH5xeyr3WMv+MPvmEfJBYr2Yfg1IULm92xODt8/Mc5
         YnG4812KuO5rEUvMWVYKLK4qryg/6n1TNMaxV4Q+f269eK4d/V+mTaK25FEpWRlB0xIV
         dvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VT2b3DIhkLrsXocDLVqwdbb9fFwHJxhRiEwuiWhammQ=;
        b=Rf+v0oZ7pFsRYp+0W2oC+lR6via9bMw0lAsvGhpb/zaJ1VKXLCYmk2qsBf/VRgyvuh
         /xRarxDpLo5kH53tdMSnrw+awEdQsM9bLSve1SR7VAwAW4Mak5FUgo8PuRWuMFLyB200
         0ClMliy41MwUpRvgVOxmI4NSmumFH81QlMO9oQmWQVVSuEPUsZA30gdNgDO+E0hh6DMG
         U8g1dga/VbAOqm3kvr0wQEWX6DuSW+LT2a40ajkz78b094gz305CPSQAIMpm11MEoNOQ
         lKx/UBCdufBSgDJtkuaztufMikKMNPKVQ2YacAZ0iONvMX6UdYkeuKr5eHF5xEAdP6BZ
         /s9g==
X-Gm-Message-State: APjAAAUvOn705ghjfv0+sYQuQI47Gx4a6X3XCHEG2w4XWZDSm6rozuem
        Zlmr+7KylK7zNK7dO5D+OFc=
X-Google-Smtp-Source: APXvYqxYXf86YcJWpgR48m5wBlMWSjpzOmnpuZw13JR3zMoDmYDHB4Oh7KgmSlXvBGAnlm3mY4exvg==
X-Received: by 2002:a1c:4d07:: with SMTP id o7mr2971396wmh.174.1580359287911;
        Wed, 29 Jan 2020 20:41:27 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g128sm4494672wme.47.2020.01.29.20.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 20:41:27 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 14/16] dmaengine: tegra-apb: Allow to compile as a loadable kernel module
Date:   Thu, 30 Jan 2020 07:38:02 +0300
Message-Id: <20200130043804.32243-15-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200130043804.32243-1-digetx@gmail.com>
References: <20200130043804.32243-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver's removal was fixed by a recent commit and module load/unload
is working well now, tested on Tegra30.

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 5142da401db3..98daf3aafdcc 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -616,7 +616,7 @@ config TXX9_DMAC
 	  integrated in chips such as the Toshiba TX4927/38/39.
 
 config TEGRA20_APB_DMA
-	bool "NVIDIA Tegra20 APB DMA support"
+	tristate "NVIDIA Tegra20 APB DMA support"
 	depends on ARCH_TEGRA
 	select DMA_ENGINE
 	help
-- 
2.24.0

