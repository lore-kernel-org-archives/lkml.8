Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26E5C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C170206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TI3mIKwD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgBLPi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:38:58 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34296 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728551AbgBLPi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:38:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581521935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=KMTNafIK+vSY11odONr7Db9tI/pw4yx07aThuFNMb4I=;
        b=TI3mIKwDyFclwzRe3e4eN516YYB2FVjHG0h0qM7U6cKJt2c7Uxw5Tax4oZZ1wdXRSKWw7m
        AERHp02UCSYFNetkMYCEiwOceepLvDX4+bEIO2jKbYsluBST/6B2Ijp9ysqe/nZ2d56CSR
        5679EU7StMdvYQicPhvU9rzMbAvZLNU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-kgNGyrdiM0aDrz4T_NuZgQ-1; Wed, 12 Feb 2020 10:38:51 -0500
X-MC-Unique: kgNGyrdiM0aDrz4T_NuZgQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA5EE107ACC9;
        Wed, 12 Feb 2020 15:38:50 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11CAD6E40A;
        Wed, 12 Feb 2020 15:38:49 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-tip 1/3] locking/lockdep: Make remove_class_from_lock_chains() depend on CONFIG_PROVE_LOCKING
Date:   Wed, 12 Feb 2020 10:38:26 -0500
Message-Id: <20200212153828.346-2-longman@redhat.com>
In-Reply-To: <20200212153828.346-1-longman@redhat.com>
References: <20200212153828.346-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The remove_class_from_lock_chains() is essentially an no-op if
CONFIG_PROVE_LOCKING isn't enabled. Make it so.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lockdep.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e55c4ee14e64..3dad36e2187b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4998,12 +4998,12 @@ void lockdep_reset(void)
 	raw_local_irq_restore(flags);
 }
 
+#ifdef CONFIG_PROVE_LOCKING
 /* Remove a class from a lock chain. Must be called with the graph lock held. */
 static void remove_class_from_lock_chain(struct pending_free *pf,
 					 struct lock_chain *chain,
 					 struct lock_class *class)
 {
-#ifdef CONFIG_PROVE_LOCKING
 	int i;
 
 	for (i = chain->base; i < chain->base + chain->depth; i++) {
@@ -5031,13 +5031,14 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 	hlist_del_rcu(&chain->entry);
 	__set_bit(chain - lock_chains, pf->lock_chains_being_freed);
 	nr_zapped_lock_chains++;
-#endif
 }
+#endif
 
 /* Must be called with the graph lock held. */
 static void remove_class_from_lock_chains(struct pending_free *pf,
 					  struct lock_class *class)
 {
+#ifdef CONFIG_PROVE_LOCKING
 	struct lock_chain *chain;
 	struct hlist_head *head;
 	int i;
@@ -5048,6 +5049,7 @@ static void remove_class_from_lock_chains(struct pending_free *pf,
 			remove_class_from_lock_chain(pf, chain, class);
 		}
 	}
+#endif
 }
 
 /*
-- 
2.18.1

