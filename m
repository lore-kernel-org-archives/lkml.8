Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC12CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C2F20720
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592871754;
	bh=33gHmx2Zc4RUbwNmQo8hCICSdmeVLoBN8tfdIBgRlxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KwohaRK3zjguAfTNNJMbyVsnQ57P0DZ3KAJ43OWdUW39pFt/MocWcbbTfoA4s5zpy
	 2oxRfo5Sd4KTsZMWNFPe27raazHNvC44MwlqT+0XoOnkwcSHCiEK1UarXjeMQ1dOxJ
	 227Pd2MxkGgOawNWUaSavzUI6lzF+ml0yohg8QV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731713AbgFWAWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:22:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:48566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731566AbgFWAVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:21:53 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0E5820B80;
        Tue, 23 Jun 2020 00:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871713;
        bh=33gHmx2Zc4RUbwNmQo8hCICSdmeVLoBN8tfdIBgRlxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0gAWaAN5qmZUm2GdGs6FWAwoo3/4m9ic+6JZzr5MB5kM+FlmzjwUWr0Qk7lGQxJgR
         IrWsPaabvZI5EGVVMyVDH9Ca1GvSc/FfMXDR9fpKjV+u4dGUmNcBg53yaQXYiEpSEj
         qrpSPgUQPs37ovbGy3eqmYgS+wRnLcMzqERITQBE=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Jules Irenge <jbi.octave@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 18/26] rcu: Replace 1 with true
Date:   Mon, 22 Jun 2020 17:21:39 -0700
Message-Id: <20200623002147.25750-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002128.GA25456@paulmck-ThinkPad-P72>
References: <20200623002128.GA25456@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jules Irenge <jbi.octave@gmail.com>

Coccinelle reports a warning

WARNING: Assignment of 0/1 to bool variable

The root cause is that the variable lastphase is a bool, but is
initialised with integer 1.  This commit therefore replaces the 1 with
a true.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/update.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index ca17b77..a0ba885 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -207,7 +207,7 @@ void rcu_end_inkernel_boot(void)
 	rcu_unexpedite_gp();
 	if (rcu_normal_after_boot)
 		WRITE_ONCE(rcu_normal, 1);
-	rcu_boot_ended = 1;
+	rcu_boot_ended = true;
 }
 
 /*
-- 
2.9.5

