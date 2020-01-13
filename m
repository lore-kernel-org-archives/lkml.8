Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6342CC33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 22:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39669207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 22:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I1OQAp6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgAMWwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 17:52:53 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38138 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728986AbgAMWwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 17:52:53 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DMnAUm020570;
        Mon, 13 Jan 2020 22:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=XRyrRpiArmfGZDdTSM1qurigf4c1+HwEG68J/F/iDCs=;
 b=I1OQAp6UApGuFSzI/nOR9eQa4whDMZPmMSMyJe5WPSP5DklSmPhyTws8LO0AHD1qIWMa
 R7ZE42R2/y64F2SfkRHq4m3sMGTbtH0DMSBtxjYzFGs7qf82XkVenEsFAfI6yPhpo19d
 rwBpdOV/Z0ijUwV9bmyJ5IcPkG6BmefQgZPIgJhZ2DUV9ooQnOi5yFBRNZUrGAyoVPQq
 E6mlWieL7j/Gi/kxdmwHvfEUU1yI5Ykzrf1cfZYEIoEwpjrSCAsVHBE0QIAkW6WJS8xY
 wyEUyekZ6HcBv825sHlH9BtSRe/DIcaAf38MfNHSg64vAnC0zjE/fy1bbf58HGKZxGAR vQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2xf74s23r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 22:52:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DMnexk064633;
        Mon, 13 Jan 2020 22:52:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2xfqvtr59x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 22:52:48 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00DMqmAS029497;
        Mon, 13 Jan 2020 22:52:48 GMT
Received: from localhost.localdomain (/98.229.125.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jan 2020 14:52:47 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] workqueue: remove workqueue_work event class
Date:   Mon, 13 Jan 2020 17:52:40 -0500
Message-Id: <20200113225240.116671-2-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200113225240.116671-1-daniel.m.jordan@oracle.com>
References: <20200113225240.116671-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001130185
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001130185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The trace event class workqueue_work now has only one consumer, so get
rid of it.  No functional change.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org
---
 include/trace/events/workqueue.h | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/include/trace/events/workqueue.h b/include/trace/events/workqueue.h
index bdfc53e7f82f..9b8ae961acc5 100644
--- a/include/trace/events/workqueue.h
+++ b/include/trace/events/workqueue.h
@@ -8,23 +8,6 @@
 #include <linux/tracepoint.h>
 #include <linux/workqueue.h>
 
-DECLARE_EVENT_CLASS(workqueue_work,
-
-	TP_PROTO(struct work_struct *work),
-
-	TP_ARGS(work),
-
-	TP_STRUCT__entry(
-		__field( void *,	work	)
-	),
-
-	TP_fast_assign(
-		__entry->work		= work;
-	),
-
-	TP_printk("work struct %p", __entry->work)
-);
-
 struct pool_workqueue;
 
 /**
@@ -73,11 +56,21 @@ TRACE_EVENT(workqueue_queue_work,
  * which happens immediately after queueing unless @max_active limit
  * is reached.
  */
-DEFINE_EVENT(workqueue_work, workqueue_activate_work,
+TRACE_EVENT(workqueue_activate_work,
 
 	TP_PROTO(struct work_struct *work),
 
-	TP_ARGS(work)
+	TP_ARGS(work),
+
+	TP_STRUCT__entry(
+		__field( void *,	work	)
+	),
+
+	TP_fast_assign(
+		__entry->work		= work;
+	),
+
+	TP_printk("work struct %p", __entry->work)
 );
 
 /**
-- 
2.24.1

