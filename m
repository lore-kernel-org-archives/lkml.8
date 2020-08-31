Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2224FC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 06:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E71282072D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 06:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="i0mzdFDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgHaGxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 02:53:35 -0400
Received: from mail-dm6nam11on2062.outbound.protection.outlook.com ([40.107.223.62]:13856
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725794AbgHaGxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 02:53:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STOmiSv0aS4dlbvc/zpO+oRpipDWkIJVHV+7Ymgib5+yBwYOUE2AOQxGaFPKH4vcpWYHPMAXS0gfzAziu6q5zVwKUATYuj/OqkZo5cxBUU8b9zMMQ7vd2rSAmpGDUHzZFFESfE1T8qhUdb57YKyMmNuKg2heCRWmNn4n+vLy5PKlJZ9RHmrugLz3tZPOpnmvBSPJaApnGInB09haRvmn4ksHWmn1C+UJUmvZ4NsQ8xpo28+AvzTqFcP6T4u6ul3ppRmA2s/6e3O3vUYn31vzOt0aPrh5QLplYf4JoPqYhc2goyPhwyyAqGheYPMpvHKrUy+8nV6PIbP3Bj+X1OWCqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9y1Xi5eIi/6Xm0NR6kLhAF0cCwSoCGfu1j43rm7zgc4=;
 b=l4+5B4ykRaN3VMzpi3Cvp/iT0+0f3BsdShBuezjUsR54EOpqEPEl0zm2aC/mH2WkxHuHaH0pVCpU7EDaOUpvq9n+U3M1eI2UV6B2pwg5j1ayJLJikeIhj3Nvq0PLkw/sleJwoDEd/w94qP96OPcUsoNVvo7qW0Hnx7HiqgNNuGoGzvm+WNFfvwB38VLzyhGKbWEsbWaGaX7TGDTaH19NKZxM/nXApylAA2z+XUDhVhmQ/Iof35q0vdUPoalzDKEK3wzFqFalUuhYL60YWCm47ewfBlSlxwgw5T1RWIJps6G2yDSPFz67wBhVS+UA9uDBd/B5wDbYh0X28eCxyPY9Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9y1Xi5eIi/6Xm0NR6kLhAF0cCwSoCGfu1j43rm7zgc4=;
 b=i0mzdFDP7A546eSy6xlw6jbqcAB7vnHCuh1zowZWwHd1ffl4FurxEaz82bFgl3m5m0vJjdN3oOKCiIs+VFKaWmpy6MKMGxQguJuMvn5kQfxE592UxXHpPeP5kh4j4dEVWnxEEr9K/zw2Bya69LV5TOMpJRllzUj2zvkuVt8nLcQ=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from BN6PR1201MB2467.namprd12.prod.outlook.com (2603:10b6:404:a7::8)
 by BN7PR12MB2754.namprd12.prod.outlook.com (2603:10b6:408:2b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Mon, 31 Aug
 2020 06:53:32 +0000
Received: from BN6PR1201MB2467.namprd12.prod.outlook.com
 ([fe80::2160:a344:3b0e:cf3e]) by BN6PR1201MB2467.namprd12.prod.outlook.com
 ([fe80::2160:a344:3b0e:cf3e%8]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 06:53:31 +0000
From:   Nehal Bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandeep.Singh@amd.com, yuanmei@lenovo.com
Cc:     Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
Subject: [PATCH] xhci: workaround for S3 issue on AMD SNPS 3.0 xHC
Date:   Mon, 31 Aug 2020 06:52:46 +0000
Message-Id: <20200831065246.1166470-1-Nehal-bakulchandra.Shah@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::11) To BN6PR1201MB2467.namprd12.prod.outlook.com
 (2603:10b6:404:a7::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MAXPR0101CA0001.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:c::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 06:53:29 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e1a1de47-4dcd-4926-c831-08d84d7a92a2
X-MS-TrafficTypeDiagnostic: BN7PR12MB2754:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2754CB9A6651842522F660E7A0510@BN7PR12MB2754.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +oawSJlqRR8jodj6EM88Uqmocdlh20odmt5gcI9JqoUf0ZIProdXTKLXuooooeL+IFcM/FZwonxI5jdB/zVdvyG9U2LbgANscLAJ5YR101RNIdvpM6CW6vIjM1YKG9Z2bA8s1wsSETC29NHenIkygV89NL7C207cSUhSzuAfNxJ2Cw55GFHtqVFR/BxfITJh3FmLv6nhMndljOQxWkgOoFyn0o+9XcnncR+H0aKr4mBMv0ErqAP8F/1eXR2I1cqALPLJTg7w/xFW2Lu/GqQljQtWy8tU0OidkHmUL5hFxHJTpXJkHmEbjopPLTyITXhBwjuABlpDifGz4zKMKqzzZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1201MB2467.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(956004)(36756003)(83380400001)(6666004)(478600001)(1076003)(4326008)(86362001)(52116002)(2616005)(26005)(316002)(6486002)(66556008)(16576012)(2906002)(8676002)(5660300002)(66476007)(66946007)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 8eTul6gWNjpgYLCgHygPgt9pXgJUWyjuVvqRH9B8tEHwQrEPC8orGQ1ExTXu0bQBJhPcLiGTgCQKHdwVa7dgA2xmIPNnIFRZK7pSe9FOpkcVFv9w+GQehTjd70rIRPGKaHLTMt35oSZY/gky1JVg4nOfBnIr3rIg7graF+IjziUgtftQxP89+n6yo2oQB3rvXfzIXOAB+4aq1wY9+gs+yxgpr38mDkPqb0ZNDQ2RNEqXcChE8oy2BGoOhmlrUlsp4tDOIZLoSVZJuXRNn52wLmF/YWl8fjzOy0Rsm996Gp/10rtM2080FYHoJ90TnEMLis85WdvvrfC3f+eoHIT0/WGGJBz5rYLgfB1A4Ands+JN2VZiGO9wx0JjqSLNLQCGmEvz1JWzjjaAjdsoN2dfk4QI4/MgkwuwiXlGibvLZmAzJ8S20OsnDp93uWRBypmvdGIQePkoO3hxsgq3lmwUEg59KnVgY7W1uXPDV7tw3HPzRB1PAgGU/6fdjPCs42M1s8Rp0MIQK80WL9zggObrSzAXqJsUtW4dmzF9Tmvs0+cmfFZgeufNIP3pe/ys1PXAuX1S5GyreKpRiiafX/tR3dKdCO1HPBVKoO63l58/a8lR5ftTGWokSSsAQ3ri7lwdVGv++47WuzEx9ToF+eLouw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a1de47-4dcd-4926-c831-08d84d7a92a2
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB2467.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 06:53:31.6104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9UUhYsQdJblPG81QQL8fKskbW4pX+EDnPNPSVPlKVNGTrblzR++MzF15BVZ6kGil
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2754
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>

On some platform of AMD, S3 fails with HCE and SRE errors.To fix this,
sparse controller enable bit has to be disabled.

Signed-off-by: Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
---
 drivers/usb/host/xhci-pci.c | 12 ++++++++++++
 drivers/usb/host/xhci.h     |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 3feaafebfe58..865a16e6c1ed 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -160,6 +160,9 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	    (pdev->device == 0x15e0 || pdev->device == 0x15e1))
 		xhci->quirks |= XHCI_SNPS_BROKEN_SUSPEND;
 
+	if (pdev->vendor == PCI_VENDOR_ID_AMD && pdev->device == 0x15e5)
+		xhci->quirks |= XHCI_DISABLE_SPARSE;
+
 	if (pdev->vendor == PCI_VENDOR_ID_AMD)
 		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
 
@@ -371,6 +374,15 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	/* USB 2.0 roothub is stored in the PCI device now. */
 	hcd = dev_get_drvdata(&dev->dev);
 	xhci = hcd_to_xhci(hcd);
+
+	if (xhci->quirks & XHCI_DISABLE_SPARSE) {
+		u32 reg;
+
+		reg = readl(hcd->regs + 0xC12C);
+		reg &=  ~BIT(17);
+		writel(reg, hcd->regs + 0xC12C);
+	}
+
 	xhci->shared_hcd = usb_create_shared_hcd(&xhci_pci_hc_driver, &dev->dev,
 						 pci_name(dev), hcd);
 	if (!xhci->shared_hcd) {
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index ea1754f185a2..ea966d70f1ee 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1874,6 +1874,7 @@ struct xhci_hcd {
 #define XHCI_RESET_PLL_ON_DISCONNECT	BIT_ULL(34)
 #define XHCI_SNPS_BROKEN_SUSPEND    BIT_ULL(35)
 #define XHCI_RENESAS_FW_QUIRK	BIT_ULL(36)
+#define XHCI_DISABLE_SPARSE	BIT_ULL(37)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
-- 
2.25.1

