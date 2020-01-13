Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4B6C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 22:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5B2207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 22:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U3tK/bta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgAMWwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 17:52:53 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38142 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbgAMWwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 17:52:53 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DMmDv3020106;
        Mon, 13 Jan 2020 22:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=yvB3s31LE8gCjb6DwYDy/tH4bEukxhOtXvizX8X9rTQ=;
 b=U3tK/btaClL7YMesFwtEFnM4ZXNyPCv+lWwEpa1w48fljaumueznaXy1vRpxW8J1xpdX
 8co9tKgiz4qSKiK1AILiKR1D2p7GCV5s26Xll7ivzZETiVeqaq/BuBsYNXd9ERlZ5xYm
 tgiMkMLtC2NZ4GtBpYPcXuVdKJfWMmf4BGbB8Bxe7snVUmnQn8KYACugy10UEPp+1PvQ
 de11EdHUkBa49xbm1IW50i0aFE7CmUNTeUyMWEc7IfqSzKaNUirTaWZg3CPyFNxO8SQI
 bgGW0+7eKRj3V4ECQtM3xpkFDOMHgRMTmqVvAXdH9lKpYPw/HAYlRAgwkuJSify/ap5D GA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2xf74s23r3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 22:52:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DMmvQ5176859;
        Mon, 13 Jan 2020 22:52:48 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2xfrh6u0ge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 22:52:48 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00DMqlFh025571;
        Mon, 13 Jan 2020 22:52:47 GMT
Received: from localhost.localdomain (/98.229.125.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jan 2020 14:52:47 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] workqueue: add worker function to workqueue_execute_end tracepoint
Date:   Mon, 13 Jan 2020 17:52:39 -0500
Message-Id: <20200113225240.116671-1-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001130185
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001130185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's surprising that workqueue_execute_end includes only the work when
its counterpart workqueue_execute_start has both the work and the worker
function.

You can't set a tracing filter or trigger based on the function, and
postprocessing scripts interested in specific functions are harder to
write since they have to remember the work from _start and match it up
with the same field in _end.

Add the function name, taking care to use the copy stashed in the
worker since the work is no longer safe to touch.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org
---
 include/trace/events/workqueue.h | 19 ++++++++++++++++---
 kernel/workqueue.c               |  2 +-
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/workqueue.h b/include/trace/events/workqueue.h
index e172549283be..bdfc53e7f82f 100644
--- a/include/trace/events/workqueue.h
+++ b/include/trace/events/workqueue.h
@@ -108,14 +108,27 @@ TRACE_EVENT(workqueue_execute_start,
 /**
  * workqueue_execute_end - called immediately after the workqueue callback
  * @work:	pointer to struct work_struct
+ * @function:   pointer to worker function
  *
  * Allows to track workqueue execution.
  */
-DEFINE_EVENT(workqueue_work, workqueue_execute_end,
+TRACE_EVENT(workqueue_execute_end,
 
-	TP_PROTO(struct work_struct *work),
+	TP_PROTO(struct work_struct *work, work_func_t function),
 
-	TP_ARGS(work)
+	TP_ARGS(work, function),
+
+	TP_STRUCT__entry(
+		__field( void *,	work	)
+		__field( void *,	function)
+	),
+
+	TP_fast_assign(
+		__entry->work		= work;
+		__entry->function	= function;
+	),
+
+	TP_printk("work struct %p: function %ps", __entry->work, __entry->function)
 );
 
 #endif /*  _TRACE_WORKQUEUE_H */
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index cfc923558e04..4bdfa270a37b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2266,7 +2266,7 @@ __acquires(&pool->lock)
 	 * While we must be careful to not use "work" after this, the trace
 	 * point will only record its address.
 	 */
-	trace_workqueue_execute_end(work);
+	trace_workqueue_execute_end(work, worker->current_func);
 	lock_map_release(&lockdep_map);
 	lock_map_release(&pwq->wq->lockdep_map);
 
-- 
2.24.1

