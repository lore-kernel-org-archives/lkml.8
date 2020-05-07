Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B2AC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ADFF2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GNMgHUHa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgEGKYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 06:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726093AbgEGKYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 06:24:32 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F25C061A41
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 03:24:32 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id r14so2811782pfg.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 03:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uayLP2IQIIMajpdlHbzdkBKHnRVFxtyMOMcfphNpLD0=;
        b=GNMgHUHacwUvRBlDY0qArxRb4Pu+eWtZHMaGVHLWsilTyL8VGV+tTJxWb2nMRZdoEr
         xamhmauOh8CrNbLvXypYcr9cM5xkCl36Xi5ODaECqcmO8/fbNNAhFJBSKsPF8+d+2rW6
         t52imrK2WKyuJMQ4xYUNExzjoG8mXm/7OAnQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uayLP2IQIIMajpdlHbzdkBKHnRVFxtyMOMcfphNpLD0=;
        b=i4pw+I3deySROsRhOnGC2HxjByZMGzfVeZDdJAv3/5D442bzWO0iV9SfmNfJxQxP4L
         E6qEfabwIWXRRCg29CSZmsTckgVOg+P8KAI8dZOcENcYk94y8pPp1P6E6nePAB84FLU7
         w7kaERkkBMoR8hMexxjxqBR/XbpmutthOSBha6p/MHI25eNeZDX5x7fN2M4zA/f18EEC
         GyoQ3dx2XWe+e5xukJP+ErRlXtxkymDci7ua/eXedMlr+KeESGiHC0J1BLG4i7GRhvfd
         xiDfeMSrrRFMyDbuBkPPJ3dA0xQ+B/7LQmt1V8qTs1myLDpQlssneDgbWuYn8lmlUhCj
         Mcag==
X-Gm-Message-State: AGi0PuYo/M1Tf/CAp9rssxWTe70nAh+yjEZUUGvnMgOW7XTIag+OvJiP
        hSGueQJiG1AJtptos8chdRlcstZLQfg=
X-Google-Smtp-Source: APiQypLYecQMcanYHXpWS67HlqoWpLrEJDzi2gez5ZNWrCDgTREBk/pph4o5wU3OqaQZOryRyKhRBw==
X-Received: by 2002:a63:a61:: with SMTP id z33mr10826593pgk.440.1588847071729;
        Thu, 07 May 2020 03:24:31 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:a92f:c47d:76a8:b09e])
        by smtp.gmail.com with ESMTPSA id 6sm4503318pfj.123.2020.05.07.03.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 03:24:31 -0700 (PDT)
From:   Eizan Miyamoto <eizan@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Eizan Miyamoto <eizan@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 2/5] [media] mtk-mdp: handle vb2_dma_contig_set_max_seg_size errors during probe
Date:   Thu,  7 May 2020 20:23:44 +1000
Message-Id: <20200507202337.v3.2.If340fa06d86053aaea25841b36741fe69c3126dd@changeid>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
In-Reply-To: <20200507102345.81849-1-eizan@chromium.org>
References: <20200507102345.81849-1-eizan@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cleanup to better handle errors during MDP probe.

Signed-off-by: Eizan Miyamoto <eizan@chromium.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v3: None
Changes in v2:
- remove unnecessary error handling labels in favor of err_m2m_register

 drivers/media/platform/mtk-mdp/mtk_mdp_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
index aeaed2cf4458..9b24b8d46eb7 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
@@ -193,7 +193,11 @@ static int mtk_mdp_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mdp);
 
-	vb2_dma_contig_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
+	ret = vb2_dma_contig_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to set vb2 dma mag seg size\n");
+		goto err_m2m_register;
+	}
 
 	pm_runtime_enable(dev);
 	dev_dbg(dev, "mdp-%d registered successfully\n", mdp->id);
-- 
2.26.2.526.g744177e7f7-goog

