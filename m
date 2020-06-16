Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48A4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88A8920739
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="aD37cj2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgFPI0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:26:41 -0400
Received: from mail-bn7nam10on2058.outbound.protection.outlook.com ([40.107.92.58]:6157
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726428AbgFPI0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:26:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k59EQrM5yAtv/9MCakoZyDIdsdrbdMr9slpFvHrvn0ndv1iBcmJW8mq6RK8Bzb/35vt4N76BNJUvSRHOy7XDG0LXWScW3KIpQBWXAnW6YE7/zqLriAWx+YuIaMnIHOp9hBwMqutPy/c8Fg6f3P7gaYReNYpeSxTDIOh+dULEbtKbqYnH876+Iz1hjHGOIEVYVZzW1BgRHXsWX5JuVX1rv6oOkOlPy8iNoLxygrWZwga0ogaEAjwlIMO2fsS6ODWty5WFs7bBnIJ6F8MmChYzCXE3DUcOkFxYSf4hI/9178IrCvg+89JVolN2eWcOUoDJskw0U6SckTNqmL4drpQKjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSW5q4n2HcOtAFkHaHD1arUwxQxubXglGQPTFQQu/OM=;
 b=nZ7V7Qpn/Cyeus546l5TSPHGJaWYcp348OQ9lXvviW2kz7Zs17xvGmAkNgbttO+W6+QEW/jyPGayZL+G/TgH4K59fld/Gr/MUJhZGLmJvYigMf0gReeY0SWnqwp0OYuw1v6MxX5YLKzAI/DFOkYX0yx6nMPkeiaSkRVlq25zFx9Gz/KW6UVwHeDp8idruh1fsge1LKAPtu+gZVQkXKXcvikaPEwYvfnX3Ouv+JRkKKTRav+qTbe5nWr8Ic6xN+6MQW/FcIJBSSw5LYrUaQwqOvbYpCvB7fchS6nXX09m9m3cWUOXvaq5FHNyHP6ZOptploqWSG+YWMr3IHtV37LzLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSW5q4n2HcOtAFkHaHD1arUwxQxubXglGQPTFQQu/OM=;
 b=aD37cj2lc6li/wzn2myGVW+e/ZIeXvUU1A106JgfqHT1Cx0qRuQzItuD61pSS3dsAd1PzXmWRcFK5OHLuxmyw2HDT6v3q97Kias0RwfPTQ4jP8cBayBTNB0unILcDRTUoxBq/5RjPUvazoUx9cX8MwdgJ5JjCaSFlfpgTAKej+w=
Authentication-Results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=synaptics.com;
Received: from BYAPR03MB3573.namprd03.prod.outlook.com (2603:10b6:a02:ae::15)
 by BYAPR03MB3575.namprd03.prod.outlook.com (2603:10b6:a02:ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.23; Tue, 16 Jun
 2020 08:26:36 +0000
Received: from BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d1ae:8ea7:ea:8998]) by BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d1ae:8ea7:ea:8998%7]) with mapi id 15.20.3088.028; Tue, 16 Jun 2020
 08:26:36 +0000
