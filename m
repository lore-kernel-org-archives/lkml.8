Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400CEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1726F208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bw2p74Nc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OJn0c4f8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732225AbgGaJWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732167AbgGaJWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329F2C06174A;
        Fri, 31 Jul 2020 02:22:40 -0700 (PDT)
Date:   Fri, 31 Jul 2020 09:22:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187358;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XFOpBXf1QINttH+m9MtjYamLhfIhx4ZawLItFUfuuQg=;
        b=bw2p74NcEe7Bvk+Ii6+UIPaMa6IfFR0SzfrC85U44eRgzAZgNaR4wE4tqz8TJGIGJK4GnK
        ehLCaCR+adslJi2krncJ2qxAI3KMFDA9XHDMksFuUCJlnIeppiMRX9mhl8GNu27k7p4VJb
        PTF4Og+j66RyHzLUOmzHn8Asdsi2Bu4VDumAMKqIeT/JWSE6VjDR0fX9fyg44cUshtJnOX
        iy3H4o+Duzfw0QwRcypIqgnz95XqJmLIf6q3mu2NJatdhQyS+koRRMSBhowSsqOy+yRoAC
        lMa1RbVxxTCtud6BF6Gr8h1+E0F1+XTSjOibs4EOZH0qfQdvJgPYEymiOz7Fdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187358;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XFOpBXf1QINttH+m9MtjYamLhfIhx4ZawLItFUfuuQg=;
        b=OJn0c4f8VpBiQ4A71XLzo++7JJeH65uv7uXu9N1gS97hUuPazLDcAImSZ3mzfGZb0rfZp5
        DEqkzLp75Lbt3YCw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Add kvm-tranform.sh script for qemu-cmd files
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618735749.4006.11953520228982739185.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     06efa9b4b27f926eeb8c935f430f8557eb8b106e
Gitweb:        https://git.kernel.org/tip/06efa9b4b27f926eeb8c935f430f8557eb8b106e
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 16 Jun 2020 14:14:09 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:01:45 -07:00

torture: Add kvm-tranform.sh script for qemu-cmd files

This commit adds a script that transforms qemu-cmd files to allow them
and the corresponding kernels to be run in contexts other than the one
that they were created for, including on systems other than the one that
they were built on.  For example, this allows the build products from a
--buildonly run to be transformed to allow distributed rcutorture testing.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-transform.sh | 51 ++++++++-
 1 file changed, 51 insertions(+)
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-transform.sh

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-transform.sh b/tools/testing/selftests/rcutorture/bin/kvm-transform.sh
new file mode 100755
index 0000000..c45a953
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/kvm-transform.sh
@@ -0,0 +1,51 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Transform a qemu-cmd file to allow reuse.
+#
+# Usage: kvm-transform.sh bzImage console.log < qemu-cmd-in > qemu-cmd-out
+#
+#	bzImage: Kernel and initrd from the same prior kvm.sh run.
+#	console.log: File into which to place console output.
+#
+# The original qemu-cmd file is provided on standard input.
+# The transformed qemu-cmd file is on standard output.
+# The transformation assumes that the qemu command is confined to a
+# single line.  It also assumes no whitespace in filenames.
+#
+# Copyright (C) 2020 Facebook, Inc.
+#
+# Authors: Paul E. McKenney <paulmck@kernel.org>
+
+image="$1"
+if test -z "$image"
+then
+	echo Need kernel image file.
+	exit 1
+fi
+consolelog="$2"
+if test -z "$consolelog"
+then
+	echo "Need console log file name."
+	exit 1
+fi
+
+awk -v image="$image" -v consolelog="$consolelog" '
+{
+	line = "";
+	for (i = 1; i <= NF; i++) {
+		if (line == "")
+			line = $i;
+		else
+			line = line " " $i;
+		if ($i == "-serial") {
+			i++;
+			line = line " file:" consolelog;
+		}
+		if ($i == "-kernel") {
+			i++;
+			line = line " " image;
+		}
+	}
+	print line;
+}'
