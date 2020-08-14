Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1918C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 03:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86E1420716
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 03:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="MguZnmYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgHNDDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 23:03:19 -0400
Received: from mail-am6eur05on2134.outbound.protection.outlook.com ([40.107.22.134]:4840
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726583AbgHNDDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 23:03:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n52m14Ne/E9BKufmT78LAie4uqEFxHkf6MPB80ECICVejvCSIkWZf1VFlfTmRE+SW/siGv9sxo3Ed6aLlscZDQDlUgowSrewKZs1p7/YdYT76Mz3uj6inUGVK3VmIVsvrj6LWAXW0yY1G8Hhb3Jy3Xf6hrEO7pTw5TQvcgd6oKYiz1dRR7qtiOGwrTsNwNdP8I2yf53/aiCL8INo11s0TXtxH6fA5BnNYusUe9gHetGcLtI0w8os64E++Si4wvCOruHcRS2BKUO2gjD9oRkj0AABOZFltELvTF+Ir2WvPog2BYckPYBQ6iEK1iOB5+pz8q0U7JDpoJdeX8EHxOXFXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unT/0UW9X4U2cqxmyiM+LWt/Jx5UZHRLGSzeLVkcJGE=;
 b=H3hMMEJkkHN7saVGTTEXCqQLnc2kqc6MO9ttHHjXCWj9qxLZNOUSiT1sLoob/Ewtp00SgfqqNzqO96L4vlKbMWYrcZNPa3wFoR4LF8D61B+YVOdnlW/c8n3Ymj2mm9G/twaS1GOTka/JDflyfmBPv0nPVx3IqVaxfv47StvwTJOn6vm2bMLwrQrzwwlG8FCV1Wa8aAcm/QkyDM4sU8+0TGKWRVed+1Lx9VuO6+LAmckRZX06t7qaUtxpjH3yCzyBCwcjvB8sM/1Hv0BS43HbAh5n6fF12lfymexe47oJaWF69Z16IOu1di5M2cVOlLqo5qs1Jvky4gymOl5TgAfNMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.17) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=nokia-sbell.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=nokia-sbell.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unT/0UW9X4U2cqxmyiM+LWt/Jx5UZHRLGSzeLVkcJGE=;
 b=MguZnmYHYdsQEj4Le7okcE0VpQ0+7JiTuwvaHvWg8hmPNMexXhQim1QGK4F+vr7Xq0f8Peze2QvR/eWKWDBObw6lPWaWiqSlB0LT7O+xqP3CbhCgCIeTkCkzGJJbPuf2L+061Mk+gl9SxqwafRv1mQwrjdaQhlGo2En/ahPRFhk=
