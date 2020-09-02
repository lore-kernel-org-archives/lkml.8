Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C920BC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 11:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A7B02072A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 11:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FA9jJNgx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgIBLH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 07:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgIBLHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 07:07:51 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23049C061245
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 04:07:51 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bh1so2115798plb.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 04:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lRbPBiajhyZAHFvs+KY/rfMq5G+YigmViKEtUETUpvU=;
        b=FA9jJNgxjJvc9qlnqShwrPZn3AEONW5P4dh7YWPvhcMQXHUhYKjBtiz3kMOeuGCATx
         Fy2XOfBQo6n6bix1+nBZec3g6ou+954h1o+5cfOJzwZUNJHfWktY+cMSeDA8TgrPe3YS
         rHMF0UnGCJcoP9bav+/CLE+5Ymz2ejyJTM0JY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lRbPBiajhyZAHFvs+KY/rfMq5G+YigmViKEtUETUpvU=;
        b=bWhG8/zRSX/0SlUncrMu5o8czC/gpIm9XNMPLq4WO3Qn9lq4pg5mKl2Za2rviDmgY0
         7VH8t5ED/0/pEWcvaYQMi7MhrjkSHgRSVaxaZHHngTT5CltDiLB0ov8x5eNAO9/AvvIg
         BVtiXXbiW+8W3leiAc5yL+D9ge1FijtW4ADtkV8UuFJQ/Ns/BH8LGdBzalXENb4CbY8z
         ipe+uOnD/+KJZ0QCcNH01NUlXJxDUWNyQBfYgH13M/xsm2OL5wh54xYOXwBs08jSY5pd
         odcokkZkGmXQwbbkMo5z/ljsmshQEDECUEKZeM7e0J2ChEbSrb6OWxKLlkUxkYrKeOlq
         QgJw==
X-Gm-Message-State: AOAM532BbdVaDKwIsh2Bdg2/sPEwtKaka/Uh7b3dns43oFA87ln9E7bu
        twEZYxv24B3ePu/MWS2nYIhj+A==
X-Google-Smtp-Source: ABdhPJz6nufpjZkKMfLCKDxGwZCBogTUned6t9PlQr+Oz/xkKLuHnC2Bj9IhrBEVpB0uYV1lm1f3LQ==
X-Received: by 2002:a17:902:fe91:b029:d0:5d99:c1a2 with SMTP id x17-20020a170902fe91b02900d05d99c1a2mr6013188plm.0.1599044870566;
        Wed, 02 Sep 2020 04:07:50 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:7220:84ff:fe09:41dc])
        by smtp.gmail.com with ESMTPSA id l13sm5523144pgq.33.2020.09.02.04.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 04:07:49 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH v2] rpmsg: Avoid double-free in mtk_rpmsg_register_device
Date:   Wed,  2 Sep 2020 19:07:15 +0800
Message-Id: <20200902190709.v2.1.I56cf27cd59f4013bd074dc622c8b8248b034a4cc@changeid>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If rpmsg_register_device fails, it will call
mtk_rpmsg_release_device which already frees mdev.

Fixes: 7017996951fde84 ("rpmsg: add rpmsg support for mt8183 SCP.")
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

Changes in v2:
 - Drop useless if and ret variable (Markus Elfring)

 drivers/rpmsg/mtk_rpmsg.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/rpmsg/mtk_rpmsg.c b/drivers/rpmsg/mtk_rpmsg.c
index 83f2b8804ee989d..96a17ec2914011d 100644
--- a/drivers/rpmsg/mtk_rpmsg.c
+++ b/drivers/rpmsg/mtk_rpmsg.c
@@ -200,7 +200,6 @@ static int mtk_rpmsg_register_device(struct mtk_rpmsg_rproc_subdev *mtk_subdev,
 	struct rpmsg_device *rpdev;
 	struct mtk_rpmsg_device *mdev;
 	struct platform_device *pdev = mtk_subdev->pdev;
-	int ret;
 
 	mdev = kzalloc(sizeof(*mdev), GFP_KERNEL);
 	if (!mdev)
@@ -219,13 +218,7 @@ static int mtk_rpmsg_register_device(struct mtk_rpmsg_rproc_subdev *mtk_subdev,
 	rpdev->dev.parent = &pdev->dev;
 	rpdev->dev.release = mtk_rpmsg_release_device;
 
-	ret = rpmsg_register_device(rpdev);
-	if (ret) {
-		kfree(mdev);
-		return ret;
-	}
-
-	return 0;
+	return rpmsg_register_device(rpdev);
 }
 
 static void mtk_register_device_work_function(struct work_struct *register_work)
-- 
2.28.0.402.g5ffc5be6b7-goog

