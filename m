Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BD2C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19A232075A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGuXdQ9F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732856AbgG1TfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:35:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54311 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729692AbgG1TfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595964903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Br7/A7r7O/BBqV20yEIjHXgSIEykQhhlwX7UDRO05bM=;
        b=UGuXdQ9F+d284IQtYYT7AhkWe98TZfs7GtyghiqOX7Ph8reHPohLvwp6m/+FnWKjy4zFls
        BB7e7Umhe0AqWIemitXCtUSMQl+MIVFvoxrkDBD6GBUQEtj4esaIIYTYmaYFgOw3RACDLl
        HRYSIc3BnbXTTu5XfIj2JUb62hrHMaU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-5hPR5CeFOPOr7fpLY-xehw-1; Tue, 28 Jul 2020 15:34:55 -0400
X-MC-Unique: 5hPR5CeFOPOr7fpLY-xehw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24222800460;
        Tue, 28 Jul 2020 19:34:53 +0000 (UTC)
Received: from llong.remote.csb (ovpn-119-38.rdu2.redhat.com [10.10.119.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2836171900;
        Tue, 28 Jul 2020 19:34:51 +0000 (UTC)
Subject: Re: [PATCH v10 5/5] locking/qspinlock: Avoid moving certain threads
 between waiting queues in CNA
To:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
References: <20200403205930.1707-1-alex.kogan@oracle.com>
 <20200403205930.1707-6-alex.kogan@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <8e5f70e7-1f93-7135-2b65-8355f5c93237@redhat.com>
Date:   Tue, 28 Jul 2020 15:34:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200403205930.1707-6-alex.kogan@oracle.com>
Content-Type: multipart/mixed;
 boundary="------------E1866B38CD0464E8AECD0ADC"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E1866B38CD0464E8AECD0ADC
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/20 4:59 PM, Alex Kogan wrote:
> Prohibit moving certain threads (e.g., in irq and nmi contexts)
> to the secondary queue. Those prioritized threads will always stay
> in the primary queue, and so will have a shorter wait time for the lock.
>
> Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/locking/qspinlock_cna.h | 30 ++++++++++++++++++++++++++----
>   1 file changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
> index e3180f6f5cdc..b004ce6882b6 100644
> --- a/kernel/locking/qspinlock_cna.h
> +++ b/kernel/locking/qspinlock_cna.h
> @@ -4,6 +4,7 @@
>   #endif
>   
>   #include <linux/topology.h>
> +#include <linux/sched/rt.h>
>   
>   /*
>    * Implement a NUMA-aware version of MCS (aka CNA, or compact NUMA-aware lock).
> @@ -41,6 +42,9 @@
>    * lock is passed to the next thread in the primary queue. To avoid starvation
>    * of threads in the secondary queue, those threads are moved back to the head
>    * of the primary queue after a certain number of intra-node lock hand-offs.
> + * Lastly, certain threads (e.g., in irq and nmi contexts) are given
> + * preferential treatment -- the scan stops when such a thread is found,
> + * effectively never moving those threads into the secondary queue.
>    *
>    * For more details, see https://arxiv.org/abs/1810.05600.
>    *
> @@ -50,7 +54,7 @@
>   
>   struct cna_node {
>   	struct mcs_spinlock	mcs;
> -	int			numa_node;
> +	int			numa_node;	/* use LSB for priority */
>   	u32			encoded_tail;	/* self */
>   	u32			partial_order;	/* encoded tail or enum val */
>   	u32			intra_count;
> @@ -79,7 +83,7 @@ static void __init cna_init_nodes_per_cpu(unsigned int cpu)
>   	for (i = 0; i < MAX_NODES; i++) {
>   		struct cna_node *cn = (struct cna_node *)grab_mcs_node(base, i);
>   
> -		cn->numa_node = numa_node;
> +		cn->numa_node = numa_node << 1;
>   		cn->encoded_tail = encode_tail(cpu, i);
>   		/*
>   		 * make sure @encoded_tail is not confused with other valid
> @@ -110,6 +114,14 @@ static int __init cna_init_nodes(void)
>   
>   static __always_inline void cna_init_node(struct mcs_spinlock *node)
>   {
> +	/*
> +	 * Set the priority bit in @numa_node for threads that should not
> +	 * be moved to the secondary queue.
> +	 */
> +	bool priority = !in_task() || irqs_disabled() || rt_task(current);
> +	((struct cna_node *)node)->numa_node =
> +		(((struct cna_node *)node)->numa_node & ~1) | priority;
> +
>   	((struct cna_node *)node)->intra_count = 0;
>   }
>   
> @@ -243,12 +255,16 @@ static u32 cna_order_queue(struct mcs_spinlock *node,
>   {
>   	struct cna_node *cni = (struct cna_node *)READ_ONCE(iter->next);
>   	struct cna_node *cn = (struct cna_node *)node;
> -	int nid = cn->numa_node;
> +	int nid = cn->numa_node >> 1;
>   	struct cna_node *last;
>   
>   	/* find any next waiter on 'our' NUMA node */
>   	for (last = cn;
> -	     cni && cni->numa_node != nid;
> +		 /*
> +		  * iterate as long as the current node is not priorizied and
> +		  * does not run on 'our' NUMA node
> +		  */
> +	     cni && !(cni->numa_node & 0x1) && (cni->numa_node >> 1) != nid;
>   	     last = cni, cni = (struct cna_node *)READ_ONCE(cni->mcs.next))
>   		;
>   
> @@ -258,6 +274,12 @@ static u32 cna_order_queue(struct mcs_spinlock *node,
>   	if (last != cn)	/* did we skip any waiters? */
>   		cna_splice_tail(node, node->next, (struct mcs_spinlock *)last);
>   
> +	/*
> +	 * We return LOCAL_WAITER_FOUND here even if we stopped the scan because
> +	 * of a prioritized waiter. That waiter will get the lock next even if
> +	 * it runs on a different NUMA node, but this is what we wanted when we
> +	 * prioritized it.
> +	 */
>   	return LOCAL_WAITER_FOUND;
>   }
>   

Sorry for the late review as I was swamped with other tasks earlier.

It is good to have a patch to handle lock waiters that shouldn't be 
delayed, the current way of using bit 0 of numa_node to indicate that is 
kind of hackery. Also it may not be a good idea to change the current 
node id like that. I have a patch (attached) that can handle these 
issues. What do you think about it?

Cheers,
Longman



--------------E1866B38CD0464E8AECD0ADC
Content-Type: text/x-patch; charset=UTF-8;
 name="0006-locking-qspinlock-Make-CNA-priority-node-inherit-pri.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0006-locking-qspinlock-Make-CNA-priority-node-inherit-pri.pa";
 filename*1="tch"

From d21eae6d7b125253dd57c034b0a648bb11acc472 Mon Sep 17 00:00:00 2001
From: Waiman Long <longman@redhat.com>
Date: Tue, 28 Jul 2020 12:07:54 -0400
Subject: [PATCH 6/9] locking/qspinlock: Make CNA priority node inherit primary
 queue node ID

When a lock waiter is not in a task context, has irq disabled or is a
RT task. It is considered at a higher priority and so will not be thrown
into the secondary queue to suffer additional lock acquisition latency.
However, if its node id is different from the primary queue node id,
we will have the situation that the primary queue node id is changed
mid-stream and the secondary queue may have nodes with the new node id
causing them to suffer undue delay.

One way to avoid this situation is to make the priority node inherit
the node id of the primary queue. That will require two numa node
fields in the CNA node - one for real numa node id and the other for
current numa node id. Since 16 bits are more than enough for node id,
we can split the current 32-bit field into two 16-bit ones without
affecting the structure size.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/qspinlock_cna.h | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
index b004ce6882b6..911c96279494 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -52,9 +52,12 @@
  *          Dave Dice <dave.dice@oracle.com>
  */
 
+#define CNA_PRIORITY_NODE	0xffff
+
 struct cna_node {
 	struct mcs_spinlock	mcs;
-	int			numa_node;	/* use LSB for priority */
+	u16			numa_node;
+	u16			real_numa_node;
 	u32			encoded_tail;	/* self */
 	u32			partial_order;	/* encoded tail or enum val */
 	u32			intra_count;
@@ -83,7 +86,7 @@ static void __init cna_init_nodes_per_cpu(unsigned int cpu)
 	for (i = 0; i < MAX_NODES; i++) {
 		struct cna_node *cn = (struct cna_node *)grab_mcs_node(base, i);
 
-		cn->numa_node = numa_node << 1;
+		cn->real_numa_node = numa_node;
 		cn->encoded_tail = encode_tail(cpu, i);
 		/*
 		 * make sure @encoded_tail is not confused with other valid
@@ -119,10 +122,10 @@ static __always_inline void cna_init_node(struct mcs_spinlock *node)
 	 * be moved to the secondary queue.
 	 */
 	bool priority = !in_task() || irqs_disabled() || rt_task(current);
-	((struct cna_node *)node)->numa_node =
-		(((struct cna_node *)node)->numa_node & ~1) | priority;
+	struct cna_node *cn = (struct cna_node *)node;
 
-	((struct cna_node *)node)->intra_count = 0;
+	cn->numa_node = priority ? CNA_PRIORITY_NODE : cn->real_numa_node;
+	cn->intra_count = 0;
 }
 
 /*
@@ -255,7 +258,7 @@ static u32 cna_order_queue(struct mcs_spinlock *node,
 {
 	struct cna_node *cni = (struct cna_node *)READ_ONCE(iter->next);
 	struct cna_node *cn = (struct cna_node *)node;
-	int nid = cn->numa_node >> 1;
+	int nid = cn->numa_node;
 	struct cna_node *last;
 
 	/* find any next waiter on 'our' NUMA node */
@@ -264,13 +267,16 @@ static u32 cna_order_queue(struct mcs_spinlock *node,
 		  * iterate as long as the current node is not priorizied and
 		  * does not run on 'our' NUMA node
 		  */
-	     cni && !(cni->numa_node & 0x1) && (cni->numa_node >> 1) != nid;
+	     cni && cni->numa_node != CNA_PRIORITY_NODE && cni->numa_node != nid;
 	     last = cni, cni = (struct cna_node *)READ_ONCE(cni->mcs.next))
 		;
 
 	if (!cni)
 		return last->encoded_tail; /* continue from here */
 
+	if (cni->numa_node == CNA_PRIORITY_NODE)
+		cni->numa_node = nid;	/* Inherit node id of primary queue */
+
 	if (last != cn)	/* did we skip any waiters? */
 		cna_splice_tail(node, node->next, (struct mcs_spinlock *)last);
 
@@ -290,6 +296,13 @@ static __always_inline u32 cna_wait_head_or_lock(struct qspinlock *lock,
 	struct cna_node *cn = (struct cna_node *)node;
 
 	if (cn->intra_count < intra_node_handoff_threshold) {
+		/*
+		 * We are at the head of the wait queue, no need to use
+		 * the fake NUMA node ID.
+		 */
+		if (cn->numa_node == CNA_PRIORITY_NODE)
+			cn->numa_node = cn->real_numa_node;
+
 		/*
 		 * Try and put the time otherwise spent spin waiting on
 		 * _Q_LOCKED_PENDING_MASK to use by sorting our lists.
-- 
2.18.1


--------------E1866B38CD0464E8AECD0ADC--