Received: from DB6PR1001CA0014.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:b7::24)
 by DB7PR07MB5498.eurprd07.prod.outlook.com (2603:10a6:10:76::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.10; Fri, 14 Aug
 2020 03:03:10 +0000
Received: from DB5EUR03FT009.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:b7:cafe::b4) by DB6PR1001CA0014.outlook.office365.com
 (2603:10a6:4:b7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Fri, 14 Aug 2020 03:03:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.17)
 smtp.mailfrom=nokia-sbell.com; vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=nokia-sbell.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-sbell.com
 designates 131.228.2.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.17; helo=fihe3nok0735.emea.nsn-net.net;
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.17) by
 DB5EUR03FT009.mail.protection.outlook.com (10.152.20.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Fri, 14 Aug 2020 03:03:09 +0000
Received: from hzling45.china.nsn-net.net (hzling45.china.nsn-net.net [10.159.218.88])
        by fihe3nok0735.emea.nsn-net.net (GMO) with ESMTP id 07E3322k008593;
        Fri, 14 Aug 2020 03:03:02 GMT
Received: by hzling45.china.nsn-net.net (Postfix, from userid 61462992)
        id 4FF8140F23; Fri, 14 Aug 2020 11:03:00 +0800 (CST)
From:   Libing Zhou <libing.zhou@nokia-sbell.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, libing.zhou@nokia-sbell.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de
Subject: [PATCH v2] sched: print fields name when do sched_show_task
Date:   Fri, 14 Aug 2020 11:02:36 +0800
Message-Id: <20200814030236.37835-1-libing.zhou@nokia-sbell.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5445e136-6e5c-49ff-c042-08d83ffe92e8
X-MS-TrafficTypeDiagnostic: DB7PR07MB5498:
X-Microsoft-Antispam-PRVS: <DB7PR07MB54981AE6D2F1E16B6C5CDCE7AF400@DB7PR07MB5498.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jeTHblANaf/KtMgWS4ItcNeb6+NalUebhuIN/vwW30bDgqZLTn1IH4zAVw4Kln7c8l+qt5ne2Knnu8Lp7U+fUQk6xwRmaYxUTEzDgF3huwrVK1HIY9RLya6Oru6J13DjqoVWAOwvvqHB4VcfsmJlk9LeOdV5lFkl0QRtQY7lCdXwMFIgBfuCqM7tPOrN4uR8zsJ47B1dAb5UxN0VrrxTTCseIk9Z2SghYG2cS6PG4ottZxl6NS8vuRSfXzPP7iRoCuK8LhDDOW83hc0hwkkcamyCxwA7ZJxRiM3Uj81iXOMqzbcGMWPuE9EW9Ijx8Eqa/Or/3sA0dg7f2r7VzDz+FNcrASmZK+IWBxA6cVpkB1ajaLuxo9QhMU0x1Rnhcvzlq57vwdeAQR8yRJj33o9M3g==
X-Forefront-Antispam-Report: CIP:131.228.2.17;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(46966005)(4326008)(86362001)(5660300002)(8676002)(26005)(47076004)(44832011)(82740400003)(70206006)(70586007)(82310400002)(2616005)(336012)(1076003)(81166007)(8936002)(6666004)(186003)(2906002)(356005)(7416002)(36756003)(478600001)(6266002)(316002)(83380400001)(42186006);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 03:03:09.0865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5445e136-6e5c-49ff-c042-08d83ffe92e8
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.17];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT009.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR07MB5498
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current sysrq(t) output task fields name are not aligned with
actual task fields value, e.g.:

	kernel: sysrq: Show State
	kernel:  task                        PC stack   pid father
	kernel: systemd         S12456     1      0 0x00000000
	kernel: Call Trace:
	kernel: ? __schedule+0x240/0x740

To make it more readable, print fields name together with task fields
value in same line, remove separate fields name print, new format looks
like:

	kernel: sysrq: Show State
	kernel: task:systemd         state:S stack:12920 pid:    1 ppid:     0 flags:0x00000000
	kernel: Call Trace:
	kernel: __schedule+0x282/0x620

Signed-off-by: Libing Zhou <libing.zhou@nokia-sbell.com>
---
v2:
Quote the new format as well in the changelog per Ingo suggested.

 kernel/sched/core.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e15543cb8481..0ad554cb0bbb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6069,10 +6069,10 @@ void sched_show_task(struct task_struct *p)
 	if (!try_get_task_stack(p))
 		return;
 
-	printk(KERN_INFO "%-15.15s %c", p->comm, task_state_to_char(p));
+	pr_info("task:%-15.15s state:%c", p->comm, task_state_to_char(p));
 
 	if (p->state == TASK_RUNNING)
-		printk(KERN_CONT "  running task    ");
+		pr_cont("  running task    ");
 #ifdef CONFIG_DEBUG_STACK_USAGE
 	free = stack_not_used(p);
 #endif
@@ -6081,8 +6081,8 @@ void sched_show_task(struct task_struct *p)
 	if (pid_alive(p))
 		ppid = task_pid_nr(rcu_dereference(p->real_parent));
 	rcu_read_unlock();
-	printk(KERN_CONT "%5lu %5d %6d 0x%08lx\n", free,
-		task_pid_nr(p), ppid,
+	pr_cont(" stack:%5lu pid:%5d ppid:%6d flags:0x%08lx\n",
+		free, task_pid_nr(p), ppid,
 		(unsigned long)task_thread_info(p)->flags);
 
 	print_worker_info(KERN_INFO, p);
@@ -6117,13 +6117,6 @@ void show_state_filter(unsigned long state_filter)
 {
 	struct task_struct *g, *p;
 
-#if BITS_PER_LONG == 32
-	printk(KERN_INFO
-		"  task                PC stack   pid father\n");
-#else
-	printk(KERN_INFO
-		"  task                        PC stack   pid father\n");
-#endif
 	rcu_read_lock();
 	for_each_process_thread(g, p) {
 		/*
-- 
2.22.0

