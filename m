Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8CDC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 12:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C12205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 12:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="iNB+kqLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgCQM5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 08:57:34 -0400
Received: from mail-eopbgr750059.outbound.protection.outlook.com ([40.107.75.59]:40259
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726192AbgCQM5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 08:57:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAN1iKs5Z3gbEDaArykwdzyrjbOi5uzTCMhn6zbk1ZGpSQlBh3RmuPENkPmSYO5qw06H00YB6YO9Dcq2B7ZQFkva4gH3KvkEkaGGx6WmyE7evMgNJvzdJGymbh0KL1VTAKn90j4q7bbKp5Tev60oYjsMSsnwR4IBNESc78fuFqKTYcrPz0sFKCiZ1dNdP5EPf0QdV0j6dt4aH6DJSe29D9sQC0iqZyDBEUhFxFU4OPOuGQMFFRN/9OwkpXa6lpc++oAkhjOGtu11M+u2dvZHWjSAP24bIaLmbWM2dvdpws/g0rULa/tuc/1kiPof5ZjM3+QBU2WuSAV/ax0m6hS6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EW/uTV0LYTLLycwhiPkOXKQV/ElTTa36nqMupT3CV1U=;
 b=bo2zHmsM2G3LQhwt4JC7AvWKzrRTBsDD+Ee+pCNjtrQz+ig145vEjLR++fvuVLBtcl9r/23zofiYiIdx92Uxt4xCSUg/Uy+XSbR/kc4borTHIDcX4FCo9GqWR2E52hPwPE0pc+cmC0y/l9kQJO3Yt4Pa6R2jA/AtP+m98zP81osFeUrIm8FzAytQ7DagYS2YCAE59jlmDx5+TRosyjcS2WQXedNmMJb23rmDakqYSEVvAkRb20trDajUdHLwloHXOgAP65o3jfX2+EBlRYxZ92MXjGoly7DUsZ38nxsVC3Im64SCZZ160GFdfJ0Z7RERaiGe6zbyNnJMkKB3fN+MEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EW/uTV0LYTLLycwhiPkOXKQV/ElTTa36nqMupT3CV1U=;
 b=iNB+kqLzjNriGQRWOPwEHnotjf5VIDEEOr4gBjeRoIxRF24MGxbs7XbHjjQ17vIQttEZTkeYFNrNjePSb/02G6bJnDwmXRlK99dYzJh2N7Ybefja4wR/zIBUy0RTj95HnRWH2VKTC+nCXty27SyB5PTmCMYFHczl9BG5IgxfeQ4=
Received: from SN4PR0601CA0012.namprd06.prod.outlook.com
 (2603:10b6:803:2f::22) by DM5PR02MB3228.namprd02.prod.outlook.com
 (2603:10b6:4:6b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 17 Mar
 2020 12:57:31 +0000
Received: from SN1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2f:cafe::23) by SN4PR0601CA0012.outlook.office365.com
 (2603:10b6:803:2f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22 via Frontend
 Transport; Tue, 17 Mar 2020 12:57:31 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT011.mail.protection.outlook.com (10.152.72.82) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2814.13
 via Frontend Transport; Tue, 17 Mar 2020 12:57:30 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <mubin.usman.sayyed@xilinx.com>)
        id 1jEBmk-000212-Ah; Tue, 17 Mar 2020 05:57:30 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <mubin.usman.sayyed@xilinx.com>)
        id 1jEBmf-0001ih-7O; Tue, 17 Mar 2020 05:57:25 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 02HCvGOU007593;
        Tue, 17 Mar 2020 05:57:16 -0700
Received: from [10.140.6.23] (helo=xhdmubinusm40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mubin.usman.sayyed@xilinx.com>)
        id 1jEBmV-0001dT-QH; Tue, 17 Mar 2020 05:57:16 -0700
From:   Mubin Usman Sayyed <mubin.usman.sayyed@xilinx.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        michals@xilinx.com, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, sivadur@xilinx.com,
        anirudh@xilinx.com, Mubin Sayyed <mubin.usman.sayyed@xilinx.com>
Subject: [PATCH v5 4/4] irqchip: xilinx:  Do not call irq_set_default_host()
Date:   Tue, 17 Mar 2020 18:26:00 +0530
Message-Id: <20200317125600.15913-5-mubin.usman.sayyed@xilinx.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200317125600.15913-1-mubin.usman.sayyed@xilinx.com>
References: <20200317125600.15913-1-mubin.usman.sayyed@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(199004)(46966005)(36756003)(426003)(2906002)(478600001)(47076004)(5660300002)(103116003)(70206006)(7696005)(70586007)(2616005)(1076003)(316002)(107886003)(356004)(6666004)(4744005)(8936002)(81156014)(8676002)(81166006)(4326008)(186003)(26005)(336012)(9786002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB3228;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bec9b7b-6fe9-40c4-24bf-08d7ca72c0f6
X-MS-TrafficTypeDiagnostic: DM5PR02MB3228:
X-Microsoft-Antispam-PRVS: <DM5PR02MB322893C3A599F885104E2856A1F60@DM5PR02MB3228.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:352;
X-Forefront-PRVS: 0345CFD558
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: imolBzMF6qUdq1qd6f0u6bCU8oj2Yce4jZ8+zq0msEVrq/mM1tV1PhWJ4DAqfee93VNrCuJysmlKdA7CJD0vq4UEekdHA3GkkmM99luiu2FLHJpIweNlXa+m2m3uENPojCrfyUeW/8Tgq0AuxXG40IWdaDmpr1SDtCRxJVC2Gr4TfAuil0vWPFUqA/d7MaP202bNgU7QGuA+BW1fYZIpB5JEYCO9u+fzcMcqYojcmIFV/QrQyP8yiulmx/kdckjjxN51mz1995jpCQbvnrRM7c7QEgPStaOvYQPBZhTz6PxXaXUBrKpYGFEQ/UGLb9s8FMelgSJ/qlMuUx9VzsFdy3Nh2r8r0Y2/2zBIB/2fMUtCB+JntkeQyDtZKTpAyTTb/lcxk29rRgTo+TTj9DNVCOQjRXOT5/gR9Sv2xyjmLegpBiZoT69sqNXDMp5C0+eaaemll+adAahTdSx4mLFUv5R/oPi+1PUAtHo94jsitOT6yFDiaAaHlq8wpjURucMNFHWQbZaZtFiXrBCGjD/qrg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 12:57:30.7522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bec9b7b-6fe9-40c4-24bf-08d7ca72c0f6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3228
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mubin Sayyed <mubin.usman.sayyed@xilinx.com>

Using a default domain on DT based platforms is unnecessary.

Signed-off-by: Mubin Sayyed <mubin.usman.sayyed@xilinx.com>
---
 drivers/irqchip/irq-xilinx-intc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index ea741818a1ce..7f811fe5bf69 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -250,7 +250,6 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 		}
 	} else {
 		primary_intc = irqc;
-		irq_set_default_host(primary_intc->root_domain);
 		set_handle_irq(xil_intc_handle_irq);
 	}
 
-- 
2.25.0

