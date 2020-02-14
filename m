Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AB8C3B196
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 12:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7BD2187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 12:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mgJ1kYMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbgBNMBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 07:01:50 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40780 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbgBNMBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 07:01:49 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so3666194plp.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 04:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SrEeeiMYTh8tdM4uM57yi2C/Gx0ZYDeODDLqafFzdQw=;
        b=mgJ1kYMC+BKoJPHgI/QnmPPE5wphvts8MkBDeru9Bwop/IFN17dqQ8HwYmQciHiVmc
         8pDKI2wW53lT/DGGKiXtf8AYsk7nhkyInXUtN8syisSnx1SkqkFpmmaLOTfvCtTT8mN5
         aEz8ZBVe5ISoTRl7RQOkFKkH7rSgiFbU/VUMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SrEeeiMYTh8tdM4uM57yi2C/Gx0ZYDeODDLqafFzdQw=;
        b=RBqM17ytYvc1oeFH+ghDT6sgP6gt7hOkIJ8k109VtJiOLFQEC5QPXILjiQ2XXihGsl
         +z+yuAfyV1CyEBsKu92lEoqmJIU5+fRVDNFlMhbUB7gBV1WjdQUOB9v/w+n7l/NqaxG8
         qUXCuByALWV8dcYSqBehEK49ETMrwyO6lx2v/BLGC8JFX/5FlhVnGWPB3MrIZY/hjp+S
         sQeJT/bOU9+zoImBFrM6zHaKwsa1jQJThL2Ro+pXQEKhObKR/u1S4lP0216z6VwzDZsX
         5/RjHMsqQBcr3oh64VMeMvbvvCq3R/FItsRI0KqZYQ/Ua5zQ3Jgrxh0srelTJ+jnd4D6
         yVOQ==
X-Gm-Message-State: APjAAAXLJ9TwYjwIegnnaEZPv3Ye+1nkFXNGV/hIlFhRtZ2y7ctjl3c9
        JWUQzG2Fp1fTQPiOR/rojgisaw==
X-Google-Smtp-Source: APXvYqwWBAPzKlqlSPflws7rlPOk76DpJUm2SkfSFNRolVl+WFSLvA3yN/iX862TqE8JTe7pwnmITA==
X-Received: by 2002:a17:902:b40c:: with SMTP id x12mr3045452plr.70.1581681708257;
        Fri, 14 Feb 2020 04:01:48 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id s18sm7120275pgn.34.2020.02.14.04.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 04:01:47 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] media: mtk-vpu: avoid unaligned access to DTCM buffer.
Date:   Fri, 14 Feb 2020 20:01:42 +0800
Message-Id: <20200214120142.50529-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct vpu_run *run in vpu_init_ipi_handler() is an ioremapped DTCM (Data
Tightly Coupled Memory) buffer shared with AP.  It's not able to do
unaligned access. Otherwise kernel would crash due to unable to handle
kernel paging request.

struct vpu_run {
	u32 signaled;
	char fw_ver[VPU_FW_VER_LEN];
	unsigned int	dec_capability;
	unsigned int	enc_capability;
	wait_queue_head_t wq;
};

fw_ver starts at 4 byte boundary. If system enables
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS, strscpy() will do
read_word_at_a_time(), which tries to read 8-byte: *(unsigned long *)addr

Copy the string by memcpy_fromio() for this buffer to avoid unaligned
access.

Fixes: 85709cbf1524 ("media: replace strncpy() by strscpy()")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
Change in v2:
- fix sparse warnings.
---
 drivers/media/platform/mtk-vpu/mtk_vpu.c | 17 ++++++++++-------
 drivers/media/platform/mtk-vpu/mtk_vpu.h |  2 +-
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/mtk-vpu/mtk_vpu.c b/drivers/media/platform/mtk-vpu/mtk_vpu.c
index a768707abb94..c59373e84a33 100644
--- a/drivers/media/platform/mtk-vpu/mtk_vpu.c
+++ b/drivers/media/platform/mtk-vpu/mtk_vpu.c
@@ -600,15 +600,18 @@ int vpu_load_firmware(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(vpu_load_firmware);
 
-static void vpu_init_ipi_handler(void *data, unsigned int len, void *priv)
+static void vpu_init_ipi_handler(void __iomem *data, unsigned int len,
+				 void *priv)
 {
 	struct mtk_vpu *vpu = (struct mtk_vpu *)priv;
-	struct vpu_run *run = (struct vpu_run *)data;
-
-	vpu->run.signaled = run->signaled;
-	strscpy(vpu->run.fw_ver, run->fw_ver, sizeof(vpu->run.fw_ver));
-	vpu->run.dec_capability = run->dec_capability;
-	vpu->run.enc_capability = run->enc_capability;
+	struct vpu_run __iomem *run = data;
+
+	vpu->run.signaled = readl(&run->signaled);
+	memcpy_fromio(vpu->run.fw_ver, run->fw_ver, sizeof(vpu->run.fw_ver));
+	/* Make sure the string is NUL-terminated */
+	vpu->run.fw_ver[sizeof(vpu->run.fw_ver) - 1] = '\0';
+	vpu->run.dec_capability = readl(&run->dec_capability);
+	vpu->run.enc_capability = readl(&run->enc_capability);
 	wake_up_interruptible(&vpu->run.wq);
 }
 
diff --git a/drivers/media/platform/mtk-vpu/mtk_vpu.h b/drivers/media/platform/mtk-vpu/mtk_vpu.h
index d4453b4bcee9..a7ac351b19c1 100644
--- a/drivers/media/platform/mtk-vpu/mtk_vpu.h
+++ b/drivers/media/platform/mtk-vpu/mtk_vpu.h
@@ -15,7 +15,7 @@
  * VPU interfaces with other blocks by share memory and interrupt.
  **/
 
-typedef void (*ipi_handler_t) (void *data,
+typedef void (*ipi_handler_t) (void __iomem *data,
 			       unsigned int len,
 			       void *priv);
 
-- 
2.25.0.265.gbab2e86ba0-goog

