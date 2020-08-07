Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE8FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 066C32086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CSpx9L+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgHGDcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 23:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgHGDcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 23:32:02 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFA5C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 20:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=zUKrZApqxPtNK6ePprgoelXB9fPclkutfE9vg2UGTBE=; b=CSpx9L+OZWls5wvFwDJVjF3806
        if4z5LOy2Yx2jZkn1hJE+PT8RkSGYjmx4jt4fKR/aDg0od/tRCuCpItpQdZXv69+DsA1drQ14TjcU
        cAMnlfSQNL387K7hoX7fhIWOsjU915my8S1nnbfUIT0whcPG7j46nuFPdH8hDdakN7uuEtRYFrzmG
        ukze/Vnr5hASCaXhlT6E2DibT5F//TlvFgdgSd5ZmtXMjMTZgS9V1cdsPx1cWUnWXgafIK8o9NTS7
        DKYIrSEN/Xe6YirUJ/wmq76CwrtG09zfN+87A1c2u0F/PNFAipF5oGWJfvyVzAYEmX2HdA9vW9qMh
        llhugM9w==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3t6s-0006m2-JF; Fri, 07 Aug 2020 03:32:00 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH] kernel: events: delete repeated words in comments
Date:   Thu,  6 Aug 2020 20:31:54 -0700
Message-Id: <20200807033154.7916-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop repeated words in kernel/events/.
{if, the, that, with, time}

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
---
 kernel/events/core.c    |    8 ++++----
 kernel/events/uprobes.c |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

--- linux-next-20200806.orig/kernel/events/core.c
+++ linux-next-20200806/kernel/events/core.c
@@ -265,7 +265,7 @@ static void event_function_call(struct p
 	if (!event->parent) {
 		/*
 		 * If this is a !child event, we must hold ctx::mutex to
-		 * stabilize the the event->ctx relation. See
+		 * stabilize the event->ctx relation. See
 		 * perf_event_ctx_lock().
 		 */
 		lockdep_assert_held(&ctx->mutex);
@@ -1299,7 +1299,7 @@ static void put_ctx(struct perf_event_co
  * life-time rules separate them. That is an exiting task cannot fork, and a
  * spawning task cannot (yet) exit.
  *
- * But remember that that these are parent<->child context relations, and
+ * But remember that these are parent<->child context relations, and
  * migration does not affect children, therefore these two orderings should not
  * interact.
  *
@@ -1438,7 +1438,7 @@ static u64 primary_event_id(struct perf_
 /*
  * Get the perf_event_context for a task and lock it.
  *
- * This has to cope with with the fact that until it is locked,
+ * This has to cope with the fact that until it is locked,
  * the context could get moved to another task.
  */
 static struct perf_event_context *
@@ -2475,7 +2475,7 @@ static void perf_set_shadow_time(struct
 	 * But this is a bit hairy.
 	 *
 	 * So instead, we have an explicit cgroup call to remain
-	 * within the time time source all along. We believe it
+	 * within the time source all along. We believe it
 	 * is cleaner and simpler to understand.
 	 */
 	if (is_cgroup_event(event))
--- linux-next-20200806.orig/kernel/events/uprobes.c
+++ linux-next-20200806/kernel/events/uprobes.c
@@ -1735,7 +1735,7 @@ void uprobe_free_utask(struct task_struc
 }
 
 /*
- * Allocate a uprobe_task object for the task if if necessary.
+ * Allocate a uprobe_task object for the task if necessary.
  * Called when the thread hits a breakpoint.
  *
  * Returns:
