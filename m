Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E185FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40EBF23119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K1WKd77c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GQ928T2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbgHFROi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:14:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58862 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730204AbgHFRJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:09:57 -0400
Date:   Thu, 06 Aug 2020 17:09:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596733794;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z7Ezb+fQEneajcgalNOzKnlkvZJhSLgdHeTzhR2VDIk=;
        b=K1WKd77c76FJ+eGWRi/+XneZsO1BMM+nOOIPacCjS0eTOu/yiWqxLe7QYnURpTdtpw2B2A
        PQukdQ4u9AGkCK1RZNdBzNTl18byJAQZUu6fYMLvVWVkDP+CZYgX1u8cxrBB5siLNmvN9b
        wZBQ4eKf4gdeCWLfQ4jXSXJvncouaiwKE1ujlqgA+M6RY/uQObkdQin9jYD+Fuxjtgj2vw
        twPPXBBfcyubPbLYFIgr7ftxOo/W0vBNt4X3AwJETvgiTu6/ZIwHWlwkPUHXEjlEXY8suL
        KKZ4LShygv93B8z7/mKHNmSoQX2asVqyrklvnhO+fHGV5emfhnnnSu28m73HlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596733794;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z7Ezb+fQEneajcgalNOzKnlkvZJhSLgdHeTzhR2VDIk=;
        b=GQ928T2lXbltuQOFu/z8BJzLU09MjCQxqyOHnuqYODfQ66g6SuEkgloDS1lwJkffotB5I8
        Xl2zPkAIflVO0GDA==
From:   "tip-bot2 for Alexey Budankov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Take over CAP_SYS_PTRACE creds to
 CAP_PERFMON capability
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <6e8392ff-4732-0012-2949-e1587709f0f6@linux.intel.com>
References: <6e8392ff-4732-0012-2949-e1587709f0f6@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159673379364.3192.13552645526544222331.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     45fd22da97c6125d8d0d35bd1791e7c0c4175279
Gitweb:        https://git.kernel.org/tip/45fd22da97c6125d8d0d35bd1791e7c0c4175279
Author:        Alexey Budankov <alexey.budankov@linux.intel.com>
AuthorDate:    Wed, 05 Aug 2020 10:56:56 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 06 Aug 2020 15:03:20 +02:00

perf/core: Take over CAP_SYS_PTRACE creds to CAP_PERFMON capability

Open access to per-process monitoring for CAP_PERFMON only
privileged processes [1]. Extend ptrace_may_access() check
in perf_events subsystem with perfmon_capable() to simplify
user experience and make monitoring more secure by reducing
attack surface.

[1] https://lore.kernel.org/lkml/7776fa40-6c65-2aa6-1322-eb3a01201000@linux.intel.com/

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/6e8392ff-4732-0012-2949-e1587709f0f6@linux.intel.com
---
 kernel/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 78e69e1..41e0cef 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11689,7 +11689,7 @@ SYSCALL_DEFINE5(perf_event_open,
 			goto err_task;
 
 		/*
-		 * Reuse ptrace permission checks for now.
+		 * Preserve ptrace permission check for backwards compatibility.
 		 *
 		 * We must hold exec_update_mutex across this and any potential
 		 * perf_install_in_context() call for this new event to
@@ -11697,7 +11697,7 @@ SYSCALL_DEFINE5(perf_event_open,
 		 * perf_event_exit_task() that could imply).
 		 */
 		err = -EACCES;
-		if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
+		if (!perfmon_capable() && !ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
 			goto err_cred;
 	}
 
