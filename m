Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9253C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA0A2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uw+QY/sO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbgBNNOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:14:00 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35838 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbgBNNN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 08:13:58 -0500
Received: by mail-wr1-f67.google.com with SMTP id w12so10859979wrt.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 05:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LkbErKWwYUT9sSZs7koUeGzSJ1kXs9rP2h4RESbdYMw=;
        b=uw+QY/sOU9TAjN6r5atc110IldveajcARtxPgbi7LquQXROET3VNg85+5bORKKLAKu
         5iGeKS24GIg3DNW3mSBhNmFwp2lEXa3Ro1vcVCMA2PFm4rP5KA0FDVcYsvICJrqMLVuR
         qUEdziIr7zy+V0A8rG7fLISfNXSn2WN6Or3yqBG+J36Ae1TJRjvr3EKhFESoAzjPPQTF
         OOmBR5QHU+6JXuZCXY8HzwNF3ZbmckjyDtwzWJzupWcUR4B43xNf/4oLDlmVIJjtuWhf
         xU5qfmZhkdjntRW0owJNeh3EzO49LmeGKZYe26oBCgzGNL0ix1c+lQaJQXcH24lm0Gh4
         CDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LkbErKWwYUT9sSZs7koUeGzSJ1kXs9rP2h4RESbdYMw=;
        b=sPt+62gBcLQwnyBaKDwnF0PyVB3srKMZ4Mm7byZCfs/4UZqxIRitKfTuD2ossuXb4I
         TmuS44vQkMe7VSPIm1+bospzEvJMVZODFTOpPVZPvHUQyjTiREExIa6qgdpcvaKaXpYI
         ZmkMUfzRXuPAnXDwT//SflV0Jlyc6d7+HYC4cOFZsVb77CYBBhhbYwI5e+KSx/bgn2Qk
         qJ94gE3fWy9+CyP1OhQE77q2kMOgh0c0rGgVWfIpSN4fNAePnGq9Oib7FSRV/gK0oMBO
         UdiiYLnbc87sPmRDPeUSTLYcSYHMpE3kUbWuVE6HFnnFGXSqOFM9DCNPqhCccY5Z2hdp
         fS9A==
X-Gm-Message-State: APjAAAVce2Hp6t1CGgcKqsa4iAkSuxMKGgBjkNruYj44yBFrf2MEz/Kb
        H7foDe0g1xHmoNt4QUKAPqNcIZm+DmA=
X-Google-Smtp-Source: APXvYqz68c0STkV8Q5Vc0fGN6lA992cZEJnJxpcnS0jlWkaeahzpyfKtfRZVr6TPtS9gcP80p4i0YQ==
X-Received: by 2002:a5d:4052:: with SMTP id w18mr4018666wrp.112.1581686036643;
        Fri, 14 Feb 2020 05:13:56 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id w7sm6760792wmi.9.2020.02.14.05.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 05:13:56 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH 2/5] ASoC: meson: aiu: fix clk bulk size allocation
Date:   Fri, 14 Feb 2020 14:13:47 +0100
Message-Id: <20200214131350.337968-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214131350.337968-1-jbrunet@baylibre.com>
References: <20200214131350.337968-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the size of allocated memory for the clock bulk data

Fixes: 6ae9ca9ce986 ("ASoC: meson: aiu: add i2s and spdif support")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/aiu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/meson/aiu.c b/sound/soc/meson/aiu.c
index 5c4845a23a34..de678a9d5cab 100644
--- a/sound/soc/meson/aiu.c
+++ b/sound/soc/meson/aiu.c
@@ -203,7 +203,7 @@ static int aiu_clk_bulk_get(struct device *dev,
 	struct clk_bulk_data *clks;
 	int i, ret;
 
-	clks = devm_kcalloc(dev, num, sizeof(clks), GFP_KERNEL);
+	clks = devm_kcalloc(dev, num, sizeof(*clks), GFP_KERNEL);
 	if (!clks)
 		return -ENOMEM;
 
-- 
2.24.1

