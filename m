Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FE1C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B544208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="plyQet7f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D7Mg+3wE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732928AbgGaJ2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:28:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56344 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732203AbgGaJWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:51 -0400
Date:   Fri, 31 Jul 2020 09:22:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zkvscX6ZdSWmORe/q9F52pVi9blxgznm8DDxOMkFxDg=;
        b=plyQet7f738U5yUtIUVSBEmZ4LCxUa1ctVxl5RWgR9DhvCIp9yz6r60MNI3i4wMgChDBF+
        sWCLhK2lwAz7w8ZFiubgKZghkYTfzvS0h8034UU/s8g1Y/Bkk/GETb+Cpv+0PoSfCQ208w
        drIvaLp92qOgA7AK4gLfZtVbvvcyTiuXxELgQECkDFoE7Ilzu/tHauPW7xKNlmRpR8QSAT
        a5gHaYLha1WDsafCqa00se49O/MrgXZ2ptXbbkB++abluw4BWac8BjJSBFwr7SxM5GBTBP
        zr8xrcQDdrgOZ6WsqUramdjiZ5r2vJYpoGn/7sK4/iPTKwtMua41f37mCH+ayQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zkvscX6ZdSWmORe/q9F52pVi9blxgznm8DDxOMkFxDg=;
        b=D7Mg+3wEKL/aAEV6pZMvZOx0AUhLTY54GwjmohTG3R+WYJymaVjqI4y1tPGyVWyCcsvXra
        xxygoxvbURDZViCw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Remove qemu dependency on EFI firmware
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20190701141403.GA246562@google.com>
References: <20190701141403.GA246562@google.com>
MIME-Version: 1.0
Message-ID: <159618736927.4006.11288693239254927787.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     88513ae533756d10358e406743c21e8cf61fb72a
Gitweb:        https://git.kernel.org/tip/88513ae533756d10358e406743c21e8cf61fb72a
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 28 Apr 2020 14:41:48 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:01:43 -07:00

torture:  Remove qemu dependency on EFI firmware

On some (probably misconfigured) systems, the torture-test scripting
will cause qemu to complain about missing EFI firmware, often because
qemu is trying to traverse broken symbolic links to find that firmware.
Which is a bit silly given that the default torture-test guest OS has
but a single binary for its userspace, and thus is unlikely to do much
in the way of networking in any case.

This commit therefore avoids such problems by specifying "-net none"
to qemu unless the TORTURE_QEMU_INTERACTIVE environment variable is set
(for example, by having specified "--interactive" to kvm.sh), in which
case "-net nic -net user" is specified to qemu instead.  Either choice
may be overridden by specifying the "-net" argument of your choice to
the kvm.sh "--qemu-args" parameter.

Link: https://lore.kernel.org/lkml/20190701141403.GA246562@google.com
Reported-by: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 tools/testing/selftests/rcutorture/bin/functions.sh      | 21 ++++++-
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh |  1 +-
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index 1281022..436b154 100644
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -215,9 +215,6 @@ identify_qemu_args () {
 		then
 			echo -device spapr-vlan,netdev=net0,mac=$TORTURE_QEMU_MAC
 			echo -netdev bridge,br=br0,id=net0
-		elif test -n "$TORTURE_QEMU_INTERACTIVE"
-		then
-			echo -net nic -net user
 		fi
 		;;
 	esac
@@ -275,3 +272,21 @@ specify_qemu_cpus () {
 		esac
 	fi
 }
+
+# specify_qemu_net qemu-args
+#
+# Appends a string containing "-net none" to qemu-args, unless the incoming
+# qemu-args already contains "-smp" or unless the TORTURE_QEMU_INTERACTIVE
+# environment variable is set, in which case the string that is be added is
+# instead "-net nic -net user".
+specify_qemu_net () {
+	if echo $1 | grep -q -e -net
+	then
+		echo $1
+	elif test -n "$TORTURE_QEMU_INTERACTIVE"
+	then
+		echo $1 -net nic -net user
+	else
+		echo $1 -net none
+	fi
+}
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 6ff611c..1b9aebd 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -141,6 +141,7 @@ then
 	cpu_count=$TORTURE_ALLOTED_CPUS
 fi
 qemu_args="`specify_qemu_cpus "$QEMU" "$qemu_args" "$cpu_count"`"
+qemu_args="`specify_qemu_net "$qemu_args"`"
 
 # Generate architecture-specific and interaction-specific qemu arguments
 qemu_args="$qemu_args `identify_qemu_args "$QEMU" "$resdir/console.log"`"
