Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A229C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCA2520E65
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897070;
	bh=5ZSZxK/kV1hZegsiFZ8O9K44GQMHY/0mzvIOGJ1aFmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fqkuXIpmHiXmHxfuYy98hNd/VdCOL9vPzJqsVKE2YP+xCjfCRegNfo24HG8vxeEMk
	 h7NNMFlV7fihaimG/CKKcoBUS1Q2Jn1GW2FjOS4MEyL92njY7YX0/mIvNdtPYA6FLB
	 q/6xMyUg5jSy1rhRgOZpz5ID85bDvDJrBHGCT8Yk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbgHaSEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:04:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729365AbgHaSEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:04:11 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EC4C21707;
        Mon, 31 Aug 2020 18:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897050;
        bh=5ZSZxK/kV1hZegsiFZ8O9K44GQMHY/0mzvIOGJ1aFmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SqgsJ9kSlOV1KM6FdO52S3Mxu1W7dxQPCqmmWhO1172zAmaRs3u/jqF5o8pVqmmty
         4ASjzhLWLNZ0VXB1e4+MIcNCZ0A07Qo48pzV8s2t4WUsX5Bj7K4FqhxgfdIkYXxkCp
         6Lr5BhZrYcmwAmWkjwU5qlAmH0ejTjPORmqWU/QQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 08/14] torture: Add kvm.sh --help and update help message
Date:   Mon, 31 Aug 2020 11:04:00 -0700
Message-Id: <20200831180406.494-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180348.GA416@paulmck-ThinkPad-P72>
References: <20200831180348.GA416@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a --help argument (along with its synonym -h) to display
the help text.  While in the area, this commit also updates the help text.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 0a08463..fc15b52 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -56,17 +56,18 @@ usage () {
 	echo "       --defconfig string"
 	echo "       --dryrun sched|script"
 	echo "       --duration minutes"
+	echo "       --help"
 	echo "       --interactive"
 	echo "       --jitter N [ maxsleep (us) [ maxspin (us) ] ]"
 	echo "       --kconfig Kconfig-options"
 	echo "       --kmake-arg kernel-make-arguments"
 	echo "       --mac nn:nn:nn:nn:nn:nn"
-	echo "       --memory megabytes | nnnG"
+	echo "       --memory megabytes|nnnG"
 	echo "       --no-initrd"
 	echo "       --qemu-args qemu-arguments"
 	echo "       --qemu-cmd qemu-system-..."
 	echo "       --results absolute-pathname"
-	echo "       --torture rcu"
+	echo "       --torture lock|rcu|rcuperf|refscale|scf"
 	echo "       --trust-make"
 	exit 1
 }
@@ -127,6 +128,9 @@ do
 		dur=$(($2*60))
 		shift
 		;;
+	--help|-h)
+		usage
+		;;
 	--interactive)
 		TORTURE_QEMU_INTERACTIVE=1; export TORTURE_QEMU_INTERACTIVE
 		;;
-- 
2.9.5

