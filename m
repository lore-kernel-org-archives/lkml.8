Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45378C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C4ED206EF
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f+6sLghC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7DdL5vVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgIAMAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 08:00:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39504 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbgIALtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:49:36 -0400
Date:   Tue, 01 Sep 2020 11:48:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960889;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MRzSW8ft0QLVpyTVdEsrKf2gyNjQx6nmcG6Plha0RSc=;
        b=f+6sLghCIKbMop0WeBa61Y75M7IxpvyyWrDElWQhSZT8wP7R+yp6mxkXzrAazxg7CD3LxH
        cptmy15fNkfFd0NSE/dfM1osbws647dTdFY05nkd02vQa+c40dIqiQfQnTuJjUASXvWYtV
        3JpApymqa8sY2B89NBpN1EIxJbP1ctWWR5vKBWrFR5XoxAD2CYlcEyX3KFTl923Gtg28vZ
        oUq3WSlrutD1IqAOzghA9htLzBZnjDea1EGB5YA7Zvi8G6opxLf6eocwU1fXLAnBL+kdgP
        XgN2kSaIe7dwGXVhwu+hEhMEUZzKvk2IZrsrKJ4SW6jiRy0YhoxjTWB/s8BmMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960889;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MRzSW8ft0QLVpyTVdEsrKf2gyNjQx6nmcG6Plha0RSc=;
        b=7DdL5vVjlsqIPWNdcB1+UNfP1JLDNLiBbTIKP26BtNgYVCZFFXaZYm7Ws+aeYKf3HLM/kW
        LKgG8iQ1lznDr+Cg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/static_call] module: Fix up module_notifier return values
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Robert Richter <rric@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200818135804.385360407@infradead.org>
References: <20200818135804.385360407@infradead.org>
MIME-Version: 1.0
Message-ID: <159896088863.20229.11644142375792343382.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/static_call branch of tip:

Commit-ID:     0340a6b7fb767f7f296b9bacc9a215920519a644
Gitweb:        https://git.kernel.org/tip/0340a6b7fb767f7f296b9bacc9a215920519a644
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 18 Aug 2020 15:57:37 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 09:58:03 +02:00

module: Fix up module_notifier return values

While auditing all module notifiers I noticed a whole bunch of fail
wrt the return value. Notifiers have a 'special' return semantics.

As is; NOTIFY_DONE vs NOTIFY_OK is a bit vague; but
notifier_from_errno(0) results in NOTIFY_OK and NOTIFY_DONE has a
comment that says "Don't care".

>From this I've used NOTIFY_DONE when the function completely ignores
the callback and notifier_to_error() isn't used.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Robert Richter <rric@kernel.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: https://lore.kernel.org/r/20200818135804.385360407@infradead.org
---
 drivers/oprofile/buffer_sync.c | 4 ++--
 kernel/trace/bpf_trace.c       | 8 ++++++--
 kernel/trace/trace.c           | 2 +-
 kernel/trace/trace_events.c    | 2 +-
 kernel/trace/trace_printk.c    | 4 ++--
 kernel/tracepoint.c            | 2 +-
 6 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/oprofile/buffer_sync.c b/drivers/oprofile/buffer_sync.c
index 4d76952..cc91786 100644
--- a/drivers/oprofile/buffer_sync.c
+++ b/drivers/oprofile/buffer_sync.c
@@ -116,7 +116,7 @@ module_load_notify(struct notifier_block *self, unsigned long val, void *data)
 {
 #ifdef CONFIG_MODULES
 	if (val != MODULE_STATE_COMING)
-		return 0;
+		return NOTIFY_DONE;
 
 	/* FIXME: should we process all CPU buffers ? */
 	mutex_lock(&buffer_mutex);
@@ -124,7 +124,7 @@ module_load_notify(struct notifier_block *self, unsigned long val, void *data)
 	add_event_entry(MODULE_LOADED_CODE);
 	mutex_unlock(&buffer_mutex);
 #endif
-	return 0;
+	return NOTIFY_OK;
 }
 
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a8d4f25..2ecf789 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2027,10 +2027,11 @@ static int bpf_event_notify(struct notifier_block *nb, unsigned long op,
 {
 	struct bpf_trace_module *btm, *tmp;
 	struct module *mod = module;
+	int ret = 0;
 
 	if (mod->num_bpf_raw_events == 0 ||
 	    (op != MODULE_STATE_COMING && op != MODULE_STATE_GOING))
-		return 0;
+		goto out;
 
 	mutex_lock(&bpf_module_mutex);
 
@@ -2040,6 +2041,8 @@ static int bpf_event_notify(struct notifier_block *nb, unsigned long op,
 		if (btm) {
 			btm->module = module;
 			list_add(&btm->list, &bpf_trace_modules);
+		} else {
+			ret = -ENOMEM;
 		}
 		break;
 	case MODULE_STATE_GOING:
@@ -2055,7 +2058,8 @@ static int bpf_event_notify(struct notifier_block *nb, unsigned long op,
 
 	mutex_unlock(&bpf_module_mutex);
 
-	return 0;
+out:
+	return notifier_from_errno(ret);
 }
 
 static struct notifier_block bpf_module_nb = {
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f40d850..df49992 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9072,7 +9072,7 @@ static int trace_module_notify(struct notifier_block *self,
 		break;
 	}
 
-	return 0;
+	return NOTIFY_OK;
 }
 
 static struct notifier_block trace_module_nb = {
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index a85effb..beebf2c 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2646,7 +2646,7 @@ static int trace_module_notify(struct notifier_block *self,
 	mutex_unlock(&trace_types_lock);
 	mutex_unlock(&event_mutex);
 
-	return 0;
+	return NOTIFY_OK;
 }
 
 static struct notifier_block trace_module_nb = {
diff --git a/kernel/trace/trace_printk.c b/kernel/trace/trace_printk.c
index d4e31e9..bb7783b 100644
--- a/kernel/trace/trace_printk.c
+++ b/kernel/trace/trace_printk.c
@@ -96,7 +96,7 @@ static int module_trace_bprintk_format_notify(struct notifier_block *self,
 		if (val == MODULE_STATE_COMING)
 			hold_module_trace_bprintk_format(start, end);
 	}
-	return 0;
+	return NOTIFY_OK;
 }
 
 /*
@@ -174,7 +174,7 @@ __init static int
 module_trace_bprintk_format_notify(struct notifier_block *self,
 		unsigned long val, void *data)
 {
-	return 0;
+	return NOTIFY_OK;
 }
 static inline const char **
 find_next_mod_format(int start_index, void *v, const char **fmt, loff_t *pos)
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 73956ea..8e05ed2 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -521,7 +521,7 @@ static int tracepoint_module_notify(struct notifier_block *self,
 	case MODULE_STATE_UNFORMED:
 		break;
 	}
-	return ret;
+	return notifier_from_errno(ret);
 }
 
 static struct notifier_block tracepoint_module_nb = {
