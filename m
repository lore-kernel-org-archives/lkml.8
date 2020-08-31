Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D0BC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05C682083E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897099;
	bh=m6UCktBqgdRYQ/JJ5bZgpv5rgKSrubvrhWuJp5E5F4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ghbOtq0tBY+DJuvqiTcuBUhXxtamNVN6tUQUh7sQQmTG2eUMQ0Pk7f5yPpxNS0TWv
	 QtQD+9jVrVATy6raHsjrA8Vj1xq/m6YNjAYpqAMyLkIBYGNn8LpJg9WLiTvGw0qYCZ
	 Xu0fdKtp0WD7DG1ShOvA4E9AOGlv7mfHPTPf3BfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgHaSE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:04:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729358AbgHaSEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:04:10 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D22DC214DB;
        Mon, 31 Aug 2020 18:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897050;
        bh=m6UCktBqgdRYQ/JJ5bZgpv5rgKSrubvrhWuJp5E5F4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kTvHEVC1c07w9AXNoSHJL/mvI1WuhML0YnUX9rk0ulItmjW8DkD1oQAD03KHQuloS
         mDF1N4ZeANi8xIrnpWFamny/mlXk1laOeeeH7nkglmRlQIhx39MtcZ9iLAMRVmR/pf
         wyaytkX5I3AOuTh7j+9RuYKNXBLNTswCXOSDSaiU=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 06/14] torture: Update initrd documentation
Date:   Mon, 31 Aug 2020 11:03:58 -0700
Message-Id: <20200831180406.494-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180348.GA416@paulmck-ThinkPad-P72>
References: <20200831180348.GA416@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu-test-image.txt documentation covers a very uncommon case where
a real userspace environment is required.  However, someone reading this
document might reasonably conclude that this is in fact a prerequisite.
In addition, the initrd.txt file mentions dracut, which is no longer used.
This commit therefore provides the needed updates.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/doc/initrd.txt  | 36 +++++-----------------
 .../selftests/rcutorture/doc/rcu-test-image.txt    | 35 ++++++++++++++++++---
 2 files changed, 37 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/doc/initrd.txt b/tools/testing/selftests/rcutorture/doc/initrd.txt
index 933b4fd..41a4255 100644
--- a/tools/testing/selftests/rcutorture/doc/initrd.txt
+++ b/tools/testing/selftests/rcutorture/doc/initrd.txt
@@ -1,12 +1,11 @@
-The rcutorture scripting tools automatically create the needed initrd
-directory using dracut.  Failing that, this tool will create an initrd
-containing a single statically linked binary named "init" that loops
-over a very long sleep() call.  In both cases, this creation is done
-by tools/testing/selftests/rcutorture/bin/mkinitrd.sh.
+The rcutorture scripting tools automatically create an initrd containing
+a single statically linked binary named "init" that loops over a
+very long sleep() call.  In both cases, this creation is done by
+tools/testing/selftests/rcutorture/bin/mkinitrd.sh.
 
-However, if you are attempting to run rcutorture on a system that does
-not have dracut installed, and if you don't like the notion of static
-linking, you might wish to press an existing initrd into service:
+However, if you don't like the notion of statically linked bare-bones
+userspace environments, you might wish to press an existing initrd
+into service:
 
 ------------------------------------------------------------------------
 cd tools/testing/selftests/rcutorture
@@ -15,24 +14,3 @@ mkdir initrd
 cd initrd
 cpio -id < /tmp/initrd.img.zcat
 # Manually verify that initrd contains needed binaries and libraries.
-------------------------------------------------------------------------
-
-Interestingly enough, if you are running rcutorture, you don't really
-need userspace in many cases.  Running without userspace has the
-advantage of allowing you to test your kernel independently of the
-distro in place, the root-filesystem layout, and so on.  To make this
-happen, put the following script in the initrd's tree's "/init" file,
-with 0755 mode.
-
-------------------------------------------------------------------------
-#!/bin/sh
-
-while :
-do
-	sleep 10
-done
-------------------------------------------------------------------------
-
-This approach also allows most of the binaries and libraries in the
-initrd filesystem to be dispensed with, which can save significant
-space in rcutorture's "res" directory.
diff --git a/tools/testing/selftests/rcutorture/doc/rcu-test-image.txt b/tools/testing/selftests/rcutorture/doc/rcu-test-image.txt
index cc280ba..b2fc247 100644
--- a/tools/testing/selftests/rcutorture/doc/rcu-test-image.txt
+++ b/tools/testing/selftests/rcutorture/doc/rcu-test-image.txt
@@ -1,8 +1,33 @@
-This document describes one way to create the rcu-test-image file
-that contains the filesystem used by the guest-OS kernel.  There are
-probably much better ways of doing this, and this filesystem could no
-doubt be smaller.  It is probably also possible to simply download
-an appropriate image from any number of places.
+Normally, a minimal initrd is created automatically by the rcutorture
+scripting.  But minimal really does mean "minimal", namely just a single
+root directory with a single statically linked executable named "init":
+
+$ size tools/testing/selftests/rcutorture/initrd/init
+   text    data     bss     dec     hex filename
+    328       0       8     336     150 tools/testing/selftests/rcutorture/initrd/init
+
+Suppose you need to run some scripts, perhaps to monitor or control
+some aspect of the rcutorture testing.  This will require a more fully
+filled-out userspace, perhaps containing libraries, executables for
+the shell and other utilities, and soforth.  In that case, place your
+desired filesystem here:
+
+	tools/testing/selftests/rcutorture/initrd
+
+For example, your tools/testing/selftests/rcutorture/initrd/init might
+be a script that does any needed mount operations and starts whatever
+scripts need starting to properly monitor or control your testing.
+The next rcutorture build will then incorporate this filesystem into
+the kernel image that is passed to qemu.
+
+Or maybe you need a real root filesystem for some reason, in which case
+please read on!
+
+The remainder of this document describes one way to create the
+rcu-test-image file that contains the filesystem used by the guest-OS
+kernel.  There are probably much better ways of doing this, and this
+filesystem could no doubt be smaller.  It is probably also possible to
+simply download an appropriate image from any number of places.
 
 That said, here are the commands:
 
-- 
2.9.5

