Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB331C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 02:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 962472078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 02:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="tg44zfWB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgHTC5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 22:57:01 -0400
Received: from mail-vi1eur05on2092.outbound.protection.outlook.com ([40.107.21.92]:18241
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726578AbgHTC5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 22:57:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8zBxZFffRgF/UXWIeV4UYgErtrM0QvIT3wuPJF810nu8/xhQCwifBE3gtZdpgd2H3o1sAOSkuWq5XlgCZD8SMAkmp+dtOVRv9I7JD2ydGzcrUmypLsx5rIjJetWxvBXchEuF0YDfJFMG2ymjvASrbnaBa50htrX3uJzVzPGc3BJdSHv1gUreQ79qkZ/rAHaKdb5NZTJNOdZc3LVGlZ5vLs0yaN8aPaa2LGlnL4zTfOTeAcEBeACIh871nr/8jNt+R9HB42QgwDIGUB4Q1GZj2AGGIQlk4z6wo4k0KJAScZfmViE6uPKlGlhX+1GwedjqgLCa5C0/z1b5dWuPrJ+2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWxVX4UV1bB5vt5S4qzr9Cz2i6Y2I5i25Y0rIapg0GY=;
 b=hWt9I5gqu0RTGJ3wWP/mpZOWjxpUtc3VAWRrhTNhtzlRFDRfznJNSSRGuEUjp9rK9/lUklM38ori3mL/HJ5amr3d0iDbVzr0nUfo6SiKEWGD2Ac8IZCXSceljU/Ton71EKZHHlS8mX7UlMTziD60IxiPSax/dzcPQ/zk0jvXyZegfnjHwqUH4qs2LNLrPRM6ylnWDba2HQVt3oFb7vp8kmukSR1gnT0nk1/ZC4RIWLu6yoaWyKE6qvhTqydbYdUZGeB54Vle07dF3nwTpkcDtjZHUPYh9haSdIW51Sg3A8zRbsDFeT/WHppSwUJUH7BYPr9bI2YRsma+JyJIZY7XMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.8) smtp.rcpttodomain=zytor.com smtp.mailfrom=nokia-sbell.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nokia-sbell.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWxVX4UV1bB5vt5S4qzr9Cz2i6Y2I5i25Y0rIapg0GY=;
 b=tg44zfWBaOi+AqaEKgUisQWSZ2+PDtiZCf1kHvPuwXoAPSUwDiwrzRH2Z8JI+cKJf64no7zuKcZMdRuDgBcIS6xC4m34XMbXVIvEZ6F8/kpxxAY0VQ6ERsFH0/IBniBxA8bOncglcun2/bwfSXZbtTn8LWHHWZdFKR/dLJ+Gm+A=
