Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C683C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 095D722B40
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="frmDXbLU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t7cjv8RK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732884AbgGaJ1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:27:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56434 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732339AbgGaJXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:05 -0400
Date:   Fri, 31 Jul 2020 09:23:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187383;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=LpICeYlP0ZLqXrpm6Kf1JML5onMJzwE9/ZMd222cnBg=;
        b=frmDXbLUfd6x52Qr0Idu2TIsaI3MyUDtjNFol1SM9pbXUydByjcJqawPfGwoPA4JgNqlTl
        hGOpJ47TAbpwKBzgms08cWjdrVOhYRtBb7HRQ4TNpVruUTqhbraOv58A2aolNliuX/qyGk
        eQr3XG7SO6uas2ssv1GYG/YayseUVt8IGWD5b4El6UgFaF4ctHDlWJHMZZgRR9k2EI4LSy
        hpW/sEIWJP3dfozoces1wXY99m1BPVNUyGOyfp3YBK+wFkAqy8UnPfnM4Rqt1kbV0RIhJV
        f2akY5tWW/Ycek8oxYj8sP09PPE2hUk8yBENfpxm1k9IyRia1dRvn+zUEoWQ5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187383;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=LpICeYlP0ZLqXrpm6Kf1JML5onMJzwE9/ZMd222cnBg=;
        b=t7cjv8RKp+1mVA9P/+9naZMhg072XvhgaJlpDzjhhFqUw9cAlEieCjFplPIkEuhm1IRjeW
        6Z/Aonq5q1uv7aBQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] refperf: Make functions static
Cc:     kbuild test robot <lkp@intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618738307.4006.16361452357164195990.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     2990750bceb05c3cdeae3a6d2683cbc4ae4de15e
Gitweb:        https://git.kernel.org/tip/2990750bceb05c3cdeae3a6d2683cbc4ae4de15e
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 26 May 2020 09:32:57 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:45 -07:00

refperf: Make functions static

Because the reset_readers() and process_durations() functions are used
only within kernel/rcu/refperf.c, this commit makes them static.

Reported-by: kbuild test robot <lkp@intel.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index fc940e3..0a900f3 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -283,7 +283,7 @@ end:
 	return 0;
 }
 
-void reset_readers(void)
+static void reset_readers(void)
 {
 	int i;
 	struct reader_task *rt;
@@ -296,7 +296,7 @@ void reset_readers(void)
 }
 
 // Print the results of each reader and return the sum of all their durations.
-u64 process_durations(int n)
+static u64 process_durations(int n)
 {
 	int i;
 	struct reader_task *rt;
