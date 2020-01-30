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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4EEC33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 04:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1372082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 04:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRfcSnbx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgA3EmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 23:42:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36565 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbgA3ElX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 23:41:23 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so2591107wma.1;
        Wed, 29 Jan 2020 20:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cjyMiwvc8w9ROljcHQa4qpuZZMm1wlAr5aTxKnohorU=;
        b=LRfcSnbxZRU9OSZNiCMYYhUj+XKN6WAfZyPo/z/92GAYluOYZlr2KKh9yasuNjI8fK
         H40wEbYFe7v93RpGec4HKT2TLwN+FqikQnVZgtHvQ07vnTKFk1Kw3eiqXRg+zi9hC8ez
         1PBijBciAMN8CCtPkMeLYrG95p7K/QH4TbuHOa28VDO65BGtTu7ehCqbzVADdX+vdk76
         q/vxzK3O9k22AoRLBOmr64MswHoCWb6D8vJ6WOwt92blInnp11NhdMcmDoM46j3QRpC6
         y+wLSXOuljAkUj/u4vKqXYFF/nRfFcWzowpNNPeF8HdVv0I51ibclYCsHh8K1lHXbedw
         rBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cjyMiwvc8w9ROljcHQa4qpuZZMm1wlAr5aTxKnohorU=;
        b=IVfKtq9Nujp1xMc5Wt5STIV4BbmU3eVy8aYSGmqKZ1/88NLPjVUg64Zd4B5I1ahahi
         SgwFWw1xMguCipmoUxiJQ4UDCOXubueExHQmqxoCPkr0BUXSfBDk3tUWrMiBqtlYLyOm
         vs2Q/uzrM/Yv30g/pd2t5Hq8anwUQT1fQn7Np1U2MPhmdInCT1j0CYY/ke824EUgKULq
         9BZo9EW+xy4iA5b5lrG/NWNTRFPZHvIxpvp3R7oX4eK5e99vGrB04g4rI2l/zcbkua4W
         gQhDrj75kEKUsfqhVY+quZJW5mhQBNEdaEvSyd1rvcbMku/mIW7hTlRlPNffQOe6f9H2
         d3fw==
X-Gm-Message-State: APjAAAVL24WZLSEWgmmErkTBXLetPJOokYPh+7+JtnWZ5J7t3bEtVOTj
        G4KbWgHwZbjSVHxO9Q0mEHY=
X-Google-Smtp-Source: APXvYqzHgWOFn6gkOgLJssjd+KE9/PDpd/dXJm0yaFOwaOPu6g+7d30AHRWNQMCGk/rRxif1qxbvjw==
X-Received: by 2002:a1c:545d:: with SMTP id p29mr3096030wmi.91.1580359281947;
        Wed, 29 Jan 2020 20:41:21 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g128sm4494672wme.47.2020.01.29.20.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 20:41:21 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 09/16] dmaengine: tegra-apb: Remove unneeded initialization of tdc->config_init
Date:   Thu, 30 Jan 2020 07:37:57 +0300
Message-Id: <20200130043804.32243-10-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200130043804.32243-1-digetx@gmail.com>
References: <20200130043804.32243-1-digetx@gmail.com>
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

