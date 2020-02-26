Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808DFC4BA1E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEFB24656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="HUdoisoB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgBZR7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:59:03 -0500
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:51454 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726688AbgBZR7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:59:02 -0500
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
        by m0050102.ppops.net-00190b01. (8.16.0.42/8.16.0.42) with SMTP id 01QHkQHB025018;
        Wed, 26 Feb 2020 17:58:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : in-reply-to; s=jan2016.eng;
 bh=CqTeI+N/FsAZZ/HaOy0JtKxisJ8ZY2/x66qmnKEmcCI=;
 b=HUdoisoB/LgG6ACLBulQ8RwCO9Q3SLoBpaAiv8PdWw3lKH8J5JBYitvkyNx1SYkmfLIu
 umcuphPMNjp5WnH/o5jDS6D8gBBg5Hgt0Sv/CErB+QQAsAWCUo7lX8tYb+yO2WvFYIBr
 Ni0zu7Zu1bxGWNywW9xKXJX1qTtWZkTylsqvPn2bsovyoDMKWIWk3WF8jlE5ZcW9m2rH
 wOmRq+S1JOq0gyUMGiy1hMjqp0DkhYokc/MsnOIiRzZWBxt1IH/ElbSx76hFh/hbEdvc
 QJAf+QEO10nyVkid429Ni4mzI2KcsEFZw+yOSYgO/KVTHb8YqmvajKlFUhxWEKtorqbl 0g== 
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61] (may be forged))
        by m0050102.ppops.net-00190b01. with ESMTP id 2ydcp9bwjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Feb 2020 17:58:57 +0000
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
        by prod-mail-ppoint6.akamai.com (8.16.0.27/8.16.0.27) with SMTP id 01QHX8Ad008553;
        Wed, 26 Feb 2020 12:58:56 -0500
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
        by prod-mail-ppoint6.akamai.com with ESMTP id 2ydhutgeew-1;
        Wed, 26 Feb 2020 12:58:56 -0500
Received: from bos-lpjec.145bw.corp.akamai.com (bos-lpjec.145bw.corp.akamai.com [172.28.3.71])
        by prod-mail-relay10.akamai.com (Postfix) with ESMTP id 1501E32904;
        Wed, 26 Feb 2020 17:58:56 +0000 (GMT)
From:   Jason Baron <jbaron@akamai.com>
To:     akpm@linux-foundation.org
Cc:     dave@stgolabs.net, rpenyaev@suse.de, linux-kernel@vger.kernel.org,
        normalperson@yhbt.net, viro@zeniv.linux.org.uk
Subject: [PATCH v2] fs/epoll: make nesting accounting safe for -rt kernel
Date:   Wed, 26 Feb 2020 12:56:56 -0500
Message-Id: <1582739816-13167-1-git-send-email-jbaron@akamai.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20200224163835.08ab964483519052d7c2e39b@linux-foundation.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-02-26_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=855
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-2002050000 definitions=main-2002260115
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-26_06:2020-02-26,2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0 mlxlogscore=857
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=4 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Davidlohr Bueso pointed out that when CONFIG_DEBUG_LOCK_ALLOC is set
ep_poll_safewake() can take several non-raw spinlocks after disabling
interrupts. Since a spinlock can block in the -rt kernel, we can't take a
spinlock after disabling interrupts. So let's re-work how we determine
the nesting level such that it plays nicely with the -rt kernel.

Let's introduce a 'nests' field in struct eventpoll that records the
current nesting level during ep_poll_callback(). Then, if we nest again we
can find the previous struct eventpoll that we were called from and
increase our count by 1. The 'nests' field is protected by
ep->poll_wait.lock.

I've also moved the visited field to reduce the size of struct eventpoll
from 184 bytes to 176 bytes on x86_64 for !CONFIG_DEBUG_LOCK_ALLOC,
which is typical for a production config.

Reported-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Jason Baron <jbaron@akamai.com>
---
v2:
-improve (hopefully:)) comments and explanations around -rt requirements
 (Andrew Morton)


 fs/eventpoll.c | 64 +++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 21 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 67a39503..81ef47c 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -218,13 +218,18 @@ struct eventpoll {
 	struct file *file;
 
 	/* used to optimize loop detection check */
-	int visited;
 	struct list_head visited_list_link;
+	int visited;
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	/* used to track busy poll napi_id */
 	unsigned int napi_id;
 #endif
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	/* tracks wakeup nests for lockdep validation */
+	u8 nests;
+#endif
 };
 
 /* Wait structure used by the poll hooks */
