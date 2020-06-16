Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58958C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C65C206F1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="s1a4cmtU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgFPOHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:07:54 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22980 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729190AbgFPOHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:07:49 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05GE40DX030295;
        Tue, 16 Jun 2020 16:07:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=qf90D1xvlnaVfhKX1/rwsBGrTYh73cmLPEcHyOqACys=;
 b=s1a4cmtUiRTnoTgkwNmfLkVXn5TN8gzQUcyPiBcdmJH3ya+Y7rR1bMTLziEKgm7ORCBh
 E7AZVHUFfDhFynDZERPyPbFLv6eqnd9UHuNzJNtKmJM2nexSwIDgwjvu4TSWMTHVbVwh
 9eZMZGCHHO5puUDk0VXXdBUC9+oBl25NgNhn0rjJu4ilVn89TBxBG3iYIuuHsY9pUBvM
 QqEjD95KRIaLHoTnWzWHuliv1zOrmbrr/i4Y2hrOqqzHMlIzNSlJodlkGDy4tldb+xG/
 w4puvqs+AQ3VmjeAlIrdrQRDdcPJFzQ4XcWpwEYaTCW/zEikQgPm4FkqpE2PM4YqHoGz sg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31mkx97uff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Jun 2020 16:07:31 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D0C4810002A;
        Tue, 16 Jun 2020 16:07:30 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C18B22B569A;
        Tue, 16 Jun 2020 16:07:30 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 16 Jun 2020 16:07:30
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
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 3/3] ARM: dts: stm32: enable usb-role-switch on USB OTG on stm32mp15xx-dkx
Date:   Tue, 16 Jun 2020 16:07:17 +0200
Message-ID: <20200616140717.28465-4-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616140717.28465-1-amelie.delaunay@st.com>
References: <20200616140717.28465-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-16_04:2020-06-16,2020-06-16 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that USB OTG driver supports usb role switch by overriding PHY input
signals (A-Valid, B-Valid and Vbus-Valid), enable it on stm32mp15xx-dkx.
dr_mode needn't to be forced to Peripheral anymore, it is set to OTG in
SoC device tree.
USB role (USB_ROLE_NONE, USB_ROLE_DEVICE, USB_ROLE_HOST) will be provided
by STUSB1600 Type-C controller driver.

This patch depends on "Add STUSB160x Type-C port controller support"
series, which is under review.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
index d946e0a02f5c..ab31db801eec 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
@@ -595,9 +595,9 @@
 };
 
 &usbotg_hs {
-	dr_mode = "peripheral";
 	phys = <&usbphyc_port1 0>;
 	phy-names = "usb2-phy";
+	usb-role-switch;
 	status = "okay";
 };
 
-- 
2.17.1

