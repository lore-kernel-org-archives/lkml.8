Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C7BC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 08:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF732075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 08:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="l62nWnCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgAXITB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 03:19:01 -0500
Received: from mail-eopbgr10118.outbound.protection.outlook.com ([40.107.1.118]:62707
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726080AbgAXITA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 03:19:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjJQyaxXMZZcsr9p3ZT3wy16uIbbqQ09VCKY7IGfJl2kZOxaBhWUvodV+oRyEkquO7ukYUYmbXJBatpkjcHKF4ia+jUPWXSxLesG/ipCKn2bACG0nZFmBy2ZiGN49xjTm89DJ4BDL0kBIi2XK8bKiP+lQGs3DeOyrt/Ea4FAgV2wg1NyNN24dCvZNH63ZhzsVa9f2pgZotoUOJ0nBYeFkrmfpENwUr28g+Ndd+MLWLAVbAXmBwRB8YTl+Jpyowoauta+YbWOdfLIWute5XHC7KMZpkvRpIpL5WL8jrrLa376giIuaL5uYMQqQnbsV8Bm/4WTZrE+g3Lb+7aEtyR3kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOBp8u+qlkhxYYvTwitQpyoWBWD1dEmTg9On/ut+cIQ=;
 b=GzyGbfTyzkwsRfAzbHef23tTLEFrNK00ppU/tZxFI3zVpkPBWkuYMnMx8dFVEEEkivEixxIL+x2wTwz++S2D9KEz1s2x8dznVn6SGiri2WVqIMD21rquvRo+5eTiO/EYiR6ZfhWTNzVxzJ1X+kMNr5j3j6GacnQ/5AS26hjFKZmpw9wcq7FDT5m/mrPeaqQr00RXabbY8JAJEhGrIFrJUVTNzvodaztKhrby+qF+xX/Bya4NT+8bafc3WBgCxUHQ3UPYib31TEnEgyYMGF44R8IKNPgVxY8cqhkp+eBLShJeln0GxldlO6KUQ4u4Ullx9wNoJl194niUEUsH32nO3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOBp8u+qlkhxYYvTwitQpyoWBWD1dEmTg9On/ut+cIQ=;
 b=l62nWnClrywcsDM3G6WT/jFCy9bDeSpaRccrS/Wsp0tznj+tcQEeGouhwRleJpN8KT7vJURag4fM4W9/9SWlUk5jpS0qy+phDDtw954C/IUtHTAUFvvWLLrfA/+B6cHGNA+DEeykkCTDK8evIcjVHZN65IVNidPl0wwgmbX10No=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=matija.glavinic-pecotic.ext@nokia.com; 
Received: from VI1PR07MB6048.eurprd07.prod.outlook.com (20.178.123.204) by
 VI1PR07MB5678.eurprd07.prod.outlook.com (20.178.120.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.14; Fri, 24 Jan 2020 08:18:56 +0000
Received: from VI1PR07MB6048.eurprd07.prod.outlook.com
 ([fe80::dd1:76b6:26ca:e2e8]) by VI1PR07MB6048.eurprd07.prod.outlook.com
 ([fe80::dd1:76b6:26ca:e2e8%6]) with mapi id 15.20.2665.017; Fri, 24 Jan 2020
 08:18:56 +0000
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
From:   Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
Subject: [PATCH] cpu/hotplug: Wait for cpu_hotplug to be enabled in
 cpu_up/down
Message-ID: <9bf397db-0eb8-ac30-b0ff-f8970d8b21be@nokia.com>
Date:   Fri, 24 Jan 2020 09:18:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0402CA0001.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::11) To VI1PR07MB6048.eurprd07.prod.outlook.com
 (2603:10a6:803:d7::12)
MIME-Version: 1.0
Received: from [172.30.9.6] (131.228.32.166) by HE1PR0402CA0001.eurprd04.prod.outlook.com (2603:10a6:3:d0::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.20.2665.20 via Frontend Transport; Fri, 24 Jan 2020 08:18:55 +0000
X-Originating-IP: [131.228.32.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b665dbdf-34e4-4f4f-f220-08d7a0a60e71
X-MS-TrafficTypeDiagnostic: VI1PR07MB5678:
X-Microsoft-Antispam-PRVS: <VI1PR07MB5678D8E2E4C35A18A93DBB31FF0E0@VI1PR07MB5678.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 02929ECF07
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(189003)(199004)(81166006)(8676002)(81156014)(31696002)(36756003)(86362001)(8936002)(478600001)(66946007)(6486002)(52116002)(66556008)(16576012)(66476007)(316002)(2616005)(2906002)(16526019)(5660300002)(956004)(26005)(6666004)(186003)(31686004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB5678;H:VI1PR07MB6048.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y89q6N3BT2ylZRywrQnCr9TSvk4E9htNO8e3HTXMxbZA1xr0f2t8Vn8/Kqo5p0ExQYhMomDQeDM2L4vw+2MlYaHs8m66j7Omg5QPxjHftAOpSR9chWcTtNE3HmmvWWt4Nc87xx7f1iMc5LErnORG8nm6L4up9NqN4mXKl8CuY+RLUbkWj8wk2wSh+32Nocr4+xNLmi8THiVZp8jHroeU+gsN36wE2pwQTEuYX4cQWs6BhFJF2AkSXA95DtuEqKjO3HmvAN2RhdYlE4AaQfegl3T6sCj5yHiscjEUv8Bj+yKUxGFYdUCmLYR/HlVu8LAY5AtgbVqQrIHPhhzkVjNzibXwWYNV/WZtkbFFAmPIl+NbMzUe1hvjE3GXegYe9ytkPhiGnQsexpclaoAkNAColT5XS8WAxeEip5QYF+WVdhuFRrptXk4bJ6lGuDrvlHY3
X-MS-Exchange-AntiSpam-MessageData: ACmlaSyt7ytvpy/rfN4gsXLkf8xmLgviDrYiSBBCmi+hF7bO7d+QnGnmXZVyefTPGGJPRYMHCpu+RYzjs6YOaoF2XR3vrlf9KDRFON2nw72ml3cYL2lJLwI2zbGN9X2dNKE9n4mf5DK2CdxsYlhd1A==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b665dbdf-34e4-4f4f-f220-08d7a0a60e71
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2020 08:18:56.4357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLaMT7AgzcSO6UN6Ho45xapO5ZfU8rQFAvjELwZslKegYlkfrqYj79I4b4ab/cWAJxOIT3m1hA+jEoAIHelZliFjQ18mAHeSHZnrDurJ8MqjTpt4zwb9/eKLRAKK4wVr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB5678
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu hotplug may be disabled via cpu_hotplug_enable/cpu_hotplug_disable.
When disabled, cpu_down and cpu_up will fail with -EBUSY. Users of the
cpu_up/cpu_down should handle this situation as this is mostly temporal
disablement and exception should be made for EBUSY, assuming that EBUSY
always stands for this situation and is worth repeating execution. One
of the users of cpu_hotplug_enable/disable is pci_device_probe yielding
errors on bringing cpu cores up/down if pci devices are getting probed.

Problem was observed on x86 board by having partitioning of the system
to RT/NRT cpu sets failing (of which part is to bring cpus down/up via
sysfs) if pci devices would be getting probed at the same time. This is
confusing for userspace as dependency to pci devices is not clear.

Fix this behavior by waiting for cpu hotplug to be ready. Return -EBUSY
only after hotplugging was not enabled for about 10 seconds.

Fixes: 1ddd45f8d76f ("PCI: Use cpu_hotplug_disable() instead of get_online_cpus()")
Signed-off-by: Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
---
  kernel/cpu.c | 50 ++++++++++++++++++++++++++++++++++++++++----------
  1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 4dc279e..2e06ca9 100644
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
  
@@ -1044,11 +1057,21 @@ static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
  
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
  
@@ -1166,7 +1189,7 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
  
  static int do_cpu_up(unsigned int cpu, enum cpuhp_state target)
  {
-	int err = 0;
+	int err = 0, retries = cpu_hotplug_retries;
  
  	if (!cpu_possible(cpu)) {
  		pr_err("can't online cpu %d because it is not configured as may-hotadd at boot time\n",
@@ -1181,9 +1204,16 @@ static int do_cpu_up(unsigned int cpu, enum cpuhp_state target)
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
