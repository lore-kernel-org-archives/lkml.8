Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B70DC35250
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 16:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61CC12080C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 16:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rd3UPcIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgBIQld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 11:41:33 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36438 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbgBIQl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 11:41:27 -0500
Received: by mail-lf1-f67.google.com with SMTP id f24so2495420lfh.3;
        Sun, 09 Feb 2020 08:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AVyPwwbkLVlQVChdUAgWIuplnsUu4TqO1h0F/ALyeGY=;
        b=rd3UPcIKB3oczwbjvNOErgOhvMm/98rb4QCXLe0UllcLl03wLAmIGAuhXE2hESOC0z
         FlnKP34Wt6uYYPVFU2pjSkPQ7HXRobCAKBFBt5el+XNuIF7mde/MOBmVo9+uNF5Fvn1R
         DGs+55uSFKIlQZA3CojOKzWXxb9pmT1tzEnR2XrfmRn46NmC2vbYKLcEaxBSFXLc/zhT
         qQyBqKJSPxFjVERelLkAIABJZTHdHsgG2PGb5a99EVSr4HfMXlIbuZhJeWQ9HKObgETe
         XAjO4ixYYxoDnKpmGEgtxjAzfVQxqCiWBikr9iw5CN8qXuqfk3In+/7dyscx+3Tnxajm
         OIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AVyPwwbkLVlQVChdUAgWIuplnsUu4TqO1h0F/ALyeGY=;
        b=AicYPbHdEDFMjuqpTk4jzlq3yWAOjpzdk75ILutN8TVQRFEVTv/rKr9IxYxzNZItcq
         fW/Sq71JZqKBFhntvKOxptZInmustY+rJN28VZAso0omMWmyUge8aiC1umz1nxwMyNzd
         WzKfPNKkUPeS0Rzr2OK5ZNU9UZ2UlIR+MPWPTS0Xg9KQC62EXnvwNDCz3zoz8AqsZTfV
         chQMmVsLtpKQTAn5NtICl4bfBUf7BgmSfxH4k4YnYPIoW54uAahKrQ7m+Vg8dGOl0sXc
         sHKmqzzKXxFfPBuWRv2YUNhRo3bZRbh2jAZpM5+bgwBwaS4cY8CSph6j+Exj/o/dnQw3
         Y6dg==
X-Gm-Message-State: APjAAAUO/RBEAH4jkb7oHFXQI7yvzZsi1Yc/DyiRHM0b8p3jdx3szBno
        0jCYdJ8lNm6VEoF3wZmD070=
X-Google-Smtp-Source: APXvYqzlGfN5y/Y4Eqme9THhAWmGciQLI6iX0MtePPM3k4ssDAZB0LWdmFcS2wS2VsQT4+6GvrfVhg==
X-Received: by 2002:a19:c7d8:: with SMTP id x207mr4207767lff.142.1581266485305;
        Sun, 09 Feb 2020 08:41:25 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g21sm4941826ljj.53.2020.02.09.08.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 08:41:24 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 09/19] dmaengine: tegra-apb: Remove unneeded initialization of tdc->config_init
Date:   Sun,  9 Feb 2020 19:33:46 +0300
Message-Id: <20200209163356.6439-10-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200209163356.6439-1-digetx@gmail.com>
References: <20200209163356.6439-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to re-initialize the already initialized variables.
The tdc->config_init=false after driver's probe and after channel's
freeing, so there is no need to re-initialize it on the channel's
allocation.

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index b4535b3a07ce..7158bd3145c4 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1284,7 +1284,6 @@ static int tegra_dma_alloc_chan_resources(struct dma_chan *dc)
 	int ret;
 
 	dma_cookie_init(&tdc->dma_chan);
-	tdc->config_init = false;
 
 	ret = pm_runtime_get_sync(tdma->dev);
 	if (ret < 0)
-- 
2.24.0

