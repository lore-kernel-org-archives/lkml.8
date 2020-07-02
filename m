Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040B4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D10F0206BE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593674956;
	bh=u29VM/PVO5QZE/Adf28yl93d1nQzkhUiMwFZCmk0V2Q=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=MF3l48Vb/wvnbfDODTXjmL6gsJsmwWr30Mz1FbIkjMDZ2f20enG0yUsPJxBaEPatF
	 bp2G/XyfDxaHzXIQSJu6xImRtcXFHerMSqmQEO8h/ndqAaImxrx+Bn0o/4CUInzMsl
	 h0P719K49SGNPk2u9vIH40x8pVM4Dqr6lM27poVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgGBH3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:29:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbgGBH3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:29:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BBEB206BE;
        Thu,  2 Jul 2020 07:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593674952;
        bh=u29VM/PVO5QZE/Adf28yl93d1nQzkhUiMwFZCmk0V2Q=;
        h=From:To:Cc:Subject:Date:From;
        b=BJHNo7S3LtJzfbzz7DTtUCKh5TGeXJlbdtD9ivfMqWhYZRpVaxGbGoXDGTwysxQtn
         JAdTdqyPiLPuEEKtZbw3gYgiqzBlv/MhLR220966ugzLx6OBP3NxVBx26+cAJUyZoZ
         nRPVLtRuzwdRfI+18mvnztIRfegO3N/7NKZwdqa4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     balbi@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/2] USB: phy: fsl-usb: remove sysfs abuse
Date:   Thu,  2 Jul 2020 09:29:13 +0200
Message-Id: <20200702072914.1072878-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file has a HUGE debugging sysfs file that spews out a lot of
information all at once, which violates the one-value-per-file rule for
sysfs.  If this is really needed, it should go into debugfs, but given
the age of this driver, I strongly doubt anyone is using it anymore.

So just remove the file entirely, it was never documented, so obviously,
no one actually needed it :)

Cc: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/phy/phy-fsl-usb.c | 93 -----------------------------------
 1 file changed, 93 deletions(-)

diff --git a/drivers/usb/phy/phy-fsl-usb.c b/drivers/usb/phy/phy-fsl-usb.c
index b451f4695f3f..93d2257aeec8 100644
--- a/drivers/usb/phy/phy-fsl-usb.c
+++ b/drivers/usb/phy/phy-fsl-usb.c
@@ -957,98 +957,6 @@ int usb_otg_start(struct platform_device *pdev)
 	return 0;
 }
 
-/*
- * state file in sysfs
- */
-static ssize_t show_fsl_usb2_otg_state(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	struct otg_fsm *fsm = &fsl_otg_dev->fsm;
-	char *next = buf;
-	unsigned size = PAGE_SIZE;
-	int t;
-
-	mutex_lock(&fsm->lock);
-
-	/* basic driver infomation */
-	t = scnprintf(next, size,
-			DRIVER_DESC "\n" "fsl_usb2_otg version: %s\n\n",
-			DRIVER_VERSION);
-	size -= t;
-	next += t;
-
-	/* Registers */
-	t = scnprintf(next, size,
-			"OTGSC:   0x%08x\n"
-			"PORTSC:  0x%08x\n"
-			"USBMODE: 0x%08x\n"
-			"USBCMD:  0x%08x\n"
-			"USBSTS:  0x%08x\n"
-			"USBINTR: 0x%08x\n",
-			fsl_readl(&usb_dr_regs->otgsc),
-			fsl_readl(&usb_dr_regs->portsc),
-			fsl_readl(&usb_dr_regs->usbmode),
-			fsl_readl(&usb_dr_regs->usbcmd),
-			fsl_readl(&usb_dr_regs->usbsts),
-			fsl_readl(&usb_dr_regs->usbintr));
-	size -= t;
-	next += t;
-
-	/* State */
-	t = scnprintf(next, size,
-		      "OTG state: %s\n\n",
-		      usb_otg_state_string(fsl_otg_dev->phy.otg->state));
-	size -= t;
-	next += t;
-
-	/* State Machine Variables */
-	t = scnprintf(next, size,
-			"a_bus_req: %d\n"
-			"b_bus_req: %d\n"
-			"a_bus_resume: %d\n"
-			"a_bus_suspend: %d\n"
-			"a_conn: %d\n"
-			"a_sess_vld: %d\n"
-			"a_srp_det: %d\n"
-			"a_vbus_vld: %d\n"
-			"b_bus_resume: %d\n"
-			"b_bus_suspend: %d\n"
-			"b_conn: %d\n"
-			"b_se0_srp: %d\n"
-			"b_ssend_srp: %d\n"
-			"b_sess_vld: %d\n"
-			"id: %d\n",
-			fsm->a_bus_req,
-			fsm->b_bus_req,
-			fsm->a_bus_resume,
-			fsm->a_bus_suspend,
-			fsm->a_conn,
-			fsm->a_sess_vld,
-			fsm->a_srp_det,
-			fsm->a_vbus_vld,
-			fsm->b_bus_resume,
-			fsm->b_bus_suspend,
-			fsm->b_conn,
-			fsm->b_se0_srp,
-			fsm->b_ssend_srp,
-			fsm->b_sess_vld,
-			fsm->id);
-	size -= t;
-	next += t;
-
-	mutex_unlock(&fsm->lock);
-
-	return PAGE_SIZE - size;
-}
-
-static DEVICE_ATTR(fsl_usb2_otg_state, S_IRUGO, show_fsl_usb2_otg_state, NULL);
-
-static struct attribute *fsl_otg_attrs[] = {
-	&dev_attr_fsl_usb2_otg_state.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(fsl_otg);
-
 /* Char driver interface to control some OTG input */
 
 /*
@@ -1167,7 +1075,6 @@ struct platform_driver fsl_otg_driver = {
 	.driver = {
 		.name = driver_name,
 		.owner = THIS_MODULE,
-		.dev_groups = fsl_otg_groups,
 	},
 };
 
-- 
2.27.0

