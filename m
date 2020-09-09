Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72BBC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 20:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92B132064B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 20:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="a22G68xD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbgIIUpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 16:45:06 -0400
Received: from mail-bn7nam10on2077.outbound.protection.outlook.com ([40.107.92.77]:37409
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729988AbgIIUpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 16:45:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D43SI9dnALq96fr+dYsonKU51QmqMSHanNSggLJXS1l3z2nGMsg7RRot193Ge7iQj3of/cyTkH1m7A4xFID4bc0c0UXcHRu2Gjp3yHVlAdShJuccwHOBdjExhEt3iw+r9MWePA9lOwuK+0KdtBbp8AL9UEU1zl4Gv5vDjbO5PHmNTwZrnTk4jSsxYM1C0ttyJhlmZouuDyb6RJVqVqxSXEDs0T+8eykkGyyxPd0gYuseRNCnxvNvs+gigX+r0yReOliQasg6+hPfMTqouKSAFLxHOBvenN7VHhj1E3NDinOBZPdVvPEKZI6delTjw0iYK9QE8UVJ8HRZWN3kFHfphw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KNIrnomXYfYSKj/SSpKfH4UCO7bRreHFecyT972LiA=;
 b=S/mUjyzJyFjxTQYXIw/Qpiv81LoCU8r48cCjNaGGrFsRjvdZyRoxAnTsIIlq1T1pudKa7IhnzAyPNatT9y8AJomKuQlPoFOWpHcxyXT97Mqv7OK4nbU1UQHm9E0jaynOJAwmYhQ246uuwjNJHNwxCvaTT4vc72N15klAirEpTk9ZvPVM4gh8B8HTC7zJ44rR4kxAaer6+/fb1HC5i3E4YnC2+QWUxsUi/hWewHjOz32/6aLvpe74/+BAnQfnCJ7xFEM3CgsLlrcJPdMy0IAfSclAVufyPcasJiMnL+q7M9e/s0QHklZc0/sB2MJaIHRK7lc7SRcw7OHfXtwRPMgATA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KNIrnomXYfYSKj/SSpKfH4UCO7bRreHFecyT972LiA=;
 b=a22G68xDb4xRytHV62ipIVa1hdbMAGEQR0Ab4C3fgnpWj30h4ds9ePnw/dirUCi2FMczONM57bZcKYUXHDa4Wke7O9Qo8QbyXZ8uNn0zwQ4wQMFtH7g/9zvirgD+9DDZHkDrSwfInTZKh6rdxgxZwTGG2JQE8z9WtQnFWn9fDrQ=
Received: from BL0PR02CA0024.namprd02.prod.outlook.com (2603:10b6:207:3c::37)
 by BL0PR02MB4930.namprd02.prod.outlook.com (2603:10b6:208:53::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 20:45:00 +0000
Received: from BL2NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2603:10b6:207:3c:cafe::a) by BL0PR02CA0024.outlook.office365.com
 (2603:10b6:207:3c::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend
 Transport; Wed, 9 Sep 2020 20:45:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT064.mail.protection.outlook.com (10.152.77.119) with Microsoft SMTP
 Server id 15.20.3348.17 via Frontend Transport; Wed, 9 Sep 2020 20:45:00
 +0000
Received: from [149.199.38.66] (port=53388 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1kG6xP-0001xT-ME; Wed, 09 Sep 2020 13:44:43 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1kG6xf-0007dx-Tb; Wed, 09 Sep 2020 13:44:59 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 089Kisr8028424;
        Wed, 9 Sep 2020 13:44:54 -0700
Received: from [10.18.5.8] (helo=xsjamitsuni51.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1kG6xa-0007dJ-6g; Wed, 09 Sep 2020 13:44:54 -0700
From:   Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     mturquette@baylibre.com, m.tretter@pengutronix.de,
        sboyd@kernel.org, michal.simek@xilinx.com, mark.rutland@arm.com,
        linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, jollys@xilinx.com, tejasp@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Subject: [PATCH v4 0/3] clk: zynqmp: Add firmware specific clock flags
Date:   Wed,  9 Sep 2020 13:44:45 -0700
Message-Id: <1599684288-20917-1-git-send-email-amit.sunil.dhamne@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 01ad2b23-c051-405b-6be1-08d85501386a
X-MS-TrafficTypeDiagnostic: BL0PR02MB4930:
X-Microsoft-Antispam-PRVS: <BL0PR02MB49301713F82D2CBEF88884DEA7260@BL0PR02MB4930.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8GMJHP28dI0/An8AR7tuTasSb2rq6ZRhriq4dYcu8WwY1BIsxBO126O2aqgXdirbpvaG6+uJCYwuZQdOkiDce+Pj0BiTc8Gc/OW1+BpEm9UxkWKmqZBG628yo3oBBOer2Rrs3wNTHTG+EPx1Rs2Oy+AMraAnnEQIlEJyc2GoBp5z7P+cgDVXxVUHC8aSdNPoFNsMaI46G+05XlMMdpk/QTVOtf1doQ7NbwqfIz4CtQK1/sIkOTmFrUc5UxFmbGHlzUdnfVXG0oU6Zfy7LaKyFLj3kihl7qrgI/CTK5iggllwTvtdf+hhb9WCAaS3PxI9mAzlbLZwIa6oQhy7L5Gf/Qa+EiISAb/AlsVSyHdOtEI3s0182YkK1G/QqyniLTHqDTeGN254022CrfQ2MQ4cew==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(136003)(39860400002)(346002)(376002)(396003)(46966005)(2906002)(4326008)(26005)(8676002)(7696005)(356005)(9786002)(426003)(8936002)(70586007)(82310400003)(5660300002)(70206006)(316002)(186003)(107886003)(82740400003)(336012)(83380400001)(2616005)(81166007)(478600001)(36756003)(6666004)(47076004);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 20:45:00.2657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ad2b23-c051-405b-6be1-08d85501386a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT064.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4930
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently firmware is maintaining CCF specific flags and provides to
CCF as it is. But CCF flag numbers may change and that shouldn't mean
that the firmware needs to change. The firmware should have its own
'flag number space' that is distinct from the common clk framework's
'flag number space'. So use firmware specific clock flags in ZynqMP
clock driver instead of CCF flags.

Changes in v4:
 - Use if condition instead of ternary operator.

Changes in v3:
 - Modify helper function signature to map zynqmp (common)flags with CCF
 - Add helper function to map zynqmp (mux & divider)flags with CCF flags

Changes in v2:
 - Add helper function to map zynqmp (common)flags with CCF flags.
 - Mapped zynqmp clock flags with CCF flags from
   zynqmp_clk_register_*() functions instead of
   __zynqmp_clock_get_topology() which is changing the flags to struct
   clk_init_data instead of the struct clock_topology.

Rajan Vaja (3):
  clk: zynqmp: Use firmware specific common clock flags
  clk: zynqmp: Use firmware specific divider clock flags
  clk: zynqmp: Use firmware specific mux clock flags

 drivers/clk/zynqmp/clk-gate-zynqmp.c |  4 +++-
 drivers/clk/zynqmp/clk-mux-zynqmp.c  | 27 ++++++++++++++++++++++--
 drivers/clk/zynqmp/clk-zynqmp.h      | 41 ++++++++++++++++++++++++++++++++=
++++
 drivers/clk/zynqmp/clkc.c            | 33 ++++++++++++++++++++++++++++-
 drivers/clk/zynqmp/divider.c         | 30 +++++++++++++++++++++++---
 drivers/clk/zynqmp/pll.c             |  4 +++-
 6 files changed, 131 insertions(+), 8 deletions(-)

--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
