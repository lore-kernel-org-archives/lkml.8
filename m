Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24636C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 13:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AA9208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 13:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="QcI2FXdl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgCENtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 08:49:47 -0500
Received: from mail-eopbgr30100.outbound.protection.outlook.com ([40.107.3.100]:41190
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725990AbgCENtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 08:49:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=feS2qpXya8n9Pe7pOybAII4I8gLB3D97eHcsvcw+Lj70sJpCuwiSSGJBtQ6TdX66OmVZ+MdOuk5ZCJaFYP3ct0AHG7aTqaVnILILOFw7UuljyU5moGDAWDth3GlmJAqc9YUPDebY8g2X4tLouVrN1bdxvor2EJjdrkIqTvABwK8dUwmLfnSpOdpaaCxxbr6lgXC+5lXoAugNSoBJ7mbecZpiOvEKUcArptNA/KUFO0YfpcA9gwKRalsQVRJ1BM7tsgdFCaCgYgNhu7MFGe1HVEkbymhuIfWO0gBVaDcwGkBakug7NS8T4PdXT2m0ljQ7LewKgPu7zamqOXKoa52ghQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJEMiP3awu4DmT/LEm3wuxisEf3MLT3TN03jKeXyYgQ=;
 b=lREIVuGZDc5goe2TdrcvokmU+lwCj6oYv7W8j3whRp/TBO72QYBcswd+O/SyjJH3vFkMW6d2V/2HVQHODAv9wP+36ETQGQ/bllIjBLEVMzHEn9YELwyFHUtAbW41vxBw4vCk24rZ74PIQzdltJJA4m5ntOLVlQ2N1UOKRFWfiR+gGzEqsoo6oeMyyUp0rxtjAFauT0TDt/SEuvCEUJ6/EjqYqPoNUJsnVQTUH9Y5M7aeo4Dr6TtbgEYjFZ94Gug6sTBDC2tHI+HwvTC0dft5gqGnWqfOIC8Hyc9RcK869FZde9WKr51klpnIUyMs8VDJkT0HQQBSuT5ec+96MzqIAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJEMiP3awu4DmT/LEm3wuxisEf3MLT3TN03jKeXyYgQ=;
 b=QcI2FXdlPBn3hyzZ9qpxUBklPoL0/1DhJ7H5/BIW8loIalpXnJCMWzbJSbU6rsZz6lEFiSsJjGh/Vpb+UsG2HSesCf6jyMcJxfnetrUjaUjwPyrWGUBvQ7s/O17IRQkC5YxjB/51G8uoGy6Lv/SxSPy0deajW5M5LgMm69LY40M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (20.179.1.217) by
 AM6PR05MB5569.eurprd05.prod.outlook.com (20.177.119.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Thu, 5 Mar 2020 13:49:44 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::dee:ffa2:1d09:30e]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::dee:ffa2:1d09:30e%4]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 13:49:43 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH] ARM: mach-imx6q: add ksz9131rn_phy_fixup
