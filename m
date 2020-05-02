Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4277C47256
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 00:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7386221775
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 00:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="KVwSffcW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgEBAZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 20:25:30 -0400
Received: from mail-bn7nam10on2071.outbound.protection.outlook.com ([40.107.92.71]:23807
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726352AbgEBAZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 20:25:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nN/a/Ix1ayoDZxFp5dhwOaoVIUdi2RluIAMX9UM18USYP8l3pjSXc32Z08FsyFgaSftjsPlpUYLG6PXd9jIUzaGaJZ2QEvsA6n3+y4f/nKFvMmnnu8Roo1NIKaHjfrpp+3ioV5oHqK/YRnQBhxVYZahmFHnjIQFCWxXRw+jo4MpjBxyq5ErUyZtTuVUPhiXt4FEDDXxsa2HDk0olQ6UCUWxSqZObUjx0Rqth81hyN6ULVfatoewDbFXIMWHH24bhH0DGj0OPdhoL2t9YEyKyz2C/M2alQbhnaZKazhEPRd2vOZon7uO9LSoiBAKuyZ6rwqa/AFpsw3wdplWfQg/IGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlwoRETXK8dK1LUyYeUzMX/A0nSc1vZw3PgFadZZ4hQ=;
 b=kIzYe9M4hVn5nsHCbnVRwMfGRu3Pp8uT53Iz5hNTSLib2YGfwkrvwYzTASaaiGDRlyeYe9L+Uks0KQ0NsZyefjJz4lq6XwhdEW6hQ4SudpfXCY04mLhxl54+hB+oun2tGQC2uvLj8u/9xjAabzD59gAZs3wZwDQwyqic07xUVgMIrLBvPiXaqUSbWU3Szau7DHqKeijfavm7XyI0ENbfKOLwhKxEz5yXCXHiZ2duMDo0k4c3Cl4pZpBI1JGnivUSUBZxntZTlfNHz9vtmPksU/AamLupUjrRGjCE40NRPW0TsBVBkJBXmKRHr89fL6fvoeetbUdiUYXdf5k3+Vhwww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlwoRETXK8dK1LUyYeUzMX/A0nSc1vZw3PgFadZZ4hQ=;
 b=KVwSffcWiyu0XuPeeo9cwsJxKqRUaYcf51CfliZgcLkmDVMesduono3/RSC4DFFr4ZdkZvWLDOqHHCPuXr/5JQYUMnOqw73Oy9U067lFD2msUFR6w+VBcyw7JeqOrubIdU0JCbguYHkibmVngOn0rG1tE1uqns5rMj1yUvyE/Pg=
Received: from MN2PR11CA0001.namprd11.prod.outlook.com (2603:10b6:208:23b::6)
 by CY4PR0201MB3539.namprd02.prod.outlook.com (2603:10b6:910:94::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Sat, 2 May
 2020 00:25:26 +0000
Received: from BL2NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:23b:cafe::22) by MN2PR11CA0001.outlook.office365.com
 (2603:10b6:208:23b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Sat, 2 May 2020 00:25:26 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT021.mail.protection.outlook.com (10.152.77.158) with Microsoft SMTP
 Server id 15.20.2958.27 via Frontend Transport; Sat, 2 May 2020 00:25:25
 +0000
Received: from [149.199.38.66] (port=38216 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jUfy7-0006Qg-A3; Fri, 01 May 2020 17:25:23 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jUfy9-0004NS-J1; Fri, 01 May 2020 17:25:25 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 0420PIOr027413;
        Fri, 1 May 2020 17:25:18 -0700
Received: from [172.19.3.8] (helo=xsjamitsuni50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jUfy2-0004Mq-0I; Fri, 01 May 2020 17:25:18 -0700
From:   Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, michal.simek@xilinx.com,
        mark.rutland@arm.com, linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, jollys@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Subject: [RESEND PATCH v2 0/2] drivers: clk: zynqmp: Update fraction clock check from custom type flags
Date:   Fri,  1 May 2020 17:25:15 -0700
Message-Id: <1588379117-254190-1-git-send-email-amit.sunil.dhamne@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966005)(70586007)(47076004)(81166007)(2906002)(36756003)(7696005)(70206006)(8936002)(8676002)(9786002)(5660300002)(26005)(478600001)(15650500001)(186003)(6666004)(966005)(426003)(82740400003)(356005)(4326008)(316002)(2616005)(107886003)(336012)(82310400002);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85bdb782-49d2-41bb-5d2d-08d7ee2f4f6d
X-MS-TrafficTypeDiagnostic: CY4PR0201MB3539:
X-Microsoft-Antispam-PRVS: <CY4PR0201MB353982497261AAFE3330278EA7A80@CY4PR0201MB3539.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WOT2aaUJTDWvKTJmOm9SD42qcNZ+ySoyRBjQgELIcr1SaT93P7QbOTP4SKEIakGU/FFG2N1xD4GcrQ1/jWIuqyS94f9E/J+EALgoJKnWdQgzfxiAk732XISra+6lhKXG/5Fk68BOvr6/x9z5l9evexbX0mngR28hvlj8j11AsZIdaky5R7n2ze3Rk/I4HHRKOThvv6kd16FIizlpGxTUbAgfB9IjJe+aq6OxjJxWKsZrGU8JUGjxjmzcjKToJhLNrhJLr795Fd5K1iOKCheLbrLxoFDt4XeD4RfYJUc/4qzUTTTzZd+ckOdmHMa7M4aJXlJu/TfQb+0OcDZc+jYGFtig5C3nnHFkHOXnAJE0rtgbS5TWKtvYBZ53THId40KKfU0a1UYzjtCPlge0Xxk/WwCCL2es9AOrtSeUa7QMtqG7biPBpeXM8ycbXvwIN3VM0wS9cpx3M4SXU2iVsN4DIejqgkIY65mDC/xGY71BFJ1H5SfUYOByCeT/3CiG4lqmek99g1VeZnvxs46/yT6oKISS1NFojTCKqLbSXqwa3R15RrTbw6S9RfwzdjVpYjsWrkbWwvzha1HXuo6nCo7A5g==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 00:25:25.9555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85bdb782-49d2-41bb-5d2d-08d7ee2f4f6d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3539
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for custom type flags passed from
firmware. It also update  fraction clock check from custom type
flags since new firmware pass CLK_FRAC flag as a part of custom flags
instead of clkflags as CLK_FRAC is not common clock framework flag.

This patch series maintains backward compatibility with older version
of firmware.
v2:
 -PATCH[2/2] Correct BIT index of CLK_FRAC in custom_type_flag
Resend v2:
 -We have tried to ping Stephen several times over email. Link:
  https://lore.kernel.org/lkml/70D64AAE-668B-4699-8BDB-41CFC755C373@xilinx.=
com/
  and also we tried to pinged him over IRC this week without no reaction
  that's why we are sending that patches again


Rajan Vaja (1):
  drivers: clk: zynqmp: Add support for custom type flags

Tejas Patel (1):
  drivers: clk: zynqmp: Update fraction clock check from custom type
    flags

 drivers/clk/zynqmp/clk-zynqmp.h | 1 +
 drivers/clk/zynqmp/clkc.c       | 4 ++++
 drivers/clk/zynqmp/divider.c    | 6 ++++--
 3 files changed, 9 insertions(+), 2 deletions(-)

--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
