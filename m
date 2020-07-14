Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9937FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78701223FB
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="XzyHONEW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgGNPSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 11:18:43 -0400
Received: from mail-eopbgr60113.outbound.protection.outlook.com ([40.107.6.113]:11653
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725876AbgGNPSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 11:18:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aB57KZ2XNPO7HL0FPWWYoB6O6j3AOQlMPbwHpihKOhL+L2G8B5V1pLSXxGJ+8JJTaAigX4w89KFfgmghnXRkfbKMC23RGLid7b781oSTt2mEOMvBXIpe51DUHo+QE/RGcR1UJW8+FPoN273osp7hNCvAjGENhdQ3cf8qrYFqWfj5EblzR2jzCa3IDWASHJ3WvBxYLuZEm/VxVf7BzStOMA/8w1sMialhEJ5FmZ5pIBjOg+/d2HCc3NIjg7mjWrDXzR2OUC1W6a0WvEpPVBN5W7S2DVSeRZvbJwcdUv7QV9jNU2dxyaf+rETgehFbeyfLtkHOiONH/Z3gy1L4Fl3zwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6jBOO5qxYI/+Pif5uhgIprpRO82xMTxLQpu7lhBUEI=;
 b=ejzTEGcd6Yyiu0IrrybhxGJE0R4KAFPCjZu8QSMAVNYZIxJTBrF70JShZo3JEHXGdb7kH0ii9VfIRdunGhRjNsaFpplcTrTtwOz3Vw70GK+nN8fFXDnWmKq0/e1OB84J3BPw79fmQ3fBz7TXfj1l49I7ATY+sAjcZ/g7714xOMM2IaY4rorV75RRjMhmAIN+3iC9U5MfQqXCxxFxftk7RuGvpY2xrWmIFXELOZwIj7D+oqhx78lbREsG6GmYii2CQS3mUx8JYvcSz6njpEkegNVwgnQDPOJKMBXDu02DGbHpBs1qqYEK97oQ/jaONHrrmCMHuMaOAzFEKFLfZC/3uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6jBOO5qxYI/+Pif5uhgIprpRO82xMTxLQpu7lhBUEI=;
 b=XzyHONEWRRmi2cETKSmMJTRTKsfGf4DK+H6ePRN845x2o6t3pyTbJM8eyDtZtCoFtCz+cGJ2Yo/OHI/fSozNylYRUIt+R/UAkXuqyjARyBjKp1qglXwckGLGL2uRsFf8OSCCxS1zHjgwKMXe7eLlWm99PTFnmfRiZW3qm2RZZSw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=toradex.com;
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (2603:10a6:20b:a8::25)
 by AM6PR05MB5174.eurprd05.prod.outlook.com (2603:10a6:20b:66::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.24; Tue, 14 Jul
 2020 15:18:38 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d%4]) with mapi id 15.20.3174.026; Tue, 14 Jul 2020
 15:18:38 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, Peter Chen <Peter.Chen@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime-pm
Date:   Tue, 14 Jul 2020 17:18:21 +0200
Message-Id: <20200714151822.250783-2-philippe.schenker@toradex.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714151822.250783-1-philippe.schenker@toradex.com>
References: <20200714151822.250783-1-philippe.schenker@toradex.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0019.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::6) To AM6PR05MB6120.eurprd05.prod.outlook.com
 (2603:10a6:20b:a8::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from philippe-pc.toradex.int (31.10.206.124) by GV0P278CA0019.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:28::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Tue, 14 Jul 2020 15:18:37 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [31.10.206.124]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53f761c8-de3e-42d2-1f50-08d828092f01
X-MS-TrafficTypeDiagnostic: AM6PR05MB5174:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB517456183AFFB3DB4D54FE23F4610@AM6PR05MB5174.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: czZnlq5kVcJH0ECYRdgaP5qTCICdbXgB4atJBjQevkOoLv9+cUCeFnnUlqyauta2kxigKGQCYLCwEHciy/FzGIkzHKcBbmst1apB/5Mb3yaUaS1891rfK9ELDj4iZucKPwCjZZLmFvKQYJDd0LuJh3OcFh+pzOv3CH/1dCTSCbNs03YWhfqKQg0iZlci5jx+sbtBfOw4DXOYR9pzUQHebbf/zE4Ail8eAa0oGUZNeGrkcOgOozH/czVe/KoI0Dk0rBiUDEmZjkPePTlLJnCkAdmnvUFapuW01Ox5lWkFrcAyS00g5tMK1H1ctSYkR4hNYYSij4fixZsHBaW8FBfdVBGELbTXeeAPti3Q3+qxFRcpfHI7r5tb+bP2uggcYMHX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6120.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(110136005)(86362001)(4326008)(5660300002)(83380400001)(7416002)(8676002)(6666004)(1076003)(6506007)(186003)(2906002)(6512007)(26005)(66556008)(6486002)(2616005)(956004)(36756003)(16526019)(66946007)(66476007)(52116002)(498600001)(8936002)(44832011)(54906003)(16060500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: HJtTe6zhSW5FBerHHmj8E6YtwJ95c2cjVi+725Q1546mEI3jRYMY/tX3iCzaGTJmjBJpqXdSKVwXrNKEYRoWQ7EJ75MfHxWZOI5G0WdUsPiPtBpIGTxiGhLtENXvJ3/P4J1eeRVceUGmKOgkDg0H9p9HkhkDlfy0JXFgC1bAHdCq688r9hpVlFa2s41VADexe6U3QX6xmf5VomSLat112UFuh70gT4AdwoV9/0QuRHDy8AttXLkfDxJDBGE2nM8C/9D8a8v9q67N1XYIQhgd/onQ5QDQlb3T7gcap49Sprn5rRxnBFPTn+JcpOgsGcKA2mtBwveDLX1RuW8+fNUVxqjo/vGPy+ZTFKFfiQougIFCM370FE60mjGRBOZjbOuzVn63UQPhk4ToAnDOAU5/CjJ5oKEPa3+B8JJTmUgBWqvBdRzAO2kPVMFssO4hIk+/THCub8x+q0rni7TAKRvXgbLZwKJCDGHxRfOjQtBpmA0=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f761c8-de3e-42d2-1f50-08d828092f01
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6120.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 15:18:38.3463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jXmFlBgErBFKQzYJolm8WJ4cJj4ynzt/dXOr/E34yiyUCLi/WwRLQNteSZp9NpCONKdJZ9DNqj2u6NUhTYInNA6FWJ7uRhSYksTE4JcuTEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Toradex Colibri iMX6ULL board has a special USB hardware design.
With runtime-pm enabled USB reset itself continuously. Furthermore the
OTG port is also not enumerating devices if the Chipidea IP is in
runtime sleep mode and a device or host gets plugged in.

This patch adds the opportunity to disable Runtime Power Management
from devicetree

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

Changes in v2:
- Change commit message to tell the use case for Colibri iMX6ULL

 drivers/usb/chipidea/ci_hdrc_imx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 5ae16368a0c7..5078d0695eb7 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -434,6 +434,9 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 		usb_phy_init(pdata.usb_phy);
 	}
 
+	if (of_property_read_bool(np, "disable-runtime-pm"))
+		pdata.flags &= ~CI_HDRC_SUPPORTS_RUNTIME_PM;
+
 	if (pdata.flags & CI_HDRC_SUPPORTS_RUNTIME_PM)
 		data->supports_runtime_pm = true;
 
-- 
2.27.0

