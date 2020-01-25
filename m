Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64942C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 01:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A402075D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 01:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xo/QhzDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387627AbgAYBPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 20:15:03 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48992 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387405AbgAYBPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 20:15:02 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00P1EdNe195498;
        Sat, 25 Jan 2020 01:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=17knrJksP07qis7PEJyABHNMWewFGgVAI4x1jGUutC0=;
 b=Xo/QhzDfwD1G+Nmv3NBUbufAf5H9RZoT3rg7zH8uqywDwxNb+cP+GVN4eM8rfmNBChgz
 fdPUTDgSRrn5GbC2JnalpFDu0vYR/X6sQ1cvLaP7j4QT/V3laAXbHBlGlViIednzIxbI
 i2erBdMgOnJG2AT8PTXIOi1A83BjWwInOlKUr89i07mZwUsFNAQ95ewMPjnKN45rrb63
 dOSQl07sg1NJzeYkDPSfEW71mRU86tWWmy0pmT4hYnk9XOLs4usUe3iXE6kBfgS8dxD+
 3HFgzW4k1X+ORnmB/OLL859y1m3ZxbY/lky0qsbcmXxh2/aLQI7TTjcibnqokvz2TmY8 9w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2xksev4aaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Jan 2020 01:14:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00P1Dwlq086174;
        Sat, 25 Jan 2020 01:14:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2xratajvw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Jan 2020 01:14:54 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00P1Eq2K007309;
        Sat, 25 Jan 2020 01:14:52 GMT
Received: from localhost.localdomain (/98.229.125.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Jan 2020 17:14:52 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] workqueue: don't use wq_select_unbound_cpu() for bound works
Date:   Fri, 24 Jan 2020 20:14:45 -0500
Message-Id: <20200125011445.983252-1-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9510 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001250008
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9510 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001250008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hillf Danton <hdanton@sina.com>

wq_select_unbound_cpu() is designed for unbound workqueues only, but
it's wrongly called when using a bound workqueue too.

Fixing this ensures work queued to a bound workqueue with
cpu=WORK_CPU_UNBOUND always runs on the local CPU.

Before, that would happen only if wq_unbound_cpumask happened to include
it (likely almost always the case), or was empty, or we got lucky with
forced round-robin placement.  So restricting
/sys/devices/virtual/workqueue/cpumask to a small subset of a machine's
CPUs would cause some bound work items to run unexpectedly there.

Fixes: ef557180447f ("workqueue: schedule WORK_CPU_UNBOUND work on wq_unbound_cpumask CPUs")
Signed-off-by: Hillf Danton <hdanton@sina.com>
[dj: massage changelog]
Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org
---
 kernel/workqueue.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index cfc923558e04..6978892b0d8a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1411,14 +1411,16 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 		return;
 	rcu_read_lock();
 retry:
-	if (req_cpu == WORK_CPU_UNBOUND)
-		cpu = wq_select_unbound_cpu(raw_smp_processor_id());
-
 	/* pwq which will be used unless @work is executing elsewhere */
-	if (!(wq->flags & WQ_UNBOUND))
-		pwq = per_cpu_ptr(wq->cpu_pwqs, cpu);
-	else
+	if (wq->flags & WQ_UNBOUND) {
+		if (req_cpu == WORK_CPU_UNBOUND)
+			cpu = wq_select_unbound_cpu(raw_smp_processor_id());
 		pwq = unbound_pwq_by_node(wq, cpu_to_node(cpu));
+	} else {
+		if (req_cpu == WORK_CPU_UNBOUND)
+			cpu = raw_smp_processor_id();
+		pwq = per_cpu_ptr(wq->cpu_pwqs, cpu);
+	}
 
 	/*
 	 * If @work was previously on a different pool, it might still be
-- 
2.24.1

