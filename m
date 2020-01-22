Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B033C2D0CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 01:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B98524676
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 01:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAVBoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 20:44:20 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:56916 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbgAVBoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 20:44:15 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 00M1iBD6020222, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV02.realtek.com.tw[172.21.6.19])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 00M1iBD6020222
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 22 Jan 2020 09:44:12 +0800
Received: from fc30.localdomain (172.21.177.138) by RTITCASV02.realtek.com.tw
 (172.21.6.19) with Microsoft SMTP Server id 14.3.468.0; Wed, 22 Jan 2020
 09:44:10 +0800
From:   Hayes Wang <hayeswang@realtek.com>
To:     <netdev@vger.kernel.org>
CC:     <nic_swsd@realtek.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <pmalani@chromium.org>,
        <grundler@chromium.org>, Hayes Wang <hayeswang@realtek.com>
Subject: [PATCH net v2 9/9] r8152: disable DelayPhyPwrChg
Date:   Wed, 22 Jan 2020 09:41:21 +0800
Message-ID: <1394712342-15778-357-Taiwan-albertk@realtek.com>
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <1394712342-15778-348-Taiwan-albertk@realtek.com>
References: <1394712342-15778-338-Taiwan-albertk@realtek.com>
 <1394712342-15778-348-Taiwan-albertk@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.177.138]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable DelayPhyPwrChg let the device fail enter the power saving mode
of P3.

Signed-off-by: Hayes Wang <hayeswang@realtek.com>
---
 drivers/net/usb/r8152.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index c037fc7adcea..3f425f974d03 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -31,7 +31,7 @@
 #define NETNEXT_VERSION		"11"
 
 /* Information for net */
-#define NET_VERSION		"10"
+#define NET_VERSION		"11"
 
 #define DRIVER_VERSION		"v1." NETNEXT_VERSION "." NET_VERSION
 #define DRIVER_AUTHOR "Realtek linux nic maintainers <nic_swsd@realtek.com>"
@@ -109,6 +109,7 @@
 #define PLA_BP_EN		0xfc38
 
 #define USB_USB2PHY		0xb41e
+#define USB_SSPHYLINK1		0xb426
 #define USB_SSPHYLINK2		0xb428
 #define USB_U2P3_CTRL		0xb460
 #define USB_CSR_DUMMY1		0xb464
@@ -384,6 +385,9 @@
 #define USB2PHY_SUSPEND		0x0001
 #define USB2PHY_L1		0x0002
 
+/* USB_SSPHYLINK1 */
+#define DELAY_PHY_PWR_CHG	BIT(1)
+
 /* USB_SSPHYLINK2 */
 #define pwd_dn_scale_mask	0x3ffe
 #define pwd_dn_scale(x)		((x) << 1)
@@ -4994,6 +4998,10 @@ static void rtl8153_up(struct r8152 *tp)
 	ocp_data &= ~LANWAKE_PIN;
 	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_LWAKE_CTRL_REG, ocp_data);
 
+	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_SSPHYLINK1);
+	ocp_data &= ~DELAY_PHY_PWR_CHG;
+	ocp_write_word(tp, MCU_TYPE_USB, USB_SSPHYLINK1, ocp_data);
+
 	r8153_aldps_en(tp, true);
 
 	switch (tp->version) {
-- 
2.21.0

