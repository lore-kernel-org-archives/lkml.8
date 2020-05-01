Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246C6C47256
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D11021775
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgEAXvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 19:51:23 -0400
Received: from mail-dm6nam12olkn2076.outbound.protection.outlook.com ([40.92.22.76]:49581
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727864AbgEAXvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 19:51:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xbz/l0cKwHpFcgtYM1oztFT4/l9JyQm+BZS4FsIWD7SX121JEgokfYN040GeLg0kR9KaLwME/uy0h5XcyP3A77CZ/fa+8smnVJNquqLnWr+heZO6TqH3ld3N6Pf0iNjy8E6QMZyVYlXOfTFhp2GFGYRWA70GHViIt0RC8UoDcXgUqs2LXN1CVolaYbrHKUXv0pdowdX3mUXhnHLHz+YnMV2mWl6S7vOKRK1gVetfn/vZ2yvDCBIPxZwbnpc9xTW407BjeMlIjXlux56YQbYjOTFhYixflr+ksD6FyFUKDaCProAVwF4kGuI1/3fzI8X6A5zBr4S7o4L9xTbPyccCxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADm1QCIora5F5xsI9vKan4SPBQw/v8naL7czrKxd8Rw=;
 b=odU+di9dJjrpTvpozQ3XtSr89iWzLqZ3NSCurTnzVxUPYtvNvjCeRKrhc66nAPIsevM5PMaeTHVsVMlyUmX+rk2zHRE9r4E8SreVatP7Yllm29B1sQlMZgDoRtIM4YPUIGJ9PLBl0PqEwaGj+LGW4nyinX0o/IRur5FZgIfm/0Yo37an+S7p+bhtZwjqnX/ajfgbKvt9GfTKCiIQXvETju0ZC2wYLMecwV4cfOvF09MQNWpVYIA7d//y9IPE35LUKY42J0wSdQBkOj1+fLoozJZphWUItg8JsVqLrE31q0cR2g2/HBW/kOIU2GLc1oDoiQ3lLpdgOZYUOU8MNPYo9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from DM6NAM12FT056.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc64::51) by
 DM6NAM12HT049.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc64::252)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12; Fri, 1 May
 2020 23:51:18 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc64::46) by DM6NAM12FT056.mail.protection.outlook.com
 (2a01:111:e400:fc64::460) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12 via Frontend
 Transport; Fri, 1 May 2020 23:51:18 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:7C092276F65BF9CD53490C2982CDE7786E711CC77745B6221EE7F73A344FDEA5;UpperCasedChecksum:E25B7D831C137B11A70E4CD399101ECE7252772C1B6DF128F7D2C0FB495C9D3F;SizeAsReceived:7884;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2958.027; Fri, 1 May 2020
 23:51:18 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH v2 04/18] ARM: dts: s5pv210: Set keep-power-in-suspend for SDHCI1 on aries
Date:   Fri,  1 May 2020 16:50:05 -0700
Message-ID: <BN6PR04MB06603B45ECF39A32F7B0B75DA3AB0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200501235019.24022-1-xc-racer2@live.ca>
References: <20200426183604.28494-1-xc-racer2@live.ca>
 <20200501235019.24022-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR17CA0058.namprd17.prod.outlook.com
 (2603:10b6:300:93::20) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200501235019.24022-5-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR17CA0058.namprd17.prod.outlook.com (2603:10b6:300:93::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Fri, 1 May 2020 23:51:16 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200501235019.24022-5-xc-racer2@live.ca>
X-TMN:  [nXWGn0tMFxhFtqsLoh9DaeIaqFBy86R1WQ1TV7tw8PDlfJAI+T5jDB+HHlLn4uxQ]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: ec4df528-ad89-4a19-d0bc-08d7ee2a8a7f
X-MS-TrafficTypeDiagnostic: DM6NAM12HT049:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D1eJN6+ZrZTUEstC5HqL32BWmGhqgGmWBThCBWvSCTCqYJT76zzEq5Vd8UZNMMnDXuW+ODk3e2LaZAjS4PcuSIwrZdZBoK4rTh0TXX+CQEfBZhw2rSm5Ki7MVk/OpcKiqufnxScazTrw7AyKsEfEHMV/QjD7UbwCr+1qDF8qOxS76vaxcvaGlqy0CypPLRkuRlMioHUuZ4Pic9LHZ9SFTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: 43Exqo6eqGCPUgLTO+G/1pGR3+leTrGQ2qa5Z8d+eJbZVJDG3nMwN0+NnSdZx2zmuwIF5XW+b+KYiVd0hqvWY07QzOvmtOxNrHFhOO2XcisJis9sNSkNFzULo9DE9ABVff8zzqS/yFizjLFg6ooAZEeWQF9UqnmHz0GLIv5aWql0ZMyaEUYKcqKCE3d6AZ5985WROnoZE5LOExsic7u9FQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4df528-ad89-4a19-d0bc-08d7ee2a8a7f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2020 23:51:18.0412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM12HT049
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDHCI1 is connected to a BCM4329 WiFi/BT chip which requires
power to be kept over suspend.  As the surrounding hardware supports
this, mark it as such.  This fixes wifi after a suspend/resume cycle.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 arch/arm/boot/dts/s5pv210-aries.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index 8ff70b856334..d419b77201f7 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -454,6 +454,7 @@
 	pinctrl-names = "default";
 	cap-sd-highspeed;
 	cap-mmc-highspeed;
+	keep-power-in-suspend;
 
 	mmc-pwrseq = <&wifi_pwrseq>;
 	non-removable;
-- 
2.20.1