@@ -551,30 +556,47 @@ static int ep_call_nested(struct nested_calls *ncalls,
  */
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
-static DEFINE_PER_CPU(int, wakeup_nest);
-
-static void ep_poll_safewake(wait_queue_head_t *wq)
+static void ep_poll_safewake(struct eventpoll *ep, struct epitem *epi)
 {
+	struct eventpoll *ep_src;
 	unsigned long flags;
-	int subclass;
+	u8 nests = 0;
 
-	local_irq_save(flags);
-	preempt_disable();
-	subclass = __this_cpu_read(wakeup_nest);
-	spin_lock_nested(&wq->lock, subclass + 1);
-	__this_cpu_inc(wakeup_nest);
-	wake_up_locked_poll(wq, POLLIN);
-	__this_cpu_dec(wakeup_nest);
-	spin_unlock(&wq->lock);
-	local_irq_restore(flags);
-	preempt_enable();
+	/*
+	 * To set the subclass or nesting level for spin_lock_irqsave_nested()
+	 * it might be natural to create a per-cpu nest count. However, since
+	 * we can recurse on ep->poll_wait.lock, and a non-raw spinlock can
+	 * schedule() in the -rt kernel, the per-cpu variable are no longer
+	 * protected. Thus, we are introducing a per eventpoll nest field.
+	 * If we are not being call from ep_poll_callback(), epi is NULL and
+	 * we are at the first level of nesting, 0. Otherwise, we are being
+	 * called from ep_poll_callback() and if a previous wakeup source is
+	 * not an epoll file itself, we are at depth 1 since the wakeup source
+	 * is depth 0. If the wakeup source is a previous epoll file in the
+	 * wakeup chain then we use its nests value and record ours as
+	 * nests + 1. The previous epoll file nests value is stable since its
+	 * already holding its own poll_wait.lock.
+	 */
+	if (epi) {
+		if ((is_file_epoll(epi->ffd.file))) {
+			ep_src = epi->ffd.file->private_data;
+			nests = ep_src->nests;
+		} else {
+			nests = 1;
+		}
+	}
+	spin_lock_irqsave_nested(&ep->poll_wait.lock, flags, nests);
+	ep->nests = nests + 1;
+	wake_up_locked_poll(&ep->poll_wait, EPOLLIN);
+	ep->nests = 0;
+	spin_unlock_irqrestore(&ep->poll_wait.lock, flags);
 }
 
 #else
 
-static void ep_poll_safewake(wait_queue_head_t *wq)
+static void ep_poll_safewake(struct eventpoll *ep, struct epitem *epi)
 {
-	wake_up_poll(wq, EPOLLIN);
+	wake_up_poll(&ep->poll_wait, EPOLLIN);
 }
 
 #endif
@@ -795,7 +817,7 @@ static void ep_free(struct eventpoll *ep)
 
 	/* We need to release all tasks waiting for these file */
 	if (waitqueue_active(&ep->poll_wait))
-		ep_poll_safewake(&ep->poll_wait);
+		ep_poll_safewake(ep, NULL);
 
 	/*
 	 * We need to lock this because we could be hit by
@@ -1264,7 +1286,7 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 
 	/* We have to call this outside the lock */
 	if (pwake)
-		ep_poll_safewake(&ep->poll_wait);
+		ep_poll_safewake(ep, epi);
 
 	if (!(epi->event.events & EPOLLEXCLUSIVE))
 		ewake = 1;
@@ -1568,7 +1590,7 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 
 	/* We have to call this outside the lock */
 	if (pwake)
-		ep_poll_safewake(&ep->poll_wait);
+		ep_poll_safewake(ep, NULL);
 
 	return 0;
 
@@ -1672,7 +1694,7 @@ static int ep_modify(struct eventpoll *ep, struct epitem *epi,
 
 	/* We have to call this outside the lock */
 	if (pwake)
-		ep_poll_safewake(&ep->poll_wait);
+		ep_poll_safewake(ep, NULL);
 
 	return 0;
 }
-- 
2.7.4

