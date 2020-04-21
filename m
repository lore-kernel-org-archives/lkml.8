Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA07C54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 649DB2076E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="b3QneW5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgDUMdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:33:22 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:34824 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728841AbgDUMdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:33:20 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03LCMRxo023343;
        Tue, 21 Apr 2020 14:33:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=0hET9m9U8HNjSCYqn7p/h2ZCXaeqDDYalebZRnWlOT0=;
 b=b3QneW5N9a4sAQW94ax4zdlhJBaO/Co186+VagX9ucAasAeOpCXA2Ly1LV/BsNvxrXuU
 G5V0VbiInVKGmMVmIpPGg/HewSZsO2r2D8LBxYEjocKoT2wVU4jHe+POWOyHZfPgSD5K
 fX05RU6ehCvcGv/czJEZKD9UK580QVbdAurFPHlOFrh4lJb3eKeaAPwke31b5Te07i8H
 CfF7dm2m9UrN2cR8z7I/aaxae15WCmkeZbs3RgJy9oGCV5SK/BPOVd+99YSLbjK/sxfH
 77la8hWrIglCRBm0+6YN0BGD6Od0kX+uHIqDnpyvurW0GTq3doaulTQuWfLUQKxH02GX tw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30fregfxse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Apr 2020 14:33:11 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5970B100034;
        Tue, 21 Apr 2020 14:33:11 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4CB152B0FCB;
        Tue, 21 Apr 2020 14:33:11 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 Apr 2020 14:33:10
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <hminas@synopsys.com>, <balbi@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@st.com>
Subject: [PATCH 1/4] usb: dwc2: gadget: move gadget resume after the core is in L0 state
Date:   Tue, 21 Apr 2020 14:32:18 +0200
Message-ID: <1587472341-17935-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587472341-17935-1-git-send-email-fabrice.gasnier@st.com>
References: <1587472341-17935-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-21_05:2020-04-20,2020-04-21 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the remote wakeup interrupt is triggered, lx_state is resumed from L2
to L0 state. But when the gadget resume is called, lx_state is still L2.
This prevents the resume callback to queue any request. Any attempt
to queue a request from resume callback will result in:
- "submit request only in active state" debug message to be issued
- dwc2_hsotg_ep_queue() returns -EAGAIN

Move the call to resume gadget after the core is put in DWC2_L0 state.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/usb/dwc2/core_intr.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc2/core_intr.c b/drivers/usb/dwc2/core_intr.c
index 876ff31..b8ebda5 100644
--- a/drivers/usb/dwc2/core_intr.c
+++ b/drivers/usb/dwc2/core_intr.c
@@ -404,9 +404,11 @@ static void dwc2_handle_wakeup_detected_intr(struct dwc2_hsotg *hsotg)
 	}
 
 	if (dwc2_is_device_mode(hsotg)) {
+		enum dwc2_lx_state lx_state = hsotg->lx_state;
+
 		dev_dbg(hsotg->dev, "DSTS=0x%0x\n",
 			dwc2_readl(hsotg, DSTS));
-		if (hsotg->lx_state == DWC2_L2) {
+		if (lx_state == DWC2_L2) {
 			u32 dctl = dwc2_readl(hsotg, DCTL);
 
 			/* Clear Remote Wakeup Signaling */
@@ -415,11 +417,13 @@ static void dwc2_handle_wakeup_detected_intr(struct dwc2_hsotg *hsotg)
 			ret = dwc2_exit_partial_power_down(hsotg, true);
 			if (ret && (ret != -ENOTSUPP))
 				dev_err(hsotg->dev, "exit power_down failed\n");
-
-			call_gadget(hsotg, resume);
 		}
 		/* Change to L0 state */
 		hsotg->lx_state = DWC2_L0;
+
+		/* Gadget may queue new requests upon resume to L0 state */
+		if (lx_state == DWC2_L2)
+			call_gadget(hsotg, resume);
 	} else {
 		if (hsotg->params.power_down)
 			return;
-- 
2.7.4

