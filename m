Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36B3C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDFFB20663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="KNhPqCAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731472AbgCPNzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 09:55:17 -0400
Received: from mail-dm6nam11on2047.outbound.protection.outlook.com ([40.107.223.47]:30561
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731110AbgCPNzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 09:55:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0jXBxTWcSyndJ2+WLT9NE7Deu0f6nnF/XE3QcZxg1XcJWewvE/IavWdHvIEpcdnvx8/FkRR6Wp4Fo4JgGYENvAj7hNuM18G9nZzDxqSksoIvnZm9/i27z1EKCVx3uwaWz4yikca1RUBZgSmbPw7Pkh0O6lkQdj/mOc9zkiNUSkD3YzWqUC28asZznWKm49yhbo157muIsSrgctTUdwcWuWABWyKZwdBkys4nWAXFkAxcgo/gIwj0ZbfAHYOU8ancMO7DmVmGPLMkZ/xp2dkCsBH9xyq0tEGWH+MySfL9nk+qh3eAiBh1WfmMsAd1+eZb/eT5GmQpne5lKeaRyzDsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtythZBvjMSg20Rl406SrsT9z2hqotaPxJKM2EFEt70=;
 b=CDGe0XVdY9yPg72BUkeNrI6Xh8XwjI5UwrIjpmlxVrd91kc19LVLi69wm135V/+ojcAEZCatw8gvdhFI1H0Ze0AXmubKzcOVAQr7XNxng/Q2LXHywZVgbkJufqqHdRp1WdfP3CmxkehAA3MgFAyxga4mjZLhtIFsNrLKBWp8MpjGcBHXWx0AFlszeXkUuJ1pUBN0jrdyvctxtBa3evkMkfNauDTiw/0gYd6UGi4ZGyiTXAkQIyxZs+yWA4vFNAffoHiQy3dFTQMHpZ1EChtxW8JC/9LY+LFBI+gkYCiUZ5L2CUF4R8Bzr6so/RruMSISOehsxcN3os61sUbVWQgJNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtythZBvjMSg20Rl406SrsT9z2hqotaPxJKM2EFEt70=;
 b=KNhPqCAbMvAXPKo3FzjYrIl49jZlNYn6z5Xpy3cLZ6TqrICq9ZjVN+EiEVf+Al7adAjFAKOGFN8onlroRMzMhYkbd0kF36WgX/0tLLeXSVdqu0jhYduIAtbNW0Aoewk6ACxBrqLB7IIhIojUlDS8MuANS6QPnYLH16lq5/OBsnM=
Received: from DM6PR14CA0048.namprd14.prod.outlook.com (2603:10b6:5:18f::25)
 by BL0PR02MB4564.namprd02.prod.outlook.com (2603:10b6:208:4d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.19; Mon, 16 Mar
 2020 13:55:12 +0000
Received: from CY1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::cf) by DM6PR14CA0048.outlook.office365.com
 (2603:10b6:5:18f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16 via Frontend
 Transport; Mon, 16 Mar 2020 13:55:12 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT057.mail.protection.outlook.com (10.152.75.110) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2814.13
 via Frontend Transport; Mon, 16 Mar 2020 13:55:11 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <mubin.usman.sayyed@xilinx.com>)
        id 1jDqD1-00041J-0Y; Mon, 16 Mar 2020 06:55:11 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <mubin.usman.sayyed@xilinx.com>)
        id 1jDqCv-0003tY-Tf; Mon, 16 Mar 2020 06:55:05 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 02GDt2XV027715;
        Mon, 16 Mar 2020 06:55:03 -0700
Received: from [10.140.6.23] (helo=xhdmubinusm40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mubin.usman.sayyed@xilinx.com>)
        id 1jDqCs-0003l2-Dq; Mon, 16 Mar 2020 06:55:02 -0700
From:   Mubin Usman Sayyed <mubin.usman.sayyed@xilinx.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        michals@xilinx.com, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, sivadur@xilinx.com,
        anirudh@xilinx.com,
        Mubin Usman Sayyed <mubin.usman.sayyed@xilinx.com>
