Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28898C38A2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03E41221F7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="fKGymBHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgDPVyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:54:53 -0400
Received: from mail-bn8nam11on2063.outbound.protection.outlook.com ([40.107.236.63]:6082
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728297AbgDPVyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 17:54:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbbKIfdPgCv1pEb9n26JfIgMVaArO41N9Il8JlAbbZQcpU5LtYeu03jtNemEWAL1GPzfhHif2T45jky6huEDL3hEhUSHMZxE0VrRASyzOKFk+5DUED0qhBiyBy7Om7VIOPBnbW3y1zIW+Z09RZg1VwuJbcIrO/vWv9WqndTmZmE7Ol+J3t7DmJIi2AhSj6CxPcYv4Av86R7mtRzgO0WVuYgMNdwAk/ZbztIVRk1Stw1rGAmV6OcWpLImz1pWSLMJENWj0KR0FvEFc2jP9QeEitFyifjTSfalIg1SeHG0JCFYtzDt6i/0D5VMNmstATkN1jsNTXJ7UNyiGdwdBSqjTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHH/Xu5Up+AEOY1e/pHcInyDAs4+tXSoTxvToxsMURc=;
 b=NTFYYDmytLjR7cp/120jjFeYo6Due5qEOLFbHwY59j2uZziJALYZFJLB8HooabB0xgRLjACzWbo+ORb8NKrDwE0MvYmpO7ahZwRDM2oLoVRwzH9hDP4NyeP6NGXJ9jBrVIjgbVhVi6i85F7DElrsPxms+d41VcovFha7Tn7DtVhfa7oMeb1NshOazBIq+PQpGbBdX1CKQ1VUW2SQ74vbtSB62LX7OSgr1yCLF3nCoiuT63WewbAzOlooG9W+l4DZQQL2SDy1OrG6KvtZTf0XyJvS51yLr6rb5Q+q89zXzzimu8Let1fqV4npzQTd0Vdb6oPVrOKUJToaXLN+vbNJmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wizery.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHH/Xu5Up+AEOY1e/pHcInyDAs4+tXSoTxvToxsMURc=;
 b=fKGymBHKrUupGeDNUGSR5O7EznZ/0BGN04h0/R73q7WZV4kGCoA2jY4FpYNp+zt7l7KMyTq4pbaYGeemi4C7NECvd7jutrmHMrzKz2BdlRBzgp7jdcScOdHG5zpL8gUJdvtNoHSPo/fbQmpMFORqEOLv1b3I9stYlN31xacEpA0=
Received: from DM5PR15CA0072.namprd15.prod.outlook.com (2603:10b6:3:ae::34) by
 BL0PR02MB5667.namprd02.prod.outlook.com (2603:10b6:208:8f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.27; Thu, 16 Apr 2020 21:54:48 +0000
Received: from CY1NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:ae:cafe::1a) by DM5PR15CA0072.outlook.office365.com
 (2603:10b6:3:ae::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.26 via Frontend
 Transport; Thu, 16 Apr 2020 21:54:47 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wizery.com; dkim=none (message not signed)
 header.d=none;wizery.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT034.mail.protection.outlook.com (10.152.75.190) with Microsoft SMTP
 Server id 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 21:54:47
 +0000
Received: from [149.199.38.66] (port=38407 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jPCSN-0004ci-MH; Thu, 16 Apr 2020 14:53:59 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jPCT8-0003e3-Sw; Thu, 16 Apr 2020 14:54:46 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jPCT4-0003cm-3j; Thu, 16 Apr 2020 14:54:42 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        michal.simek@xilinx.com, jollys@xilinx.com, rajan.vaja@xilinx.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] remoteproc: Add zynqmp_r5 driver
Date:   Thu, 16 Apr 2020 14:54:37 -0700
Message-Id: <1587074082-14836-1-git-send-email-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(396003)(46966005)(9786002)(5660300002)(47076004)(478600001)(356005)(81166007)(4326008)(70586007)(70206006)(6666004)(7696005)(2906002)(186003)(336012)(426003)(316002)(44832011)(36756003)(8676002)(81156014)(2616005)(8936002)(26005)(82740400003);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2f13fbb-17f3-4f9c-9dc0-08d7e250c7b1
X-MS-TrafficTypeDiagnostic: BL0PR02MB5667:
X-Microsoft-Antispam-PRVS: <BL0PR02MB566779F2A6A3C459CB201E78B5D80@BL0PR02MB5667.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0375972289
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cPdZ2tQdcHS9c7XeP9V1DdY4784QcKhQidXDjYbyn5HYi5lW+jeeTkwWDatmkk6kks/A23RPw5kzsbzmYuOJpiLo8GbTVJnTQIxxrtbJmuRZ+TExmcQKUwh1yJpiCrGlEjHFWR76w0y6fKBCu3/CtOD34SoEGDLeFYuAkWe5zVG/fqq7UaWDfiCncBNIfwnkRA2lndSnd5TKW37PDob2PPXVF8WqSFH014F1w6TNYloHV4t/BfB5yNYzcS5eqKuT0T35IBgoM9HaOQQCQNH/UFtM0BPWNZf3XLaBwYyS7WjqNnNNtaTyvIqzymtWCb8MpmeRcGdKHSLYvVnywTUA2GmuVNbxCRr4ZFX1+26ESxjkjp6ln6CHUYxagYlqu5uz2EDX/JnEvM6nv1TEJNyqir51sM8Z7G/suvLbb5v+2j58TRiEf5KDqJoGwgVjQ19gqKWdAehnONt6ezVEcjaoadjhrDXpKJrGiZqjEfThoTFOX3XtkLxG+sWNHvzy8Z13iJkDvd3v8KS5mR7AcHW7xQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 21:54:47.1661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f13fbb-17f3-4f9c-9dc0-08d7e250c7b1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5667
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are Cortex-R5 processors on Xilinx ZynqMP UltraScale+
MPSoC.
This patch is to add an Xilinx ZynqMP R5 remoteproc driver to
enable Linux kernel to bringup R5, and enable communication
between Linux kernel and R5.

Ben Levinsky (5):
  firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU
    configuration.
  firmware: xilinx: Add shutdown/wakeup APIs
  firmware: xilinx: Add zynqmp_get_node_status API
  dt-bindings: remoteproc: Add documentation for ZynqMP R5 rproc
    bindings
  remoteproc: Add initial zynqmp R5 remoteproc driver


Changes since v1:
- remove domain struct as per review from Mathieu

 .../remoteproc/xilinx,zynqmp-r5-remoteproc.yaml    | 119 +++
 drivers/firmware/xilinx/zynqmp.c                   |  81 ++
 drivers/remoteproc/Kconfig                         |  10 +
 drivers/remoteproc/Makefile                        |   1 +
 drivers/remoteproc/zynqmp_r5_remoteproc.c          | 911 +++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h               |  30 +
 6 files changed, 1152 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.yaml
 create mode 100644 drivers/remoteproc/zynqmp_r5_remoteproc.c

-- 
2.7.4

