Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D52C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794AE222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7cBpZzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgAOVoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:44:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38896 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729946AbgAOVnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 16:43:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579124619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=Imhocc/diFXvIDaBLVmN5diQ1k2dvsm/M+cTlPHIstc=;
        b=B7cBpZzCCzUtQKelZFgZQqo8sPZp4Qi9I0pQjJpjBt2LwiwVvYQyojZSjranNzNGbbCF+8
        UdWBTSGDOzfuSPnwuP8t0ebfSNfYdVSqC+ap13aTgV2xeKU95J8s7MlGTZz38yF1xzegVV
        qrcetQ923dTqsPv70EbyvH0FHBCfFIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-uvTvTDF3OiOCmsvQd4RsqA-1; Wed, 15 Jan 2020 16:43:36 -0500
X-MC-Unique: uvTvTDF3OiOCmsvQd4RsqA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28B60800D48;
        Wed, 15 Jan 2020 21:43:35 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76BB65C3F8;
        Wed, 15 Jan 2020 21:43:34 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v3 5/8] locking/lockdep: Track number of zapped lock chains
Date:   Wed, 15 Jan 2020 16:43:10 -0500
Message-Id: <20200115214313.13253-6-longman@redhat.com>
In-Reply-To: <20200115214313.13253-1-longman@redhat.com>
References: <20200115214313.13253-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new counter nr_zapped_lock_chains to track the number lock chains
that have been removed.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lockdep.c           | 2 ++
 kernel/locking/lockdep_internals.h | 1 +
 kernel/locking/lockdep_proc.c      | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 436fcaa4d5d5..10471167b5f7 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2637,6 +2637,7 @@ check_prevs_add(struct task_struct *curr, struct held_lock *next)
 struct lock_chain lock_chains[MAX_LOCKDEP_CHAINS];
 static DECLARE_BITMAP(lock_chains_in_use, MAX_LOCKDEP_CHAINS);
 static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
+unsigned long nr_zapped_lock_chains;
 unsigned int nr_chain_hlocks;
 
 struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i)
@@ -4808,6 +4809,7 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 	 */
 	hlist_del_rcu(&chain->entry);
 	__set_bit(chain - lock_chains, pf->lock_chains_being_freed);
+	nr_zapped_lock_chains++;
 #endif
 }
 
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 42a1e55f49a7..b013250f2ca1 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -131,6 +131,7 @@ struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i);
 
 extern unsigned long nr_lock_classes;
 extern unsigned long nr_zapped_classes;
+extern unsigned long nr_zapped_lock_chains;
 extern unsigned long nr_list_entries;
 long lockdep_next_lockchain(long i);
 unsigned long lock_chain_count(void);
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 2457bc97924c..df1b97912871 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -349,6 +349,8 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 	seq_puts(m, "\n");
 	seq_printf(m, " zapped classes:                %11lu\n",
 			nr_zapped_classes);
+	seq_printf(m, " zapped lock chains:            %11lu\n",
+			nr_zapped_lock_chains);
 	return 0;
 }
 
-- 
2.18.1

