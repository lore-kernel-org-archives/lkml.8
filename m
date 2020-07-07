Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0F8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E114206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgGGLpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:45:04 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:28696 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727834AbgGGLpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:45:03 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id 15C503D8B48ABFE1F3AD;
        Tue,  7 Jul 2020 19:44:59 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notes_smtp.zte.com.cn [10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id 067Bimif058681;
        Tue, 7 Jul 2020 19:44:48 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2020070719450240-4209657 ;
          Tue, 7 Jul 2020 19:45:02 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     timur@kernel.org
Cc:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        wang.liang82@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>
Subject: [PATCH] ASoC: fsl: mpc8610_hpcd: Add missing of_node_put()
Date:   Tue, 7 Jul 2020 19:47:47 +0800
Message-Id: <1594122467-11615-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2020-07-07 19:45:02,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2020-07-07 19:44:51,
        Serialize complete at 2020-07-07 19:44:51
X-MAIL: mse-fl1.zte.com.cn 067Bimif058681
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liao Pingfang <liao.pingfang@zte.com.cn>

After finishing using device node got from of_find_compatible_node(),
of_node_put() needs to be called.

Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
---
 sound/soc/fsl/mpc8610_hpcd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index f7bd900..b3090fe 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -426,9 +426,11 @@ static int __init mpc8610_hpcd_init(void)
 	guts_np = of_find_compatible_node(NULL, NULL, "fsl,mpc8610-guts");
 	if (of_address_to_resource(guts_np, 0, &res)) {
 		pr_err("mpc8610-hpcd: missing/invalid global utilities node\n");
+		of_node_put(guts_np);
 		return -EINVAL;
 	}
 	guts_phys = res.start;
+	of_node_put(guts_np);
 
 	return platform_driver_register(&mpc8610_hpcd_driver);
 }
-- 
2.9.5

