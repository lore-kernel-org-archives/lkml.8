Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411BCC33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 06:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E645A20721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 06:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="aYzjqLNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgBCGvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 01:51:38 -0500
Received: from mail-eopbgr00102.outbound.protection.outlook.com ([40.107.0.102]:51523
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726045AbgBCGvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 01:51:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMaW8syOxzP9aux7DDOGfBJQ1/ykWnzgf84THXOZuunNaxBytNS2hY8A5P+KOt6U7wImlkEOUsLrYlE+vtB5AOMJgEHRAnsU2GgJJfJVYcD/mTgP/mIrK9Y/zY//4abQ2DlpISeRfP7eanx1RZr4dmnYjaO76GIqWJYxXaGSkcKKViDfwCAl8f36jnHxGNWK5czdKw6y1A0+SWokwcdnUGGrDp+ic08fLURGVZetya1rsp3d3vnFTr4paG5qUj+GLqa1NrOgBom9Hb/tuvDYI1XZuF/nlyn28439IyjGAoxGg5WwhyZ2fdBy5m7LRy6P9XSqHyRpXCK5AJ8PCApVjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4ksCWo/gPDCVrlWx7WioxXjm7sbqsH/OF5DNSRzJHo=;
 b=J3NCTDPWKUyiusFaf609+hK0EAMpnUXL2sfVbUZl7lQ8rCbAqdYPgojrFFXwBk0pE+8SyIbKkpV7+baj4WJnJ7rur2r6Tp4hsfCh0rNhIQB908U9u3xW0PuccNxNHIpAxqJKD44bL7t/FvftVIySCTcrrqO1dy+XSOD1E0/yPSDhbrRhr9CcSPe4fG4mAi17qWqM0Fc9GSRXauePi2FLd6HZbSpwgvpVlmIqOF2FxWN4qO7xF8Ckbe8hju0rvlz2as8+EfGmC9yR/OnkFDC/fqP2eQam/kXwezbuMIqzTr1yCn2pOxCb0ujkl21nPz3jyV8v6N1Bd+QgFrI+12uLTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4ksCWo/gPDCVrlWx7WioxXjm7sbqsH/OF5DNSRzJHo=;
 b=aYzjqLNpszD/IFQQpMapbsV4cC2dHkrGvx4t2ZtQatj9SOvPNod4vo84fA5g8FUw0bKENY6zE3dSYH+QFr8/d9my1pYOVUCv2Cldbj1CAljgNMEA9UOFmDJnj8EZxniqdWiy1w56oAuANZL2B/ndIpTVr52a++5iw/lcU0vc13M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=matija.glavinic-pecotic.ext@nokia.com; 
Received: from VI1PR07MB6048.eurprd07.prod.outlook.com (20.178.123.204) by
 VI1PR07MB5197.eurprd07.prod.outlook.com (20.178.9.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.10; Mon, 3 Feb 2020 06:51:34 +0000
Received: from VI1PR07MB6048.eurprd07.prod.outlook.com
 ([fe80::dd1:76b6:26ca:e2e8]) by VI1PR07MB6048.eurprd07.prod.outlook.com
 ([fe80::dd1:76b6:26ca:e2e8%6]) with mapi id 15.20.2707.018; Mon, 3 Feb 2020
 06:51:34 +0000
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
From:   Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
Subject: [PATCH RESEND] cpu/hotplug: Wait for cpu_hotplug to be enabled in
 cpu_up/down
Message-ID: <d950a169-941e-7caa-608a-df97a127c95d@nokia.com>
Date:   Mon, 3 Feb 2020 07:51:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P189CA0023.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::36)
 To VI1PR07MB6048.eurprd07.prod.outlook.com (2603:10a6:803:d7::12)
MIME-Version: 1.0
Received: from [172.30.9.7] (131.228.32.167) by HE1P189CA0023.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.20.2686.29 via Frontend Transport; Mon, 3 Feb 2020 06:51:33 +0000
X-Originating-IP: [131.228.32.167]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 411d24bf-a170-4c66-2fd7-08d7a87581ed
X-MS-TrafficTypeDiagnostic: VI1PR07MB5197:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR07MB51978ADBEF46EAA1E8F6A88CFF000@VI1PR07MB5197.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(189003)(199004)(66476007)(2616005)(956004)(66946007)(66556008)(16576012)(316002)(4326008)(2906002)(8676002)(81156014)(81166006)(52116002)(5660300002)(8936002)(31686004)(478600001)(36756003)(186003)(26005)(16526019)(86362001)(31696002)(107886003)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB5197;H:VI1PR07MB6048.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lqQ39qmUffLJKi6j4CrdxFut9VUdetBj47IxdD4aEl3QnJvtX8bGjkpuNwxuA0TZTXW1pGbN7FFrJZMtr3iVtddlEh3J3Til5a34twXVGc/z/ONZByqqWT7FBrYFAcBIs5/CZkeogckIOS/ToCvjiH98rMWbI6Yd9SbJQaAaP9HgNj52YDbT2WpJxsJGcLbL48S52mY6AFboBFePqxsCtgKM/5tu2rLOxx0hIZiTYTkIaEvRX/YKVfsfPLbutA6nsLcZyb9kgnQgu8g4gXx2PPGBfH8gB96WbLFQ+9C7UuG3lrD2y+v0rgpRLkvLd6EO7JZT0esj9DXrIfiFxDkzusEfMV6oARPPLN4hSD3G5cEVtrSCqMo04Az88h8TmmSClL3DW/ETSdHVFwoi9FMRSoaSAISZvVaMZH27HnqKmLHtdROSosN3ENZc+iau7DV3
X-MS-Exchange-AntiSpam-MessageData: tFYwpiIcTyzAK9+Nf28gJzx4nfbcnaZgmKjHUhIeWhqVsEgdu0JskgQ/+zfonv9c2FmsZEOpR4trECvjq/BD7noCDiOUvruTxrPJ+/8o3FIWaKsGEk21FFvzvu16DsxLhaFgCriLEcfdwhs/N8aK3Q==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 411d24bf-a170-4c66-2fd7-08d7a87581ed
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 06:51:34.2278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kRXjRJP3Z6aOhNi4DQdKzRSVH3r0XwCYf08zcYlU7Ufo9KiI34hpbRKltxXaGCmThKqg6dzo1CqNuQ8IpOn+PhAXYolCHqgHeBVaMSP3P0vN+SEz6SmxOqn8aBfUnHyy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB5197
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu hotplug may be disabled via cpu_hotplug_enable/cpu_hotplug_disable.
When disabled, cpu_down and cpu_up will fail with -EBUSY. Users of the
cpu_up/cpu_down should handle this situation as this is mostly temporal
disablement and exception should be made for EBUSY, assuming that EBUSY
always stands for this situation and is worth repeating execution. This
kind of handling isn't implemented within kernel space users of cpu_up,
cpu_down, while for user space at least implementation within rt-tools
doesn't deal with it.

Instead of creating exceptions for users, this problem should be dealt
at source. One could claim that EBUSY justifies such exception, however
when possible we should create as simple as possible interfaces which
do not fail in case of resource being held.

Heavier user of cpu_hotplug_enable/disable is pci_device_probe yielding
errors on bringing cpu cores up/down if pci devices are getting probed.
Situation in which pci devices are getting probed and having cpus going
down/up is valid situation.

Problem was observed on x86 board by having partitioning of the system
to RT/NRT cpu sets failing (of which part is to bring cpus down/up via
sysfs) if pci devices would be getting probed at the same time. This is
confusing for userspace as dependency to pci devices is not clear.

Fix this behavior by waiting for cpu hotplug to be ready. Return -EBUSY
only after hotplugging was not enabled for about 10 seconds.

Fixes: 1ddd45f8d76f ("PCI: Use cpu_hotplug_disable() instead of get_online_cpus()")
Signed-off-by: Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
  kernel/cpu.c | 50 ++++++++++++++++++++++++++++++++++++++++----------
  1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 9c706af..6ff3c1a 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -31,6 +31,7 @@
  #include <linux/relay.h>
  #include <linux/slab.h>
  #include <linux/percpu-rwsem.h>
+#include <linux/wait.h>
  
  #include <trace/events/power.h>
  #define CREATE_TRACE_POINTS
@@ -278,11 +279,22 @@ void cpu_maps_update_done(void)
  }
  
  /*
- * If set, cpu_up and cpu_down will return -EBUSY and do nothing.
+ * If set, cpu_up and cpu_down will retry for cpu_hotplug_retries and
+ * eventually return -EBUSY if unsuccessful.
   * Should always be manipulated under cpu_add_remove_lock
   */
  static int cpu_hotplug_disabled;
  
