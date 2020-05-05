Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE73C47258
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 04:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A34020721
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 04:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ii8+KtIL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgEEEBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 00:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbgEEEBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 00:01:24 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B71C061A10
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 21:01:24 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id h12so669760pjz.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 21:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ctoh4fSKKdbnfncF1YOVBJD74K9A/+MRfOMQ6EjpdWU=;
        b=Ii8+KtILgS8kUQw30kWi/g6X8rQQSL7btnKUADBZbiGPsB7xgLrjW/n8WdNDKbgQWN
         tD0CyhvsndPuo5olMQnHe7XkJqOToYWcqesKzfNx4Cr9zVrfqs44PzQD1F0/aSptMOBL
         eUsczSXbwqFmnb3O1kmfFjGdB5/HS/Xh7TVSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ctoh4fSKKdbnfncF1YOVBJD74K9A/+MRfOMQ6EjpdWU=;
        b=HuGMrxHCCgVpUj5wtfxlFfsCfqK/oZrA69/1rYkPJ8QJF0FVD2Y98s+fNWxX/57tyn
         PVowM0xImN4chAjLcMI6/lm8VBWIgj1N6V37TP1V+3iipU/2f61UHcjbIZFl9bevj5+i
         phVFT7xcln4Xzfa1k3A4wsVNB0Q9o9Cb+DumRcS6sve46y9xZzt0RIRHogUdh0SXrmnz
         rH7opEKAYAcBkr0vwLIXXV5cwf9DuksaN76fsfUK9H/uSas+QSKuZLT2sLeCA+Zzk+6X
         PWujAwmndco0Wrlc9NdvKVdVlujKoHUa2t0A65yf2OHov2xKdD8crrKxFZl6ysR2WzlX
         b34A==
X-Gm-Message-State: AGi0Pua6LUgciVHFjFipmo02JGpUjb+I7F2GEgGIINAfKyO5WAzNg/s5
        pbddhUhI17azesXOp4/3kmdAXtjlIpc=
X-Google-Smtp-Source: APiQypIIEru/mWi8soSg13FgeYsWH8bdQu/U7isUmQMJNW8Y7jDjPHye4EUxOyOGu5+scYfufol+BQ==
X-Received: by 2002:a17:90a:7f83:: with SMTP id m3mr525112pjl.147.1588651283555;
        Mon, 04 May 2020 21:01:23 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:a92f:c47d:76a8:b09e])
        by smtp.gmail.com with ESMTPSA id w2sm565152pfc.194.2020.05.04.21.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 21:01:23 -0700 (PDT)
From:   Eizan Miyamoto <eizan@chromium.org>
X-Google-Original-From: Eizan Miyamoto <eizan@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Eizan Miyamoto <eizan@google.com>, eizan@chromium.org,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v1 2/5] [media] mtk-mdp: handle vb2_dma_contig_set_max_seg_size errors during probe
Date:   Tue,  5 May 2020 14:00:45 +1000
Message-Id: <20200505125042.v1.2.Ie596e59e0a18935f0b7321ff45e5c5f2ce8082b1@changeid>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
In-Reply-To: <20200505040048.132493-1-eizan@google.com>
References: <20200505040048.132493-1-eizan@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cleanup to better handle errors during MDP probe.

Signed-off-by: eizan@chromium.org
Signed-off-by: Eizan Miyamoto <eizan@google.com>
---

 drivers/media/platform/mtk-mdp/mtk_mdp_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
index aeaed2cf4458..c20ac7681c6f 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
@@ -193,13 +193,19 @@ static int mtk_mdp_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mdp);
 
-	vb2_dma_contig_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
+	ret = vb2_dma_contig_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to set vb2 dma mag seg size\n");
+		goto err_set_max_seg_size;
+	}
 
 	pm_runtime_enable(dev);
 	dev_dbg(dev, "mdp-%d registered successfully\n", mdp->id);
 
 	return 0;
 
+err_set_max_seg_size:
+
 err_m2m_register:
 	v4l2_device_unregister(&mdp->v4l2_dev);
 
-- 
2.26.2.526.g744177e7f7-goog

