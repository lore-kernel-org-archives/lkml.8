Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C711FC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89E5820C09
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="jViknBfu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgIITDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 15:03:30 -0400
Received: from mail-mw2nam10on2059.outbound.protection.outlook.com ([40.107.94.59]:13792
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725772AbgIITD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 15:03:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PE8ivolFGC5pvuB+/3m1HzSHbSSQ6shLZhagvr4UoLgfcN+18XuSBkPemO9k/+4EI5YM1S4pzAQhfpI5ZKQSGFELLr76dxYdAxfVJeOalq4eTnRv7zW34AQCxanoxkhYwSHHBm+uDpTkIQhr4f42lSliCPuNxEnvV3+poLN1pbWETQcvtSZSV1Pd8sfueOhWhsTu0WkUob2YmSisp2kmsEq9N+0vrut0k0jsfk15Tyjqp0W2b5X/z0ZWiOyQ8gi3bjxPwZGpmRJHAwbGgZuznMWs0+TfNoOsTF3TNa8yfPW6z2yozScHN2RNKKXD61P0H3i/eBYLLwQRXVT1+XvaXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4kpBbYGhlIQ6MsPQqx63VN33wUw1oJQbfvhhHqxsZk=;
 b=eNLJlLqn6LgOkdNG/G1HSaEgxUl8W75Hd/aABcfYZGUV/xTA1abO5ioPQWLgugyGeNhEVsPp6UV8GYwprjXnpRL92zJk/Qw31DoHBw9FLgOyj146HLRPCyC5VeHi0Cjnp+XjldW/YdFN+y0FhCyfW3f3yRw49WCSJfm5TbaJR4TbkFJ4cA3qX9Y9ElgNUY2Vhbw7eMr6e+28l/in3a7XNRf4tpa71fEtZ9FHtLJWJtXjo85W6K+QNRRg+NtDnQUuW9gNMOR90J4WCkqgtPFYuWtIeS8Yj3rOzJKbtvzNQgCFFSlM1eTBTdYIog3IbsXJnT7PAJb8lgwLURWZueCZXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4kpBbYGhlIQ6MsPQqx63VN33wUw1oJQbfvhhHqxsZk=;
 b=jViknBfuIbmCapbZEKhOeAT9rwM0TtPixQ62LUO9joRpDJLcdHkPzynVTT4yn+/rYmFGBa7eKiuFpAwYaG1z3Pz/+MRxCrShxpA6I8byp3O5vTeZAMjx806xt4w7UPdSUc4FuqA/CQWaHDXyKPloON+85jhtRS6gpVrFB6/5KiA=
Received: from SA0PR11CA0029.namprd11.prod.outlook.com (2603:10b6:806:d3::34)
 by DM6PR02MB4810.namprd02.prod.outlook.com (2603:10b6:5:fb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.18; Wed, 9 Sep
 2020 19:03:24 +0000
Received: from SN1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d3:cafe::bb) by SA0PR11CA0029.outlook.office365.com
 (2603:10b6:806:d3::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Wed, 9 Sep 2020 19:03:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT009.mail.protection.outlook.com (10.152.73.32) with Microsoft SMTP
 Server id 15.20.3348.17 via Frontend Transport; Wed, 9 Sep 2020 19:03:23
 +0000
Received: from [149.199.38.66] (port=46072 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1kG5N5-0000Js-GO; Wed, 09 Sep 2020 12:03:07 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1kG5NL-0006oT-KG; Wed, 09 Sep 2020 12:03:23 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1kG5NC-0006m2-74; Wed, 09 Sep 2020 12:03:14 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 68C371210F9; Thu, 10 Sep 2020 00:33:13 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        michal.simek@xilinx.com, balbi@kernel.org, p.zabel@pengutronix.de
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com, Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v2 0/2] Add a separate DWC3 OF driver for Xilinx platforms
Date:   Thu, 10 Sep 2020 00:33:03 +0530
Message-Id: <1599678185-119412-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 03e79000-94ec-46e6-30ca-08d854f306bc
X-MS-TrafficTypeDiagnostic: DM6PR02MB4810:
X-Microsoft-Antispam-PRVS: <DM6PR02MB481094AA01B74BB6A06878B8C1260@DM6PR02MB4810.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IGNyOlukbEDeSHgezOBPwmVx3X0nFLOS1+hrv8KiUC0nJSfpdn0aXiiDmrbWrWRXoyFwMAP+gK1U5lmmK28OVoCRzl8OLgXyQ9Hc6246e1JHJR4GC0QuqTbRQoQeAvKcEqNS3L16p3aGutYUC39+1Ipy7P0d9h7JJidlrv6IwUzF7BM0iCFWY8NpSkfEv2PM8MsRMvCQlkuPrK+jl8gmC139jc8b7lxEha0V5J9snvsUMSZn66EkhlqidJPMHg/z75Ob6xUwefn/89c2JIBpdGW9ZU/TpIMx1o+R+heMdpsqxJKv89IDFMi327IeCtZmZ4S4nPD5hxf0WAGIcYmQmUpvjyXj7KOqQW7myjHYbqdYxJubJWrOc3Phz9xd1xoNxRGLRAL6tLI2XdJwHGNCXQ==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(39860400002)(136003)(396003)(376002)(346002)(46966005)(47076004)(36756003)(356005)(6266002)(426003)(4744005)(5660300002)(107886003)(44832011)(2616005)(8676002)(6666004)(316002)(8936002)(42186006)(336012)(26005)(478600001)(186003)(2906002)(4326008)(81166007)(82310400003)(83380400001)(70206006)(82740400003)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 19:03:23.9467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e79000-94ec-46e6-30ca-08d854f306bc
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT009.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4810
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series documents the Xilinx Versal DWC3 controller. This also
adds a new Xilinx specific driver for adding new features in the future.

Changes in v2:
	- Addressed review comments from v1
	- merged normal and runtime suspend resume functions as they are
	  same
	- Improved description of some register operations to avoid
	  confusion
	- Updated commit log for patch 2/2 for better clarity.

Manish Narani (2):
  dt-bindings: usb: dwc3-xilinx: Add documentation for Versal DWC3
    Controller
  usb: dwc3: Add driver for Xilinx platforms

 .../devicetree/bindings/usb/dwc3-xilinx.txt   |  20 +-
 drivers/usb/dwc3/Kconfig                      |   9 +
 drivers/usb/dwc3/Makefile                     |   1 +
 drivers/usb/dwc3/dwc3-of-simple.c             |   1 -
 drivers/usb/dwc3/dwc3-xilinx.c                | 334 ++++++++++++++++++
 5 files changed, 362 insertions(+), 3 deletions(-)
 create mode 100644 drivers/usb/dwc3/dwc3-xilinx.c

-- 
2.17.1

