Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADEFC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DA8E2078A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Em1a3mFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgHZSog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:44:36 -0400
Received: from mail-bn8nam11on2042.outbound.protection.outlook.com ([40.107.236.42]:13729
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726786AbgHZSof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:44:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klGyn4ySlw25xjvjWxzYcgAv132Z9CKzslmv3qs0YG4NPJDnACAiaINxtXTj1Grnldex+fJ+HXlMbB4AfJUFwCt3DPMoXqkk6Zl54cknR2hei3FGD+AKQ6s8Q/mTBuB1Z7bHZG1QCXBFhqgGAlvmxXalZuCIGO3vH7gP3WGIcLB/CsJCdmcE6+GbinYp+d51xnf8zxldzOsUP9HLNkdkz+DtsYk31VcDkYGnfaY3jk5lkeHSof06vDxzymtpaWGbgHWFieSSLQG+i9a83JZ1l2/wN52N/zOSyhOapHUnRGq46oqDHfPmBTmmeY7SBSE1CKpwUWdT10HZEk9csxTkmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sr7Rxu5N1hxyLakYX1rDtpttNRcvr3x3UdqNgtwlHUQ=;
 b=bUeBuOEHeGTMjPHAForfmK15fxtd0jigRVEWBpdl8TdHdHmFWhTIPVXMFscc/TyW0wOZxoNRxGwJCXqt+jZXSSLcMJOB1gzACqXM/G/GoxFpYUnoj1k4wwBmnkj1RaDLO7qEzT6HpuSUwlvxTbSHq9z41moYC56DY0+h/aVleR4cmq8GfLYpoGcQ9dYiPWKVkceJLlY2F9kbyzn2H7RicQ4h+4iglZfyQTRml8Z/EYPHz6IVXcrDSqRpE4KL7p6tAcFxDYPXCLjwxnkWAm4TlNRMlUDo+ez7csdAlAVyJBMgLk6jA6Dh4doIKJlgrlZWyDXoDy7WbCusbdYNsHGcWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sr7Rxu5N1hxyLakYX1rDtpttNRcvr3x3UdqNgtwlHUQ=;
 b=Em1a3mFmC4lDcZeDBWMfxdoJsBm5EUd1+gsDO+LfChgoOrywOHzB8AD7DG0lrW310+Ey8hQrhK/bU81bADC6IKTZdGGv7WBXELaB2zoSTv+kdPlGXwHBo99fSkqgSBRe/6kTDPpWhHII4bCQEEmgK47qChpDYCHQ/RzxVtvMMiY=
Received: from MN2PR22CA0016.namprd22.prod.outlook.com (2603:10b6:208:238::21)
 by BY5PR02MB6771.namprd02.prod.outlook.com (2603:10b6:a03:200::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Wed, 26 Aug
 2020 18:44:32 +0000
Received: from BL2NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:238:cafe::b1) by MN2PR22CA0016.outlook.office365.com
 (2603:10b6:208:238::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Wed, 26 Aug 2020 18:44:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT024.mail.protection.outlook.com (10.152.77.62) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 18:44:32
 +0000
Received: from [149.199.38.66] (port=58166 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1kB0Ou-0000lZ-No; Wed, 26 Aug 2020 11:44:00 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1kB0PP-0008Om-S0; Wed, 26 Aug 2020 11:44:31 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 07QIiSlL008569;
        Wed, 26 Aug 2020 11:44:28 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1kB0PL-0008Oc-Ul; Wed, 26 Aug 2020 11:44:28 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 2550A12116C; Thu, 27 Aug 2020 00:14:27 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        michal.simek@xilinx.com, balbi@kernel.org, p.zabel@pengutronix.de
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com, Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH 0/2] Add a separate DWC3 OF driver for Xilinx platforms
Date:   Thu, 27 Aug 2020 00:13:59 +0530
Message-Id: <1598467441-124203-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c2c9d48a-6a22-42fe-f44d-08d849f01260
X-MS-TrafficTypeDiagnostic: BY5PR02MB6771:
X-Microsoft-Antispam-PRVS: <BY5PR02MB6771A98F1E196857257FF546C1540@BY5PR02MB6771.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +VIPWT2b0qSRSlnyLtcozQF1fGFGdGKBGRkfHBN7lH9JWLvu3hXB4h89rU0XfOX77asV2VcCVohrDc1CPQdS8/0sjcBa2b9UvuEdv6I24r5hlOyEauHAWoOK6Cys2StD+CO3nZ/evPHi0gVu3cUBZg2EEiinxuKTSG+e5iXHpMmXO/8W+PUSxnWHLPoLfBmzaqLe9rh0kjIdvEmZUKEEc5IU39S67jTiUtMfYEb/jr7OyTCLlm0XCX8GouJ/Ps0rV8GWJIxKSbRyfrJHQOrhlvFviHWvb9qYm/ACV8tdgSnBgVrU1iHLDfeyQ8sTNoRINB6fRmqC8nmaemxd1pW19fh4CMMXY0wzvUDBtMRUwtI/6N5PNOOzP4BHnhWdi98dikiUljRUHotmzvrlB78/YA==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(136003)(396003)(346002)(376002)(39860400002)(46966005)(70206006)(186003)(70586007)(26005)(42186006)(316002)(8676002)(6266002)(5660300002)(356005)(336012)(83380400001)(107886003)(8936002)(36756003)(478600001)(2906002)(4744005)(4326008)(81166007)(44832011)(47076004)(6666004)(82740400003)(82310400002)(2616005)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 18:44:32.2147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c9d48a-6a22-42fe-f44d-08d849f01260
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT024.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6771
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series documents the Xilinx Versal DWC3 controller. This also
adds a new Xilinx specific driver for adding new features in the future.

Manish Narani (2):
  dt-bindings: usb: dwc3-xilinx: Add documentation for Versal DWC3
    Controller
  usb: dwc3: Add driver for Xilinx platforms

 .../devicetree/bindings/usb/dwc3-xilinx.txt   |  12 +-
 drivers/usb/dwc3/Kconfig                      |   8 +
 drivers/usb/dwc3/Makefile                     |   1 +
 drivers/usb/dwc3/dwc3-of-simple.c             |   1 -
 drivers/usb/dwc3/dwc3-xilinx.c                | 416 ++++++++++++++++++
 5 files changed, 436 insertions(+), 2 deletions(-)
 create mode 100644 drivers/usb/dwc3/dwc3-xilinx.c

-- 
2.17.1

