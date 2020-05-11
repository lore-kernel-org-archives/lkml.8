Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FC1C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7607220882
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbgEKU7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728046AbgEKU7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:16 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB0EC05BD09;
        Mon, 11 May 2020 13:59:16 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFW7-0005ed-6t; Mon, 11 May 2020 22:59:15 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CB1411C001F;
        Mon, 11 May 2020 22:59:14 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:14 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Save a few lines by using
 config_override_param initially
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923075476.390.8042140654477523357.tip-bot2@tip-bot2>
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

Commit-ID:     409670aa26b6a8c9c0fb34eb7a887b9fedc6952b
Gitweb:        https://git.kernel.org/tip/409670aa26b6a8c9c0fb34eb7a887b9fedc6952b
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 09 Apr 2020 16:58:00 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 07 May 2020 10:15:29 -07:00

torture: Save a few lines by using config_override_param initially

This commit saves a few lines of code by also using the bash
config_override_param() to set the initial list of Kconfig options from
the CFcommon file.  While in the area, it makes this function capable of
update-in-place on the file containing the cumulative Kconfig options,
thus avoiding annoying changes when adding another source of options.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 38 ++-----
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index c7534fd..52f8966 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -46,35 +46,29 @@ echo ' ---' `date`: Starting build
 echo ' ---' Kconfig fragment at: $config_template >> $resdir/log
 touch $resdir/ConfigFragment.input
 
-# Combine additional Kconfig options into an existing set such that newer
-# options win.  The first argument is the Kconfig source ID, the second
-# the source file within $T, the third the destination file within $T,
-# and the fourth and final the list of additional Kconfig options.
+# Combine additional Kconfig options into an existing set such that
+# newer options win.  The first argument is the Kconfig source ID, the
+# second the to-be-updated file within $T, and the third and final the
+# list of additional Kconfig options.  Note that a $2.tmp file is
+# created when doing the update.
 config_override_param () {
-	if test -n "$4"
+	if test -n "$3"
 	then
-		echo $4 | sed -e 's/^ *//' -e 's/ *$//' | tr -s " " "\012" > $T/Kconfig_args
+		echo $3 | sed -e 's/^ *//' -e 's/ *$//' | tr -s " " "\012" > $T/Kconfig_args
 		echo " --- $1" >> $resdir/ConfigFragment.input
 		cat $T/Kconfig_args >> $resdir/ConfigFragment.input
-		config_override.sh $T/$2 $T/Kconfig_args > $T/$3
+		config_override.sh $T/$2 $T/Kconfig_args > $T/$2.tmp
+		mv $T/$2.tmp $T/$2
 		# Note that "#CHECK#" is not permitted on commandline.
-	else
-		cp $T/$2 $T/$3
 	fi
 }
 
-if test -r "$config_dir/CFcommon"
-then
-	echo " --- $config_dir/CFcommon" >> $resdir/ConfigFragment.input
-	cat < $config_dir/CFcommon >> $resdir/ConfigFragment.input
-	cp $config_dir/CFcommon $T/Kc0
-else
-	echo > $T/Kc0
-fi
-config_override_param "$config_template" Kc0 Kc1 "`cat $config_template 2> /dev/null`"
-config_override_param "--kcsan options" Kc1 Kc2 "$TORTURE_KCONFIG_KCSAN_ARG"
-config_override_param "--kconfig argument" Kc2 Kc3 "$TORTURE_KCONFIG_ARG"
-cp $T/Kc3 $resdir/ConfigFragment
+echo > $T/KcList
+config_override_param "$config_dir/CFcommon" KcList "`cat $config_dir/CFcommon 2> /dev/null`"
+config_override_param "$config_template" KcList "`cat $config_template 2> /dev/null`"
+config_override_param "--kcsan options" KcList "$TORTURE_KCONFIG_KCSAN_ARG"
+config_override_param "--kconfig argument" KcList "$TORTURE_KCONFIG_ARG"
+cp $T/KcList $resdir/ConfigFragment
 
 base_resdir=`echo $resdir | sed -e 's/\.[0-9]\+$//'`
 if test "$base_resdir" != "$resdir" -a -f $base_resdir/bzImage -a -f $base_resdir/vmlinux
@@ -87,7 +81,7 @@ then
 	ln -s $base_resdir/.config $resdir  # for kvm-recheck.sh
 	# Arch-independent indicator
 	touch $resdir/builtkernel
-elif kvm-build.sh $T/Kc3 $resdir
+elif kvm-build.sh $T/KcList $resdir
 then
 	# Had to build a kernel for this test.
 	QEMU="`identify_qemu vmlinux`"
