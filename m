Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A80C47247
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 04:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 840E720787
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 04:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="TuFcHG3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgEBEhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 00:37:18 -0400
Received: from mail-eopbgr760084.outbound.protection.outlook.com ([40.107.76.84]:56200
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726439AbgEBEhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 00:37:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IasgLrKZBjprh6wF6R19mbEQwnx/tMtOzkY31NL2bwEC8bHZSvpkfANTQDnLkK2ygcFZ2eRtpgnybxQ02GzszMrEUe5CuGFt7I73NYyDwL8HcckTIvFj5V3eXSpzZe1HZ5OqQtuM45u3PyHnfZMmneBjlWsaR3Bz/N9sTN/fTREWroj+cnA9plk4GesyPwNlmGp20Izn3YU9irIYdx96KQ5LzGH0IFm8+vWAcbp5hrupXRsBtZMTwiWltOS3xLHfp9vGkvyibY/8SNcIOnOxgLASytT8n/bulfK7iCeBUrJ52Wx5nTSLviFE6WE/Re9yhccOJ5P7+JeEIFxGb0mIvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81Vr0pdQLNjcCLAMipEhCBN3HMdvBiv21M+tfaC7ngQ=;
 b=W5y7k0Y7O2Ij0zgGvFiALnHLtlDtIN5mjJePp9QEo4W2NiMyi5xCE/RwDSJDMshqePHFj8EuvIH/uYAh2/R3jfSAPG43n2lOsMmFX98JKoKqpWJBB1BlSlk+2vQ2nX3brZDjnQgl9X9Eq/iFumRUlK6MrPzufcdeQn7bAodc20bF1bzOfHAm/RFG8BgmuJ17JNUqhiaX5/XoDq2IGlQrz67xVocKJtRUGt6FnBV+QuDAO82SigAOtGqFnquCuQEOiuD26JCMQaGByiRBLXm8EZfN/Lpx7N3G7Tm8ONpjrVaskvL6sm3rEXJp6yklJHq9wo8Orlz+CvnNubEpOuzW4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81Vr0pdQLNjcCLAMipEhCBN3HMdvBiv21M+tfaC7ngQ=;
 b=TuFcHG3VsiO4rEIBcTWBhpSm9fskphj4IY0tnA/cWVxQbB8XS8+TkPvdf3wob4rOZoAjAR1Jyi3S6nybRynlK/tPNByU1XrjdMmyAXsKXbwN9wAAM7wSEISyyqSzcv6aDJfHpwUTzBzgiGXbLflbFS/oE6OPqijhGn8GR/doikM=
Received: from DM5PR21CA0068.namprd21.prod.outlook.com (2603:10b6:3:129::30)
 by DM6PR02MB5801.namprd02.prod.outlook.com (2603:10b6:5:17c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Sat, 2 May
 2020 04:37:14 +0000
Received: from CY1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:129:cafe::c2) by DM5PR21CA0068.outlook.office365.com
 (2603:10b6:3:129::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.3 via Frontend
 Transport; Sat, 2 May 2020 04:37:14 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT040.mail.protection.outlook.com (10.152.75.135) with Microsoft SMTP
 Server id 15.20.2958.27 via Frontend Transport; Sat, 2 May 2020 04:37:13
 +0000
Received: from [149.199.38.66] (port=34426 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jUjtn-0002fb-34; Fri, 01 May 2020 21:37:11 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jUjtp-0004eZ-JX; Fri, 01 May 2020 21:37:13 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 0424b5gJ003802;
        Fri, 1 May 2020 21:37:05 -0700
Received: from [172.19.3.8] (helo=xsjamitsuni50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jUjth-0004de-4p; Fri, 01 May 2020 21:37:05 -0700
From:   Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, michal.simek@xilinx.com,
        mark.rutland@arm.com, linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, jollys@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Subject: [RESEND PATCH v2 0/4] drivers: clk: zynqmp: minor bux fixes for zynqmp clock driver
Date:   Fri,  1 May 2020 21:36:59 -0700
Message-Id: <1588394223-257635-1-git-send-email-amit.sunil.dhamne@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(46966005)(478600001)(6666004)(966005)(316002)(7696005)(107886003)(5660300002)(8676002)(26005)(356005)(4326008)(8936002)(82310400002)(81166007)(2906002)(9786002)(47076004)(82740400003)(70586007)(70206006)(36756003)(336012)(186003)(426003)(2616005);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f24b8a0-11a5-4742-9e4e-08d7ee527c78
X-MS-TrafficTypeDiagnostic: DM6PR02MB5801:
X-Microsoft-Antispam-PRVS: <DM6PR02MB58010C628EC813145A219146A7A80@DM6PR02MB5801.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /7oWpxS7ouS0Kunzf8ZsbjiWZ6cyD6f+jjAVce57a9x+D3fQ9wXAPqisewPs+9+D3tloWQhqdYbYqTLgdJ9r+xdzpJ8SnF7rCVUcEfUakWoB0xfS+pvlJB1Cn1VJTRCpvXRdSYRBKVrUGGusCxehfCsezrxAEM6sbMjpxyWRobIDeu9Az3EG47HGAk4vlr6PiVk3GA41bIq2CGMtpeWDDGe3+furVbVodGwoLGFMl5SCSSlvIU8vfhY5JLOoHXygMF7WkC+34X7YgBt4G7jpjPjLiijL+31MbYnvVrxdOVfrvSn8ytw//QDP5ss7vw+0PzDD1cdW7zjgvh036gyFCHL3nziLe5M7Nf9yCKSB6GH20XgIiHGmmfPSfpabC8I5dXgjUhguZqweZXaDSean+xD732jas6n2RpqAHLEPpHXdAMuipD6fIQLBNeSq1VTt/U9aqYAjPRnRGZEQ9JKXJdmBYngY6gq8/Ak17RSObJyvPHA0xMsty8O35il9NAnO7/QJQ3JwFOM3Kd4L3qWMF8PqjHn5GPIIxbOdHBFxrZAJy+CRCuMxWUH2crLVa6YUref1iEk4Jic3TIeUeuDC7w==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 04:37:13.8933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f24b8a0-11a5-4742-9e4e-08d7ee527c78
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5801
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset includes below fixes for clock driver
1> Fix Divider2 calculation
2> Memory leak in clock registration
3> Fix invalid name queries
4> Limit bestdiv with maxdiv

v2:
 - Updated subject for cover letter and patches
   to add prefix
resend-v2:
  - -We have tried to ping Stephen several times over email. Link:
  https://lkml.org/lkml/2020/4/9/754 and also we tried to pinged him
  over IRC this week without no reaction that's why we are sending
  patches again


Quanyang Wang (1):
  drivers: clk: zynqmp: fix memory leak in zynqmp_register_clocks

Rajan Vaja (2):
  drivers: clk: zynqmp: Limit bestdiv with maxdiv
  drivers: clk: zynqmp: Fix invalid clock name queries

Tejas Patel (1):
  drivers: clk: zynqmp: Fix divider2 calculation

 drivers/clk/zynqmp/clkc.c    | 20 ++++++++++++++------
 drivers/clk/zynqmp/divider.c | 19 ++++++++++++++-----
 2 files changed, 28 insertions(+), 11 deletions(-)

--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
