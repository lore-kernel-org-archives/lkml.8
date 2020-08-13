Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FECC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6F8C20771
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="As9Vs7HB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgHMKvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 06:51:53 -0400
Received: from mail-db8eur05on2095.outbound.protection.outlook.com ([40.107.20.95]:55136
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726102AbgHMKvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 06:51:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tyx3h8qin6cp5OVQlt++l7gkwHY1uPF7p/xxTd/Mpf3cGBEyfwGJev8ba8qDjr8r343xabN+HqT/LHm6BEtFoVAlv3xgXt3SejvMO/uwIhT8DS7KwWiFXL+qvtMI+WoKgPxMXxWrPQkLr3ud2WW6lSyTzkTSN5pfMCTGALyKvychf3n/ndb5hFH98WJKJ5BUvLHcW/MFDg95Z2T5vkD8FGzzf8fZuvggYIupfkb68+5hZJYJfmQzcQ9tOPyKyMcsk9Wc/M5FwxRtroMoQ/u7mg20PnIR8QZoaYXI0Yn2gFBkvnJzeZ2WbjYA2U/G41/TkG5sTPctaCslX6jL/fW9DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cA9ae5tiaxOfGPQmbRosS4QHAJ/h2bSG0xvl0xw3oOY=;
 b=l3VoB/xMhextL9yFm8pne1DaSfm7SmRCJsfGn58LLHQfFjC7pz19vyymlzfz36tUEGVNmsh29w7/FMDV6G52CcXjcmukkpbIKqHbG8zOSgkI2YoOzg2JcByvj2/YUXFXUu01BvKkv2TqWpd3o5f8u0c8PSdL9qeYoySAWnvfihDaBhnj7vBIg6xw66/lWke+UwJ5HmIQofqFPg6ZyQzo/HEgIRF6ArQDX1zTOoIX/wOIsG/T4FrCGJzQZ2WlQ5M5seeLW71yE5C8yp32ERP7LtCTDKoWoaZllYN6SsSY2OXjqLI4PLfQ6ONrIGseOTInC1lTF1He3tnVB6RlrHNo4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.8) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nokia-sbell.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nokia-sbell.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cA9ae5tiaxOfGPQmbRosS4QHAJ/h2bSG0xvl0xw3oOY=;
 b=As9Vs7HBQ42z4EZ3lh9nPsSNQ2vC5NFVd3TmySXJcDXr/azeCyddlmUUa2c74mpo+MgMpknZkTLYJ9N2fRkJygaW/+HbGF+x/Yf7OCzruNIGkIInBlgT0jvby1M5OxBp7tMxvD4y0C1yA3yIUQK5tTAdj7plRteWco+ZOZltN4M=
Received: from AM5PR0201CA0009.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::19) by DB6PR07MB4358.eurprd07.prod.outlook.com
 (2603:10a6:6:4a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.6; Thu, 13 Aug
 2020 10:51:45 +0000
Received: from AM5EUR03FT028.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:3d:cafe::6a) by AM5PR0201CA0009.outlook.office365.com
 (2603:10a6:203:3d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20 via Frontend
 Transport; Thu, 13 Aug 2020 10:51:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.8)
 smtp.mailfrom=nokia-sbell.com; vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=nokia-sbell.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-sbell.com
 designates 131.228.2.8 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.8; helo=fihe3nok0734.emea.nsn-net.net;
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.8) by
 AM5EUR03FT028.mail.protection.outlook.com (10.152.16.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Thu, 13 Aug 2020 10:51:43 +0000
Received: from hzling45.china.nsn-net.net (hzling45.china.nsn-net.net [10.159.218.88])
        by fihe3nok0734.emea.nsn-net.net (GMO) with ESMTP id 07DApbid011111;
        Thu, 13 Aug 2020 10:51:37 GMT
Received: by hzling45.china.nsn-net.net (Postfix, from userid 61462992)
        id 818F840EBB; Thu, 13 Aug 2020 18:51:35 +0800 (CST)
From:   Libing Zhou <libing.zhou@nokia-sbell.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, libing.zhou@nokia-sbell.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de
Subject: [PATCH] sched: print fields name when do sched_show_task
Date:   Thu, 13 Aug 2020 18:48:34 +0800
Message-Id: <20200813104833.17573-1-libing.zhou@nokia-sbell.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 72e0652a-32cf-46b2-618b-08d83f76de06
X-MS-TrafficTypeDiagnostic: DB6PR07MB4358:
X-Microsoft-Antispam-PRVS: <DB6PR07MB4358B5C8F37E6801F67A606AAF430@DB6PR07MB4358.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iKnHRn0+rAEIRqfZUiaJHuwaAB9EB46k8gUH+xwePteLtnP2BUM/tJ9aeghDCyEOX4ZrF6sRAJaxIjAzxKTig4/8L8ta6m72xaDAOSuJnSElzOQHqlJOVj6OfYvNPKcZXhimbn86N/CSbc78nJXbfdy9PbG5f7Nrd7WvkxNVAjz3UgWD8FOefLtLYJBefjUFpCtMBBqeeKoYXrIJBJPGoBqhEG87OnDo5P9c6wJDfvFefRN8wDD/S/k3jyX9cdNpFayhVoEKhcdaY2mh8xvuwiB6CXjtVr5pf5p3lsw/mpJFBvmaMj6fwmXIxkTaNCYtQFPzHdYSanL/BeNv3h3WATzyQCa6ln19DXwyzNfH4SJahtpsw4PSRnEFSFjv+ldK1u7k5eqzDZc89O1mxoYkig==
X-Forefront-Antispam-Report: CIP:131.228.2.8;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(46966005)(83380400001)(8936002)(2906002)(5660300002)(47076004)(356005)(336012)(86362001)(82740400003)(82310400002)(81166007)(6266002)(70206006)(2616005)(4326008)(44832011)(7416002)(36756003)(8676002)(26005)(1076003)(478600001)(42186006)(316002)(186003)(70586007);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 10:51:43.5946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e0652a-32cf-46b2-618b-08d83f76de06
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.8];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT028.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR07MB4358
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current sysrq(t) output task fields name are not aligned with
actual task fields value, e.g.:

        kernel: sysrq: SysRq : Show State
        kernel:  task                        PC stack   pid father
        kernel: systemd         S12456     1      0 0x00000000
        kernel: Call Trace:
        kernel: ? __schedule+0x240/0x740

To make it more readable, print fields name together with task fields
value in same line, remove separate fields name print.

Signed-off-by: Libing Zhou <libing.zhou@nokia-sbell.com>
---
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

