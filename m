Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1C3C3B1BF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 00:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3E3207FF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 00:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581727304;
	bh=VUkpiAnzyt7OTRrDXr8sI89PTPa7eWlAXWxwXQF1RRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cw/My+1EHJsEuAVJlEQR9hU0wGxJVrPZPZToLx02U/QZAtJ/v0YRO/fi8CV3pEEpE
	 Ftp8DXkgwmQD35qdCtqC/vY+L3sJQgmvZcgqsD3utTOgzo4R5HnzyuWari7Bm2Jg47
	 xLL1toLrFl71o+N2pEmoQ4VK3RyZWl5yR/fjGv2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgBOAln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:41:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:48582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgBOAlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:41:42 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68813217F4;
        Sat, 15 Feb 2020 00:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581727302;
        bh=VUkpiAnzyt7OTRrDXr8sI89PTPa7eWlAXWxwXQF1RRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WTu2lpL7VeD6/3Wj9SbFp/ClYH3SZKvnk6ukfZ8MDt8FQEo42uSBu9+RG2isllsdq
         aan7xaDkzxDpGNOy3sqpoBrmLtSYb7JwXqU2J90DuaGKjl4UbBEBvOlbsI03wERxcf
         fUfZb3mX4fJwoteGmSpnt6NR5E7R6+pXTHL3Z4t4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 10/18] rcutorture: Make kvm-find-errors.sh abort on bad directory
Date:   Fri, 14 Feb 2020 16:41:17 -0800
Message-Id: <20200215004125.16953-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215003634.GA16227@paulmck-ThinkPad-P72>
References: <20200215003634.GA16227@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, kvm-find-errors.sh gives a usage prompt when given a bad
directory, but then soldiers on, giving a series of confusing error
messages.  This commit therefore prints an error message and exits when
given a bad directory, hopefully reducing confusion.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
index 1871d00..6f50722 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
@@ -20,7 +20,9 @@
 rundir="${1}"
 if test -z "$rundir" -o ! -d "$rundir"
 then
+	echo Directory "$rundir" not found.
 	echo Usage: $0 directory
+	exit 1
 fi
 editor=${EDITOR-vi}
 
-- 
2.9.5

