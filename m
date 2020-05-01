Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA0BC47259
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1637E21835
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgEAXvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 19:51:18 -0400
Received: from mail-mw2nam12olkn2107.outbound.protection.outlook.com ([40.92.23.107]:11778
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726562AbgEAXvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 19:51:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I639gnG1KE1bUR0cxSLdpZ+fxlf4O4TmkNgclvzpbK2+Ck3VjZFLaRHw+/jD4gO0wv2ReXFM6vu+Zkj71SME18lD8mItOr365luN3Lrq9evhVg9tSPqUuvC04sjPguKACK5FHGhy0jNpTkvmRi5kBkKqUDxUqMu1iTQ+NojjaepJ8giJDideyuWFMRH8Wo9JeFXHIjGbHLZzCJvtDR9zrC2NbtkawadXGPvv9x3Bq+DghjY2zeGl/JyrUonXQdOhy6BDImYNvwpOSjYXlOokarIc+4JaJRmSiRVs8xr6dS4FIPnkPwvbyKaUUJaeVR96EDQpv22bIqSN8Ybb+HTsUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQPOA1QD9GTVHUlU+BUHXvxBpBudTQ+4UbWWmc0Qg+M=;
 b=Dyhg6tFQR7XIyx+ZclR5PJ+JEd3EivA2WYUgYKc1076HpY75GDXl+u0N087Sh+aT2AkpMsR0dk5aGgbpERjKcThRUVgu7Nar7a6/Jbfr/TVAWNZr6FFASRFjrwlFDKYE/LkaaQUQkauKrc5OBiEwW4rureK4cc4Yl64bhCbBDaMS5Ge0dloTMiOOWUfW+Kxo42b1O2KALCRmOqZ/Cf8krXelkycTmrWtG4pDDydlR9VLLCieWACB0IG0fdvKOUI+zLnyQncPXleUiYhtTxpQT+ZCkhxLuQfoQ707/ybL37FWwpbMt0tg5W6zd2/uzZb2oxJmO0uTrf8TXATbU0aUoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from DM6NAM12FT056.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc64::49) by
 DM6NAM12HT168.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc64::131)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12; Fri, 1 May
 2020 23:51:13 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc64::46) by DM6NAM12FT056.mail.protection.outlook.com
 (2a01:111:e400:fc64::460) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12 via Frontend
 Transport; Fri, 1 May 2020 23:51:13 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:1365E61CB772CCAB1694D4B7488D5CE67D868E2AA1B95A8E57CA286429737748;UpperCasedChecksum:2E3433D890EE56A4368986C1AD1CF85DD99A31F933CA35E321977A5028A45848;SizeAsReceived:7855;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2958.027; Fri, 1 May 2020
 23:51:13 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH v2 01/18] ARM: dts: s5pv210: Add helper define for sleep gpio config
Date:   Fri,  1 May 2020 16:50:02 -0700
Message-ID: <BN6PR04MB0660BFEF9B4A618BBA90AD10A3AB0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200501235019.24022-1-xc-racer2@live.ca>
References: <20200426183604.28494-1-xc-racer2@live.ca>
 <20200501235019.24022-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR17CA0058.namprd17.prod.outlook.com
 (2603:10b6:300:93::20) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200501235019.24022-2-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR17CA0058.namprd17.prod.outlook.com (2603:10b6:300:93::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Fri, 1 May 2020 23:51:11 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200501235019.24022-2-xc-racer2@live.ca>
X-TMN:  [5ErvH9+B7c99eb+NHFblKfuuucl9T/Q/VcoitdFfIUIIlu1Bzt3MiCDnuZUxvBAi]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: d1fa2f23-81e2-44f3-2e63-08d7ee2a876a
X-MS-TrafficTypeDiagnostic: DM6NAM12HT168:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OscV43Ds18JhVX9Aeq1gZ7Gtbqm4XjN9kcs1XjkwcT0Ue7D9ubHHw/aOwCL7/GOZOYKYSFIYgCHjwcuwsu4oC5PUUpBpuRJ/X9D6RnYAh3bl+rz7bsAsZaO8QWFrlOZpGaITZ4EHey9rVZqR1gz8eVMlu/cQQQinNdeh0YD9x693OalQx6RuhGf4haeya0anY1hi/AXWOGgcBu3XMr4q3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: hfhD4BdXrA9R281TbuIqXSXgBWDwdMxYP4PvbSAjObW0ELOOhLYDeX594MroBCWB9v9NY9mcL6bAmvEh7L6FqXr7ZtKFrJIa9DG5hbgVT9qbrkcKDV8Wgu630v8gh54dVxsinn141rRo44BfzCdb3bzvtb7NdjjTJf5/fkG9x4LRZ7ABMGvy+lT2NAa3y3ZMGp/87Ft5pqdhPm4Vp8xY7g==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1fa2f23-81e2-44f3-2e63-08d7ee2a876a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2020 23:51:13.1131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM12HT168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To simplify writing of sleep gpio configs, add a common helper
similar to what is present for other Samsung CPUs.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210-pinctrl.dtsi b/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
index 7f0c9d447871..609f323d0805 100644
--- a/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
+++ b/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
@@ -18,6 +18,13 @@
 
 #include <dt-bindings/pinctrl/samsung.h>
 
+#define PIN_SLP(_pin, _mode, _pull)					\
+	_pin {								\
+		samsung,pins = #_pin;					\
+		samsung,pin-con-pdn = <EXYNOS_PIN_PDN_ ##_mode>;	\
+		samsung,pin-pud-pdn = <S3C64XX_PIN_PULL_ ##_pull>;	\
+	}
+
 &pinctrl0 {
 	gpa0: gpa0 {
 		gpio-controller;
-- 
2.20.1

