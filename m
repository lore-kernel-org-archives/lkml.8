Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A750BC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9406820882
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731348AbgEKU7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730215AbgEKU7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:18 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180FEC061A0C;
        Mon, 11 May 2020 13:59:18 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFW8-0005fL-DD; Mon, 11 May 2020 22:59:16 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 010DE1C0494;
        Mon, 11 May 2020 22:59:16 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:15 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Abstract application of additional Kconfig options
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923075593.390.3795753886843663390.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     6be63d7d9c149143a9af19085516ddba6ab6a2af
Gitweb:        https://git.kernel.org/tip/6be63d7d9c149143a9af19085516ddba6ab6a2af
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 09 Apr 2020 16:02:23 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 07 May 2020 10:15:29 -07:00

torture: Abstract application of additional Kconfig options

This commit introduces a config_override_param() bash function that
folds in an additional set of Kconfig options.  This is initially applied
to fold in the --kconfig kvm.sh parameter, but later commits will also
apply it to the Kconfig options added by the --kcsan kvm.sh parameter.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 31 ++++---
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 74da059..1801b06 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -45,6 +45,24 @@ fi
 echo ' ---' `date`: Starting build
 echo ' ---' Kconfig fragment at: $config_template >> $resdir/log
 touch $resdir/ConfigFragment.input
+
+# Combine additional Kconfig options into an existing set such that newer
+# options win.  The first argument is the Kconfig source ID, the second
+# the source file within $T, the third the destination file within $T,
+# and the fourth and final the list of additional Kconfig options.
+config_override_param () {
+	if test -n "$4"
+	then
+		echo $4 | sed -e 's/^ *//' -e 's/ *$//' | tr -s " " "\012" > $T/Kconfig_args
+		echo " --- $1" >> $resdir/ConfigFragment.input
+		cat $T/Kconfig_args >> $resdir/ConfigFragment.input
+		config_override.sh $T/$2 $T/Kconfig_args > $T/$3
+		# Note that "#CHECK#" is not permitted on commandline.
+	else
+		cp $T/$2 $T/$3
+	fi
+}
+
 if test -r "$config_dir/CFcommon"
 then
 	echo " --- $config_dir/CFcommon" >> $resdir/ConfigFragment.input
@@ -55,17 +73,8 @@ else
 fi
 echo " --- $config_template" >> $resdir/ConfigFragment.input
 cat $config_template >> $resdir/ConfigFragment.input
-if test -n "$TORTURE_KCONFIG_ARG"
-then
-	echo $TORTURE_KCONFIG_ARG | tr -s " " "\012" > $T/cmdline
-	echo " --- --kconfig argument" >> $resdir/ConfigFragment.input
-	cat $T/cmdline >> $resdir/ConfigFragment.input
-	config_override.sh $T/Kc1 $T/cmdline > $T/Kc2
-	# Note that "#CHECK#" is not permitted on commandline.
-else
-	cp $T/Kc1 $T/Kc2
-fi
-cat $T/Kc2 > $resdir/ConfigFragment
+config_override_param "--kconfig argument" Kc1 Kc2 "$TORTURE_KCONFIG_ARG"
+cp $T/Kc2 $resdir/ConfigFragment
 
 base_resdir=`echo $resdir | sed -e 's/\.[0-9]\+$//'`
 if test "$base_resdir" != "$resdir" -a -f $base_resdir/bzImage -a -f $base_resdir/vmlinux