Date:   Tue, 16 Jun 2020 16:26:17 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc2: use well defined macros for power_down
Message-ID: <20200616162617.38365cc8@xhacker.debian>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:404:a6::24) To BYAPR03MB3573.namprd03.prod.outlook.com
 (2603:10b6:a02:ae::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TY2PR02CA0036.apcprd02.prod.outlook.com (2603:1096:404:a6::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.26 via Frontend Transport; Tue, 16 Jun 2020 08:26:35 +0000
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90e6d1e9-2bdb-4c67-956d-08d811cefbfc
X-MS-TrafficTypeDiagnostic: BYAPR03MB3575:
X-Microsoft-Antispam-PRVS: <BYAPR03MB3575E8EB6C3F92AE23A3EA19ED9D0@BYAPR03MB3575.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:530;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YWYYbwANDFcMURSOd51tFmHdLqmlKSHU+PJhTPCYvphTJraihwO9btatEN29K8Q6cxjU2le74E/ahlC9vUTlaGuf8MVF5FXdnLs5nrkIDuKdISuu+PHKCur5qUqhuMTRq07JQKEP+D9ODRPaBetGcRNjUPRUlXnXSW4jfYDy6gftjXENyWB2/3PRsal1RvFe87whIUmOuCCbEVgQud7w+MljKhsIKb9sWJSJf77W+QaOqLcbPUt42LKJ2fC9VQ3EEEkeycFktZjBJ280XEcBtDz4n3+LZLg05eJ6LH0Qzxb4GcODdhsG7d1bM+KvFhkh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3573.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(346002)(136003)(376002)(39860400002)(4326008)(16526019)(55016002)(186003)(2906002)(5660300002)(1076003)(66556008)(8676002)(26005)(8936002)(9686003)(66946007)(66476007)(316002)(956004)(110136005)(86362001)(6506007)(6666004)(478600001)(52116002)(83380400001)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: WaKQ+LTh4L3J2Nz118PETeFLkQgoEr0ef033fE6p5v8YLkh7pI8tihrKMQ239KiUW5iekEx87oaKhIij0c1RCwdd0MwfBpwE3Jd/YgtrtyAXGJ4lXa4O2BwH4SLO7MfiSceKWuLYmnS7elSFQ2VQpzVCWcLnI4zyN6qpIm5eC6nz02MAsa0JAbZEzHKseYT/vnow6aEQNUDH5sGB3D2wtaFTfx8ktD9/MsJoaVxMK3qwWRLGwELdd2Y9sZrhoQPsJzS+JwJIHljYKqkqOgBsa1RhT55U1UtZMtdkUuOEsnIsW6LuNuzRvEC9TZXmF/moJJe7yKLxTQOtPy+oVv865nMvANQvlJbCzsjlNubm1yGZwpR+saZQMESpF3xxlerZnGd52ykgthXWt9IyuOg+MfX9BTp5EEt4iD8zPWW62RXte3AvZBnI7K4ezcQHDbnn2EGvpf8PygnciMDKgZx+YPKeZVYUK6phiMFJtbavOkswmnWHYvqYU/MI8RbXkK3i
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e6d1e9-2bdb-4c67-956d-08d811cefbfc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 08:26:36.2704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jtWsBKNkXXBfsG2apaT+pS+Nhl2jCH5LisCbpAzr/l38KfcmUhSTZYJyN2CreARZK7/IIzGvCYAXr0rRO2N2Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3575
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the well defined macros such as DWC2_POWER_DOWN_PARAM_NONE,
DWC2_POWER_DOWN_PARAM_PARTIAL and DWC2_POWER_DOWN_PARAM_HIBERNATION
to make code more readable.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/usb/dwc2/hcd.c    |  4 ++--
 drivers/usb/dwc2/params.c | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index b90f858af960..e9ac215b9663 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -3628,7 +3628,7 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
 				"SetPortFeature - USB_PORT_FEAT_SUSPEND\n");
 			if (windex != hsotg->otg_port)
 				goto error;
-			if (hsotg->params.power_down == 2)
+			if (hsotg->params.power_down == DWC2_POWER_DOWN_PARAM_HIBERNATION)
 				dwc2_enter_hibernation(hsotg, 1);
 			else
 				dwc2_port_suspend(hsotg, windex);
@@ -3646,7 +3646,7 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
 			break;
 
 		case USB_PORT_FEAT_RESET:
-			if (hsotg->params.power_down == 2 &&
+			if (hsotg->params.power_down == DWC2_POWER_DOWN_PARAM_HIBERNATION &&
 			    hsotg->hibernated)
 				dwc2_exit_hibernation(hsotg, 0, 1, 1);
 			hprt0 = dwc2_read_hprt0(hsotg);
diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index ce736d67c7c3..8f9d061c4d5f 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -68,14 +68,14 @@ static void dwc2_set_his_params(struct dwc2_hsotg *hsotg)
 	p->ahbcfg = GAHBCFG_HBSTLEN_INCR16 <<
 		GAHBCFG_HBSTLEN_SHIFT;
 	p->change_speed_quirk = true;
-	p->power_down = false;
+	p->power_down = DWC2_POWER_DOWN_PARAM_NONE;
 }
 
 static void dwc2_set_s3c6400_params(struct dwc2_hsotg *hsotg)
 {
 	struct dwc2_core_params *p = &hsotg->params;
 
-	p->power_down = 0;
+	p->power_down = DWC2_POWER_DOWN_PARAM_NONE;
 	p->phy_utmi_width = 8;
 }
 
@@ -89,7 +89,7 @@ static void dwc2_set_rk_params(struct dwc2_hsotg *hsotg)
 	p->host_perio_tx_fifo_size = 256;
 	p->ahbcfg = GAHBCFG_HBSTLEN_INCR16 <<
 		GAHBCFG_HBSTLEN_SHIFT;
-	p->power_down = 0;
+	p->power_down = DWC2_POWER_DOWN_PARAM_NONE;
 }
 
 static void dwc2_set_ltq_params(struct dwc2_hsotg *hsotg)
@@ -319,11 +319,11 @@ static void dwc2_set_param_power_down(struct dwc2_hsotg *hsotg)
 	int val;
 
 	if (hsotg->hw_params.hibernation)
-		val = 2;
+		val = DWC2_POWER_DOWN_PARAM_HIBERNATION;
 	else if (hsotg->hw_params.power_optimized)
-		val = 1;
+		val = DWC2_POWER_DOWN_PARAM_PARTIAL;
 	else
-		val = 0;
+		val = DWC2_POWER_DOWN_PARAM_NONE;
 
 	hsotg->params.power_down = val;
 }
-- 
2.27.0

