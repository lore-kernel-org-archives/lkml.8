Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC5DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79D6C22D00
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Le+u6q1I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uag0zI9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732212AbgGaJWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:22:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56338 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732083AbgGaJWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:40 -0400
Date:   Fri, 31 Jul 2020 09:22:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187358;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=NNCeDoN6ksX+5EL8iE2AHqZrfS7RJ3bRGy9oCrYKoRU=;
        b=Le+u6q1IsV23jGfw8DxtZ7xVuFB8mflZNQmwwFiUEjeOCclcgFoahck8OuvjOwFGSBdL82
        IbG/Rut7TYVdMsu19PGYcDbZAZvfv5otoHtr0/ZD+LZUxhrEBFehqmP9U4mKBxPLTp2h/J
        HRyvPlbldk+l0DGjruPL8Ijdki0FdYoQmT7fjGEahAeRCl9zvaVYsTiQ9zTQO4zEP92isU
        hceHVlOYvMhQfPlQo3PJn0owWKNt3aQlrtKozLD8f1CXseS3/sG9f/ENbn8iGvCLwXZij6
        UstEu1rFLPLhUSRqut0CpRPb51tVA1BlfKvftFNIWm35HNccQbEmepOP1ch/aA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187358;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=NNCeDoN6ksX+5EL8iE2AHqZrfS7RJ3bRGy9oCrYKoRU=;
        b=Uag0zI9x5g7GhBDSrvy9FyA4h1Y71R1YHVZpJMwHLMrIsD+68RJ/6yq68icdu6zLxBzbui
        ENPHv92JGSOeaaDQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Add more tracing crib notes to kvm.sh
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618735818.4006.13892640783693161073.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     9ccba350bd824ecacbfd8965f4f3ac980b96f951
Gitweb:        https://git.kernel.org/tip/9ccba350bd824ecacbfd8965f4f3ac980b96f951
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 16 Jun 2020 11:16:18 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:01:45 -07:00

torture: Add more tracing crib notes to kvm.sh

This commit adds a few more hints about how to use tracing as comments
at the end of kvm.sh.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 3578c85..bdfa0c0 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -503,3 +503,7 @@ fi
 # Tracing: trace_event=rcu:rcu_grace_period,rcu:rcu_future_grace_period,rcu:rcu_grace_period_init,rcu:rcu_nocb_wake,rcu:rcu_preempt_task,rcu:rcu_unlock_preempted_task,rcu:rcu_quiescent_state_report,rcu:rcu_fqs,rcu:rcu_callback,rcu:rcu_kfree_callback,rcu:rcu_batch_start,rcu:rcu_invoke_callback,rcu:rcu_invoke_kfree_callback,rcu:rcu_batch_end,rcu:rcu_torture_read,rcu:rcu_barrier
 # Function-graph tracing: ftrace=function_graph ftrace_graph_filter=sched_setaffinity,migration_cpu_stop
 # Also --kconfig "CONFIG_FUNCTION_TRACER=y CONFIG_FUNCTION_GRAPH_TRACER=y"
+# Control buffer size: --bootargs trace_buf_size=3k
+# Get trace-buffer dumps on all oopses: --bootargs ftrace_dump_on_oops
+# Ditto, but dump only the oopsing CPU: --bootargs ftrace_dump_on_oops=orig_cpu
+# Heavy-handed way to also dump on warnings: --bootargs panic_on_warn
