Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E4CC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60A382496B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gwz1VLQA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgEHPHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 11:07:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47948 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgEHPHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 11:07:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 048F7oj4126568;
        Fri, 8 May 2020 15:07:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=ygriZszAK7uOqyWhz842ZZT0KgYajtrTrd4tzNFIj/0=;
 b=Gwz1VLQALtvp35MtFeGpQufTqn1dft1N2tri/H7KDUgJpn+hO0jTDG0JBpAEIfEScZRR
 xsuqcFHBfV8Z4F6aJELnyplEfgY6BTM/I58RHGPiI4PBM6vd4+UmDv1/sGZzjzPYT2Mu
 JzO5W4gqfsJIyPbY52IWIWDa01L99Uwr0ph3IrvO5i1gEQPHnV0d60hrce3ZmOc7rkDS
 O5zKK7NxAQfItqJv6VJ43Avm/kK95h8rBNUp5FEbqUKGfs0EhSVF4unu/VWhynfSwkD0
 jwt5gdNBuNqQ3ToQsPqolj3qYOMlSTzWaOv89rQWjQE1l/5W2FueCWKUBYWe8GP3sBpR hQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 30vtexug38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 May 2020 15:07:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 048F6wb0129074;
        Fri, 8 May 2020 15:07:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 30vtdnrwck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 May 2020 15:07:47 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 048F7lxK016233;
        Fri, 8 May 2020 15:07:47 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 May 2020 08:07:46 -0700
Date:   Fri, 8 May 2020 18:07:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tejun Heo <tj@kernel.org>, Sean Fu <fxinrong@gmail.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] workqueue: Fix an use after free in init_rescuer()
Message-ID: <20200508150740.GA415175@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9614 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005080135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9614 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005080135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to preserve error code before freeing "rescuer".

Fixes: f187b6974f6df ("workqueue: Use IS_ERR and PTR_ERR instead of PTR_ERR_OR_ZERO.")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Another option would be to just revert the original commit.

 kernel/workqueue.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index ddf0537dce140..10ed8d761e0b7 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4197,6 +4197,7 @@ static int wq_clamp_max_active(int max_active, unsigned int flags,
 static int init_rescuer(struct workqueue_struct *wq)
 {
 	struct worker *rescuer;
+	int ret;
 
 	if (!(wq->flags & WQ_MEM_RECLAIM))
 		return 0;
@@ -4208,8 +4209,9 @@ static int init_rescuer(struct workqueue_struct *wq)
 	rescuer->rescue_wq = wq;
 	rescuer->task = kthread_create(rescuer_thread, rescuer, "%s", wq->name);
 	if (IS_ERR(rescuer->task)) {
+		ret = PTR_ERR(rescuer->task);
 		kfree(rescuer);
-		return PTR_ERR(rescuer->task);
+		return ret;
 	}
 
 	wq->rescuer = rescuer;
-- 
2.26.2

