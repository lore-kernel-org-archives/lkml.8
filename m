Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CE2C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 19:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0B02072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 19:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="Q3IeAtBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbgAQTWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 14:22:06 -0500
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:12798 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727573AbgAQTWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 14:22:06 -0500
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
        by m0050102.ppops.net-00190b01. (8.16.0.42/8.16.0.42) with SMTP id 00HJG5Cq008328;
        Fri, 17 Jan 2020 19:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : in-reply-to; s=jan2016.eng;
 bh=Iq+eB5iBTUn1nohyURD4CmxGTPSkwp/dNMxfYRNHM7Y=;
 b=Q3IeAtBRHslwAc1Y70/j8srIz78y3iieMEOCO1PPlp4r6JGaDWOLKM72kEygy1xH2+2c
 ptmhrwiksaYwqBuXSCSoIDqUGHLjIkaZ2CToo2MuUZ0whBYk9MCuEL3cNt5/omm16ACQ
 iSNE2vqCAJvXaxaVYl6qLrIEHFnWWXZWfiNKmnbkIkkHDnYoHgW14z5qJKG7W0jBI2Dt
 7Lj8K5kDzUGmsPgxErWkSM0hC1NYU16aUSWvbst871rgZEm/OiLalqYCuwGELGwKapo9
 WESyYaw1F4AJKq/D8UKQKnlqSG2gxpELW9pYlRRkvat8DSIBChZ/VRveJy+cPhemMjXv Eg== 
Received: from prod-mail-ppoint7 (prod-mail-ppoint7.akamai.com [96.6.114.121] (may be forged))
        by m0050102.ppops.net-00190b01. with ESMTP id 2xhptukt71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jan 2020 19:22:01 +0000
Received: from pps.filterd (prod-mail-ppoint7.akamai.com [127.0.0.1])
        by prod-mail-ppoint7.akamai.com (8.16.0.27/8.16.0.27) with SMTP id 00HJIRZN019939;
        Fri, 17 Jan 2020 14:22:00 -0500
Received: from prod-mail-relay15.akamai.com ([172.27.17.40])
        by prod-mail-ppoint7.akamai.com with ESMTP id 2xfak6ebc0-1;
        Fri, 17 Jan 2020 14:22:00 -0500
Received: from bos-lpjec.145bw.corp.akamai.com (bos-lpjec.145bw.corp.akamai.com [172.28.3.71])
        by prod-mail-relay15.akamai.com (Postfix) with ESMTP id ACD7921595;
        Fri, 17 Jan 2020 19:21:59 +0000 (GMT)
From:   Jason Baron <jbaron@akamai.com>
To:     dave@stgolabs.net
Cc:     rpenyaev@suse.de, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, normalperson@yhbt.net,
        viro@zeniv.linux.org.uk
Subject: [PATCH] fs/epoll: make nesting accounting safe for -rt kernel
Date:   Fri, 17 Jan 2020 14:16:47 -0500
Message-Id: <1579288607-11868-1-git-send-email-jbaron@akamai.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20200106210104.4hqlgpujqujcbeg7@linux-p48b>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-01-17_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=759
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001170148
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_05:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 clxscore=1015
 mlxlogscore=768 suspectscore=4 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001170147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Davidlohr Bueso pointed out that when CONFIG_DEBUG_LOCK_ALLOC is set
ep_poll_safewake() can take several non-raw spinlocks after disabling
pre-emption which is no no for the -rt kernel. So let's re-work how we
determine the nesting level such that it plays nicely with -rt kernel.

Let's introduce a 'nests' field in struct eventpoll that records the
current nesting level during ep_poll_callback(). Then, if we nest again we
can find the previous struct eventpoll that we were called from and
increase our count by 1. The 'nests' field is protected by
ep->poll_wait.lock.

I've also moved napi_id field into a hole in struct eventpoll as part of
introduing the nests field. This change reduces the struct eventpoll from
184 bytes to 176 bytes on x86_64 for the !CONFIG_DEBUG_LOCK_ALLOC
production config.

Reported-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Jason Baron <jbaron@akamai.com>
---
 fs/eventpoll.c | 61 ++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 67a39503..8ee356c 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -219,12 +219,18 @@ struct eventpoll {
 
 	/* used to optimize loop detection check */
 	int visited;
-	struct list_head visited_list_link;
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	/* used to track busy poll napi_id */
 	unsigned int napi_id;
 #endif
+
+	struct list_head visited_list_link;
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	/* used to track wakeup nests for lockdep validation */
+	u8 nests;
+#endif
 };
 
 /* Wait structure used by the poll hooks */
@@ -551,30 +557,43 @@ static int ep_call_nested(struct nested_calls *ncalls,
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
+	 * If we are not being call from ep_poll_callback(), epi is
+	 * NULL and we are at the first level of nesting, 0. Otherwise,
+	 * we are being called from ep_poll_callback() and if a previous
+	 * wakeup source is not an epoll file itself, we are at depth
+	 * 1 since the wakeup source is depth 0. If the wakeup source
+	 * is a previous epoll file in the wakeup chain then we use its
+	 * nests value and record ours as nests + 1. The previous epoll
+	 * file nests value is stable since its already holding its
+	 * own poll_wait.lock.
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
@@ -795,7 +814,7 @@ static void ep_free(struct eventpoll *ep)
 
 	/* We need to release all tasks waiting for these file */
 	if (waitqueue_active(&ep->poll_wait))
-		ep_poll_safewake(&ep->poll_wait);
+		ep_poll_safewake(ep, NULL);
 
 	/*
 	 * We need to lock this because we could be hit by
@@ -1264,7 +1283,7 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 
 	/* We have to call this outside the lock */
 	if (pwake)
-		ep_poll_safewake(&ep->poll_wait);
+		ep_poll_safewake(ep, epi);
 
 	if (!(epi->event.events & EPOLLEXCLUSIVE))
 		ewake = 1;
@@ -1568,7 +1587,7 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 
 	/* We have to call this outside the lock */
 	if (pwake)
-		ep_poll_safewake(&ep->poll_wait);
+		ep_poll_safewake(ep, NULL);
 
 	return 0;
 
@@ -1672,7 +1691,7 @@ static int ep_modify(struct eventpoll *ep, struct epitem *epi,
 
 	/* We have to call this outside the lock */
 	if (pwake)
-		ep_poll_safewake(&ep->poll_wait);
+		ep_poll_safewake(ep, NULL);
 
 	return 0;
 }
-- 
2.7.4

