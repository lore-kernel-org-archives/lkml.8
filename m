Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00472C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D257B2072D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgCSIul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:50:41 -0400
Received: from comms.puri.sm ([159.203.221.185]:33218 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgCSIul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:50:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 79038DFD58;
        Thu, 19 Mar 2020 01:50:40 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mVIS9R2TCHKD; Thu, 19 Mar 2020 01:50:39 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     balbi@kernel.org
Cc:     gregkh@linuxfoundation.org, rogerq@ti.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v2] usb: dwc3: support continuous runtime PM with dual role
Date:   Thu, 19 Mar 2020 09:49:02 +0100
Message-Id: <20200319084902.24747-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DRD module calls dwc3_set_mode() on role switches, i.e. when a device is
being pugged in. In order to support continuous runtime power management when
plugging in / unplugging a cable, we need to call pm_runtime_get() in this path.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---

revision history
----------------
v2: move pm_rumtime calls into workqueue (thanks Roger)
    remove unrelated documentation patch
v1: https://lore.kernel.org/linux-usb/ef22f8de-9bfd-c1d5-111c-696f1336dbda@puri.sm/T/


 drivers/usb/dwc3/core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 1d85c42b9c67..0c058b2ac21d 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -121,17 +121,19 @@ static void __dwc3_set_mode(struct work_struct *work)
 	if (dwc->dr_mode != USB_DR_MODE_OTG)
 		return;
 
+	pm_runtime_get(dwc->dev);
+
 	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_OTG)
 		dwc3_otg_update(dwc, 0);
 
 	if (!dwc->desired_dr_role)
-		return;
+		goto out;
 
 	if (dwc->desired_dr_role == dwc->current_dr_role)
-		return;
+		goto out;
 
 	if (dwc->desired_dr_role == DWC3_GCTL_PRTCAP_OTG && dwc->edev)
-		return;
+		goto out;
 
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_HOST:
@@ -190,6 +192,9 @@ static void __dwc3_set_mode(struct work_struct *work)
 		break;
 	}
 
+out:
+	pm_runtime_mark_last_busy(dwc->dev);
+	pm_runtime_put_autosuspend(dwc->dev);
 }
 
 void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
-- 
2.20.1

