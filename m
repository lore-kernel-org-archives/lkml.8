Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B91C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EF56206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbgEKU7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728046AbgEKU7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:18 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84349C061A0C;
        Mon, 11 May 2020 13:59:18 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFW8-0005fZ-Ta; Mon, 11 May 2020 22:59:17 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7906B1C001F;
        Mon, 11 May 2020 22:59:16 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:16 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Eliminate duplicate #CHECK# from ConfigFragment
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923075643.390.8270731853350752134.tip-bot2@tip-bot2>
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

Commit-ID:     b5744d3c6c38a44e14894bc3ee17b98885e4852f
Gitweb:        https://git.kernel.org/tip/b5744d3c6c38a44e14894bc3ee17b98885e4852f
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 09 Apr 2020 15:32:56 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 07 May 2020 10:15:29 -07:00

torture: Eliminate duplicate #CHECK# from ConfigFragment

The #CHECK# directives that can be present in CFcommon and in the
rcutorture scenario Kconfig files are both copied to ConfigFragment
and grepped out of the two directive files and added to ConfigFragment.
This commit therefore removes the redundant "grep" commands and takes
advantage of the consequent opportunity to simplify redirection.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index e035230..74da059 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -44,19 +44,17 @@ then
 fi
 echo ' ---' `date`: Starting build
 echo ' ---' Kconfig fragment at: $config_template >> $resdir/log
-touch $resdir/ConfigFragment.input $resdir/ConfigFragment
+touch $resdir/ConfigFragment.input
 if test -r "$config_dir/CFcommon"
 then
 	echo " --- $config_dir/CFcommon" >> $resdir/ConfigFragment.input
 	cat < $config_dir/CFcommon >> $resdir/ConfigFragment.input
 	config_override.sh $config_dir/CFcommon $config_template > $T/Kc1
-	grep '#CHECK#' $config_dir/CFcommon >> $resdir/ConfigFragment
 else
 	cp $config_template $T/Kc1
 fi
 echo " --- $config_template" >> $resdir/ConfigFragment.input
 cat $config_template >> $resdir/ConfigFragment.input
-grep '#CHECK#' $config_template >> $resdir/ConfigFragment
 if test -n "$TORTURE_KCONFIG_ARG"
 then
 	echo $TORTURE_KCONFIG_ARG | tr -s " " "\012" > $T/cmdline
@@ -67,7 +65,7 @@ then
 else
 	cp $T/Kc1 $T/Kc2
 fi
-cat $T/Kc2 >> $resdir/ConfigFragment
+cat $T/Kc2 > $resdir/ConfigFragment
 
 base_resdir=`echo $resdir | sed -e 's/\.[0-9]\+$//'`
 if test "$base_resdir" != "$resdir" -a -f $base_resdir/bzImage -a -f $base_resdir/vmlinux
