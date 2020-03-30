Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3970FC2D0E9
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 08:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B36920748
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 08:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbgC3IHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 04:07:33 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:10545 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729546AbgC3IHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 04:07:32 -0400
X-Greylist: delayed 546 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Mar 2020 04:07:31 EDT
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app12-12012 (RichMail) with SMTP id 2eec5e81a66c798-0a7d3; Mon, 30 Mar 2020 15:57:32 +0800 (CST)
X-RM-TRANSID: 2eec5e81a66c798-0a7d3
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee95e81a66be31-380c6;
        Mon, 30 Mar 2020 15:57:32 +0800 (CST)
X-RM-TRANSID: 2ee95e81a66be31-380c6
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: nomadik:remove unneeded variable
Date:   Mon, 30 Mar 2020 15:56:26 +0800
Message-Id: <1585554986-26521-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ret is unneeded, just return 0.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index 95f864d..4c56483 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -1340,8 +1340,6 @@ struct nmk_cfg_param {
 
 static int nmk_dt_pin_config(int index, int val, unsigned long *config)
 {
-	int ret = 0;
-
 	if (nmk_cfg_params[index].choice == NULL)
 		*config = nmk_cfg_params[index].config;
 	else {
@@ -1351,7 +1349,7 @@ static int nmk_dt_pin_config(int index, int val, unsigned long *config)
 				nmk_cfg_params[index].choice[val];
 		}
 	}
-	return ret;
+	return 0;
 }
 
 static const char *nmk_find_pin_name(struct pinctrl_dev *pctldev, const char *pin_name)
-- 
1.9.1