Date:   Thu,  5 Mar 2020 14:49:28 +0100
Message-Id: <20200305134928.19775-1-philippe.schenker@toradex.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR2PR09CA0014.eurprd09.prod.outlook.com
 (2603:10a6:101:16::26) To AM6PR05MB6120.eurprd05.prod.outlook.com
 (2603:10a6:20b:a8::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from philippe-pc.toradex.int (31.10.206.124) by PR2PR09CA0014.eurprd09.prod.outlook.com (2603:10a6:101:16::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18 via Frontend Transport; Thu, 5 Mar 2020 13:49:43 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [31.10.206.124]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d4e8cd1-94be-42a0-aba0-08d7c10c0f54
X-MS-TrafficTypeDiagnostic: AM6PR05MB5569:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB55699F71D197820F7C97B03AF4E20@AM6PR05MB5569.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 03333C607F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(396003)(39850400004)(366004)(136003)(189003)(199004)(6512007)(66946007)(1076003)(8676002)(8936002)(66476007)(5660300002)(4326008)(66556008)(316002)(86362001)(6506007)(16526019)(110136005)(54906003)(44832011)(26005)(956004)(7416002)(6486002)(81166006)(6666004)(2906002)(2616005)(81156014)(478600001)(36756003)(186003)(52116002)(16060500001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR05MB5569;H:AM6PR05MB6120.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y4GJyYtrBHV1Se3ykurNeZkMp31FU7l3msNHj6qsQ/LYWHgMwBDp0cVOuz3+irYJgiud5q/0RMPbZXwF8sQ3U+GL4xqOUT2iFxCwm668L6Mb2QlcGNa3X1b4kNu+mWrsQdYQk/SP0RF2lei4OVyMY8wIyjjyO8wSnOXS/obBG5clsASoWzb26zsDnzt0UlyNWSqfWh0p5yruPwTnxXVWrUgBE58n5y8Qk+feA0D1zsheVmO52Vd7xxZUSsJ2kpuKY8w73tTNi0zbCtIRi62lf5VMbyZzQ45sXqPoAGBIErYjAW2zK+XnafjXEFVTF49CrBqHWvjLA3DHycHQ8Lqakg2TSSt/yIzknfAgD9Gi70lzmjJcsprsF1VIaxxMheXe2EmFDzoWcIiL0uW0atq6dvFS4g2+GMmH/782y4F+YHL63ob2en29lGRZ/ywKvtx+SAeBlnFPr7YALgQA/T7d/Th30fYnDHUitKMujensLJCFLPkS+9d39aMX/2QHq2Ia
X-MS-Exchange-AntiSpam-MessageData: 3794z509fEL4sYzFOaEEr+Aea19RoFaYPF8/F31p7ZT9al3ODDqhlZ1QS6oAx69zxnPQfaObUezhX7eKLqIDiws4Voc/xfTOL8raKAqBzlPxrF7eRvugiWtemd0pCbJUkA0Bz/OMXFkZACn5ogi60g==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4e8cd1-94be-42a0-aba0-08d7c10c0f54
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 13:49:43.8809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtHkd1/DxSlZ5DG82Iu4IL3CgfwmLk5tPGErdICS/3Gky98xBwuooGXuZknBfHoIxiqq43v+Mv5996uiGjcGGTH/CqIbEoInAm9dBhHMj6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5569
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MAC of the i.MX6 SoC is compliant with RGMII v1.3. The KSZ9131 PHY
is like KSZ9031 adhering to RGMII v2.0 specification. This means the
MAC should provide a delay to the TXC line. Because the i.MX6 MAC does
not provide this delay this has to be done in the PHY.

This patch adds by default ~1.6ns delay to the TXC line. This should
be good for all boards that have the RGMII signals routed with the
same length.

The KSZ9131 has relatively high tolerances on skew registers from
MMD 2.4 to MMD 2.8. Therefore the new DLL-based delay of 2ns is used
and then as little as possibly subtracted from that so we get more
accurate delay. This is actually needed because the i.MX6 SoC has
an asynchron skew on TXC from -100ps to 900ps, to get all RGMII
values within spec.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

 arch/arm/mach-imx/mach-imx6q.c | 37 ++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index edd26e0ffeec..8ae5f2fa33e2 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -61,6 +61,14 @@ static void mmd_write_reg(struct phy_device *dev, int device, int reg, int val)
 	phy_write(dev, 0x0e, val);
 }
 
+static int mmd_read_reg(struct phy_device *dev, int device, int reg)
+{
+	phy_write(dev, 0x0d, device);
+	phy_write(dev, 0x0e, reg);
+	phy_write(dev, 0x0d, (1 << 14) | device);
+	return phy_read(dev, 0x0e);
+}
+
 static int ksz9031rn_phy_fixup(struct phy_device *dev)
 {
 	/*
@@ -74,6 +82,33 @@ static int ksz9031rn_phy_fixup(struct phy_device *dev)
 	return 0;
 }
 
+#define KSZ9131_RXTXDLL_BYPASS	12
+
+static int ksz9131rn_phy_fixup(struct phy_device *dev)
+{
+	int tmp;
+
+	tmp = mmd_read_reg(dev, 2, 0x4c);
+	/* disable rxdll bypass (enable 2ns skew delay on RXC) */
+	tmp &= ~(1 << KSZ9131_RXTXDLL_BYPASS);
+	mmd_write_reg(dev, 2, 0x4c, tmp);
+
+	tmp = mmd_read_reg(dev, 2, 0x4d);
+	/* disable txdll bypass (enable 2ns skew delay on TXC) */
+	tmp &= ~(1 << KSZ9131_RXTXDLL_BYPASS);
+	mmd_write_reg(dev, 2, 0x4d, tmp);
+
+	/*
+	 * Subtract ~0.6ns from txdll = ~1.4ns delay.
+	 * leave RXC path untouched
+	 */
+	mmd_write_reg(dev, 2, 4, 0x007d);
+	mmd_write_reg(dev, 2, 6, 0xdddd);
+	mmd_write_reg(dev, 2, 8, 0x0007);
+
+	return 0;
+}
+
 /*
  * fixup for PLX PEX8909 bridge to configure GPIO1-7 as output High
  * as they are used for slots1-7 PERST#
@@ -167,6 +202,8 @@ static void __init imx6q_enet_phy_init(void)
 				ksz9021rn_phy_fixup);
 		phy_register_fixup_for_uid(PHY_ID_KSZ9031, MICREL_PHY_ID_MASK,
 				ksz9031rn_phy_fixup);
+		phy_register_fixup_for_uid(PHY_ID_KSZ9131, MICREL_PHY_ID_MASK,
+				ksz9131rn_phy_fixup);
 		phy_register_fixup_for_uid(PHY_ID_AR8031, 0xffffffef,
 				ar8031_phy_fixup);
 		phy_register_fixup_for_uid(PHY_ID_AR8035, 0xffffffef,
-- 
2.25.1

