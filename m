Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE97C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5758422CAD
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WoSq6Ify";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S5AsXXPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732302AbgGaJW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:22:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56344 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732235AbgGaJWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:48 -0400
Date:   Fri, 31 Jul 2020 09:22:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187367;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jBoOhsEWZoLYOhA8Q7IrkGTmWoGwlT/jzq9cCnTUnDQ=;
        b=WoSq6Ify/ORF/ebLcYT8pwSU4jh2aX7esytsLYTYnFTn2KZibnOuEfXfBJoR1xm3XxTZ8L
        VRonMjFEf2ATyzIOUF7QfoOCVIoQeUrb9yVZKbSnDFhj/s+Pa2141eFBHqu3WNVMVoG/Vk
        e2m66iuWT0u6Agc1JDlL4GzM5VZevaOZxm9/UWb1757s+3dwPhgaQR5gqhFVzGEW+IeF47
        J+jIyd6EUkSWhYCcjBm5yDOiKVwFeK7dlGa67DGg5uw7BPHEtu78f0hYzkIgvh6ME+N6pd
        x6dpSz/qrgJdoFswQt6/GxsQM6qafpa/My3CfJe+xPJCwlR5HHrOHYMmHOb3Bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187367;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jBoOhsEWZoLYOhA8Q7IrkGTmWoGwlT/jzq9cCnTUnDQ=;
        b=S5AsXXPgf4bGvq3zab1A8dVTEoOPqSbEfI/BPm/6qzzgOL2YfgyUEWkj4u3lqnYVZpcCWB
        2SKyAIOt6a7Uj7Cg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Set configfile variable to current scenario
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618736668.4006.10295126204104607934.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     61251d6899803594a108c3165aeb072c73e09cc8
Gitweb:        https://git.kernel.org/tip/61251d6899803594a108c3165aeb072c73e09cc8
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 26 Apr 2020 16:48:46 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:01:44 -07:00

torture: Set configfile variable to current scenario

The torture-test recheck logic fails to set the configfile variable to
the current scenario, so this commit properly initializes this variable.
This change isn't critical given that all errors for a given scenario
follow that scenario's heading, but it is easier on the eyes to repeat it.
And this repetition also prevents confusion as to whether a given message
goes with the previous heading or the next one.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
index 736f047..2261aa6 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
@@ -31,6 +31,7 @@ do
 			head -1 $resdir/log
 		fi
 		TORTURE_SUITE="`cat $i/../TORTURE_SUITE`"
+		configfile=`echo $i | sed -e 's,^.*/,,'`
 		rm -f $i/console.log.*.diags
 		kvm-recheck-${TORTURE_SUITE}.sh $i
 		if test -f "$i/qemu-retval" && test "`cat $i/qemu-retval`" -ne 0 && test "`cat $i/qemu-retval`" -ne 137
