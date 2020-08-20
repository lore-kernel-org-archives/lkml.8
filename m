Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05DFC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFB2920FC3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597881785;
	bh=9eM5rUoj0DJZv2BnhxvvhEMbKv87QePAjTshRCH1THE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sVmRSF8dkciilljj2wwpib++bSHY03GmxvpHe5rTivSjuofYJWE83qpBHBC8pg2N7
	 v1FBmlA29IFPGnl5F41Mxeb4XnrJgRXSi4pjLkmZrmZXKvzgFbcbKUcaa7f+hgJwoY
	 nZO6GJF2m8s7IyjbqbWPqXrvMKetvNqaHCvgcnA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgHTADE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 20:03:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728138AbgHTACz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 20:02:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FE18207FB;
        Thu, 20 Aug 2020 00:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597881774;
        bh=9eM5rUoj0DJZv2BnhxvvhEMbKv87QePAjTshRCH1THE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2o7nu1dSS+m0nRZbGMSCHW8uWG7fDDBan3hte3I2eqE/Zl0qqPP6Q2JCFBYh1C8hx
         Y4/PVFnQDxPfVcPGHy441Ahmg/cCn06rqdJdIMcQizGWfSKZHzbYpeeZFpjRoQS3IF
         79ArFxSVPA/kzEKcWm6VPSOh9GqQRDRurT6jop70=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Evgeny Novikov <novikov@ispras.ru>,
        Anton Vasilyev <vasilyev@ispras.ru>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 18/22] media: camss: fix memory leaks on error handling paths in probe
Date:   Wed, 19 Aug 2020 20:02:25 -0400
Message-Id: <20200820000229.215333-18-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820000229.215333-1-sashal@kernel.org>
References: <20200820000229.215333-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeny Novikov <novikov@ispras.ru>

[ Upstream commit f45882cfb152f5d3a421fd58f177f227e44843b9 ]

camss_probe() does not free camss on error handling paths. The patch
introduces an additional error label for this purpose. Besides, it
removes call of v4l2_async_notifier_cleanup() from
camss_of_parse_ports() since its caller, camss_probe(), cleans up all
its resources itself.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
Co-developed-by: Anton Vasilyev <vasilyev@ispras.ru>
Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/camss/camss.c | 30 +++++++++++++++--------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 3fdc9f964a3c6..2483641799dfb 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -504,7 +504,6 @@ static int camss_of_parse_ports(struct camss *camss)
 	return num_subdevs;
 
 err_cleanup:
-	v4l2_async_notifier_cleanup(&camss->notifier);
 	of_node_put(node);
 	return ret;
 }
@@ -835,29 +834,38 @@ static int camss_probe(struct platform_device *pdev)
 		camss->csid_num = 4;
 		camss->vfe_num = 2;
 	} else {
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_free;
 	}
 
 	camss->csiphy = devm_kcalloc(dev, camss->csiphy_num,
 				     sizeof(*camss->csiphy), GFP_KERNEL);
-	if (!camss->csiphy)
-		return -ENOMEM;
+	if (!camss->csiphy) {
+		ret = -ENOMEM;
+		goto err_free;
+	}
 
 	camss->csid = devm_kcalloc(dev, camss->csid_num, sizeof(*camss->csid),
 				   GFP_KERNEL);
-	if (!camss->csid)
-		return -ENOMEM;
+	if (!camss->csid) {
+		ret = -ENOMEM;
+		goto err_free;
+	}
 
 	camss->vfe = devm_kcalloc(dev, camss->vfe_num, sizeof(*camss->vfe),
 				  GFP_KERNEL);
-	if (!camss->vfe)
-		return -ENOMEM;
+	if (!camss->vfe) {
+		ret = -ENOMEM;
+		goto err_free;
+	}
 
 	v4l2_async_notifier_init(&camss->notifier);
 
 	num_subdevs = camss_of_parse_ports(camss);
-	if (num_subdevs < 0)
-		return num_subdevs;
+	if (num_subdevs < 0) {
+		ret = num_subdevs;
+		goto err_cleanup;
+	}
 
 	ret = camss_init_subdevices(camss);
 	if (ret < 0)
@@ -936,6 +944,8 @@ static int camss_probe(struct platform_device *pdev)
 	v4l2_device_unregister(&camss->v4l2_dev);
 err_cleanup:
 	v4l2_async_notifier_cleanup(&camss->notifier);
+err_free:
+	kfree(camss);
 
 	return ret;
 }
-- 
2.25.1

