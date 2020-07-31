Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2043AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF45622B40
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TSEDiv4O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KpYfMWXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732461AbgGaJ3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732197AbgGaJWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47604C061574;
        Fri, 31 Jul 2020 02:22:42 -0700 (PDT)
Date:   Fri, 31 Jul 2020 09:22:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187360;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6XLOrayGCAI11qeVwIJBhVh/WJrR5AIHkxFc9qq7f/o=;
        b=TSEDiv4OH07TcFAtwGy4oag3AbCaA9HqN87Y90K6+a+7QrS3VmO62IMOilsAt+rAf6Zsbx
        /y8MEdJ77foZ73CFZ20898lNggBj3yxIDroOSscVDE8DGDpWqKDnPikN7bsE2dRFSt16k3
        ytvEf1XmCwTdEtVaR3jlpNzLz3rx6+Bc/C78kYUZxaFEqX8JXXu7EPRaleEOG1JcQgY2DM
        1AlzEZYrO1FHVhOAtvXqMyTcosFIrc6AYMnOzh8WtIS9YxtnuiUprefpiH2HNudK0pyBTr
        pNcu92CDF1M1Q8HdGqMHOWjtqC3giM3KiFSpuXPjqNXWQjEGBMMxwZJJZMxcPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187360;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6XLOrayGCAI11qeVwIJBhVh/WJrR5AIHkxFc9qq7f/o=;
        b=KpYfMWXXpqyOe2ysPt9KRoySxzHvw9Fn/SCJSfiNlCCbTT8U20xvCX0CzurDRlPoLsA3KL
        8I6xdenx0YlMXkAA==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Pass --kmake-arg to all make invocations
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618736016.4006.571280411245483359.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     603d11ad6976e1289f19c2a19e2f75a83d0dc296
Gitweb:        https://git.kernel.org/tip/603d11ad6976e1289f19c2a19e2f75a83d0dc296
Author:        Marco Elver <elver@google.com>
AuthorDate:    Tue, 16 Jun 2020 11:49:24 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:01:44 -07:00

torture: Pass --kmake-arg to all make invocations

We need to pass the arguments provided to --kmake-arg to all make
invocations. In particular, the make invocations generating the configs
need to see the final make arguments, e.g. if config variables depend on
particular variables that are passed to make.

For example, when using '--kcsan --kmake-arg CC=clang-11', we would lose
CONFIG_KCSAN=y due to 'make oldconfig' not seeing that we want to use a
compiler that supports KCSAN.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/configinit.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/configinit.sh b/tools/testing/selftests/rcutorture/bin/configinit.sh
index 93e80a4..d6e5ce0 100755
--- a/tools/testing/selftests/rcutorture/bin/configinit.sh
+++ b/tools/testing/selftests/rcutorture/bin/configinit.sh
@@ -32,11 +32,11 @@ if test -z "$TORTURE_TRUST_MAKE"
 then
 	make clean > $resdir/Make.clean 2>&1
 fi
-make $TORTURE_DEFCONFIG > $resdir/Make.defconfig.out 2>&1
+make $TORTURE_KMAKE_ARG $TORTURE_DEFCONFIG > $resdir/Make.defconfig.out 2>&1
 mv .config .config.sav
 sh $T/upd.sh < .config.sav > .config
 cp .config .config.new
-yes '' | make oldconfig > $resdir/Make.oldconfig.out 2> $resdir/Make.oldconfig.err
+yes '' | make $TORTURE_KMAKE_ARG oldconfig > $resdir/Make.oldconfig.out 2> $resdir/Make.oldconfig.err
 
 # verify new config matches specification.
 configcheck.sh .config $c