Subject: [PATCH v4 0/3]  irqchip: xilinx: Add support for multiple instances
Date:   Mon, 16 Mar 2020 19:24:44 +0530
Message-Id: <20200316135447.30162-1-mubin.usman.sayyed@xilinx.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(396003)(199004)(46966005)(966005)(478600001)(47076004)(426003)(186003)(70586007)(26005)(1076003)(36756003)(70206006)(336012)(4326008)(316002)(7696005)(9786002)(103116003)(107886003)(8676002)(8936002)(2906002)(5660300002)(81156014)(81166006)(356004)(6666004)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4564;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bba01616-f45c-4cbc-83a2-08d7c9b1a545
X-MS-TrafficTypeDiagnostic: BL0PR02MB4564:
X-Microsoft-Antispam-PRVS: <BL0PR02MB456497CE7EDF271D137BFDEBA1F90@BL0PR02MB4564.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-Forefront-PRVS: 03449D5DD1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LhteofftiGPJWCSxrY0go/XssiD3LibfwyJEfq5LSp+bwUNWPfpOGCCxX2EUYr73bqYr3GG61/yMfdusLCkRlF8pYRORcK659EpgXzUFxeI7uBeAQ5LALeV05Q5jbi4SUvVU56fkJE+lfMmLtM7b4iY214J+n2WRxcVE901PZZyrN9QvxAhma5n5bl/Rh07G98a3vpZzGFNg5A+KeiOb+LtgqrUJKyBmumxMsITs30At4uo4s/DDLcgi9lWOXndEuEczWh4dlWDQf3hmpWyDERhTK50loQ3t/WhmeheDcbC6UGQ/lbsi3Xbvz0YwoIhXAV/P1gknNCdYdR6Iv6/k76ercaTw7yWXANNvZk7jvyo5q8IlMS6OInMGyBMkVkZxzQ+u4ubB4tKbdfPEMjdMTPSou19YvobEG2GVhDfUXXW+xbgpZkyc9EK7uTfibh/biJkBoup7TT168wO+dA/jOaENkjxt4zOijKSYqGuea1PxYPGZUM3Hjw5e8ViaLcURhoMMS52CFgvaw+7CzENgJf4y8EYdzRJaTijbk4vtT0MB+7tjuPgCCQteUTA/IX0ovbEyWthkp68Ivt67aDZ3zw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 13:55:11.4104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bba01616-f45c-4cbc-83a2-08d7c9b1a545
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4564
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Created series by rebasing inter-dependent patches
from Michal (https://lkml.org/lkml/2020/3/8/164) on top
of v3 (https://lkml.org/lkml/2020/2/14/2680)

Changes for v4:
        - Fixed review comments from Thomas - updated commit
          message, variable declarations changed to reverse
          fir tree and cleaned up some code.
        - Added inter-dependendent patches 2/3 and 3/3 from Michal
          https://lkml.org/lkml/2020/3/8/164

Changes for v3:
        - Modified prototype of xintc_write/xintc_read
        - Fixed review comments regarding indentation/variable
          names, used BIT
        - Modified xintc_get_irq_local to return 0
          in case of failure/no pending interrupts
        - Fixed return type of xintc_read
        - Reverted changes related to device name and
          kept intc_dev as static

Changes for v2:
        - Removed write_fn/read_fn hooks, used xintc_write/
          xintc_read directly
        - Moved primary_intc declaration after xintc_irq_chip




Michal Simek (2):
  irqchip: xilinx: Fill error code when irq domain registration fails
  irqchip: xilinx: Enable generic irq multi handler

Mubin Sayyed (1):
  irqchip: xilinx: Add support for multiple instances

 arch/microblaze/Kconfig           |   2 +
 arch/microblaze/include/asm/irq.h |   3 -
 arch/microblaze/kernel/irq.c      |  21 +----
 drivers/irqchip/irq-xilinx-intc.c | 130 ++++++++++++++++++------------
 4 files changed, 82 insertions(+), 74 deletions(-)

-- 
2.25.0

