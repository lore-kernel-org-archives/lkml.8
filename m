Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6343C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92EA922464
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aOFKtqcA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgBFPYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:24:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33332 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727675AbgBFPY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581002667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=hZQ1bZXwx73UG2QTjcRZPYs7EAoVSiICeHspPztTjlk=;
        b=aOFKtqcA/k6U9LP97h0uuGkNZAJRa3sABRy78g5T0wXCpSDYK1CUNtz1RMbh+fRywcuUbA
        ZSxkhhgSWTTauII8gvfKFSD0mHQJV4bYWvcqhsbXCdFBFmFMqZ2vKKz5WO6x2w/iLhngsb
        Mbicjy1c0VYCELPALT8vERk6bdwqLBI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-1K3yg_kbMku4_OgZzL34Kw-1; Thu, 06 Feb 2020 10:24:24 -0500
X-MC-Unique: 1K3yg_kbMku4_OgZzL34Kw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33D2D80588D;
        Thu,  6 Feb 2020 15:24:23 +0000 (UTC)
Received: from llong.com (ovpn-124-223.rdu2.redhat.com [10.10.124.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5EC901001B05;
        Thu,  6 Feb 2020 15:24:22 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v6 2/6] locking/lockdep: Display irq_context names in /proc/lockdep_chains
Date:   Thu,  6 Feb 2020 10:24:04 -0500
Message-Id: <20200206152408.24165-3-longman@redhat.com>
In-Reply-To: <20200206152408.24165-1-longman@redhat.com>
References: <20200206152408.24165-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the irq_context field of a lock chains displayed in
/proc/lockdep_chains is just a number. It is likely that many people
may not know what a non-zero number means. To make the information more
useful, print the actual irq names ("softirq" and "hardirq") instead.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lockdep_proc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 9bb6d2497b04..0f6842bcfba8 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -128,6 +128,13 @@ static int lc_show(struct seq_file *m, void *v)
 	struct lock_chain *chain = v;
 	struct lock_class *class;
 	int i;
+	static const char * const irq_strs[] = {
+		[0]			     = "0",
+		[LOCK_CHAIN_HARDIRQ_CONTEXT] = "hardirq",
+		[LOCK_CHAIN_SOFTIRQ_CONTEXT] = "softirq",
+		[LOCK_CHAIN_SOFTIRQ_CONTEXT|
+		 LOCK_CHAIN_HARDIRQ_CONTEXT] = "hardirq|softirq",
+	};
 
 	if (v == SEQ_START_TOKEN) {
 		if (nr_chain_hlocks > MAX_LOCKDEP_CHAIN_HLOCKS)
@@ -136,7 +143,7 @@ static int lc_show(struct seq_file *m, void *v)
 		return 0;
 	}
 
-	seq_printf(m, "irq_context: %d\n", chain->irq_context);
+	seq_printf(m, "irq_context: %s\n", irq_strs[chain->irq_context]);
 
 	for (i = 0; i < chain->depth; i++) {
 		class = lock_chain_get_class(chain, i);
-- 
2.18.1

