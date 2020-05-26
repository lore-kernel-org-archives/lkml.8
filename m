Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE08C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95A732054F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ligm5/JI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731474AbgEZIAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 04:00:39 -0400
Received: from mail-bn7nam10on2059.outbound.protection.outlook.com ([40.107.92.59]:22780
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727772AbgEZIAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 04:00:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5pus8z8SAp04Nx6lXfXhJ9GxITXhlmegUBmJNo7E1+4aczoVOCpzDUx1w4k7Svj5/G0gifK9lp20jpTLnS3pslSDh7egZhl/+c8KoOKT471qFy9gCw4uaDusk7nOURtKHBlyuNIpiNSE/uLppd/OQTd6PrAw7pObqh5R3WtqEOR0BpGgdt/5eQLsnsN+OM/YlNBn1yvNluQydsA7TWLwE1yEnINrZvLbB6eSDchcEnXSXXRutzWwhwSUYK4BWbvunueO3/bI+XEJk5mIgWhOrCTdwWMamvhOW1zoGYLDzcWpfuO2Pw1/tjz7QByzFx2KMVmfxMTHNYMDYw0USEbgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFur7+hvEAckJneUss4HF6YfuQRKPrMTM5qk2dTU0nM=;
 b=TZ3wvf4d9bBY/esu1z6kzmQV5lN+CBleeVMNtDKmiHjxGCK/IXD1IjzhT6XGz0IQ5HFXSEve2vtHY0ssHOfiDhGe4eT1gJgCWXTjEb5rmlhIP+f0En6+WiRzb48cuK9CM2wwMTgKmgT+n/7XxF80ogsVno1g4VzPMjea9y8u9yDUm7qZg1vcjpq8oLn4JdEoO3NDBJm54x/i99ZSau5TcVKcPgP83z/9ma5f42f0YvHwNXCXA3+NcqhTPGwH8Tz9t0Q/u9YF1qH9y1TLZF5zy7PLvJc9/yDFSNJ/IXUuk++Piv7IaKjikByK0DMg4/fqrQUQfNGIC0P+mql3uTS45Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=sina.com smtp.mailfrom=srdcmail.amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFur7+hvEAckJneUss4HF6YfuQRKPrMTM5qk2dTU0nM=;
 b=ligm5/JIX/hYB5Y7euEEbJ0VXSQRUI0DB4LavLzvMeCk+ZgMlGWgKkQEkHQKx5aVCEC2Af1L1byH6mWd8CV+G5AUoPlouFaITupr1MspRORozffsSxJfcWzerUa1IQRrL2Luh2EzGVtpOGn401p9CSnaahxyFQpeK7emCizq8zU=
Received: from DM5PR17CA0055.namprd17.prod.outlook.com (2603:10b6:3:13f::17)
 by BN6PR12MB1794.namprd12.prod.outlook.com (2603:10b6:404:100::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Tue, 26 May
 2020 08:00:36 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13f:cafe::45) by DM5PR17CA0055.outlook.office365.com
 (2603:10b6:3:13f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Tue, 26 May 2020 08:00:35 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=srdcmail.amd.com; sina.com; dkim=none (message not signed)
 header.d=none;sina.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: srdcmail.amd.com does not
 designate permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3021.23 via Frontend Transport; Tue, 26 May 2020 08:00:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 26 May
 2020 03:00:34 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 26 May
 2020 03:00:33 -0500
Received: from atlvmail01.amd.com (10.180.10.61) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 26 May 2020 03:00:33 -0500
Received: from srdcmail.amd.com (srdcmail.amd.com [10.237.16.23])
        by atlvmail01.amd.com (8.14.4/8.14.4) with ESMTP id 04Q80Vvi014384;
        Tue, 26 May 2020 04:00:32 -0400
Received: from srdcws1054.amd.com (srdcws1054.amd.com [10.66.16.34])
        by srdcmail.amd.com (8.13.8/8.13.8) with ESMTP id 04Q80UHs025260;
        Tue, 26 May 2020 16:00:30 +0800
Received: (from weisheng@localhost)
        by srdcws1054.amd.com (8.14.7/8.14.7/Submit) id 04Q80Sr0020868;
        Tue, 26 May 2020 16:00:28 +0800
From:   Wesley Sheng <wesley.sheng@amd.com>
To:     <jdmason@kudzu.us>, <dave.jiang@intel.com>, <allenbh@gmail.com>,
        <linux-ntb@googlegroups.com>, <linux-kernel@vger.kernel.org>
CC:     <wesleyshenggit@sina.com>, <wesley.sheng@amd.com>
Subject: [PATCH] NTB: correct ntb_peer_spad_addr and ntb_peer_spad_read comment typos
Date:   Tue, 26 May 2020 15:59:43 +0800
Message-ID: <20200526075943.20756-1-wesley.sheng@amd.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB02.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(46966005)(8676002)(1076003)(5660300002)(4326008)(70586007)(82740400003)(26005)(70206006)(2906002)(316002)(47076004)(44832011)(8936002)(54906003)(42186006)(110136005)(426003)(356005)(6666004)(81166007)(2616005)(336012)(498600001)(83170400001)(36756003)(82310400002)(2101003);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4722de4b-c7c2-454f-a49b-08d8014ade9e
X-MS-TrafficTypeDiagnostic: BN6PR12MB1794:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1794BF0AF5F29DDAA3A3393CF0B00@BN6PR12MB1794.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 041517DFAB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VNcfLpcYn+5JLBnApqZomPXqwa2xKcPRTCTjIZlGeD5Pleg0CcEtvsQtol7x8kxfhol7KhvDLQcFHHYTF9KJq5PCJ0zAN72tQyZTXfeAs0D8xLW3IlXVUgWKauyP+tCS6+oPNoQWrTrNM8coQdT8tS9bz8vDflqoAJ5q7Gx6Tlxdth8bJSreENElYPvf/LlFQgJhkrV7TwQbkoQGt6ZTrCtJZeQVJdryY5waCqdY1x/MmjfMnHWGo7ZKhA0pZOirEEFJwAx/WlkBcoCVzR4fSGU+oZ4qzp1dYPQaW3LZLYkOKCKYjy6Xn2U2jjvSjduhRR/FOqG92Opspmail+EG2FZ1+9GsZSCa5s8oxqQz9dIJk5YEf/x41JtKBbIuMJgPUd55hubolDtJRPWkgDiseCuI+Xq8rID6UNKxwnXFTuo=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2020 08:00:34.6172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4722de4b-c7c2-454f-a49b-08d8014ade9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1794
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment for ntb_peer_spad_addr and ntb_peer_spad_read
incorrectly referred to peer doorbell register and local
scratchpad register.

Signed-off-by: Wesley Sheng <wesley.sheng@amd.com>
---
 include/linux/ntb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 8c13538aeffe..b9b0d805d0f9 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -1351,7 +1351,7 @@ static inline int ntb_spad_write(struct ntb_dev *ntb, int sidx, u32 val)
  * @sidx:	Scratchpad index.
  * @spad_addr:	OUT - The address of the peer scratchpad register.
  *
- * Return the address of the peer doorbell register.  This may be used, for
+ * Return the address of the peer scratchpad register.  This may be used, for
  * example, by drivers that offload memory copy operations to a dma engine.
  *
  * Return: Zero on success, otherwise an error number.
@@ -1373,7 +1373,7 @@ static inline int ntb_peer_spad_addr(struct ntb_dev *ntb, int pidx, int sidx,
  *
  * Read the peer scratchpad register, and return the value.
  *
- * Return: The value of the local scratchpad register.
+ * Return: The value of the peer scratchpad register.
  */
 static inline u32 ntb_peer_spad_read(struct ntb_dev *ntb, int pidx, int sidx)
 {
-- 
2.16.2

