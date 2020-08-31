Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65674C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33A112083E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897073;
	bh=c1eX5BAARmAO38R1wBxSSMBka8xaHIKq0uGffIOgYkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZxaMkt2wAoKkR6ExLzUTgGMasPpRro7e0Bl9RfAK8kG5QnFQjsq2GUv2sRAoTgCaW
	 2Kx82e9ykkhKBaodvt9U3RjdivDwl9HJEQX6DcWkA0X8fC4S9o7jDnErQuNxjFSRmK
	 Oijw9dxlpCeKjXr7muHJNkcwrQdabFCbpYUy7zxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbgHaSEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728048AbgHaSEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:04:08 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A943E2083E;
        Mon, 31 Aug 2020 18:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897048;
        bh=c1eX5BAARmAO38R1wBxSSMBka8xaHIKq0uGffIOgYkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fnnn0F+hkdS1qBuz+A9GT18+fXi2Rtk64EVECR8GVIzo6OVmN/9Y88NpFYMweDNhd
         AoUuD+SFYi0pm05BtFN3khjB1VD3oOe0WGbBhaNJEOjUCJ86cxZ93GKawXphEqBOWe
         f0AVL44fcXUGNXAksoKDNFZz3hLRTC6uiNHz+Qds=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 01/14] rcutorture: Remove KCSAN stubs
Date:   Mon, 31 Aug 2020 11:03:53 -0700
Message-Id: <20200831180406.494-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180348.GA416@paulmck-ThinkPad-P72>
References: <20200831180348.GA416@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

KCSAN is now in mainline, so this commit removes the stubs for the
data_race(), ASSERT_EXCLUSIVE_WRITER(), and ASSERT_EXCLUSIVE_ACCESS()
macros.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index f453bf8..db37861 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -52,19 +52,6 @@
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com> and Josh Triplett <josh@joshtriplett.org>");
 
-#ifndef data_race
-#define data_race(expr)							\
-	({								\
-		expr;							\
-	})
-#endif
-#ifndef ASSERT_EXCLUSIVE_WRITER
-#define ASSERT_EXCLUSIVE_WRITER(var) do { } while (0)
-#endif
-#ifndef ASSERT_EXCLUSIVE_ACCESS
-#define ASSERT_EXCLUSIVE_ACCESS(var) do { } while (0)
-#endif
-
 /* Bits for ->extendables field, extendables param, and related definitions. */
 #define RCUTORTURE_RDR_SHIFT	 8	/* Put SRCU index in upper bits. */
 #define RCUTORTURE_RDR_MASK	 ((1 << RCUTORTURE_RDR_SHIFT) - 1)
-- 
2.9.5

