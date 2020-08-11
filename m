Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A636C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 05:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3741E206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 05:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="igcNx4rX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgHKF2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 01:28:02 -0400
Received: from mail-eopbgr60090.outbound.protection.outlook.com ([40.107.6.90]:56982
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726559AbgHKF2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 01:28:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZK4R1JDGJ6+qH7rkpTEl+N++EbcJbpOVPYuUy6Czp1iJFN0XYwCDRyRfyLOUULpvyPpPv+b8Ye/0IuKSTsOqb4ZNoIKxfRvwIG05j7CYLVb836xFpGa1cSI0xrs6pRidZ1aQKnKHV6+TRVEnatYcAh3h+fDw9y/0VTKF+THYuX0/Z3GK03Ey2UKZSdss7J9m5YAvQ5ers4w3OthVbqieprqCpR122yaBLSw74ABPGTttSxWJWo3f1YUJVg8/bd582iYQMAyj48T6vZUuNHrkzlV1ym61VRkM5TRq0gvnakGVpGabLpatRrpcwcRlKbDuIwlN9lpLMM/O54LC82bCTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5i7/9Q7pu7PXRJhtVsbX0nC5kxlbm0EJB+i7bkPtWA=;
 b=Op1EuS9ThSaNLMk56yr2V2iD1w9AS4WhSWfQZUy/aJB42TB+AqNe9DUUVOFYwWqSGqy8SSCwNJHxqn0npF2qoPD8PVNL7S7Pwjyan2i95FtLgZZkKlNXC5CUP7nFw0KG9kuMBG8zYNRCmXD1CFr3ruUJ0A7YWbqQhSx6zSJIA/yxMWAmOannE9Zk6g/Yb1+lodVwYvnTizN+/bmD+6l+utf/9JD8AX2rIDJnvVlY4qOR3ShZan9oFSPldmj+bjlyBuccp8pqaV7NY37rVM0ZjirJRn7Rnv0Zm5wa5CO2FwNd1GFXltmgjR4UBf8xgiRQtS9xjBeaOsXNi8KBJqbnxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.17) smtp.rcpttodomain=zeniv.linux.org.uk
 smtp.mailfrom=nokia-sbell.com; dmarc=temperror action=none
 header.from=nokia-sbell.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5i7/9Q7pu7PXRJhtVsbX0nC5kxlbm0EJB+i7bkPtWA=;
 b=igcNx4rX6+VOrQOqMxs2aurKXQ2MMrZUfdD6zob9cKVsY5wu0ZQ7wjRYNH1YsOeJfOh1Dsll5IUJIkYaZZ76v+FbOHzfOty9U5P0DEMfg8fwO5UXdnE738UjqoVHnzmNLwXtGOHY9U/n+KPy6c7641yEqaLM+ggqHzbYOC5EW90=
Received: from AM6P195CA0057.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:87::34)
 by AM0PR07MB5250.eurprd07.prod.outlook.com (2603:10a6:208:ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.11; Tue, 11 Aug
 2020 05:27:55 +0000
Received: from AM5EUR03FT045.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:87:cafe::5f) by AM6P195CA0057.outlook.office365.com
 (2603:10a6:209:87::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19 via Frontend
 Transport; Tue, 11 Aug 2020 05:27:55 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.17) smtp.mailfrom=nokia-sbell.com; zeniv.linux.org.uk; dkim=none
 (message not signed) header.d=none;zeniv.linux.org.uk; dmarc=temperror
 action=none header.from=nokia-sbell.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-sbell.com: DNS Timeout)
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.17) by
 AM5EUR03FT045.mail.protection.outlook.com (10.152.17.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.16 via Frontend Transport; Tue, 11 Aug 2020 05:27:54 +0000
Received: from hzling45.china.nsn-net.net (hzling45.china.nsn-net.net [10.159.218.88])
        by fihe3nok0735.emea.nsn-net.net (GMO) with ESMTP id 07B5RnpJ008815;
        Tue, 11 Aug 2020 05:27:49 GMT
Received: by hzling45.china.nsn-net.net (Postfix, from userid 61462992)
        id 52B8140F26; Tue, 11 Aug 2020 13:27:47 +0800 (CST)
From:   Libing Zhou <libing.zhou@nokia-sbell.com>
To:     linux-kernel@vger.kernel.org
Cc:     libing.zhou@nokia-sbell.com, akpm@linux-foundation.org,
        dhowells@redhat.com, viro@zeniv.linux.org.uk
Subject: [PATCH] ROMFS: support inode blocks calculation
Date:   Tue, 11 Aug 2020 13:26:06 +0800
Message-Id: <20200811052606.4243-1-libing.zhou@nokia-sbell.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6f381744-5d13-4f3c-534f-08d83db74c9e
X-MS-TrafficTypeDiagnostic: AM0PR07MB5250:
X-Microsoft-Antispam-PRVS: <AM0PR07MB525065E7786329F18178E6B5AF450@AM0PR07MB5250.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Forefront-Antispam-Report: CIP:131.228.2.17;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(46966005)(186003)(82310400002)(336012)(83380400001)(70586007)(70206006)(2906002)(6916009)(4326008)(81166007)(6266002)(44832011)(316002)(4744005)(2616005)(36756003)(63370400001)(63350400001)(5660300002)(1076003)(42186006)(6666004)(86362001)(8936002)(478600001)(82740400003)(8676002)(356005)(26005)(47076004);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 05:27:54.6090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f381744-5d13-4f3c-534f-08d83db74c9e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.17];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT045.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB5250
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When use 'stat' tool to display file status, the 'Blocks' field
always in '0', this is not good for tool 'du'(e.g.: busybox 'du'),
it always output '0' size for the files under ROMFS since such
tool calculates number of 512B Blocks.

This patch calculates approx. number of 512B blocks based on inode
size.

Signed-off-by: Libing Zhou <libing.zhou@nokia-sbell.com>
---
 fs/romfs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index e582d001f792..b1b7d3f5752f 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -356,6 +356,7 @@ static struct inode *romfs_iget(struct super_block *sb, unsigned long pos)
 	}
 
 	i->i_mode = mode;
+	i->i_blocks = (i->i_size + 511) >> 9;
 
 	unlock_new_inode(i);
 	return i;
-- 
2.22.0

