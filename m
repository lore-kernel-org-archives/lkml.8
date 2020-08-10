Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FEFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 02:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1DB6206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 02:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="dS2T6DkA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgHJCJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 22:09:55 -0400
Received: from mail-eopbgr80091.outbound.protection.outlook.com ([40.107.8.91]:30397
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726338AbgHJCJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 22:09:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5fGMXnFMMn9Uace81B5Tm7umBNVAH9Az7LzbwbC+f1Aezucahsot1jwHP3lgdTp3ya4KFNhiilVyeYaa9ilLoyqyf6Y9foLTbjz9mPF0uhkRoCpC30kriGnMHGRJtup/9oflG83hwLekEZC3I6U2xL5cm/dTJ4SWKWa6M0WQ3yPXw/i5bALK38ZKNMGn2jux9bVYcqPiFU75+BCmcxRYA65vH5hkDp+S4Z88URYUO99epbUtFsNnnvadw/am6k5nwoDskUeLrcSOBbBLwDjQ5k1SY7LQGwKyCzyaNMI/bRFLm7jReNZ05KPoZBBEtIKGGddnX4i//4U6ZCyocFzCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5i7/9Q7pu7PXRJhtVsbX0nC5kxlbm0EJB+i7bkPtWA=;
 b=nBSQaTlZuilK3aBzzDeyj0Bsp9W+k/2Y+4zVFsI4iJu5CGtLbDx6fBY+LuD/n/fXRJ9v4L1FKGqcpZYHUnuHK9/xxar5AZkA0msVF+JYaWvo5Y5Jrb22tEQwpuFpPcHGSG3t60uNrHuk9EPveBDjy+Iyuq5ZRTSgki27mF9frT8Ef8bjLvwH+d0m8MEm4Ip07iwm5FolL3+Lyu2n3cjwIPGLl65npwfQYdWBlKuEgLqkwB8EgkpxiF6HYSARBSZK15QXE4u4+cZJv3evp3w0x1QYY2Tq+gDbVTW/BtDqd0OC6bEFm9fVW3NlnBGw6O8jCpjLaYWOMnPJtey1f8cNfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.17) smtp.rcpttodomain=zeniv.linux.org.uk
 smtp.mailfrom=nokia-sbell.com; dmarc=temperror action=none
 header.from=nokia-sbell.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5i7/9Q7pu7PXRJhtVsbX0nC5kxlbm0EJB+i7bkPtWA=;
 b=dS2T6DkA1Ijb0NwV1ggw5zw1Qu+fW02z6br+1WgKP68Seo4kTZdBHGARoSJ0yWKwefv7QhA5b2xlVJ9ckKr0fBNDNJMcMSOXYOQAKHmgxXet0zCJtye7UkAHeGEKMknaSRZkAhERj/mTWRnFVB4FLG/poziyAkqt+Tq0j5bzp6w=
Received: from MR2P264CA0191.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::30) by
 DB6PR07MB4198.eurprd07.prod.outlook.com (2603:10a6:6:4b::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.14; Mon, 10 Aug 2020 02:09:49 +0000
Received: from VE1EUR03FT055.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:501:0:cafe::7d) by MR2P264CA0191.outlook.office365.com
 (2603:10a6:501::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20 via Frontend
 Transport; Mon, 10 Aug 2020 02:09:49 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.17) smtp.mailfrom=nokia-sbell.com; zeniv.linux.org.uk; dkim=none
 (message not signed) header.d=none;zeniv.linux.org.uk; dmarc=temperror
 action=none header.from=nokia-sbell.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-sbell.com: DNS Timeout)
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.17) by
 VE1EUR03FT055.mail.protection.outlook.com (10.152.19.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.16 via Frontend Transport; Mon, 10 Aug 2020 02:09:47 +0000
Received: from hzling45.china.nsn-net.net (hzling45.china.nsn-net.net [10.159.218.88])
        by fihe3nok0735.emea.nsn-net.net (GMO) with ESMTP id 07A29h43032324;
        Mon, 10 Aug 2020 02:09:43 GMT
Received: by hzling45.china.nsn-net.net (Postfix, from userid 61462992)
        id DF86940F1C; Mon, 10 Aug 2020 10:09:34 +0800 (CST)
From:   Libing Zhou <libing.zhou@nokia-sbell.com>
To:     viro@zeniv.linux.org.uk, dhowells@redhat.com
Cc:     libing.zhou@nokia-sbell.com, darrick.wong@oracle.com,
        deepa.kernel@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ROMFS: support inode blocks calculation
Date:   Mon, 10 Aug 2020 10:08:56 +0800
Message-Id: <20200810020856.30866-1-libing.zhou@nokia-sbell.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 92748125-4d5b-4170-6ac6-08d83cd274b0
X-MS-TrafficTypeDiagnostic: DB6PR07MB4198:
X-Microsoft-Antispam-PRVS: <DB6PR07MB4198BCD825A2A231568D34F8AF440@DB6PR07MB4198.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ubnjon9dGUNo9cjPS5ZeqCXhiT3/9nCM6wt0cd3bokUjJ+ks03NtL5yTbrweRKvmbMBjjOPSxr9y36fheV0Lo9SBriwRYc1LvsPZVx1HHj9+GEMToDsD7zVbiLyzdTP3Qni1mZbiwL7O6xnMIZIDs0aW9j9rZs5SH1ZUr/KNkXwJYLP4Vb/vNUFIbFWa2rWL7HhU9w66LJSsdrSm978OyXZ81GsCk4ifSP2M4Zut9SeYQKJgk411wNDZwJTNnZ1hc6tbkvQGk2LtL0KZg4j/YiI7SsvVfyRscWTP5Eyr3hFW6XAtE6mR8o3+FgMQcPlZ0K9SSZGwFbEaLje4MkkbPybcayRNsYAYkxskkd3xo5UZmlYvINlA30JPiblfd3UcIM2e3HjdQ8gYJZqvQ2QVhQ==
X-Forefront-Antispam-Report: CIP:131.228.2.17;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(46966005)(82310400002)(6666004)(63370400001)(4326008)(2616005)(63350400001)(8676002)(478600001)(356005)(81166007)(8936002)(83380400001)(36756003)(6266002)(47076004)(86362001)(2906002)(44832011)(82740400003)(42186006)(316002)(4744005)(70206006)(70586007)(336012)(5660300002)(26005)(186003)(1076003);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2020 02:09:47.0504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92748125-4d5b-4170-6ac6-08d83cd274b0
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.17];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT055.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR07MB4198
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

