Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588C0C33CA2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 17:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321802084D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 17:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AF3rZjfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733263AbgALRcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 12:32:02 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45387 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733191AbgALRbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 12:31:43 -0500
Received: by mail-lj1-f195.google.com with SMTP id j26so7424044ljc.12;
        Sun, 12 Jan 2020 09:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0hLaeTkiGQpndBzsnntj+Kt92MOlWlIIs3RhP31I+1g=;
        b=AF3rZjfC3e2LMp8KwG8yJBu4lWsuaJxqzMWnY4SDWLOP5YsebM4zTGB2L2wWO+QMBV
         r2U9T/5HuthSAq/qhwbjC7iNwSzZOUwfR4490vqNySwMU5veqQr1FAjqj1uWEHlXbnaf
         TCtNiB/CQQ3tXdN0BN6arnbvl+XuqTxTZdor5JGQfAcXym72pVUw8eUKaDX5YbcpVDbZ
         /cvoobw9lBJerXFjTK+SIY+OaV4H64fZOt/J3bLfjegJ+CbYNXDgc33coN71ic5IngP/
         301kKdFX6mn1jBL6zVvcHDKc3bot//16sy9KnMhywrHwUsIVbjPE5Kxvg0V3jv23WpCw
         eroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0hLaeTkiGQpndBzsnntj+Kt92MOlWlIIs3RhP31I+1g=;
        b=Rfjx7+6FUcbBqaYir97P57tI6wE5oVq/u4M/41R3AeJN00sq/5K1HiADZQA3ZYCUnp
         mG63w6hqfmSpwmbouaSdT+M1QmnR3BrL3P2y0xL82ihxbnjhdDcbZSbO73UXpA0riKLJ
         ovZJTADkot8r+8qO7WIzM6XvMh1UqGkQxh1189eSMs8L94sb8+szbXyF9nGv9bNpzRGg
         yhKyPLyLDD/u99RjuqDilta/Bwffu1qS1H3SJIIPnsfWLwuuBQ5eJ+TD1/nwVddvBmBG
         fT8mxGKS+w88z6nYtuHxY7NBSng+l+7u+b2XTjRTVcOf7w+yufdC4k3iNJew7ZQGn/mB
         pxLQ==
X-Gm-Message-State: APjAAAWFNdnnWuSmf+1TBPxIk6dZpnripd5X6zIOVpawDm3/ZWxNihh+
        eD+BSqXP4FCpiqgTa65d26w=
X-Google-Smtp-Source: APXvYqwDyFhBtkrDhw+Tvn61pJu2+8rzeXS0mcrEA5I1ejYLwTATuESWSZR2xUEfAg2L+Y7eOmEpsw==
X-Received: by 2002:a2e:b0c9:: with SMTP id g9mr8364168ljl.134.1578850300750;
        Sun, 12 Jan 2020 09:31:40 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id 140sm4458888lfk.78.2020.01.12.09.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 09:31:40 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/14] dmaengine: tegra-apb: Allow to compile as a loadable kernel module
Date:   Sun, 12 Jan 2020 20:30:05 +0300
Message-Id: <20200112173006.29863-14-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200112173006.29863-1-digetx@gmail.com>
References: <20200112173006.29863-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver's removal was fixed by a recent commit and module load/unload
is working well now, tested on Tegra30.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 6fa1eba9d477..9f43e2cae8b4 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -586,7 +586,7 @@ config TXX9_DMAC
 	  integrated in chips such as the Toshiba TX4927/38/39.
 
 config TEGRA20_APB_DMA
-	bool "NVIDIA Tegra20 APB DMA support"
+	tristate "NVIDIA Tegra20 APB DMA support"
 	depends on ARCH_TEGRA
 	select DMA_ENGINE
 	help
-- 
2.24.0

