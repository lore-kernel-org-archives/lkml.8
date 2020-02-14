Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126CEC3B1BF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 23:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D467322314
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 23:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581724586;
	bh=IB7d62IQq5RwmgoRniVB/fZVD/cmuaexuhC+RX0oeOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eec2kBAwHOAWWlqlOCBpQXi4xCJF10nQeRa6ZbdVxN+/ObdYdAcA3H+kBqn9ClPr2
	 x2VUa7bk6FG5uTo0rd585Pk9DA4DQhISZf3CuoJHSaSkr77PrS1aHmwSwGc/uaDGU+
	 OXzUCbJ/EzNMY79cO3o7j+BRt7JYLpN4F5FaL9nY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgBNX40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:56:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:36180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbgBNX4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 18:56:25 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B402A24649;
        Fri, 14 Feb 2020 23:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581724584;
        bh=IB7d62IQq5RwmgoRniVB/fZVD/cmuaexuhC+RX0oeOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ndn0LLnTPJ31iZMPY9XqR1Izv8/2I+7cN+7BvHkjy2Z9pTwmnS0Zcbs+ZwL2PY1qE
         UCLeG/R8jc4KH7AWpp6qybVBmrLZrHh6HoQTiTF9v7Cemmx/ijLy7oidgrr2FdmqHU
         vrEJKntN8xiKbXcU0kBbPspupbwm4+i5cnswc3T8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 04/30] rcu: Provide debug symbols and line numbers in KCSAN runs
Date:   Fri, 14 Feb 2020 15:55:41 -0800
Message-Id: <20200214235607.13749-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200214235536.GA13364@paulmck-ThinkPad-P72>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds "-g -fno-omit-frame-pointer" to ease interpretation
of KCSAN output, but only for CONFIG_KCSAN=y kerrnels.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/Makefile b/kernel/rcu/Makefile
index 82d5fba..f91f2c2 100644
--- a/kernel/rcu/Makefile
+++ b/kernel/rcu/Makefile
@@ -3,6 +3,10 @@
 # and is generally not a function of system call inputs.
 KCOV_INSTRUMENT := n
 
+ifeq ($(CONFIG_KCSAN),y)
+KBUILD_CFLAGS += -g -fno-omit-frame-pointer
+endif
+
 obj-y += update.o sync.o
 obj-$(CONFIG_TREE_SRCU) += srcutree.o
 obj-$(CONFIG_TINY_SRCU) += srcutiny.o
-- 
2.9.5

