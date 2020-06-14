Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DB7C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 20:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD8DF20739
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 20:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgFNUYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 16:24:38 -0400
Received: from mail-oln040092010071.outbound.protection.outlook.com ([40.92.10.71]:26239
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726905AbgFNUYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 16:24:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdzgyX+D42ePb4aWWojTPJEYbg90Ohc6RNrZJsa5z92QKdYXTWAHELzlMni7tbcbYrD25DR9SHuDK1NIQ2paUGGJH9yNwKZu17f+/Kig4HwW/qN+oTv3PEPhHxkE2mdM3s9TvTaIWvy030UxTuyzDUpXTTxnCVkvgy9VRdT1hxww0NtgeRQ8mI4q8Nu+Quv90JJY9KuCqvrmp7t9+tT15ReM9BPj1DRlpBce6LhNvtjyCTtDeZNv0xH8vZ1dPVGerdFjrVRO3MEA4HkPP6XD2VL8fYq7mn1R3GSkv2gEBCwysVzjOImrBx4JZuBUX+YilZkSZ6jVpWv9i0zuZxM/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9JpVb8HDdgcqZbpgEag/+JakOsfoHvg+7m2Yx0i+PY=;
 b=cekcfv3624ANlsaXY7CkEMiZ0MIpz0G5o2JceRL5tD14aV26nndFSoOGZy9wdaSnrloBeXWJchiX7211E0hirL0UjRbXGNrgjcdor6oq1toD8/PizlaQ07OOU8jWLXBwuzo41uNeNuyXoF/MnOgg5Uq/nw17RQlgbW4Vew0Cn0i48Vg+l3M2nSAaiuVwhojVOnXVtA2HewIDE2WyTKka717fa5D6lelbLAURUr4iq0m+1LZSln3w1Vss2seOnMEm4JZDfVNbzTz1oqaSLVmPjWMEQfs235AhUZraMC30OGcw1pPKLx58QIv170UaET9NRvsfEKSEqoaysEPLJuDhkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BN3NAM04FT037.eop-NAM04.prod.protection.outlook.com
 (10.152.92.59) by BN3NAM04HT116.eop-NAM04.prod.protection.outlook.com
 (10.152.93.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Sun, 14 Jun
 2020 20:24:34 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:7e4e::4c) by BN3NAM04FT037.mail.protection.outlook.com
 (2a01:111:e400:7e4e::196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend
 Transport; Sun, 14 Jun 2020 20:24:34 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:78BFEF84A6F596F1C5B5510BA8F4604D3679A49A811E88309387BB4BB60024B6;UpperCasedChecksum:865594C9107B7BA0D54BF8DEFE6A5D00136E5E6194BE376F00481289EB99F7A1;SizeAsReceived:7837;Count:49
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::b9c3:9bff:541d:f383]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::b9c3:9bff:541d:f383%9]) with mapi id 15.20.3088.028; Sun, 14 Jun 2020
 20:24:34 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     krzk@kernel.org, sbkim73@samsung.com, s.nawrocki@samsung.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 1/3] dt-bindings: sound: Document wm8994 endpoints
Date:   Sun, 14 Jun 2020 13:24:09 -0700
Message-ID: <BN6PR04MB066019A8783D22F1C4A588B7A39F0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200614202411.27843-1-xc-racer2@live.ca>
References: <20200614202411.27843-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR2001CA0018.namprd20.prod.outlook.com
 (2603:10b6:301:15::28) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200614202411.27843-2-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR2001CA0018.namprd20.prod.outlook.com (2603:10b6:301:15::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21 via Frontend Transport; Sun, 14 Jun 2020 20:24:32 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200614202411.27843-2-xc-racer2@live.ca>
X-TMN:  [e1yVr75bp/mrckUddMU5geJ85D0K50JNe5LUCtLwnqMG7ZmD0twNUWP923M6GIJg]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 49
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: dda2dd32-31e3-4343-abd0-08d810a0f39c
X-MS-TrafficTypeDiagnostic: BN3NAM04HT116:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ftlHKz01+M8KWQdzIL5YG91NWwcZb+32UL2crzCnb9y4uLJsrUofI8saBnwujoHUYtBnIAnOfrYrmq5zQjrXyqG6bthXKTiRxBscHPVACK/s5D9D5rXkgjVMmEej1D/CuXjGLHYTgYisQMgHEZrl1K21ON/agHdR2Eii+XdpVWd1brgBFQ+MB9k89DxdHKB0K3li2WU0Fwmqltazxyn68g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: HgyaJGq4Mw4MevomK8cio/8KTCHfFDAk+1DtG5pMpfHaoG0BKcKFiYql63XpgIFLq6KDmtlVKcdwFprH3SGGpWfBhLFDgc8IcxxxKrmchhSe4nUJBq4tJk2RFhoMJDgTVN6b9HSphOJTzxUnQW7a13chAInkv4YfUAsXT1Df2iup2lgKpeKRRxjIUsZUUWkV8/rBGBebKKdTnBzUT8E/eg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dda2dd32-31e3-4343-abd0-08d810a0f39c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2020 20:24:34.6785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3NAM04HT116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wm8994 exposes several inputs and outputs that can be used by
machine drivers in their routing.  Add them to the documention so
they don't have been duplicated in any machine drivers bindings.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 .../devicetree/bindings/sound/wm8994.txt      | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/wm8994.txt b/Documentation/devicetree/bindings/sound/wm8994.txt
index 367b58ce1bb9..8fa947509c10 100644
--- a/Documentation/devicetree/bindings/sound/wm8994.txt
+++ b/Documentation/devicetree/bindings/sound/wm8994.txt
@@ -68,6 +68,29 @@ Optional properties:
   - wlf,csnaddr-pd : If present enable the internal pull-down resistor on
     the CS/ADDR pin.
 
+Pins on the device (for linking into audio routes):
+
+  * IN1LN
+  * IN1LP
+  * IN2LN
+  * IN2LP:VXRN
+  * IN1RN
+  * IN1RP
+  * IN2RN
+  * IN2RP:VXRP
+  * SPKOUTLP
+  * SPKOUTLN
+  * SPKOUTRP
+  * SPKOUTRN
+  * HPOUT1L
+  * HPOUT1R
+  * HPOUT2P
+  * HPOUT2N
+  * LINEOUT1P
+  * LINEOUT1N
+  * LINEOUT2P
+  * LINEOUT2N
+
 Example:
 
 wm8994: codec@1a {
-- 
2.20.1

