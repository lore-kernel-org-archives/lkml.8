Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09CAC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8336620729
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="mOyrefry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbgGVGzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 02:55:50 -0400
Received: from mail-eopbgr690054.outbound.protection.outlook.com ([40.107.69.54]:39842
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728649AbgGVGzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 02:55:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3z9YF2yZRcWHLf4OYKqe8PGEmdRChITP+2tQuKWWjJu2lk28fBfOo5R2Gm1rqUzSMGmd4b5l9f+UF3iYg6whu299kVKdfcPFyQoMOv47/BhFBJq/GAg7tKHG19qI+GgiWAmh5IGCPlPeRnC5nI2cP/tc+YVZSJ+V/iqVoFNnfovNqlDb0j5xeeIyTkyWsZ+fEU6ndAv6WPrzNsuP0FMThHEMNWts44OegHKt10wXUE4uhd4RDHkAv4RRB4G41An+G58TTe4gd6ebKa1rhGtyjwyE6QdRKtohQ6aqLKpZhSWGEUnuMr3CTFS7ONS5M8Wfs4dUdpKhRBeYbU/GSNOpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCc5CuIftvyfYIfoK2Az/qH2MEobepBDVo1RzOxqP1s=;
 b=GvLIdVMRn6hSeHlOPRvkj0LxcmzT92U6PagbI4cMrQ+Is5UufthMPW6/MeE3xBK8Gn7BEt1+TqgsZVTlBovIXjzKh30AqRSvBNe0X2XOrf2h8IAsFgoaZeZfs1+JAZimXyhXOCo4i/4tsYASBnsV8QcprAdwy0VHLb72mtA6DwkJa0cyC1lrzFEBM9hfBPyGuRR5XDnukNpwrYGV34UzxibyP2T6blIULW1jjXjFE5M7MYi7TJi0JE0K0gzXSsYiQ+BJISVvyVEmsoVRwPEYLXcjzEdS5NTp+SQnTnWTdNXILvfNkBkj6z9WlfmZZBCqfHDpxP3pyWmvNhcZx4gFkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCc5CuIftvyfYIfoK2Az/qH2MEobepBDVo1RzOxqP1s=;
 b=mOyrefryUxXO+v1cHlEdCsn2X/J1bzKiVhEZaGXTboeM3AMDCfgBjnxebqc3Ona1+jcUA7jLh6wa1ogEubMkIZgSIurjdbdqQvhIZAZJKkRL52v2BdAraMmWOJ/wbPQ6arqLI0hvv2LxJLyfdDGR4F2dNjhAcoGsa1MOp6H9B+w=
Received: from MN2PR08CA0022.namprd08.prod.outlook.com (2603:10b6:208:239::27)
 by BN7PR02MB4994.namprd02.prod.outlook.com (2603:10b6:408:2a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Wed, 22 Jul
 2020 06:55:42 +0000
Received: from BL2NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:239:cafe::fb) by MN2PR08CA0022.outlook.office365.com
 (2603:10b6:208:239::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22 via Frontend
 Transport; Wed, 22 Jul 2020 06:55:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT023.mail.protection.outlook.com (10.152.77.72) with Microsoft SMTP
 Server id 15.20.3216.10 via Frontend Transport; Wed, 22 Jul 2020 06:55:41
 +0000
Received: from [149.199.38.66] (port=59645 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jy8dR-00024g-0d; Tue, 21 Jul 2020 23:53:49 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jy8fF-00037V-5w; Tue, 21 Jul 2020 23:55:41 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 06M6tZIH011756;
        Tue, 21 Jul 2020 23:55:35 -0700
Received: from [172.19.3.8] (helo=xsjamitsuni50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jy8f9-00036T-3I; Tue, 21 Jul 2020 23:55:35 -0700
From:   Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     mturquette@baylibre.com, m.tretter@pengutronix.de,
        sboyd@codeaurora.org, sboyd@kernel.org, michal.simek@xilinx.com,
        mark.rutland@arm.com, linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, jollys@xilinx.com, tejasp@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Subject: [PATCH v2 0/3] clk: zynqmp: Add firmware specific clock flags
Date:   Tue, 21 Jul 2020 23:55:29 -0700
Message-Id: <1595400932-303612-1-git-send-email-amit.sunil.dhamne@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(39850400004)(376002)(136003)(396003)(346002)(46966005)(107886003)(8936002)(8676002)(5660300002)(186003)(426003)(47076004)(478600001)(9786002)(6666004)(81166007)(336012)(26005)(316002)(2616005)(70206006)(82310400002)(70586007)(36756003)(83380400001)(4326008)(7696005)(2906002)(356005)(82740400003);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2442af36-44ac-44ac-5614-08d82e0c3fa9
X-MS-TrafficTypeDiagnostic: BN7PR02MB4994:
X-Microsoft-Antispam-PRVS: <BN7PR02MB4994381C683AC4FAD6C4EDA6A7790@BN7PR02MB4994.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EDksFZcJ2ONGaM9pKpbSecEH2v6InCPwERwWgwm8Tii1ODgIlXCEe1QLQcnHyYJtumG+pLLt0ueo2N35slYIcwRqHO4Ev5p7sGp4G8dTi6mGbsAwlEdZvhHVMDWddtvjx+BefBi+haEltpjbgE+a2uVx+k77YOFCE9GF4tzApS6zso09bYec7Dox/VpO8FwYhUN06/A5tyfraZCxJ6NEvjNJTISdol/vfJo80XiCxkP6A1NG4jPDzRZGVet/VXtcSMVz4KUEGUlwS83oK8P6DqeWuVxQhEEFbu3GhT+fcsFgPKGSZZL9aT51Un3me8Zx20SFBFJueLooeFd98fpH9aXTD799LkihnU/ShXcCk0sB7izkqTw+e122QSxfUo42pwNIy1sRROJhX0hRmtAC0Q==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 06:55:41.5352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2442af36-44ac-44ac-5614-08d82e0c3fa9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT023.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB4994
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds supports for firmware specific flags. These include
- Common Flags
- Divider Flags
- Mux Flags

The intent is to remove firmware's dependency on CCF flag values by having
firmware specific flags with independent values.

Currently firmware is maintaining CCF specific flags and provides to
CCF as it is. But CCF flag numbers may change and that shouldn't mean
that the firmware needs to change. The firmware should have its own
'flag number space' that is distinct from the common clk framework's
'flag number space'. So use firmware specific clock flags in ZynqMP
clock driver instead of CCF flags.

Changes in v2:
 - Add helper function to map zynqmp flags with CCF flags.
 - Mapped zynqmp clock flags with CCF flags from
   zynqmp_clk_register_*() functions instead of
   __zynqmp_clock_get_topology() which is changing the flags to struct
   clk_init_data instead of the struct clock_topology.

Rajan Vaja (3):
  clk: zynqmp: Use firmware specific common clock flags
  clk: zynqmp: Use firmware specific divider clock flags
  clk: zynqmp: Use firmware specific mux clock flags

 drivers/clk/zynqmp/clk-gate-zynqmp.c |  4 +++-
 drivers/clk/zynqmp/clk-mux-zynqmp.c  | 18 ++++++++++++++--
 drivers/clk/zynqmp/clk-zynqmp.h      | 42 ++++++++++++++++++++++++++++++++=
++++
 drivers/clk/zynqmp/clkc.c            | 31 +++++++++++++++++++++++++-
 drivers/clk/zynqmp/divider.c         | 21 +++++++++++++++---
 drivers/clk/zynqmp/pll.c             |  4 +++-
 6 files changed, 112 insertions(+), 8 deletions(-)

--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
