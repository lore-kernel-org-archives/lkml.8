Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65193C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E76B20637
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="wfeT62dQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgCILZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:25:58 -0400
Received: from mail-am6eur05on2126.outbound.protection.outlook.com ([40.107.22.126]:23602
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725796AbgCILZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:25:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lmc58QkQyOpavEsUVBEmzR2DsffDHcc9nKND5v/+iZYOESGvNOB+QFukyhOtBoWwoAzB13qCeNr2xw1zFw+lSV0ZAxddukPOLYzeRKKwDVeCyAhjjSK251h2lS/4HTW8kOsxyMaOcO7zKz9cF2xwfPqEeRV6ccirSM2lbX/PrRUOfxIy/ste4CgAHkFBwdo2Dlt7DB1ByYb7KcfloFNcqmlldgxB/FUpZoGoCQsxV1CpDEcZiYok6mJvGBRX/8jNiqOnF7/MvGhM0pF0X9DIPHxmi2vZVV22KochLwBeZpjnwgTocMFpKxGk7d2u7NtLEarBIsQ+kRh7mnglHjgVvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmYhKF061Kz2SDLY/8oXeYPA9iJ2YvxUePqLRzQ7FNI=;
 b=WNDNKNtOCIH3+a7Vt2IyiTE0SJZc/tfo3WE5Zmd3QDtoPhh6W1GMv206pDf8u6DNnQShQRzzG847aHUoakWYFkFLsLkOxQ/26CweD7WxJ0+yQsZ7SapYMuRc86FT2ak4GchUhcMUsO0eRFpEtvjonCVDj+XQOZ64/XE+JkveFXCDmzDNqQtvBJiUmrvMV5c8iKQJ6TdspKddclrM3SNxrhDHlr8iXReQVJYw6W13DQ3l5jmnaM3W/LI6FgAqXJcoMa/IEaCN5p0yf42MktvIr2CIspz4B+0QfFBiuI2rgM4sAP15ET3YjaWGNKrMKbAOUPXs+mUlz/zFgKjXpFOvxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmYhKF061Kz2SDLY/8oXeYPA9iJ2YvxUePqLRzQ7FNI=;
 b=wfeT62dQ4M+o2B99UWdMaxuE1E4p0bbRzhSm0h5fEVneiOtArULMlrPrOMSs2E5/dkgxY4ZQG/6caX1dunAfOzifkt4r7gzLjQFrJB75hpvIrWyRh6BzCoJAEbsZNw8SPwNCZGZjr/AMG485D/0TKVRLFFOYL/S9TzVM2xlm98E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com (10.255.29.216) by
 AM0PR02MB5779.eurprd02.prod.outlook.com (52.132.215.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Mon, 9 Mar 2020 11:25:54 +0000
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::8112:12dd:4130:9206]) by AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::8112:12dd:4130:9206%3]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 11:25:54 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     oded.gabbay@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] habanalabs: add print upon clock change
Date:   Mon,  9 Mar 2020 13:25:47 +0200
Message-Id: <20200309112547.22123-1-oshpigelman@habana.ai>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0025.eurprd05.prod.outlook.com (2603:10a6:205::38)
 To AM0PR02MB5523.eurprd02.prod.outlook.com (2603:10a6:208:15e::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from oshpigelman2-vm.habana-labs.com (31.154.190.6) by AM4PR05CA0025.eurprd05.prod.outlook.com (2603:10a6:205::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend Transport; Mon, 9 Mar 2020 11:25:54 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [31.154.190.6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4d59b59-11d6-4bcb-8c19-08d7c41ca174
X-MS-TrafficTypeDiagnostic: AM0PR02MB5779:
X-Microsoft-Antispam-PRVS: <AM0PR02MB57793E9F8BEE197456E59FE7B8FE0@AM0PR02MB5779.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:245;
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(346002)(366004)(39830400003)(199004)(189003)(1076003)(36756003)(2616005)(81166006)(8676002)(81156014)(6512007)(478600001)(26005)(2906002)(8936002)(6916009)(316002)(6666004)(186003)(956004)(66946007)(66476007)(86362001)(4326008)(16526019)(6486002)(6506007)(66556008)(5660300002)(52116002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR02MB5779;H:AM0PR02MB5523.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kpXTRKBe5Qf9Z1opDyaACQ1ePWP2s+eSr1lqvceLKsaxUOg0+QMEX1XODusZbO6zjFzG4hGYQ3cS3UPP1BoDYcAWDYuzg+f2u9rfcf/qsUxeHuJVauQOb6uDRB1k9XsFHu3rRxoPw2qdklddFP2hqPHlR16/sg9s9GLTD6WTbYIo3bdV0tpPXg9ulGkA28Po18mBBLJ4mYq9mQwDa2cs9PyV5e9rFFChsGAgr/m6cW/GNM0KaNf6BwH+Yss4C297aPU/HDLnT17rBpLiteqMp72G9IyveYIYsSwS8qGHwHtq7wfHY1utNrhOZxiJ6bYsWSahExlvtLWnLk/eV2HmML6V9sb4wrgfEDlnGj1Yhxid/b7Z2s5F+wHKZBoMFblwB+hte+ADuLwA8ysrhFguuSkucnyxm2ivwcWA/YWv95y+U0KqiHUOVBWUHCnqimIH
X-MS-Exchange-AntiSpam-MessageData: vTZgRYzU+yZK7XIfTkCInKXvBLETkpPhIFJgd3FJTKyGKBxsUHBvpmvgL+guIRXkYcSDZrF2IAppHGD80+WJYFgstGB3VEfgW/Q/D8tq9C8JOO7JdPP4bDJiE12YxQCRCey3pZJB1br+W89MOk0lsA==
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d59b59-11d6-4bcb-8c19-08d7c41ca174
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 11:25:54.5021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01aBzWw+YV3/Jh0Tt8F7GE9QX2Vpniv2MU3qbpWuzaKfLAIeOrvEQ9cb5I85I2dj27THpAOsUEN+ZUyCUCumnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB5779
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add print upon clock slow down due to power consumption or overheating.
In addition, add print when back to optimal clock.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
---
 drivers/misc/habanalabs/goya/goya.c           | 50 ++++++++++++++++++-
 .../include/goya/goya_async_events.h          |  4 ++
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 9d4295cc83cf..1ccf2ed9a8dc 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -324,7 +324,11 @@ static u32 goya_all_events[] = {
 	GOYA_ASYNC_EVENT_ID_DMA_BM_CH1,
 	GOYA_ASYNC_EVENT_ID_DMA_BM_CH2,
 	GOYA_ASYNC_EVENT_ID_DMA_BM_CH3,
-	GOYA_ASYNC_EVENT_ID_DMA_BM_CH4
+	GOYA_ASYNC_EVENT_ID_DMA_BM_CH4,
+	GOYA_ASYNC_EVENT_ID_POWER_ENV_S,
+	GOYA_ASYNC_EVENT_ID_POWER_ENV_E,
+	GOYA_ASYNC_EVENT_ID_THERMAL_ENV_S,
+	GOYA_ASYNC_EVENT_ID_THERMAL_ENV_E
 };
 
 static int goya_mmu_clear_pgt_range(struct hl_device *hdev);
@@ -4389,6 +4393,14 @@ static const char *_goya_get_event_desc(u16 event_type)
 		return "TPC%d_bmon_spmu";
 	case GOYA_ASYNC_EVENT_ID_DMA_BM_CH0 ... GOYA_ASYNC_EVENT_ID_DMA_BM_CH4:
 		return "DMA_bm_ch%d";
+	case GOYA_ASYNC_EVENT_ID_POWER_ENV_S:
+		return "POWER_ENV_S";
+	case GOYA_ASYNC_EVENT_ID_POWER_ENV_E:
+		return "POWER_ENV_E";
+	case GOYA_ASYNC_EVENT_ID_THERMAL_ENV_S:
+		return "THERMAL_ENV_S";
+	case GOYA_ASYNC_EVENT_ID_THERMAL_ENV_E:
+		return "THERMAL_ENV_E";
 	default:
 		return "N/A";
 	}
@@ -4619,6 +4631,33 @@ static int goya_unmask_irq(struct hl_device *hdev, u16 event_type)
 	return rc;
 }
 
+static void goya_print_clk_change_info(struct hl_device *hdev, u16 event_type)
+{
+	switch (event_type) {
+	case GOYA_ASYNC_EVENT_ID_POWER_ENV_S:
+		dev_info_ratelimited(hdev->dev,
+			"Clock throttling due to power consumption\n");
+		break;
+	case GOYA_ASYNC_EVENT_ID_POWER_ENV_E:
+		dev_info_ratelimited(hdev->dev,
+			"Power envelop is safe, back to optimal clock\n");
+		break;
+	case GOYA_ASYNC_EVENT_ID_THERMAL_ENV_S:
+		dev_info_ratelimited(hdev->dev,
+			"Clock throttling due to overheating\n");
+		break;
+	case GOYA_ASYNC_EVENT_ID_THERMAL_ENV_E:
+		dev_info_ratelimited(hdev->dev,
+			"Thermal envelop is safe, back to optimal clock\n");
+		break;
+
+	default:
+		dev_err(hdev->dev, "Received invalid clock change event %d\n",
+			event_type);
+		break;
+	}
+}
+
 void goya_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry)
 {
 	u32 ctl = le32_to_cpu(eq_entry->hdr.ctl);
@@ -4702,6 +4741,15 @@ void goya_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry)
 		goya_unmask_irq(hdev, event_type);
 		break;
 
+	case GOYA_ASYNC_EVENT_ID_POWER_ENV_S:
+	case GOYA_ASYNC_EVENT_ID_POWER_ENV_E:
+	case GOYA_ASYNC_EVENT_ID_THERMAL_ENV_S:
+	case GOYA_ASYNC_EVENT_ID_THERMAL_ENV_E:
+		goya_print_irq_info(hdev, event_type, false);
+		goya_print_clk_change_info(hdev, event_type);
+		goya_unmask_irq(hdev, event_type);
+		break;
+
 	default:
 		dev_err(hdev->dev, "Received invalid H/W interrupt %d\n",
 				event_type);
diff --git a/drivers/misc/habanalabs/include/goya/goya_async_events.h b/drivers/misc/habanalabs/include/goya/goya_async_events.h
index bb7a1aa3279e..6be41a846c99 100644
--- a/drivers/misc/habanalabs/include/goya/goya_async_events.h
+++ b/drivers/misc/habanalabs/include/goya/goya_async_events.h
@@ -188,6 +188,10 @@ enum goya_async_event_id {
 	GOYA_ASYNC_EVENT_ID_HALT_MACHINE = 485,
 	GOYA_ASYNC_EVENT_ID_INTS_REGISTER = 486,
 	GOYA_ASYNC_EVENT_ID_SOFT_RESET = 487,
+	GOYA_ASYNC_EVENT_ID_POWER_ENV_S = 507,
+	GOYA_ASYNC_EVENT_ID_POWER_ENV_E = 508,
+	GOYA_ASYNC_EVENT_ID_THERMAL_ENV_S = 509,
+	GOYA_ASYNC_EVENT_ID_THERMAL_ENV_E = 510,
 	GOYA_ASYNC_EVENT_ID_LAST_VALID_ID = 1023,
 	GOYA_ASYNC_EVENT_ID_SIZE
 };
-- 
2.17.1

