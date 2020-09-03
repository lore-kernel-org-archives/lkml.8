Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3726FC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 11:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F08552071B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 11:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="FOTskssg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgICLig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 07:38:36 -0400
Received: from crapouillou.net ([89.234.176.41]:51414 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728596AbgICLbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 07:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1599132378; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VitADMM0fnVC5UEnlJQqBbjbeuxkosY7PKciS9JCWhQ=;
        b=FOTskssgTXu613ZyXQFH73GPSn4sAH4YrP0JV6oEP+WsASxewPFIop8x6uA55dH2X0sPIU
        nYurhrftzHdBnJRaCPCA6k8tDEyO3YMnmeLEyHvxrjcjUS+VBt6Ymr6jWUZnVt/N1mci+7
        cxpnf7I+HG5vzL5cT8vb59uEQPISUYA=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Prisk <linux@prisktech.co.nz>, Bin Liu <b-liu@ti.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 06/20] usb/chipidea: core: Use pm_ptr() macro
Date:   Thu,  3 Sep 2020 13:25:40 +0200
Message-Id: <20200903112554.34263-7-paul@crapouillou.net>
In-Reply-To: <20200903112554.34263-1-paul@crapouillou.net>
References: <20200903112554.34263-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the newly introduced pm_ptr() macro, and mark the suspend/resume
functions __maybe_unused. These functions can then be moved outside the
CONFIG_PM_SUSPEND block, and the compiler can then process them and
detect build failures independently of the config. If unused, they will
simply be discarded by the compiler.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/usb/chipidea/core.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index aa40e510b806..af64ab98fb56 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -1231,9 +1231,8 @@ static int ci_hdrc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
 /* Prepare wakeup by SRP before suspend */
-static void ci_otg_fsm_suspend_for_srp(struct ci_hdrc *ci)
+static void __maybe_unused ci_otg_fsm_suspend_for_srp(struct ci_hdrc *ci)
 {
 	if ((ci->fsm.otg->state == OTG_STATE_A_IDLE) &&
 				!hw_read_otgsc(ci, OTGSC_ID)) {
@@ -1245,7 +1244,7 @@ static void ci_otg_fsm_suspend_for_srp(struct ci_hdrc *ci)
 }
 
 /* Handle SRP when wakeup by data pulse */
-static void ci_otg_fsm_wakeup_by_srp(struct ci_hdrc *ci)
+static void __maybe_unused ci_otg_fsm_wakeup_by_srp(struct ci_hdrc *ci)
 {
 	if ((ci->fsm.otg->state == OTG_STATE_A_IDLE) &&
 		(ci->fsm.a_bus_drop == 1) && (ci->fsm.a_bus_req == 0)) {
@@ -1259,7 +1258,7 @@ static void ci_otg_fsm_wakeup_by_srp(struct ci_hdrc *ci)
 	}
 }
 
-static void ci_controller_suspend(struct ci_hdrc *ci)
+static void __maybe_unused ci_controller_suspend(struct ci_hdrc *ci)
 {
 	disable_irq(ci->irq);
 	ci_hdrc_enter_lpm(ci, true);
@@ -1277,7 +1276,7 @@ static void ci_controller_suspend(struct ci_hdrc *ci)
  * interrupt (wakeup int) only let the controller be out of
  * low power mode, but not handle any interrupts.
  */
-static void ci_extcon_wakeup_int(struct ci_hdrc *ci)
+static void __maybe_unused ci_extcon_wakeup_int(struct ci_hdrc *ci)
 {
 	struct ci_hdrc_cable *cable_id, *cable_vbus;
 	u32 otgsc = hw_read_otgsc(ci, ~0);
@@ -1294,7 +1293,7 @@ static void ci_extcon_wakeup_int(struct ci_hdrc *ci)
 		ci_irq(ci->irq, ci);
 }
 
-static int ci_controller_resume(struct device *dev)
+static int __maybe_unused ci_controller_resume(struct device *dev)
 {
 	struct ci_hdrc *ci = dev_get_drvdata(dev);
 	int ret;
@@ -1332,8 +1331,7 @@ static int ci_controller_resume(struct device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int ci_suspend(struct device *dev)
+static int __maybe_unused ci_suspend(struct device *dev)
 {
 	struct ci_hdrc *ci = dev_get_drvdata(dev);
 
@@ -1366,7 +1364,7 @@ static int ci_suspend(struct device *dev)
 	return 0;
 }
 
-static int ci_resume(struct device *dev)
+static int __maybe_unused ci_resume(struct device *dev)
 {
 	struct ci_hdrc *ci = dev_get_drvdata(dev);
 	int ret;
@@ -1386,9 +1384,8 @@ static int ci_resume(struct device *dev)
 
 	return ret;
 }
-#endif /* CONFIG_PM_SLEEP */
 
-static int ci_runtime_suspend(struct device *dev)
+static int __maybe_unused ci_runtime_suspend(struct device *dev)
 {
 	struct ci_hdrc *ci = dev_get_drvdata(dev);
 
@@ -1408,13 +1405,12 @@ static int ci_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int ci_runtime_resume(struct device *dev)
+static int __maybe_unused ci_runtime_resume(struct device *dev)
 {
 	return ci_controller_resume(dev);
 }
 
-#endif /* CONFIG_PM */
-static const struct dev_pm_ops ci_pm_ops = {
+static const struct dev_pm_ops __maybe_unused ci_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(ci_suspend, ci_resume)
 	SET_RUNTIME_PM_OPS(ci_runtime_suspend, ci_runtime_resume, NULL)
 };
@@ -1424,7 +1420,7 @@ static struct platform_driver ci_hdrc_driver = {
 	.remove	= ci_hdrc_remove,
 	.driver	= {
 		.name	= "ci_hdrc",
-		.pm	= &ci_pm_ops,
+		.pm	= pm_ptr(&ci_pm_ops),
 		.dev_groups = ci_groups,
 	},
 };
-- 
2.28.0