Received: from DB6PR0202CA0023.eurprd02.prod.outlook.com (2603:10a6:4:29::33)
 by AM0PR07MB5683.eurprd07.prod.outlook.com (2603:10a6:208:112::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.10; Thu, 20 Aug
 2020 02:56:57 +0000
Received: from DB5EUR03FT021.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:29:cafe::3c) by DB6PR0202CA0023.outlook.office365.com
 (2603:10a6:4:29::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Thu, 20 Aug 2020 02:56:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.8)
 smtp.mailfrom=nokia-sbell.com; zytor.com; dkim=none (message not signed)
 header.d=none;zytor.com; dmarc=pass action=none header.from=nokia-sbell.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-sbell.com
 designates 131.228.2.8 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.8; helo=fihe3nok0734.emea.nsn-net.net;
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.8) by
 DB5EUR03FT021.mail.protection.outlook.com (10.152.20.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 02:56:56 +0000
Received: from hzling45.china.nsn-net.net (hzling45.china.nsn-net.net [10.159.218.88])
        by fihe3nok0734.emea.nsn-net.net (GMO) with ESMTP id 07K2uoYx022986;
        Thu, 20 Aug 2020 02:56:51 GMT
Received: by hzling45.china.nsn-net.net (Postfix, from userid 61462992)
        id 5E0DE40F2D; Thu, 20 Aug 2020 10:56:45 +0800 (CST)
From:   Libing Zhou <libing.zhou@nokia-sbell.com>
To:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, bp@suse.de, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, libing.zhou@nokia-sbell.com,
        hpa@zytor.com
Subject: [PATCH v2] x86/nmi: Fix nmi_handle duration miscalculation
Date:   Thu, 20 Aug 2020 10:56:41 +0800
Message-Id: <20200820025641.44075-1-libing.zhou@nokia-sbell.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3d15d9e7-e68d-428a-f3b9-08d844b4b38f
X-MS-TrafficTypeDiagnostic: AM0PR07MB5683:
X-Microsoft-Antispam-PRVS: <AM0PR07MB5683D1A95A06C82B0E6EC8D4AF5A0@AM0PR07MB5683.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T5fUCGA/dSrfNImMO8nU148wGsGeS8ZRQPGBe/5SMwjmcSmwYU0Mv0JJlgDpXDWzMnT3IVin8ZiCiCD235dUAPkXT0Phru5w6Wj/SMo3qzKdxgDF2isWqvcp0Wksx+GZG3sHp/cwQSEemsOy8FKj/SlcJgC5ytNL5kPzW03/Af7DR683H2ATdhfLtaGkoxm13/htZDpMZOqHcCxQ2oe6/NMm67jH6o4jmJ7eGoiTeESadDblU/Dssg2FoRsAMy8C3oxYOHPvFwChKcN8aKROACwy88LkUZwH5BI6Ch7FxrLzm1yt5ql+WamX6BA7dUN78bzAaOGrifwsBIje+lYcKJecnjNPedQFaA1muOnlsJZcGhw8s0RTkEzdRktdePR7ML6SgzBHOjxO09NqD5qTnA==
X-Forefront-Antispam-Report: CIP:131.228.2.8;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(46966005)(8676002)(86362001)(1076003)(356005)(83380400001)(2616005)(336012)(47076004)(82740400003)(82310400002)(316002)(4326008)(478600001)(186003)(81166007)(70586007)(42186006)(36756003)(44832011)(70206006)(6666004)(26005)(8936002)(5660300002)(6266002)(2906002);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 02:56:56.9313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d15d9e7-e68d-428a-f3b9-08d844b4b38f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.8];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT021.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB5683
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In nmi_check_duration(), the 'whole_msecs' value get from
'action->max_duration' is wrong.

Fixes: 248ed51048c4 ("x86/nmi: Remove irq_work from the long duration NMI handler")
Signed-off-by: Libing Zhou <libing.zhou@nokia-sbell.com>
---
v2:
Change solution as peterz@infradead.org suggested.

 arch/x86/kernel/nmi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 4fc9954a9560..47381666d6a5 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -102,7 +102,6 @@ fs_initcall(nmi_warning_debugfs);
 
 static void nmi_check_duration(struct nmiaction *action, u64 duration)
 {
-	u64 whole_msecs = READ_ONCE(action->max_duration);
 	int remainder_ns, decimal_msecs;
 
 	if (duration < nmi_longest_ns || duration < action->max_duration)
@@ -110,12 +109,12 @@ static void nmi_check_duration(struct nmiaction *action, u64 duration)
 
 	action->max_duration = duration;
 
-	remainder_ns = do_div(whole_msecs, (1000 * 1000));
+	remainder_ns = do_div(duration, (1000 * 1000));
 	decimal_msecs = remainder_ns / 1000;
 
 	printk_ratelimited(KERN_INFO
 		"INFO: NMI handler (%ps) took too long to run: %lld.%03d msecs\n",
-		action->handler, whole_msecs, decimal_msecs);
+		action->handler, duration, decimal_msecs);
 }
 
 static int nmi_handle(unsigned int type, struct pt_regs *regs)
-- 
2.22.0

