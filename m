Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7A1C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 01:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 416C1206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 01:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="B1jq+S1O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbgIJB7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 21:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbgIJBhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 21:37:31 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8117CC061344
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 17:20:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mW57OrhCnN4uBw+wqMcUW8gCrR8Ge7qbBYraXcKn4eianAAjo2sQqozkZf19rBFvMi8S1upsefRQ+OfyQnL5PkXpPBA/it6K7/xRKhR7GgWpc9fIJw91FSGgR+vVgpizfBLS5me1v6v5LArTvAFf0P6OvHCM6c0PeE7Qs2B1Vb5Amtzr7owRi7RUsszK664elz2YCxpArlWjYehOaNJC3300t+13oMVtK1vLTR/TiP6oF+uPMqdf5OjONRyaZM+VQqh/X9PkU5pHkKBb7AFebt06OMD5P5+R+py0mTu2b9Mx2DrLAKf7cRue302IWI2A8sdEIOwKroC675J+ipLm1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7sVEN/5C6w6Un8NnYDVrTdtV1UPUdXTEKgYPTTmb1o=;
 b=d9woZ5ipwLXRf2uMqO1Cx4wmbieRhXYz+EHoL9JA/uiRTTOt1JJryrRRfJ8DJzGCbusxb2nKRj6JsV+YJRP2SBUhA8iOMVdh3Fme1mCH5YMmwuOSwDKn82S0t2shADwiT5SF3b+dyVjdzdlWYpvOTaf82OY23qVLE4nyLuXpOvyN/hVILL/JhhrUay/BGEofyrJFNRa5UDWEPzmPtaEwsukEDRf7h7/apOIt1ZsETGf0qlO6BoSAAMmuPZ7XjlKQqI60k1Cj1ngw62InrZfekgr81vnbs6zPuLOIJ4y8neZwNS4poRcYCrqT7iV7XqY5z6jmRelNhns+vmYBBKxbAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7sVEN/5C6w6Un8NnYDVrTdtV1UPUdXTEKgYPTTmb1o=;
 b=B1jq+S1OldURZvYyBzw0vqrRk8Nwb/RhlsI0xWjM7ZgP6gtIcvrbotT1QrYULp7yXxPYEPUxZZzCrQAj9wW7CoUCLL9n4WQKBI6M+6F5EK39Aab/e1M1N6pOdps+y6npcQ7vij5GrY2HetgYCqCQSgNMZJjxYbYHrXc3CU1A7A8=
Received: from SN1PR12CA0050.namprd12.prod.outlook.com (2603:10b6:802:20::21)
 by MWHPR02MB3264.namprd02.prod.outlook.com (2603:10b6:301:65::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 10 Sep
 2020 00:20:12 +0000
Received: from SN1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2603:10b6:802:20:cafe::18) by SN1PR12CA0050.outlook.office365.com
 (2603:10b6:802:20::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Thu, 10 Sep 2020 00:20:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT019.mail.protection.outlook.com (10.152.72.130) with Microsoft SMTP
 Server id 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 00:20:11
 +0000
Received: from [149.199.38.66] (port=46238 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1kGAJf-0007M1-21; Wed, 09 Sep 2020 17:19:55 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1kGAJv-0006Qx-F9; Wed, 09 Sep 2020 17:20:11 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08A0K6QC001918;
        Wed, 9 Sep 2020 17:20:08 -0700
Received: from [10.18.5.8] (helo=xsjamitsuni51.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1kGAJp-0006Dg-Uy; Wed, 09 Sep 2020 17:20:06 -0700
From:   Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com,
        rajanv@xilinx.com, tejas.patel@xilinx.com, jollys@xilinx.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rajan.vaja@xilinx.com, jolly.shah@xilinx.com,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Subject: [PATCH 0/3] firmware: xilinx: Add support to get last reset reason
Date:   Wed,  9 Sep 2020 17:20:01 -0700
Message-Id: <1599697204-32103-1-git-send-email-amit.sunil.dhamne@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 90033435-b578-4347-3e60-08d8551f4853
X-MS-TrafficTypeDiagnostic: MWHPR02MB3264:
X-Microsoft-Antispam-PRVS: <MWHPR02MB3264688778B6057DAF3865E8A7270@MWHPR02MB3264.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 44pXPqnZ04v3se/vujX5mOl9pmrfqXWsESkWs7TQr4QETwbJfYrGNdz7NVRZcdgnR3E5/Xp5joJ8mm5wdWHYjx/t7K+8S5LC0wkq+1SyE3i23Dhy2nJtBdfKa1OEhSVkTjkOJhwFCkrq093E9mYIwSIdxZnin81yU/+HrbK7Qwqszw15jV6skCSc+7+bRzmARmNJcfKJc67vC+NKdntcmJOBSorOipo/Qh+0oLK2MLJWVfKYtStBFszrXdoNMGggI5bDEPTaRLe1Yqz7sdl/UTH8MGS7f7Bc4s0w7QzDIJk4uB4yP/OGap3SmHyKqeV9p1SIGLImLWr7ASeH3L7qpMTpehCSGVrSllskJqT0ti/rgQHNMWj0VKZKWC/UuxfZOhjWlKyNWJAjnx8YvyQ8bys1MP3RWfESJ6kCZCKuYgg=
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(39860400002)(346002)(376002)(136003)(396003)(46966005)(2906002)(7416002)(82740400003)(8936002)(9786002)(83380400001)(81166007)(356005)(70206006)(70586007)(82310400003)(4744005)(5660300002)(8676002)(107886003)(6636002)(36756003)(4326008)(47076004)(7696005)(6666004)(426003)(2616005)(316002)(478600001)(26005)(186003)(336012)(921003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 00:20:11.8427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90033435-b578-4347-3e60-08d8551f4853
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT019.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3264
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to get last reset reason for Xilinx Versal platform.

Tejas Patel (3):
  firmware: xilinx: Add validation check for IOCTL
  firmware: xilinx: Add support for GET_LAST_RESET_REASON IOCTL
  firmware: xilinx: Add sysfs to get last reset reason

 .../ABI/stable/sysfs-driver-firmware-zynqmp        |  13 ++
 drivers/firmware/xilinx/zynqmp.c                   | 174 +++++++++++++++++=
+---
 include/linux/firmware/xlnx-zynqmp.h               |  18 +++
 3 files changed, 183 insertions(+), 22 deletions(-)

--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
