Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1F6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5CFC221FD
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgGNL33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:29:29 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:3531 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgGNL33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:29:29 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee55f0d9709d4a-ebdd1; Tue, 14 Jul 2020 19:29:16 +0800 (CST)
X-RM-TRANSID: 2ee55f0d9709d4a-ebdd1
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee35f0d970911e-7570e;
        Tue, 14 Jul 2020 19:29:16 +0800 (CST)
X-RM-TRANSID: 2ee35f0d970911e-7570e
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     broonie@kernel.org, tiwai@suse.com, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, lgirdwood@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] ASoC: qcom: qdsp6: Use the defined variable to clean code
Date:   Tue, 14 Jul 2020 19:29:23 +0800
Message-Id: <20200714112923.14944-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the defined variable "dev" to make the code cleaner.

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/qcom/qdsp6/q6adm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6adm.c b/sound/soc/qcom/qdsp6/q6adm.c
index da242515e..2ec868b2d 100644
--- a/sound/soc/qcom/qdsp6/q6adm.c
+++ b/sound/soc/qcom/qdsp6/q6adm.c
@@ -588,12 +588,12 @@ static int q6adm_probe(struct apr_device *adev)
 	struct device *dev = &adev->dev;
 	struct q6adm *adm;
 
-	adm = devm_kzalloc(&adev->dev, sizeof(*adm), GFP_KERNEL);
+	adm = devm_kzalloc(dev, sizeof(*adm), GFP_KERNEL);
 	if (!adm)
 		return -ENOMEM;
 
 	adm->apr = adev;
-	dev_set_drvdata(&adev->dev, adm);
+	dev_set_drvdata(dev, adm);
 	adm->dev = dev;
 	q6core_get_svc_api_info(adev->svc_id, &adm->ainfo);
 	mutex_init(&adm->lock);
-- 
2.20.1.windows.1



