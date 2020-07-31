Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004FEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDF7C22BF3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Ge69nBk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="et5m62g+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732152AbgGaJWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:22:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56324 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732037AbgGaJWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:38 -0400
Date:   Fri, 31 Jul 2020 09:22:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187356;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ZTo8q74qq1GjbZg40Xm1FxIkjnUJrsnWtKytdKzob3U=;
        b=2Ge69nBkAEVYNrgkhCa0XfkAtkyaVN4bK9UWbuYaPdOjXRZ7N+vT4KHWENO9VPJZ6dRKFz
        nB9gA3Gwtk+BaI5QKZWFEpQFUyQkJ9Whl1IPhzHg1Lt4pbDkj0Zr49s4qxz/dVs6D6dvLm
        dSy8+eFNeHt13OQD3gpUxL294BrP8gERKc0bfI7OoKgwPCjcaYRB7XiSyy3d+H+NFKx06u
        plSo8P18nNGW4xIyprm1YiTtItp4czvm0Z5o2e28arFbvVDdPaESLg4+Z0M77AY4Ou8ltm
        oODGXjoiruQNYLL9AKLkLB6fTyqABMBP79OsGkhsuc91eXIiBdvlPx3I5dcy/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187356;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ZTo8q74qq1GjbZg40Xm1FxIkjnUJrsnWtKytdKzob3U=;
        b=et5m62g++KQ9Uuo8cWpttIJddz7ZLlNJEOeqoakLB03f2bfoMVHXo4JVHMKOl6XHBH4W4c
        5ocCr2yN+EokxVCA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Remove obsolete "cd $KVM"
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618735551.4006.18104740019852856686.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     7a6bbeaa01f71af2722fd775a4a4ff9593d12838
Gitweb:        https://git.kernel.org/tip/7a6bbeaa01f71af2722fd775a4a4ff9593d12838
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 16 Jun 2020 17:07:15 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:01:45 -07:00

torture: Remove obsolete "cd $KVM"

In the dim distant past, qemu commands needed to be run from the
rcutorture directory, but this is no longer the case.  This commit
therefore removes the now-useless "cd $KVM" from the kvm-test-1-run.sh
script.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 484445b..e07779a 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -124,7 +124,6 @@ seconds=$4
 qemu_args=$5
 boot_args=$6
 
-cd $KVM
 kstarttime=`gawk 'BEGIN { print systime() }' < /dev/null`
 if test -z "$TORTURE_BUILDONLY"
 then
