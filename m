Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D013C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 03:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3905F20739
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 03:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XdrQDrDD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbgGFD2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 23:28:41 -0400
Received: from mail-m972.mail.163.com ([123.126.97.2]:50154 "EHLO
        mail-m972.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbgGFD2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 23:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=5yazT
        dyA3YxMPgoBpYzzCyqT8fJEoy7VrCOXLHWeXI8=; b=XdrQDrDDQoHy04HdxYZxj
        h3KjGArTII3jkEehfkOKhLmlREGMWNGvTeO5+jV64xvkcLfmvFxWAzwZeH4qkpeZ
        PrxA6H4qj7dMX1PKcoeWBfjUrQzCwWiZLQAPWqCJk8D6+pB6B5zCWaSF55gNp7Zp
        D+xs/Yq1p/8GgVurTtRZqU=
Received: from ubuntu.localdomain (unknown [182.113.175.219])
        by smtp2 (Coremail) with SMTP id GtxpCgC3GA8rmgJfecIjDg--.165S3;
        Mon, 06 Jul 2020 11:27:44 +0800 (CST)
From:   Xidong Wang <wangxidong_97@163.com>
To:     Xidong Wang <wangxidong_97@163.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] ALSA: opl3: fix infoleak in opl3
Date:   Sun,  5 Jul 2020 20:27:38 -0700
Message-Id: <1594006058-30362-1-git-send-email-wangxidong_97@163.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgC3GA8rmgJfecIjDg--.165S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFy7ZFy8tF4UtF4kAr45Awb_yoW3Krg_C3
        4Fqrn7Zryrurn2yr4ayFW3ZrZrKasrZw1vqF42vry3J3sa9ryavr1kZryxWF1UJFs7WF43
        Z3savr48AF98JjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRic_-PUUUUU==
X-Originating-IP: [182.113.175.219]
X-CM-SenderInfo: pzdqw5xlgr0wrbzxqiywtou0bp/1tbiyBBZ81p7AiB0FQAAsQ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xidongwang <wangxidong_97@163.com>

The stack object “info” in snd_opl3_ioctl() has a leaking problem.
It has 2 padding bytes which are not initialized and leaked via
“copy_to_user”.

Signed-off-by: xidongwang <wangxidong_97@163.com>
---
 sound/drivers/opl3/opl3_synth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/drivers/opl3/opl3_synth.c b/sound/drivers/opl3/opl3_synth.c
index e69a4ef..08c10ac 100644
--- a/sound/drivers/opl3/opl3_synth.c
+++ b/sound/drivers/opl3/opl3_synth.c
@@ -91,6 +91,8 @@ int snd_opl3_ioctl(struct snd_hwdep * hw, struct file *file,
 		{
 			struct snd_dm_fm_info info;
 
+			memset(&info, 0, sizeof(info));
+
 			info.fm_mode = opl3->fm_mode;
 			info.rhythm = opl3->rhythm;
 			if (copy_to_user(argp, &info, sizeof(struct snd_dm_fm_info)))
-- 
2.7.4

