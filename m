Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A432C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0ABB2051A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ltTXZwDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731252AbgBYRYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:24:44 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34043 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbgBYRYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:24:44 -0500
Received: by mail-pf1-f196.google.com with SMTP id i6so7547699pfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 09:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lfotpKjLU7BxU2unCoAL0OLP6JpkqZvfhxJOwfxAYmg=;
        b=ltTXZwDqi3bj0f4va6iSNa+noIAQ6niJVSGeslx5czOaMstk4QGvtQQBXCIA5DdolR
         n4MHGW+hII0IRLuu5vH5+ECcXvVBUIxDWvuiepyhTBqQbzFDKU5Eg6L51TGu0NJl6T2d
         4Aj3Fnggf+FTY9ad5BqpOrZyLPt3CvCy1aEd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lfotpKjLU7BxU2unCoAL0OLP6JpkqZvfhxJOwfxAYmg=;
        b=MpnRqUlPwKk6kDAdz+uhEO7DV2S4h5ILOXtdDY4l2rbyWmXsytbQhtHJAqIkBiQNi6
         L8w1fgr01F3+5RTTfG8+oMKpi7oZ0RKn07MN1P6zjkp/noJ+4Ea8nIDuyGbThLLRror2
         kSuA4HbhrSD71g3dL1vxQrGsPfZenbQvkIAHvd9V06IfVA5fyjk1mM5x7Awh5z1pb87n
         X5DhJlutiqw7T7XTN6Z/xfOmMKzefgA4EwIquLyyTP3ZiFo+6Xw/FA/2dKNtSzr/cPO4
         0qm90tKW6Hhc+9JyYwO82UYE/ovt7a3lPz8NkZy6deC52bsDECi5BIh0We1EHxGHmwqb
         P8SA==
X-Gm-Message-State: APjAAAVESor8WYd04J8+wjPr2twGCfMnAoSsryK4dmXPylHKsWy+x68j
        DB/No4AQN/yo8IBQB8hNXS+9kg==
X-Google-Smtp-Source: APXvYqwArngtth7ItH3EpE8LH8S4j/eVAVVg6AqEvqOu3xoUF1RjeEXBYLVRxkXdit5VDdriBk3z6w==
X-Received: by 2002:a63:cf06:: with SMTP id j6mr39603191pgg.379.1582651483432;
        Tue, 25 Feb 2020 09:24:43 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id a17sm11099378pgv.11.2020.02.25.09.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 09:24:42 -0800 (PST)
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
Subject: [PATCH v3] media: mtk-vpu: avoid unaligned access to DTCM buffer.
Date:   Wed, 26 Feb 2020 01:24:37 +0800
Message-Id: <20200225172437.106679-1-hsinyi@chromium.org>
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
Change in v3:
- fix sparse warnings.
Change in v2:
- fix sparse warnings.
---
 drivers/media/platform/mtk-vpu/mtk_vpu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/mtk-vpu/mtk_vpu.c b/drivers/media/platform/mtk-vpu/mtk_vpu.c
index a768707abb94..e3fd2d1814f3 100644
--- a/drivers/media/platform/mtk-vpu/mtk_vpu.c
+++ b/drivers/media/platform/mtk-vpu/mtk_vpu.c
@@ -603,12 +603,14 @@ EXPORT_SYMBOL_GPL(vpu_load_firmware);
 static void vpu_init_ipi_handler(void *data, unsigned int len, void *priv)
 {
 	struct mtk_vpu *vpu = (struct mtk_vpu *)priv;
-	struct vpu_run *run = (struct vpu_run *)data;
-
-	vpu->run.signaled = run->signaled;
-	strscpy(vpu->run.fw_ver, run->fw_ver, sizeof(vpu->run.fw_ver));
-	vpu->run.dec_capability = run->dec_capability;
-	vpu->run.enc_capability = run->enc_capability;
+	struct vpu_run __iomem *run = (struct vpu_run __iomem __force *)data;
+
+	vpu->run.signaled = readl(&run->signaled);
+	memcpy_fromio(vpu->run.fw_ver, run->fw_ver, sizeof(vpu->run.fw_ver));
+	/* Make sure the string is NUL-terminated */
+	vpu->run.fw_ver[sizeof(vpu->run.fw_ver) - 1] = '\0';
+	vpu->run.dec_capability = readl(&run->dec_capability);
+	vpu->run.enc_capability = readl(&run->enc_capability);
 	wake_up_interruptible(&vpu->run.wq);
 }
 
-- 
2.25.0.265.gbab2e86ba0-goog

