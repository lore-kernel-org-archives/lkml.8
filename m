Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EBEC43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 00:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDFD0208FE
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 00:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ob2B6cIl";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="bvN4A+VT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgIEALv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 20:11:51 -0400
Received: from a27-18.smtp-out.us-west-2.amazonses.com ([54.240.27.18]:36104
        "EHLO a27-18.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726208AbgIEALu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 20:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599264709;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=m8OST3NtguGhEpXtkvL77ryP7YKnmfmmkex8q6xIWHM=;
        b=ob2B6cIlkJEoKPqHKfYdzC3pFUTIkDs4OFGZcp/lkwON/gLeq5i/UvqlezuE0loY
        Z74OOGtMveNVYeLTVd6dsh8ngwqy+t7lz2Tg85hZJlxz3kj40DBm4bnbq7to1hsegpl
        MY6LR7oQKsheHc0jbb+AtRnDLkMrpz+SCDtd/FLQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599264709;
        h=From:To:Cc:Subject:Date:Message-Id:Feedback-ID;
        bh=m8OST3NtguGhEpXtkvL77ryP7YKnmfmmkex8q6xIWHM=;
        b=bvN4A+VTTi2ZtKZGQmaLN41C5VwLRMfrop2hM3AVFzF4eNbRN4K1z2gSOcr8F+Wt
        BD6pP4eZPAfa0XlszY2WLqLg2dqj2P8aaKYQO2ITjde9v78PJ8hc/tm3ckyXVxvzwn4
        lEKB89QjTLlT5ARzE33dyzVVtrBbeHyY9XBecOwo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 072A3C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=isaacm@codeaurora.org
From:   "Isaac J. Manjarres" <isaacm@codeaurora.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        christian.brauner@ubuntu.com, akpm@linux-foundation.org,
        mingo@kernel.org, peterz@infradead.org, ebiederm@xmission.com,
        esyr@redhat.com, tglx@linutronix.de, christian@kellner.me,
        areber@redhat.com, shakeelb@google.com, cyphar@cyphar.com,
        psodagud@codeaurora.org, pratikp@codeaurora.org
Subject: [RFC PATCH] fork: Free per-cpu cached vmalloc'ed thread stacks with
Date:   Sat, 5 Sep 2020 00:11:49 +0000
Message-ID: <010101745b9ada0c-eb39681f-a76f-479a-8bad-0fbbe605aea9-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
X-SES-Outgoing: 2020.09.05-54.240.27.18
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The per-cpu cached vmalloc'ed stacks are currently freed in the
CPU hotplug teardown path by the free_vm_stack_cache() callback,
which invokes vfree(), which may result in purging the list of
lazily freed vmap areas.

Purging all of the lazily freed vmap areas can take a long time
when the list of vmap areas is large. This is problematic, as
free_vm_stack_cache() is invoked prior to the offline CPU's timers
being migrated. This is not desirable as it can lead to timer
migration delays in the CPU hotplug teardown path, and timer callbacks
will be invoked long after the timer has expired.

For example, on a system that has only one online CPU (CPU 1) that is
running a heavy workload, and another CPU that is being offlined,
the online CPU will invoke free_vm_stack_cache() to free the cached
vmalloc'ed stacks for the CPU being offlined. When there are 2702
vmap areas that total to 13498 pages, free_vm_stack_cache() takes
over 2 seconds to execute:

[001]   399.335808: cpuhp_enter: cpu: 0005 target:   0 step:  67 (free_vm_stack_cache)

/* The first vmap area to be freed */
[001]   399.337157: __purge_vmap_area_lazy: [0:2702] 0xffffffc033da8000 - 0xffffffc033dad000 (5 : 13498)

/* After two seconds */
[001]   401.528010: __purge_vmap_area_lazy: [1563:2702] 0xffffffc02fe10000 - 0xffffffc02fe15000 (5 : 5765)

Instead of freeing the per-cpu cached vmalloc'ed stacks synchronously
with respect to the CPU hotplug teardown state machine, free them
asynchronously to help move along the CPU hotplug teardown state machine
quickly.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 4d32190..68346a0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -202,7 +202,7 @@ static int free_vm_stack_cache(unsigned int cpu)
 		if (!vm_stack)
 			continue;
 
-		vfree(vm_stack->addr);
+		vfree_atomic(vm_stack->addr);
 		cached_vm_stacks[i] = NULL;
 	}
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

