Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F28C3B1BF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 00:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2002082F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 00:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581727335;
	bh=HqPklbUHPAKE7xzj27oVOEQl4YeBYJpuGITsXNi0X2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kVFio3Koy3DGUFGRvETw5MMQBlo8A3TXzi/0UMRmtqUNctlyLkBci6T9SZ1uTL7v2
	 j/F/TDd2YDupVP8rULh20dHdkZReb4Ko9j5LuVSe7vebIvWlWoCmF8IfJiO9mXeXj0
	 raoWt20LUEcgynEk64U8vLShznieGVhnbzcK9BsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgBOAmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:42:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:49250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728099AbgBOAmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:42:11 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDA9F2083B;
        Sat, 15 Feb 2020 00:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581727330;
        bh=HqPklbUHPAKE7xzj27oVOEQl4YeBYJpuGITsXNi0X2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K7P8rtso61MC/7U+bxLnRuP3VcidzYbSzHn4pXxscJaM1aOv9GfGTy2OU/MD55DwO
         TcWmCb0HIbCkuDgtj9Q3Wvja6oRjI9B0aCjdUxBIs9YAFIUtYtpHHGO4/2HFyYdwMn
         aQMbjr/V5IV7e9YZQkk2RAORARTpyi3mdpa4SqA0=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 18/18] rcutorture: Set KCSAN Kconfig options to detect more data races
Date:   Fri, 14 Feb 2020 16:41:25 -0800
Message-Id: <20200215004125.16953-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215003634.GA16227@paulmck-ThinkPad-P72>
References: <20200215003634.GA16227@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit enables the KCSAN Kconfig options that (1) detect data
races between reads and writes even when the writes do not change the
variable's value and (2) detect data races involving plain C-language
writes.  These changes only affect scripted rcutorture runs and can be
overridden using the kvm.sh --kconfig argument.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/CFcommon | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
index e19a444..0e92d85 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
@@ -3,3 +3,5 @@ CONFIG_PRINTK_TIME=y
 CONFIG_HYPERVISOR_GUEST=y
 CONFIG_PARAVIRT=y
 CONFIG_KVM_GUEST=y
+CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n
+CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n
-- 
2.9.5

