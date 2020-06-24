Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FF7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D75C4206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="by5AlTYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404627AbgFXPv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404586AbgFXPvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:51:50 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8FDC061796
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=YCNRxVdwXiAUVSTcLJEk+raGgN9RNB/RFHzydfwKP+4=; b=by5AlTYvXTeBUKUeV3+xaeyFlJ
        pKqJOJfJAu0ogBsJyUXaXSZRDIz98qPebcSnWTN8R7eDDBmgMC8GMqxoB9X3mXKwHVGhbOyGTfkqe
        bKLmAMjURTwSGbkSljWPYNN++ZOehSU2jsroIjarW19R2ryiFHeAOplISRS/zo218uOLTCAqgtR0f
        njERlFA7dJRzV14iqgLtEsnkZQv9Y7dKCrmwKwZpbl8TQQ8edGxmZeAu7MfU7+7VxjEN/M6q9W7tL
        9p42YkRL0arcHW/u/XeDnAKWjIJKreUKOUjhr4ERD7hKjeqeVW8tMNJLtfVjb2ETOdPJ9C/So6Rn7
        jY+J436g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo7gB-0004rH-4L; Wed, 24 Jun 2020 15:51:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E79EA300261;
        Wed, 24 Jun 2020 17:51:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D1FEA236E7758; Wed, 24 Jun 2020 17:51:13 +0200 (CEST)
Message-ID: <20200624154156.841688382@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 24 Jun 2020 17:30:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com, linux@rasmusvillemoes.dk,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Robert Richter <rric@kernel.org>
Subject: [PATCH v5 02/17] module: Fix up module_notifier return values
References: <20200624153024.794671356@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While auditing all module notifiers I noticed a whole bunch of fail
wrt the return value. Notifiers have a 'special' return semantics.

As is; NOTIFY_DONE vs NOTIFY_OK is a bit vague; but
notifier_from_errno(0) results in NOTIFY_OK and NOTIFY_DONE has a
comment that says "Don't care".

>From this I've used NOTIFY_DONE when the function completely ignores
the callback and notifier_to_error() isn't used.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Robert Richter <rric@kernel.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 drivers/oprofile/buffer_sync.c |    4 ++--
 kernel/trace/bpf_trace.c       |    8 ++++++--
 kernel/trace/trace.c           |    2 +-
 kernel/trace/trace_events.c    |    2 +-
 kernel/trace/trace_printk.c    |    4 ++--
 kernel/tracepoint.c            |    2 +-
 6 files changed, 13 insertions(+), 9 deletions(-)

--- a/drivers/oprofile/buffer_sync.c
+++ b/drivers/oprofile/buffer_sync.c
@@ -116,7 +116,7 @@ module_load_notify(struct notifier_block
 {
 #ifdef CONFIG_MODULES
 	if (val != MODULE_STATE_COMING)
-		return 0;
+		return NOTIFY_DONE;
 
 	/* FIXME: should we process all CPU buffers ? */
 	mutex_lock(&buffer_mutex);
@@ -124,7 +124,7 @@ module_load_notify(struct notifier_block
 	add_event_entry(MODULE_LOADED_CODE);
 	mutex_unlock(&buffer_mutex);
 #endif
-	return 0;
+	return NOTIFY_OK;
 }
 
 
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1451,10 +1451,11 @@ static int bpf_event_notify(struct notif
 {
 	struct bpf_trace_module *btm, *tmp;
 	struct module *mod = module;
+	int ret = 0;
 
 	if (mod->num_bpf_raw_events == 0 ||
 	    (op != MODULE_STATE_COMING && op != MODULE_STATE_GOING))
-		return 0;
+		goto out;
 
 	mutex_lock(&bpf_module_mutex);
 
@@ -1464,6 +1465,8 @@ static int bpf_event_notify(struct notif
 		if (btm) {
 			btm->module = module;
 			list_add(&btm->list, &bpf_trace_modules);
+		} else {
+			ret = -ENOMEM;
 		}
 		break;
 	case MODULE_STATE_GOING:
@@ -1479,7 +1482,8 @@ static int bpf_event_notify(struct notif
 
 	mutex_unlock(&bpf_module_mutex);
 
-	return 0;
+out:
+	return notifier_from_errno(ret);
 }
 
 static struct notifier_block bpf_module_nb = {
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8696,7 +8696,7 @@ static int trace_module_notify(struct no
 		break;
 	}
 
-	return 0;
+	return NOTIFY_OK;
 }
 
 static struct notifier_block trace_module_nb = {
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2442,7 +2442,7 @@ static int trace_module_notify(struct no
 	mutex_unlock(&trace_types_lock);
 	mutex_unlock(&event_mutex);
 
-	return 0;
+	return NOTIFY_OK;
 }
 
 static struct notifier_block trace_module_nb = {
--- a/kernel/trace/trace_printk.c
+++ b/kernel/trace/trace_printk.c
@@ -95,7 +95,7 @@ static int module_trace_bprintk_format_n
 		if (val == MODULE_STATE_COMING)
 			hold_module_trace_bprintk_format(start, end);
 	}
-	return 0;
+	return NOTIFY_OK;
 }
 
 /*
@@ -173,7 +173,7 @@ __init static int
 module_trace_bprintk_format_notify(struct notifier_block *self,
 		unsigned long val, void *data)
 {
-	return 0;
+	return NOTIFY_OK;
 }
 static inline const char **
 find_next_mod_format(int start_index, void *v, const char **fmt, loff_t *pos)
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -521,7 +521,7 @@ static int tracepoint_module_notify(stru
 	case MODULE_STATE_UNFORMED:
 		break;
 	}
-	return ret;
+	return notifier_from_errno(ret);
 }
 
 static struct notifier_block tracepoint_module_nb = {


