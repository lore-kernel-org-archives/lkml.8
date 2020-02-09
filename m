Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C80C35250
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 16:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D0E20715
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 16:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4A3GBka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgBIQmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 11:42:03 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32780 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbgBIQlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 11:41:35 -0500
Received: by mail-lj1-f194.google.com with SMTP id y6so4439613lji.0;
        Sun, 09 Feb 2020 08:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3LEQBc7KTSu78YIgLtGrWKgS6uNh01RCVuGt61iLvic=;
        b=k4A3GBkaKt/z/ZylzUsMq4lJ/jHNzeLiDzhmTevZaQocMkfZuO+t2rISvNiVtx4Nri
         uHYD8AMmOAe4phPOqHtgw8dQ2sKzB0Eyx34s1CxKj7PnvFMSop1haFd2uDAg7t0NgB1L
         xfxlZRqu1S1DjcamYzYTeWE79aoCdbJ+ZtZ9i4L3HvGn3mVAht3JbAl/K2I78zhxMf1J
         0Na1yZC2wBDazoCkGvHQE+v6VjvXUgTbSnP/TwMTsrcdMbkijKxGqDKos6QSHpZJS+mp
         /RGtrA5cPI5U/qH9asncCPXHXRQ3NbvIwQOaOFgIyVNaRWCb8RATp4eVz4P8Hg4CHR9e
         7aWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3LEQBc7KTSu78YIgLtGrWKgS6uNh01RCVuGt61iLvic=;
        b=DrhioxfywjM9UwPbS8K7JggenSHSoRRbET9wzeTLYQjQV9RzRdMT1YmYlVAmhZwNeE
         s6GydS36pekjQ6ourY+WPA3UEMLCA+INwgT9n1CHu4f9V/uaavQY1IvEWIbgXeqe2ylT
         ju4M+kQwVCyOVdQkyK5gyzPCExaEMGui4pOUgEVpfGtS8715TuLypGzcSDQFHHD4pBj9
         1EJ7cXcS6/8BMUeoOFLVDcfdVAeXvXKAvNqZJEVIFSXqK9QLrIUQIc+bGUVRLDIFGxZ8
         /e5sx199hIi4qB9v0HL8Qpyr3JkgsXrL5qo+sW+C7F5vTj26LstRIOKPsr1xIvyVJaf8
         j7Dw==
X-Gm-Message-State: APjAAAW+IuVdIIFMwwMGSKisLa0ufH3VGjWwI/jiNdfiALU2POnmtjAK
        cS+kiJIzOhIUCgLXyIN9Yk8=
X-Google-Smtp-Source: APXvYqxccbVpQt+x2FQxqF4GtAyS5ZURP8TYIFbUBig7J1934sk+0FtlolbUrjN3RE2ZwySZbUgUEQ==
X-Received: by 2002:a2e:9e55:: with SMTP id g21mr5593324ljk.245.1581266493232;
        Sun, 09 Feb 2020 08:41:33 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g21sm4941826ljj.53.2020.02.09.08.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 08:41:32 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 17/19] dmaengine: tegra-apb: Support COMPILE_TEST
Date:   Sun,  9 Feb 2020 19:33:54 +0300
Message-Id: <20200209163356.6439-18-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200209163356.6439-1-digetx@gmail.com>
References: <20200209163356.6439-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is nothing arch-specific in the driver's code, so let's enable
compile-testing for the driver.

Acked-by: Jon Hunter <jonathanh@nvidia.com>
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

