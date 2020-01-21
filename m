Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C3DC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A7A2253D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9fivagN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgAUPlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 10:41:08 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50910 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729130AbgAUPlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 10:41:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579621266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=IcawgmeP/9SOelURBigSUicEKZ7h4SFbJprPzNN3llY=;
        b=b9fivagNU436Yq8qN+4PQoYdwTWHUN4A4xDQQ45Ea6QA8nldbm3CauFmak47HWGXyUXn73
        EeZP2b3oMa+v5+p8xaVfN9xL2G/M3x/HRy2Rf/S6GKH4TYa0ccUUs7uuWf9ZaqcsU/DMYJ
        xlxRr3ofPkaS2ZnFjgLTtTZohyzust4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-PoLucfwkPBuQOhLUs96oVg-1; Tue, 21 Jan 2020 10:41:01 -0500
X-MC-Unique: PoLucfwkPBuQOhLUs96oVg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D82188EB474;
        Tue, 21 Jan 2020 15:40:58 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E3A260FC1;
        Tue, 21 Jan 2020 15:40:58 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 2/7] locking/lockdep: Display irq_context names in /proc/lockdep_chains
Date:   Tue, 21 Jan 2020 10:40:04 -0500
Message-Id: <20200121154009.11993-3-longman@redhat.com>
In-Reply-To: <20200121154009.11993-1-longman@redhat.com>
References: <20200121154009.11993-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
index dadb7b7fba37..5e64a6ec09c2 100644
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

