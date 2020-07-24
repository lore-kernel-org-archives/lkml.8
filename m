Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E11C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 417CD2074B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="m5g5GToc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgGXMiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:38:11 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35436 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726455AbgGXMiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 08:38:09 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06OCbOKl029988;
        Fri, 24 Jul 2020 14:37:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=FRFwv70pslXpbzDDFiAT4tkfUee8cC3QNP2PqAXCowg=;
 b=m5g5GTocUGhhu0LPxOxdxuKY23LtN9Xdg9OSukoVtYQWOb6UN8eXaBK61rZnVwa8wUbM
 IHIgjmhhz6TsegsQC5f+NUMwU2tNjBrN2BlVLFQEZ6Caes72kR2dFt+Abk9uXyMUbs4Y
 TUvG6DYF/lvMWg8g1aeRc9UiaG/Ky9nhqDaA6D7s3rWGSIA3qnlKVl9gNIXJ7diCiygc
 5HY7Yw8ysMtHTKswldrPJFj87sbKs3ZQsJDrVcNzoveGQN9gLfOrJXCCC5Ys9v+S7eU1
 SadfnZZ61+LT5booRHm8F+guo0NfhOT0ziS2izMDZFK4TdWO3GPqddfi35/yGdDvya9i bw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32bsahgcgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 14:37:54 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 637D210002A;
        Fri, 24 Jul 2020 14:37:54 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 557122AF334;
        Fri, 24 Jul 2020 14:37:54 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 24 Jul 2020 14:37:54
 +0200
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/4] usb: dwc2: fix build issue when config is USB_DWC2_HOST only
Date:   Fri, 24 Jul 2020 14:37:46 +0200
Message-ID: <20200724123748.25369-3-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724123748.25369-1-amelie.delaunay@st.com>
References: <20200724123748.25369-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-24_04:2020-07-24,2020-07-24 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add missing definition of dwc2_hsotg_core_disconnect and
check configuration before using hsotg->test_mode, to fix build issue when
config USB_DWC2_PERIPHERAL or USB_DWC2_DUAL_ROLE are not set.

Fixes: bc0f0d4a5853 ("usb: dwc2: override PHY input signals with usb role switch support")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/usb/dwc2/core.h | 1 +
 drivers/usb/dwc2/drd.c  | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 33e790ccefb3..7161344c6522 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -1425,6 +1425,7 @@ static inline int dwc2_gadget_init(struct dwc2_hsotg *hsotg)
 { return 0; }
 static inline void dwc2_hsotg_core_init_disconnected(struct dwc2_hsotg *dwc2,
 						     bool reset) {}
+static inline void dwc2_hsotg_core_disconnect(struct dwc2_hsotg *hsotg) {}
 static inline void dwc2_hsotg_core_connect(struct dwc2_hsotg *hsotg) {}
 static inline void dwc2_hsotg_disconnect(struct dwc2_hsotg *dwc2) {}
 static inline int dwc2_hsotg_set_test_mode(struct dwc2_hsotg *hsotg,
diff --git a/drivers/usb/dwc2/drd.c b/drivers/usb/dwc2/drd.c
index 032efffa37ab..5099841b1417 100644
--- a/drivers/usb/dwc2/drd.c
+++ b/drivers/usb/dwc2/drd.c
@@ -76,11 +76,14 @@ static int dwc2_drd_role_sw_set(struct usb_role_switch *sw, enum usb_role role)
 	    (role == USB_ROLE_HOST && hsotg->dr_mode == USB_DR_MODE_PERIPHERAL))
 		return -EINVAL;
 
+#if IS_ENABLED(CONFIG_USB_DWC2_PERIPHERAL) || \
+	IS_ENABLED(CONFIG_USB_DWC2_DUAL_ROLE)
 	/* Skip session if core is in test mode */
 	if (role == USB_ROLE_NONE && hsotg->test_mode) {
 		dev_dbg(hsotg->dev, "Core is in test mode\n");
 		return -EBUSY;
 	}
+#endif
 
 	spin_lock_irqsave(&hsotg->lock, flags);
 
-- 
2.17.1

