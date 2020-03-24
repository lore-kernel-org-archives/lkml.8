Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AE0C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8392208D6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgCXJQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:16:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43898 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbgCXJQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:37 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGffm-0007xf-OB; Tue, 24 Mar 2020 10:16:34 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CB2BB1C0493;
        Tue, 24 Mar 2020 10:16:32 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:32 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Add READ_ONCE() to rcu_torture_count and
 rcu_torture_batch
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504139248.28353.2678997832857467483.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     f042a436c8dc9f9cfe8ed1ee5de372697269657d
Gitweb:        https://git.kernel.org/tip/f042a436c8dc9f9cfe8ed1ee5de372697269657d
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 03 Jan 2020 16:27:00 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 16:03:31 -08:00

rcutorture: Add READ_ONCE() to rcu_torture_count and rcu_torture_batch

The rcutorture rcu_torture_count and rcu_torture_batch per-CPU variables
are read locklessly, so this commit adds the READ_ONCE() to a load in
order to avoid various types of compiler vandalism^Woptimization.

This data race was reported by KCSAN. Not appropriate for backporting
due to failure being unlikely and due to this being rcutorture.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 124160a..0b9ce9a 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1413,8 +1413,8 @@ rcu_torture_stats_print(void)
 
 	for_each_possible_cpu(cpu) {
 		for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++) {
-			pipesummary[i] += per_cpu(rcu_torture_count, cpu)[i];
-			batchsummary[i] += per_cpu(rcu_torture_batch, cpu)[i];
+			pipesummary[i] += READ_ONCE(per_cpu(rcu_torture_count, cpu)[i]);
+			batchsummary[i] += READ_ONCE(per_cpu(rcu_torture_batch, cpu)[i]);
 		}
 	}
 	for (i = RCU_TORTURE_PIPE_LEN - 1; i >= 0; i--) {
