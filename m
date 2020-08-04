Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFD1C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB9D720781
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="O7ZoxIF9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgHDGoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 02:44:54 -0400
Received: from mail-mw2nam10on2045.outbound.protection.outlook.com ([40.107.94.45]:1217
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbgHDGox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 02:44:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfuMLkndoEjFUEYAu+KrEHxJt9E0dEm0rljs9raOJCCDni2sMU/F5mRSUCAOAneTjSk3ObAhUyGuJGWNyN1Ge7KgZcy8uDFdtqO6fYS+TKUbZ10rB5UQYLWuLHmyH1oBXXwSZRiSjbx9CGTnb8YBiEqZ8e0FiYVGY9tyPQxIAHZBh634Y8mvQshvYHyr1zsTfSMCW9Ju3XTos+27Rhd+bzZwXh5QcZHMWi/zDi+YUqIxp27dxEBmtk6YhUav4CWg+X4GnTaVwvGZT43QpnAXa0o6P5YfZu+8a4wl8CqdgwNUrUoSG3BB/QKouJWJnnddAxM/xUai7uQKA9DSwQfOxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28NX54e53OQf0t0knhUhW8JpxxmkqiaVicVQlqcW9JQ=;
 b=mCXX+rJZiUXvhb9ubMfbgskO22Zw7GONZwJlyFDTKG1dXe1Fwd735itRnUXd+Tu3psRR4HdpdV+rpQA6ZMyongD8eFpvZdx9n+ZflfCiFbd4m0/bRKOvxrM5KXA3Ryr++nVwNiXcmwjQjsm5GZH5lrxpUHzB6fB2dRMiI0pcZX8ABsOpuI0A9hmqM5MRWvtde8hGSH01Bvjva8moIBbG+ml6mOXv+j3kJms4NV+7eY5homjCudDaGSrd5vI5tS4G0SPIYJJr5mrPbafbUZYNOXzI89OkTB6ac+c2PKpml8m7C24nv8o8C988nySxKs47zSS5fxvEjVlLTHdS+XFTow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=baylibre.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28NX54e53OQf0t0knhUhW8JpxxmkqiaVicVQlqcW9JQ=;
 b=O7ZoxIF9yd9vlBkBdh5pBwaoEoj95m5goRXhxuqtan6BiN0q0gpr4ersYl2p/wYSecC48IKCRshIWzVscBRGs3rPS558EZovTmKOr5aictCycopOV36daritmt8eI9dbu4+D6ls/tkymEel02snkrQFm2EI0CWO1cGoNy5kcFJg=
Received: from MN2PR12CA0032.namprd12.prod.outlook.com (2603:10b6:208:a8::45)
 by MWHPR02MB3213.namprd02.prod.outlook.com (2603:10b6:301:64::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Tue, 4 Aug
 2020 06:44:51 +0000
Received: from BL2NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:a8:cafe::ae) by MN2PR12CA0032.outlook.office365.com
 (2603:10b6:208:a8::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Tue, 4 Aug 2020 06:44:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT018.mail.protection.outlook.com (10.152.77.170) with Microsoft SMTP
 Server id 15.20.3239.17 via Frontend Transport; Tue, 4 Aug 2020 06:44:51
 +0000
Received: from [149.199.38.66] (port=42260 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1k2qgp-00022d-C2; Mon, 03 Aug 2020 23:44:47 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1k2qgs-0007mp-KT; Mon, 03 Aug 2020 23:44:50 -0700
Received: from [172.19.3.8] (helo=xsjamitsuni50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1k2qgl-0007l0-7Q; Mon, 03 Aug 2020 23:44:43 -0700
From:   Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     mturquette@baylibre.com, m.tretter@pengutronix.de,
        sboyd@kernel.org, michal.simek@xilinx.com, mark.rutland@arm.com,
        linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, jollys@xilinx.com, tejasp@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Subject: [PATCH v3 0/3] clk: zynqmp: Add firmware specific clock flags
Date:   Mon,  3 Aug 2020 23:44:14 -0700
Message-Id: <1596523457-40465-1-git-send-email-amit.sunil.dhamne@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a2a0ef87-8f3a-4fb2-1fa0-08d83841e348
X-MS-TrafficTypeDiagnostic: MWHPR02MB3213:
X-Microsoft-Antispam-PRVS: <MWHPR02MB3213F77603191D2AC0879B12A74A0@MWHPR02MB3213.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ls3ydz5Dco/iuPijRDXOFz1e/EE4dsj8MPEf0e3d7FWMnIKLwVrZHnG/SEqjtLg9EJxGc6UWPaE0pfgtksKvQA4KuSV5zvYfJsBTHYUMG75E/oVSyFyYOPfbipWKAGDzT+Q+1HMDH/cczw7tULV+TpjH32pzbQ5z7bZBzWJIwQMHAZi+0tU+CIlBpshQBOdN6LETdLbqnYqMnN2mJLijWIUE3PWwIhi3EOLXtYDp19baBsgw/3pTwBcPD2S9pOvPtVboW1WQIZfG2yIV6pvcMtf3I9JY91qgdGHKAbDs4tXP5Lcx+vCaAz1bBSV6XGkgQzE9619BUUNc9muStCIFkmRAmp2rsV/fkLBG98rACvNTCeqVcBkq7T3JD/5Df1LdSrVwVQ+BRX766Dy/gOTx5A==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(376002)(136003)(396003)(46966005)(2616005)(426003)(107886003)(316002)(7696005)(4326008)(336012)(8936002)(26005)(83380400001)(6666004)(2906002)(82310400002)(5660300002)(9786002)(70586007)(70206006)(478600001)(356005)(47076004)(186003)(82740400003)(36756003)(8676002)(81166007);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 06:44:51.0019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a0ef87-8f3a-4fb2-1fa0-08d83841e348
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT018.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3213
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
 drivers/clk/zynqmp/clk-mux-zynqmp.c  | 26 +++++++++++++++++++++--
 drivers/clk/zynqmp/clk-zynqmp.h      | 41 ++++++++++++++++++++++++++++++++=
++++
 drivers/clk/zynqmp/clkc.c            | 32 +++++++++++++++++++++++++++-
 drivers/clk/zynqmp/divider.c         | 29 ++++++++++++++++++++++---
 drivers/clk/zynqmp/pll.c             |  4 +++-
 6 files changed, 128 insertions(+), 8 deletions(-)

--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
