Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71CBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 867E522CAF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aJM02Jra";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OTMzygH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732506AbgGaJXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:23:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56338 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732342AbgGaJXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:06 -0400
Date:   Fri, 31 Jul 2020 09:23:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187384;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=oLuv+KFWW1VBCour/O+GL0PkOXzk8yrV3Sj9/H16A2k=;
        b=aJM02JrareaQM7o44A3rIWztdOVuurpXYanXOUl2bddlzHFqpSg1AWJwpDtf+/m/iFAqxv
        KEB5lEtKrs07D3fCQ+2tnaUtUs6sga0zSUiGwFQGIoVMTtJE8brchAOH2koHKAC31rOmL1
        RkPwkv/0wK7OsA5H5AfIAttzDr0rRGscjsnxryuZ3UVgobdRaT0TZhuTonieF8ksMI38p9
        br6FkwITsvJz2M+wn7I3SG8UDkTWIe50PipsnrHFLN/qKmN/p5Qpen8RHAofgPPch9Zncp
        GRj/C0beE2snOpUHFjNXNnehf1k7u2YjxlXWqoYHrQ6R4smbFvXA62nvqkCEiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187384;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=oLuv+KFWW1VBCour/O+GL0PkOXzk8yrV3Sj9/H16A2k=;
        b=OTMzygH72W+GLD9O6rOtjfxxkoFyXvfdTrxVB9Wfryldainpaksm0SebzJ2SlJgKJotNc6
        T2WCDMYjuBVjdxDQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] refperf: Dynamically allocate thread-summary output buffer
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618738373.4006.8609303107692541900.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     2e90de76f226f11fe26c871aa321be28152f565a
Gitweb:        https://git.kernel.org/tip/2e90de76f226f11fe26c871aa321be28152f565a
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 25 May 2020 17:45:03 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:44 -07:00

refperf: Dynamically allocate thread-summary output buffer

Currently, the buffer used to accumulate the thread-summary output is
fixed size, which will cause problems if someone decides to run on a large
number of PCUs.  This commit therefore dynamically allocates this buffer.

[ paulmck: Fix memory allocation as suggested by KASAN. ]
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 75b9cce..fc940e3 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -301,9 +301,12 @@ u64 process_durations(int n)
 	int i;
 	struct reader_task *rt;
 	char buf1[64];
-	char buf[512];
+	char *buf;
 	u64 sum = 0;
 
+	buf = kmalloc(128 + nreaders * 32, GFP_KERNEL);
+	if (!buf)
+		return 0;
 	buf[0] = 0;
 	sprintf(buf, "Experiment #%d (Format: <THREAD-NUM>:<Total loop time in ns>)",
 		exp_idx);
@@ -322,6 +325,7 @@ u64 process_durations(int n)
 
 	PERFOUT("%s\n", buf);
 
+	kfree(buf);
 	return sum;
 }
 
