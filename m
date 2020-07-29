Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DF0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 10:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74F852074B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 10:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="jdF86K/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgG2KJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 06:09:21 -0400
Received: from mail-eopbgr30095.outbound.protection.outlook.com ([40.107.3.95]:24843
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725851AbgG2KJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 06:09:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDaDYmHuLijU0dCuQ5z84EaJGRaZd3l5ylMGPYmZtr0zNgCjAuVbCH1T89O2G7sufGYNxWZCX12zybDucGTYK0MZiJJPmKNnjR8jzKlyWsYPqjLxm9fdkX8JZEstOfysdPoFZAvuVyg9W1efQs5ndRPGlB5PXsT1mk8qMcAhZizo3Wu7j9WqtplXln6gdhTG6ZrfySIZ5TCis8jCI3wuTeTiPk3k5vkf+p8z5VYoZGgfzCzL+4VuGMndF2CkqQr987X4EGaxjR0N7uMs4ztcHKH1FlaNp5PQYfDcdXsd0gdJvxsnimePM43OhkRJKjBa+/mt1IwZYLZs5N+pJKbLVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5i7/9Q7pu7PXRJhtVsbX0nC5kxlbm0EJB+i7bkPtWA=;
 b=Go4YdmdbQw60R3U+cMsFty7Fgj8duBSm2s6UcLT4FIRvcVYhRmR0xJEfqQGzrdU/RxmpCzbgGiE7HvmhNL+FN2WloV4JMjkfISUPzVbdLDE8k3sZuCf6vlLnPgt0Vy+sdKOT5ZyLWO261imh6gPAxiFPYQ/E9d69bZ9BNoC+zJHKYflE75ktsrfUGCBwQoo3dRvm7+3NrCgZhlxrYjV3WauWTZWUzzdVJHi0eM8oo133gus10kVM/c49lGkcV1EfbKrlCJyRWIXhcSpy+ScEubj4lzFEquX8xqo+yirUrmFOIcHXNhDgPBoN+rMNQkc9j1ly/3Jsm9M6VmZO9pqhSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.8) smtp.rcpttodomain=zeniv.linux.org.uk
 smtp.mailfrom=nokia-sbell.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=nokia-sbell.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5i7/9Q7pu7PXRJhtVsbX0nC5kxlbm0EJB+i7bkPtWA=;
 b=jdF86K/igusJKUgu7aqSxFsV54mWlVnp5caK+z6cxSMFVelVLYTzr2JwWEg6ZVTpOkJprz6lkbk14DQ2ozLFVlAO89ZLmGKxGgcN8iH7FQEnMFVrTOnFW5F/JWDAQfzqs4wofPpfFQQdpt026+g/OM+gg9J7vyexqgyb2PsCs+I=
Received: from DB6PR07CA0049.eurprd07.prod.outlook.com (2603:10a6:6:2a::11) by
 VI1PR0701MB2192.eurprd07.prod.outlook.com (2603:10a6:800:31::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.9; Wed, 29 Jul
 2020 10:09:12 +0000
Received: from DB5EUR03FT009.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:2a:cafe::4a) by DB6PR07CA0049.outlook.office365.com
 (2603:10a6:6:2a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.9 via Frontend
 Transport; Wed, 29 Jul 2020 10:09:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.8)
 smtp.mailfrom=nokia-sbell.com; zeniv.linux.org.uk; dkim=none (message not
 signed) header.d=none;zeniv.linux.org.uk; dmarc=pass action=none
 header.from=nokia-sbell.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-sbell.com
 designates 131.228.2.8 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.8; helo=fihe3nok0734.emea.nsn-net.net;
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.8) by
 DB5EUR03FT009.mail.protection.outlook.com (10.152.20.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.10 via Frontend Transport; Wed, 29 Jul 2020 10:09:12 +0000
Received: from hzling02.china.nsn-net.net (hzling02.china.nsn-net.net [10.159.215.126])
        by fihe3nok0734.emea.nsn-net.net (GMO) with ESMTP id 06TA9AHE005064;
        Wed, 29 Jul 2020 10:09:10 GMT
Received: by hzling02.china.nsn-net.net (Postfix, from userid 61462992)
        id 753F54849; Wed, 29 Jul 2020 18:09:08 +0800 (CST)
Date:   Wed, 29 Jul 2020 18:09:08 +0800
From:   Libing Zhou <libing.zhou@nokia-sbell.com>
To:     viro@zeniv.linux.org.uk, dhowells@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ROMFS: support inode blocks calculation
Message-ID: <20200729100908.GA25571@hzling02.china.nsn-net.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6ffc777-bfde-407a-e784-08d833a77146
X-MS-TrafficTypeDiagnostic: VI1PR0701MB2192:
X-Microsoft-Antispam-PRVS: <VI1PR0701MB21926F9ACE91ABE37A888564AF700@VI1PR0701MB2192.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vlMM8nvGNUawu7PLlkiGn3QEWB11UbpURIp8StChZPQvgEWIm+pplvae3ZuBxiLkHmWbS2FnmY8Bq3hez5FWN+QxaJeVVqpNySjt5tdQY0XQoIl4Y7dFV8MAvjjkzOPbf/37DgmSR7rmcmnDciJaYIR55PqnBaRmrIRzOllKiKvK5Z8WBPUxRi5nBERwGbwoEXntZrOIyRJMeu8cXGCcV2T77A21FVQu8ySBzW6d9ausdloGg20MfZOPV+ZWLdOjHsswsZAGs5qEVuLunglXkNpXotygEyyonVk2tsom1e9FKw5qeIpUMkf30gZr5vV8Tkph+3k2PODSfyb8sIYwYPoB0gITgZaRLnsGOK9X9eJ/QMDPmVifv8WJ9WRiLAoYXBjvNtVHXd1iUkpHDJj2Kg==
X-Forefront-Antispam-Report: CIP:131.228.2.8;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(46966005)(316002)(8676002)(42186006)(8936002)(81166007)(356005)(70586007)(186003)(82310400002)(82740400003)(26005)(70206006)(33656002)(47076004)(6266002)(4326008)(478600001)(9686003)(336012)(44832011)(83380400001)(86362001)(4744005)(5660300002)(1076003)(2906002);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 10:09:12.5052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ffc777-bfde-407a-e784-08d833a77146
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.8];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT009.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB2192
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

