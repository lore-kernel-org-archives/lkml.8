Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CD8C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCF82086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iRndtfyp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731656AbgBCQmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:42:14 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55549 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731617AbgBCQmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:42:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580748127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=hZQ1bZXwx73UG2QTjcRZPYs7EAoVSiICeHspPztTjlk=;
        b=iRndtfypxP6dzcPYo4feW4PRCDMEASCHoHOSOLS10g6giFdmQ+eJwDLp/zSZlzVRrSYU2F
        SJonYPBTCvegT26JA9mtrY4E1Wn5UkRRIVXCex+yLT4E3cbFE7qLVzxDouZsodLmGkEOh0
        eHIezBu0VNzPrmJZlC9QcTSTZf+IkMM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-muDVYYQ3NxCGyIX04hpqiA-1; Mon, 03 Feb 2020 11:42:02 -0500
X-MC-Unique: muDVYYQ3NxCGyIX04hpqiA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D16AC1005F79;
        Mon,  3 Feb 2020 16:42:00 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2604E10013A7;
        Mon,  3 Feb 2020 16:42:00 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v5 2/7] locking/lockdep: Display irq_context names in /proc/lockdep_chains
Date:   Mon,  3 Feb 2020 11:41:42 -0500
Message-Id: <20200203164147.17990-3-longman@redhat.com>
In-Reply-To: <20200203164147.17990-1-longman@redhat.com>
References: <20200203164147.17990-1-longman@redhat.com>
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