+/*
+ * waitqueue for waiting on cpu_hotplug_disabled
+ */
+static DECLARE_WAIT_QUEUE_HEAD(wait_cpu_hp_enabled);
+
+/*
+ * Retries for cpu_hotplug to be enabled by cpu_up/cpu_down.
+ */
+static int cpu_hotplug_retries = 10;
+
  #ifdef CONFIG_HOTPLUG_CPU
  
  DEFINE_STATIC_PERCPU_RWSEM(cpu_hotplug_lock);
@@ -341,7 +353,7 @@ static void lockdep_release_cpus_lock(void)
  
  /*
   * Wait for currently running CPU hotplug operations to complete (if any) and
- * disable future CPU hotplug (from sysfs). The 'cpu_add_remove_lock' protects
+ * briefly disable CPU hotplug (from sysfs). The 'cpu_add_remove_lock' protects
   * the 'cpu_hotplug_disabled' flag. The same lock is also acquired by the
   * hotplug path before performing hotplug operations. So acquiring that lock
   * guarantees mutual exclusion from any currently running hotplug operations.
@@ -366,6 +378,7 @@ void cpu_hotplug_enable(void)
  	cpu_maps_update_begin();
  	__cpu_hotplug_enable();
  	cpu_maps_update_done();
+	wake_up(&wait_cpu_hp_enabled);
  }
  EXPORT_SYMBOL_GPL(cpu_hotplug_enable);
  
@@ -1043,11 +1056,21 @@ static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
  
  static int do_cpu_down(unsigned int cpu, enum cpuhp_state target)
  {
-	int err;
+	int err = -EBUSY, retries = cpu_hotplug_retries;
  
-	cpu_maps_update_begin();
-	err = cpu_down_maps_locked(cpu, target);
-	cpu_maps_update_done();
+	while (retries--) {
+		wait_event_timeout(wait_cpu_hp_enabled,
+				!cpu_hotplug_disabled,
+				HZ);
+		cpu_maps_update_begin();
+		if (cpu_hotplug_disabled) {
+			cpu_maps_update_done();
+			continue;
+		}
+		err = _cpu_down(cpu, 0, target);
+		cpu_maps_update_done();
+		break;
+	}
  	return err;
  }
  
@@ -1171,7 +1194,7 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
  
  static int do_cpu_up(unsigned int cpu, enum cpuhp_state target)
  {
-	int err = 0;
+	int err = 0, retries = cpu_hotplug_retries;
  
  	if (!cpu_possible(cpu)) {
  		pr_err("can't online cpu %d because it is not configured as may-hotadd at boot time\n",
@@ -1186,9 +1209,16 @@ static int do_cpu_up(unsigned int cpu, enum cpuhp_state target)
  	if (err)
  		return err;
  
-	cpu_maps_update_begin();
-
-	if (cpu_hotplug_disabled) {
+	while (--retries) {
+		wait_event_timeout(wait_cpu_hp_enabled,
+				   !cpu_hotplug_disabled,
+				   HZ);
+		cpu_maps_update_begin();
+		if (!cpu_hotplug_disabled)
+			break;
+		cpu_maps_update_done();
+	}
+	if (!retries) {
  		err = -EBUSY;
  		goto out;
  	}
-- 
2.10.2

