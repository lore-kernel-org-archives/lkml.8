Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48545C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C3822522
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbgAYKpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:45:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44325 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729701AbgAYKnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:43:17 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIuI-0000BE-EP; Sat, 25 Jan 2020 11:43:14 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 132B51C1A79;
        Sat, 25 Jan 2020 11:42:54 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:53 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Dispense with Dracut for initrd creation
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994897387.396.11740216561501375357.tip-bot2@tip-bot2>
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

Commit-ID:     9aa55ec206a6841e297c9df7e737b3d57f048a82
Gitweb:        https://git.kernel.org/tip/9aa55ec206a6841e297c9df7e737b3d57f048a82
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sat, 12 Oct 2019 15:29:02 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 09 Dec 2019 13:00:26 -08:00

rcutorture: Dispense with Dracut for initrd creation

The dracut scripting does not work on all platforms, and there are no
known failures from the init binary based on the statically linked C
program.  This commit therefore removes the dracut scripting so that the
statically linked C program is always used to create the init "script".

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/mkinitrd.sh | 55 +-------------
 1 file changed, 3 insertions(+), 52 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
index 6fa9bd1..38e424d 100755
--- a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
+++ b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
@@ -20,58 +20,9 @@ if [ -s "$D/initrd/init" ]; then
     exit 0
 fi
 
-T=${TMPDIR-/tmp}/mkinitrd.sh.$$
-trap 'rm -rf $T' 0 2
-mkdir $T
-
-cat > $T/init << '__EOF___'
-#!/bin/sh
-# Run in userspace a few milliseconds every second.  This helps to
-# exercise the NO_HZ_FULL portions of RCU.  The 192 instances of "a" was
-# empirically shown to give a nice multi-millisecond burst of user-mode
-# execution on a 2GHz CPU, as desired.  Modern CPUs will vary from a
-# couple of milliseconds up to perhaps 100 milliseconds, which is an
-# acceptable range.
-#
-# Why not calibrate an exact delay?  Because within this initrd, we
-# are restricted to Bourne-shell builtins, which as far as I know do not
-# provide any means of obtaining a fine-grained timestamp.
-
-a4="a a a a"
-a16="$a4 $a4 $a4 $a4"
-a64="$a16 $a16 $a16 $a16"
-a192="$a64 $a64 $a64"
-while :
-do
-	q=
-	for i in $a192
-	do
-		q="$q $i"
-	done
-	sleep 1
-done
-__EOF___
-
-# Try using dracut to create initrd
-if command -v dracut >/dev/null 2>&1
-then
-	echo Creating $D/initrd using dracut.
-	# Filesystem creation
-	dracut --force --no-hostonly --no-hostonly-cmdline --module "base" $T/initramfs.img
-	cd $D
-	mkdir -p initrd
-	cd initrd
-	zcat $T/initramfs.img | cpio -id
-	cp $T/init init
-	chmod +x init
-	echo Done creating $D/initrd using dracut
-	exit 0
-fi
-
-# No dracut, so create a C-language initrd/init program and statically
-# link it.  This results in a very small initrd, but might be a bit less
-# future-proof than dracut.
-echo "Could not find dracut, attempting C initrd"
+# Create a C-language initrd/init infinite-loop program and statically
+# link it.  This results in a very small initrd.
+echo "Creating a statically linked C-language initrd"
 cd $D
 mkdir -p initrd
 cd initrd
