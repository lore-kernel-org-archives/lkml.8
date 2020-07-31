Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF298C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B80EA22CAF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ccBzntq1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kVf5taYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732698AbgGaJZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732513AbgGaJXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4585FC061574;
        Fri, 31 Jul 2020 02:23:37 -0700 (PDT)
Date:   Fri, 31 Jul 2020 09:23:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187415;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ikwb6J4zl4uHIrkHPqyDHq7FbevZ55y/fU5KUCq6FC4=;
        b=ccBzntq1ctAUB+cX26Mo482SFEa4Wto3ErLmxH+JO/IBkFE+BEcH5csxEl9AX1NVODRG0t
        9fi7moFJbwI1uXXfAb000jgxT+7cw0tsyAQqVGHGmiCzsasXvBqze/puwOq4YkH2gkwMmH
        aB10d4/vn+2X7hF7N4wYzXKZs1Jluqq+9SWStxrc7oB+SNktinotOqIyg5gnmdF4srbtmB
        GNPWSEX6ZhFa12S7gGXmrgYEzS/SrDitWoa7ix+xeeTXw5v23flyqOoRPLY4PNrLjk6Oqv
        357RTLnMYkJd+3nbf3hlTTjBcB/94WY5Q6Qy2I2gNY90NG3LJIESLYtkAbAAaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187415;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ikwb6J4zl4uHIrkHPqyDHq7FbevZ55y/fU5KUCq6FC4=;
        b=kVf5taYya7DWQA9BdwfiZYJHht5uAv4iBYolcpQ9xxWyaftOyHCQrfY9DnsQn9s5LdrPZ9
        yiJvSKOZ9Dfq/ZDw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: No-CBs-related sleeps to idle priority
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618741530.4006.14529789092772976005.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     f5ca34643bbd84f514bdeee194c45dd1fb066ef2
Gitweb:        https://git.kernel.org/tip/f5ca34643bbd84f514bdeee194c45dd1fb066ef2
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 07 May 2020 16:36:10 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:58:50 -07:00

rcu: No-CBs-related sleeps to idle priority

This commit converts the schedule_timeout_interruptible() call used by
RCU's no-CBs grace-period kthreads to schedule_timeout_idle().  This
conversion avoids polluting the load-average with RCU-related sleeping.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 25296c1..982fc5b 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2005,7 +2005,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		/* Polling, so trace if first poll in the series. */
 		if (gotcbs)
 			trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Poll"));
-		schedule_timeout_interruptible(1);
+		schedule_timeout_idle(1);
 	} else if (!needwait_gp) {
 		/* Wait for callbacks to appear. */
 		trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Sleep"));
