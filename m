Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AF7C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 11:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D2B62072D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 11:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g8iv19BU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgHULUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 07:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgHULTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 07:19:49 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41FAC061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 04:19:47 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 189so839969pgg.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 04:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2VIeirKC7U7WGWxGmP4oRtrh71NIdS/JKoywFCrHktQ=;
        b=g8iv19BUauBM54+OaGxIEwnRevuDpN11JroVr9XjhhoUpwbDGmNMYGxZyruJZIF65u
         Sng5gJC2U+duUzp9VJUfRYkuhqKw47vBKo/JTk0vQ0WRR1QMg5SEp6a1LMRhomUMdwqU
         0M6WQrtnvRLSZpDjsnoDAQkUue1O8ysZpS0IA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2VIeirKC7U7WGWxGmP4oRtrh71NIdS/JKoywFCrHktQ=;
        b=ftjXny8bnwmxp3wjNknpUDWqfEYgZW3g+2Lpl02EbSZb5Tc2llmnT8eWn3+E1mHUBB
         i8yOwNR+hDnflRukyGm1lSd5/V4p7oUgxwq4TR+AaVIWA7vkjYc0QDIZqS5qrLlg3OvQ
         WZZ2tWTvm9ohw5PKt9KRbbN3CEKNtZYz97/yi4l+9G1EGohVN4bCUpYIS6rhlFkVH7Dp
         aDyQWRXfgZv6etHRmsLxKBa5iC6Cj4WrlluNfEyVO/TgyodLv4l5WerpUmTkRMNPcYX1
         LrfiPuyY3lCxZCn5FiBvRJIjUtJ7kE6Ly+refcCmF5fs9hQoLey7oEwQiy2bcv81kw31
         HHmQ==
X-Gm-Message-State: AOAM531rr3dRQRM/Vz7COsLdTRZ9Sxp2gNuI2pWzZD7C52M2VCiAOQZs
        gD47nSxtQQDthHy2VbnmbsOcJw==
X-Google-Smtp-Source: ABdhPJzVqnf1RyIgIZ6S3FevYn5PI/d8NZHy8ofqSoD4DTDV68i+kCDcddYWR+B+ab6mPFfxG2R/4g==
X-Received: by 2002:a05:6a00:1343:: with SMTP id k3mr2146199pfu.91.1598008785422;
        Fri, 21 Aug 2020 04:19:45 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:eeb1:d7ff:fe57:b7e5])
        by smtp.gmail.com with ESMTPSA id p9sm1860786pge.39.2020.08.21.04.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 04:19:44 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH] media: mtk-vcodec: make IRQs disabled upon request
Date:   Fri, 21 Aug 2020 20:19:23 +0900
Message-Id: <20200821111924.2328306-1-acourbot@chromium.org>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver requests IRQs to disable them immediately. This is
potentially racy, fix this by requesting the IRQs to come disabled
instead using the IRQ_NOAUTOEN flag of irq_set_status_flags().

Reported-by: Ezequiel Garcia <ezequiel@collabora.com>
Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
The "media: mtk-vcodec: venc: support for MT8183" happens to change this
part of the code, this version applies on top of it (but adapting it to
the media ToT is trivial). If preferred I can include this one on top of
the series on its next respin, even though it also touches the decoder.

 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c | 2 +-
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
index 5b5765b98e57..a6ba342f7bc8 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
@@ -259,6 +259,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 	}
 
 	dev->dec_irq = platform_get_irq(pdev, 0);
+	irq_set_status_flags(dev->dec_irq, IRQ_NOAUTOEN);
 	ret = devm_request_irq(&pdev->dev, dev->dec_irq,
 			mtk_vcodec_dec_irq_handler, 0, pdev->name, dev);
 	if (ret) {
@@ -268,7 +269,6 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		goto err_res;
 	}
 
-	disable_irq(dev->dec_irq);
 	mutex_init(&dev->dec_mutex);
 	mutex_init(&dev->dev_mutex);
 	spin_lock_init(&dev->irqlock);
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
index d6438cb4eead..2a4136e6e867 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
@@ -311,6 +311,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 	}
 
 	dev->enc_irq = platform_get_irq(pdev, 0);
+	irq_set_status_flags(dev->enc_irq, IRQ_NOAUTOEN);
 	ret = devm_request_irq(&pdev->dev, dev->enc_irq,
 			       mtk_vcodec_enc_irq_handler,
 			       0, pdev->name, dev);
@@ -321,7 +322,6 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		ret = -EINVAL;
 		goto err_res;
 	}
-	disable_irq(dev->enc_irq);
 
 	if (dev->venc_pdata->has_lt_irq) {
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
@@ -333,6 +333,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		mtk_v4l2_debug(2, "reg[%d] base=0x%p", i, dev->reg_base[VENC_LT_SYS]);
 
 		dev->enc_lt_irq = platform_get_irq(pdev, 1);
+		irq_set_status_flags(dev->enc_lt_irq, IRQ_NOAUTOEN);
 		ret = devm_request_irq(&pdev->dev,
 				       dev->enc_lt_irq,
 				       mtk_vcodec_enc_lt_irq_handler,
@@ -344,7 +345,6 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 			ret = -EINVAL;
 			goto err_res;
 		}
-		disable_irq(dev->enc_lt_irq); /* VENC_LT */
 	}
 
 	mutex_init(&dev->enc_mutex);
-- 
2.28.0.297.g1956fa8f8d-goog

