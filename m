Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98041C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 04:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71017208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 04:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kUGCGos3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgHUEOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 00:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgHUEOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 00:14:23 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED67C061386
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 21:14:23 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id v16so315897plo.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 21:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R+6PqGDmju1P8TUKui985wN5cTC8kMP9k9WSWy+URa0=;
        b=kUGCGos3WLE1bpbh6O7msg86bx9Ao0Sf5P1qcz6SN4hewmUEXGH6Ajt8gkbFzrBxaQ
         Es1FJMpwyGCUmrZm7c9k6z+Gqp55q/SGRmM3MlvJAgIPFl6wrGT39ZPOVYBWVT/janLp
         3bzNMPXsvnVEXRD/Un5qzVTWvtrATK8365Zlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R+6PqGDmju1P8TUKui985wN5cTC8kMP9k9WSWy+URa0=;
        b=bdRhyj0a3Dzo6Hzya8hUJSwgy6tND0/yh4G3Vr1UXdaCM3LXEwSK8p569V0HIV0x2s
         d0XaCSZ1XA3Rhk3Hgksyj8LjSbSiJxjOJYPguyeczKt8PSKwyWas3ov8Xn9KHIZHJs9z
         nxiFtB4rb9nQ2+Z3Jxuwz3ZruZ6jm4sZDg6NQLhRhpivhriCa6sAn06Ljd3AkY7afr/a
         8YzyywCGLegjuxRVmAbDsHHX8/JqwHNtjU8pfQCqibMXU3BzVTvSRqhiIa5qYXQ8xTx8
         tC3Z+MMqEROFTotywVdnrqh7JzzMh2wg0R0RLagVMu8V7rQIaOzCP4U7+wK4w2pQKRVl
         CxdA==
X-Gm-Message-State: AOAM533wfd7/yBtYzgNrcGSnWlcxq/GWHVhw1EyzMelybTg0Ypn/UASx
        twUdmEMq3R+MEoS3/ldTBUXqug==
X-Google-Smtp-Source: ABdhPJyoE4QtlNetKdTpBD0mBXP4WeZ4fIV/NQsjOJ7MyXGse2cOOLja6gdF5h7neoQfxkWjQuiN6A==
X-Received: by 2002:a17:90a:ea8e:: with SMTP id h14mr956670pjz.105.1597983262635;
        Thu, 20 Aug 2020 21:14:22 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:1a60:24ff:fe89:3e93])
        by smtp.gmail.com with ESMTPSA id 30sm419936pjz.24.2020.08.20.21.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 21:14:22 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-mediatek@lists.infradead.org
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-media@vger.kernel.org, Irui Wang <irui.wang@mediatek.com>,
        Anand K Mistry <amistry@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: mtk-vcodec: set dma max segment size
Date:   Fri, 21 Aug 2020 12:14:14 +0800
Message-Id: <20200821041414.1560707-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set dma max segment size for encoder and decoder driver.

Fix following warning with CONFIG_DMA_API_DEBUG_SG=y

[   75.147825] ------------[ cut here ]------------
[   75.147844] mtk-vcodec-enc 19002000.vcodec: DMA-API: mapping sg segment longer than device claims to support [len=983040] [max=65536]
[   75.147876] WARNING: CPU: 2 PID: 4069 at kernel/dma/debug.c:1302 debug_dma_map_sg+0x1a8/0x2c4
...
[   75.148139] Call trace:
[   75.148149]  debug_dma_map_sg+0x1a8/0x2c4
[   75.148165]  vb2_dc_get_userptr+0x228/0x364 [videobuf2_dma_contig]
[   75.148178]  __buf_prepare+0x3ac/0x8c0 [videobuf2_common]
[   75.148188]  vb2_core_qbuf+0xa4/0x58c [videobuf2_common]
[   75.148199]  vb2_qbuf+0x88/0xe4 [videobuf2_v4l2]
[   75.148211]  v4l2_m2m_qbuf+0x80/0xf8 [v4l2_mem2mem]
[   75.148221]  vidioc_venc_qbuf+0x3c/0x70 [mtk_vcodec_enc]
[   75.148234]  v4l_qbuf+0x48/0x58
[   75.148242]  __video_do_ioctl+0x200/0x37c
[   75.148250]  video_usercopy+0x360/0x834
[   75.148259]  video_ioctl2+0x38/0x48
[   75.148267]  v4l2_ioctl+0x6c/0x80
[   75.148276]  do_video_ioctl+0xefc/0x4b70
[   75.148284]  v4l2_compat_ioctl32+0x5c/0xcc
[   75.148294]  __arm64_compat_sys_ioctl+0xf4/0x240
[   75.148304]  el0_svc_common+0xac/0x198
[   75.148312]  el0_svc_compat_handler+0x2c/0x40
[   75.148321]  el0_svc_compat+0x8/0x18
[   75.148328] irq event stamp: 0
[   75.148337] hardirqs last  enabled at (0): [<0000000000000000>]           (null)
[   75.148347] hardirqs last disabled at (0): [<ffffff90080e65c0>] copy_process+0x380/0x115c
[   75.148356] softirqs last  enabled at (0): [<ffffff90080e65d8>] copy_process+0x398/0x115c
[   75.148364] softirqs last disabled at (0): [<0000000000000000>]           (null)
[   75.148372] ---[ end trace 588bf529451e3531 ]---

Reported-by: Anand K Mistry <amistry@chromium.org>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c | 8 ++++++++
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
index 97a1b6664c20..3bbd0bac56d6 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
@@ -242,6 +242,14 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		mtk_v4l2_err("[VPU] vpu device in not ready");
 		return -EPROBE_DEFER;
 	}
+	if (!pdev->dev.dma_parms) {
+		pdev->dev.dma_parms = devm_kzalloc(&pdev->dev,
+						sizeof(*pdev->dev.dma_parms),
+						GFP_KERNEL);
+		if (!pdev->dev.dma_parms)
+			return -ENOMEM;
+	}
+	dma_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
 
 	vpu_wdt_reg_handler(dev->vpu_plat_dev, mtk_vcodec_dec_reset_handler,
 			dev, VPU_RST_DEC);
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
index 4d31f1ed113f..ff4a87485d69 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
@@ -249,6 +249,14 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		mtk_v4l2_err("[VPU] vpu device in not ready");
 		return -EPROBE_DEFER;
 	}
+	if (!pdev->dev.dma_parms) {
+		pdev->dev.dma_parms = devm_kzalloc(&pdev->dev,
+						sizeof(*pdev->dev.dma_parms),
+						GFP_KERNEL);
+		if (!pdev->dev.dma_parms)
+			return -ENOMEM;
+	}
+	dma_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
 
 	vpu_wdt_reg_handler(dev->vpu_plat_dev, mtk_vcodec_enc_reset_handler,
 				dev, VPU_RST_ENC);
-- 
2.28.0.297.g1956fa8f8d-goog

