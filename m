Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0797FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C943820781
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592871000;
	bh=qcJ/5t5PNa6BkRezuac2p2g5ttgTxTLc8Bz2YwjcuB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kl5Msd8FGUiFjMPFztJoJkuuva2WYAfN9BWvWHD8J0Zf7/oauxAVRfSkZLnzrsRUC
	 DUggi3hVlz6wUJa0nU7DnJxH8i/vfwbLsCj/tZ3P7RCzsseWsO0vITYTf6rc5gjdVL
	 BBhW9CjpRsYSJirdSoeGvjObUFYQwrg/0R+pMylQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbgFWAJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:09:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731410AbgFWAJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:09:52 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74A70208B8;
        Tue, 23 Jun 2020 00:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592870991;
        bh=qcJ/5t5PNa6BkRezuac2p2g5ttgTxTLc8Bz2YwjcuB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ytZkkAUON7BtJEPUwX6uSeyp8ttPfTtQaBHsBuRzRQi3EGvcN7oLLLm4krM9lLkt5
         vj9NDEsD3s8MkhmtPqJBVo2usrSTUBLEZLw5nDk07/8xHhYO3fHyX3GH3RHYUI7Rxb
         7t99EVSp0WCnaIOMfvAjmBChxqULWDkx7OscvCsY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 10/10] doc: Tasks RCU must protect instructions before trampoline
Date:   Mon, 22 Jun 2020 17:09:47 -0700
Message-Id: <20200623000947.25222-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623000923.GA25047@paulmck-ThinkPad-P72>
References: <20200623000923.GA25047@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Protecting the code in a trampoline can also require protecting a
number of instructions prior to actually entering the trampoline.
For example, these earlier instructions might be computing the address
of the trampoline.  This commit therefore updates RCU's requirements to
record this for posterity.

Link: https://lore.kernel.org/lkml/20200511154824.09a18c46@gandalf.local.home/
Reported-by: Lai Jiangshan <jiangshanlai@gmail.com>
Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/Design/Requirements/Requirements.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 75b8ca0..a69b5c4 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2583,7 +2583,12 @@ not work to have these markers in the trampoline itself, because there
 would need to be instructions following ``rcu_read_unlock()``. Although
 ``synchronize_rcu()`` would guarantee that execution reached the
 ``rcu_read_unlock()``, it would not be able to guarantee that execution
-had completely left the trampoline.
+had completely left the trampoline. Worse yet, in some situations
+the trampoline's protection must extend a few instructions *prior* to
+execution reaching the trampoline.  For example, these few instructions
+might calculate the address of the trampoline, so that entering the
+trampoline would be pre-ordained a surprisingly long time before execution
+actually reached the trampoline itself.
 
 The solution, in the form of `Tasks
 RCU <https://lwn.net/Articles/607117/>`__, is to have implicit read-side
-- 
2.9.5

