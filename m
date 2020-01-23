Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C005C33CAA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 23:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D988F21734
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 23:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0idhHLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbgAWXLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 18:11:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36745 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729921AbgAWXLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 18:11:03 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so5214634wru.3;
        Thu, 23 Jan 2020 15:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QMJiXLF1JbYFb+JW/uJeE/qawBShUmR+DHoM9EjGezk=;
        b=d0idhHLC9THq4K5LGz36aLPqrpXYpX+W2KMXspfIWMeBlV2v+FEkZjKahD0jvgIQLF
         uB2vJd3lOWB+MGYf4SuIAQrWdj88KKQNkpCIDTWWTHf2S51vqGL7og/F9YemACSoBkJh
         29TF0Skv4bjCmVPRbgyQb4MYov9HZxD62xM7tTDN2o1B0P1SEXA9QI/+dp+1kxzq6S/R
         WRSSuNjiEPD8ApHNrHTgE2NyAhnblLpa5VP6HRnMbsBj3IRmaKG7nGM7B02fuA/YBj+z
         YQ7frwo3Ux6TSLzREqfBTEK2267tqOej+rL1UFp2z+0BF9UhNHaZllfC4mZY9nuvpm8w
         TVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QMJiXLF1JbYFb+JW/uJeE/qawBShUmR+DHoM9EjGezk=;
        b=hQuV4vVZ2vSXzlfe5NgIDPTsCVP5UWdnOMiqnBTl7pI+fAMaBqizjoxMwdNrhQIsto
         CYlPpe9QMtqZi0+9T4vdFh3EV/udtLWUgGcJPdVAP1uEjJEMrBWtbj1ZnczK7F+o7Yeb
         XV7d9tqMODrDkghxruVD/NR/IC5BGw0gDxQYgSDY5N94VIrOO91noeT7BJy6boyz5o3u
         od0p49IX8ZuLcU7+OzM0noTHKANdT6e9Vywmo3XBiNaRrrhEl9f9NeKWxHFNCPdYoI8/
         msPJGEBlioZhuZtn3w3AhL/V8PzjB7gZgOCVS7cW/3xMYuIz/Fz3WwQgdEh6vTCjHFFp
         i6Xg==
X-Gm-Message-State: APjAAAVsotbfsxTKL0hvb6/WyeGBP9TO5o/phSoNd/AeeC4uIURLLcPM
        06jHWQQHKQ5qLlSGoEfw56U=
X-Google-Smtp-Source: APXvYqyTPHMPE845HLY2B5GKwIiCGHer2IWZI3hDnBCaAmDvl3yXjJXOPRuuOri8w/BzlrEodwNJTQ==
X-Received: by 2002:adf:fc4b:: with SMTP id e11mr484141wrs.326.1579821061580;
        Thu, 23 Jan 2020 15:11:01 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id z6sm5105552wrw.36.2020.01.23.15.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 15:11:01 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 14/14] dmaengine: tegra-apb: Remove MODULE_ALIAS
Date:   Fri, 24 Jan 2020 02:03:25 +0300
Message-Id: <20200123230325.3037-15-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200123230325.3037-1-digetx@gmail.com>
References: <20200123230325.3037-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra APB DMA driver is an Open Firmware driver and thus it uses OF alias
naming scheme which overrides MODULE_ALIAS, meaning that MODULE_ALIAS does
nothing and could be removed safely.

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 8f4281ab6296..756a5dbef118 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1684,7 +1684,6 @@ static struct platform_driver tegra_dmac_driver = {
 
 module_platform_driver(tegra_dmac_driver);
 
-MODULE_ALIAS("platform:tegra20-apbdma");
 MODULE_DESCRIPTION("NVIDIA Tegra APB DMA Controller driver");
 MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.24.0

