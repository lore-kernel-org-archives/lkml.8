Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B16C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9B4F208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AQTYsXM0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hYbyDe6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732933AbgGaJ2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:28:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56350 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732223AbgGaJWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:47 -0400
Date:   Fri, 31 Jul 2020 09:22:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187366;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BeyC/p7pZv5CR8pQNojnRUIhBZ+uh4RVMO24o7/VibI=;
        b=AQTYsXM07z26ilzm112/0KhhPbx6taAYP+c05psQIxTKLVC/QEiD2ahVUj1Ugpy+SHnCP1
        YpxOtvIKSJNl4/J2+CDBSbKq1Fi++pDjklH1PxsdaFwL0algUUGYi5PRr5ekmZDCCYr1Ji
        6yrpv5oXMQOQFdEbTHrtJFxEBm+Fcr2vrMIi3QovzezmT6UcUouRG59w1i3W1oc186I8Ta
        /OxYlSFPqc8oFBV8FeSCH9irGFeQKLWZuxa9tfMC3Ui87T0AWqVpleM8v7qoAolaC5So/m
        3u2fWe1AKNgXynk0e1Q2BJ2k/1WJhfJ+PR9IoiHkw3O82WOhk2Kdf89b65FiAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187366;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BeyC/p7pZv5CR8pQNojnRUIhBZ+uh4RVMO24o7/VibI=;
        b=hYbyDe6xVkTZuHTx0yWggKJqtcR5ELxJkVrf8rp8rGDafynYFPvvehPWoo3UPpn8o3ljOM
        kufZKBTDvB36AFDw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: NULL rcu_torture_current earlier in cleanup code
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618736537.4006.12539331813320292478.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     cae7cc6ba5bad320c2055ac54f73affd051e76ca
Gitweb:        https://git.kernel.org/tip/cae7cc6ba5bad320c2055ac54f73affd051e76ca
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 26 Apr 2020 19:20:37 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:01:44 -07:00

rcutorture: NULL rcu_torture_current earlier in cleanup code

Currently, the rcu_torture_current variable remains non-NULL until after
all readers have stopped.  During this time, rcu_torture_stats_print()
will think that the test is still ongoing, which can result in confusing
dmesg output.  This commit therefore NULLs rcu_torture_current immediately
after the rcu_torture_writer() kthread has decided to stop, thus informing
rcu_torture_stats_print() much sooner.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 2621a33..5911207 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1172,6 +1172,7 @@ rcu_torture_writer(void *arg)
 					WARN(1, "%s: rtort_pipe_count: %d\n", __func__, rcu_tortures[i].rtort_pipe_count);
 				}
 	} while (!torture_must_stop());
+	rcu_torture_current = NULL;  // Let stats task know that we are done.
 	/* Reset expediting back to unexpedited. */
 	if (expediting > 0)
 		expediting = -expediting;
@@ -2473,7 +2474,6 @@ rcu_torture_cleanup(void)
 					     reader_tasks[i]);
 		kfree(reader_tasks);
 	}
-	rcu_torture_current = NULL;
 
 	if (fakewriter_tasks) {
 		for (i = 0; i < nfakewriters; i++) {
