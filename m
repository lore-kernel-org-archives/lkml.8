Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A795C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A01822CA1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f2sW3pfg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xb9lt1FS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgG2Oes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:34:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42998 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbgG2Odf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:33:35 -0400
Date:   Wed, 29 Jul 2020 14:33:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596033213;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ENaLXBByTTJ5ISrjtB1c6/CxEdRmK1cicpQfyvi2pmc=;
        b=f2sW3pfg/LMadIRS+c9GeqialkCEVbjLtL2nJLmgoqTeLFV5p9VQObOatEebZGuwmapGf/
        f7b9QnENYubxHpNECbJlF9gzl4Vyr1INPVXD59z9fHM0g3862x5fKlIfSqnWmolUQ5seoU
        VLo5HIi8IrOFZzm+zrTsa2yUdrYgZu+MaXpG0PPYFwor1tWEIuL2Vm1qIAaXc2JDTbzo09
        EFnHsdNDReziqkLJQ5nZzVp4ndNVzqLtDzPDCXTEtTKKhTcIImumRc0lw3Y3WjelVSfTaR
        sDtU2XcSWIkv+FFiEK9d8JPjldMYJmXVHG3dL0PG9cL7sf7CaJ9wctcOHv2clw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596033213;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ENaLXBByTTJ5ISrjtB1c6/CxEdRmK1cicpQfyvi2pmc=;
        b=xb9lt1FS+cIHa+dZULXjHnJYFZ4IiuVPW61a0BpxQ1nw+UhofqRS0kWEscpjiGQM1snjIH
        +VNg96NWdIFE8oCg==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] xfrm: policy: Use sequence counters with associated lock
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720155530.1173732-17-a.darwish@linutronix.de>
References: <20200720155530.1173732-17-a.darwish@linutronix.de>
MIME-Version: 1.0
Message-ID: <159603321244.4006.14222637112308108738.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     77cc278f7b202e4f16f8596837219d02cb090b96
Gitweb:        https://git.kernel.org/tip/77cc278f7b202e4f16f8596837219d02cb090b96
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Mon, 20 Jul 2020 17:55:22 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Jul 2020 16:14:27 +02:00

xfrm: policy: Use sequence counters with associated lock

A sequence counter write side critical section must be protected by some
form of locking to serialize writers. If the serialization primitive is
not disabling preemption implicitly, preemption has to be explicitly
disabled before entering the sequence counter write side critical
section.

A plain seqcount_t does not contain the information of which lock must
be held when entering a write side critical section.

Use the new seqcount_spinlock_t and seqcount_mutex_t data types instead,
which allow to associate a lock with the sequence counter. This enables
lockdep to verify that the lock used for writer serialization is held
when the write side critical section is entered.

If lockdep is disabled this lock association is compiled out and has
neither storage size nor runtime overhead.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200720155530.1173732-17-a.darwish@linutronix.de
---
 net/xfrm/xfrm_policy.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 564aa64..732a940 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -122,7 +122,7 @@ struct xfrm_pol_inexact_bin {
 	/* list containing '*:*' policies */
 	struct hlist_head hhead;
 
-	seqcount_t count;
+	seqcount_spinlock_t count;
 	/* tree sorted by daddr/prefix */
 	struct rb_root root_d;
 
@@ -155,7 +155,7 @@ static struct xfrm_policy_afinfo const __rcu *xfrm_policy_afinfo[AF_INET6 + 1]
 						__read_mostly;
 
 static struct kmem_cache *xfrm_dst_cache __ro_after_init;
-static __read_mostly seqcount_t xfrm_policy_hash_generation;
+static __read_mostly seqcount_mutex_t xfrm_policy_hash_generation;
 
 static struct rhashtable xfrm_policy_inexact_table;
 static const struct rhashtable_params xfrm_pol_inexact_params;
@@ -719,7 +719,7 @@ xfrm_policy_inexact_alloc_bin(const struct xfrm_policy *pol, u8 dir)
 	INIT_HLIST_HEAD(&bin->hhead);
 	bin->root_d = RB_ROOT;
 	bin->root_s = RB_ROOT;
-	seqcount_init(&bin->count);
+	seqcount_spinlock_init(&bin->count, &net->xfrm.xfrm_policy_lock);
 
 	prev = rhashtable_lookup_get_insert_key(&xfrm_policy_inexact_table,
 						&bin->k, &bin->head,
@@ -1906,7 +1906,7 @@ static int xfrm_policy_match(const struct xfrm_policy *pol,
 
 static struct xfrm_pol_inexact_node *
 xfrm_policy_lookup_inexact_addr(const struct rb_root *r,
-				seqcount_t *count,
+				seqcount_spinlock_t *count,
 				const xfrm_address_t *addr, u16 family)
 {
 	const struct rb_node *parent;
@@ -4153,7 +4153,7 @@ void __init xfrm_init(void)
 {
 	register_pernet_subsys(&xfrm_net_ops);
 	xfrm_dev_init();
-	seqcount_init(&xfrm_policy_hash_generation);
+	seqcount_mutex_init(&xfrm_policy_hash_generation, &hash_resize_mutex);
 	xfrm_input_init();
 
 #ifdef CONFIG_INET_ESPINTCP
