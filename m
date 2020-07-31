Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2940AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01F1E208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W05QWYxN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zd2PZiAG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732630AbgGaJ1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:27:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56338 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732248AbgGaJXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:08 -0400
Date:   Fri, 31 Jul 2020 09:23:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187387;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vN4LX5+UNWWR0Tpvlc++XA8VPecElgwFcEcaOtarg50=;
        b=W05QWYxNn99OmZB2jQbFQPBNM8sOPlfg0QOvheNcoMxf17z0keI6GT+gmIi7VqKJ+bWUNn
        sbtwsB2v1/uyxDIM4Y3zkW/nuRlT7jQaGh3QAakOOLJ2c+i65Gzy6V07Xk6UlzQItewmMf
        SojeQDdLLailKx5uJOjNKnz/tT4CMedPma86wjYY+JQIQND8bgkFPzgLjIRRcNEWIgNI1I
        u0ezS9SbaJ/zxQ6GjzVODunAr9jEbYm3JBquo4t8tMxOd7DhU8QcrtsjGeqhd7JGaH7Auc
        9P0B2zpyuqwiSfOCe432eI1BFb0GiHo7PTmFc/tXcfTLyW8thxnJ41y0LXtuoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187387;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vN4LX5+UNWWR0Tpvlc++XA8VPecElgwFcEcaOtarg50=;
        b=Zd2PZiAGrbcrsmt6nnaDiaTvtMrfbPfyvRovtrwxDfLDuA5OJi0Rex9694vmp/G6gL7JAz
        SHcFHHbzx6X73UAg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] refperf: Allow decimal nanoseconds
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618738645.4006.7605038959064014144.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     83b88c86da0e5f97faeac5a9bb19fe32f8c0394b
Gitweb:        https://git.kernel.org/tip/83b88c86da0e5f97faeac5a9bb19fe32f8c0394b
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 25 May 2020 15:31:07 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:44 -07:00

refperf: Allow decimal nanoseconds

The CONFIG_PREEMPT=n rcu_read_lock()/rcu_read_unlock() pair's overhead,
even including loop overhead, is far less than one nanosecond.
Since logscale plots are not all that happy with zero values, provide
picoseconds as decimals.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 57c7b7a..e991d48 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -375,7 +375,7 @@ static int main_func(void *arg)
 		if (torture_must_stop())
 			goto end;
 
-		reader_tasks[exp].result_avg = process_durations(exp) / ((exp + 1) * loops);
+		reader_tasks[exp].result_avg = 1000 * process_durations(exp) / ((exp + 1) * loops);
 	}
 
 	// Print the average of all experiments
@@ -386,7 +386,7 @@ static int main_func(void *arg)
 	strcat(buf, "Threads\tTime(ns)\n");
 
 	for (exp = 0; exp < nreaders; exp++) {
-		sprintf(buf1, "%d\t%llu\n", exp + 1, reader_tasks[exp].result_avg);
+		sprintf(buf1, "%d\t%llu.%03d\n", exp + 1, reader_tasks[exp].result_avg / 1000, (int)(reader_tasks[exp].result_avg % 1000));
 		strcat(buf, buf1);
 	}
 
