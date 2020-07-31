Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19415C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3099208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C4fVIQ4q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9dgheEA8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732278AbgGaJWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732222AbgGaJWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38358C061574;
        Fri, 31 Jul 2020 02:22:46 -0700 (PDT)
Date:   Fri, 31 Jul 2020 09:22:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187364;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=T7ukGN4bM+gflCLO43W24GiEXTL1gig4f058wloVrgQ=;
        b=C4fVIQ4qqcQ7KjisFmH7KE85z3arTWgtadWl4qSek48cIqKPuRT2rciEPDz7n9meeVDtEE
        /dIaW1jICKxs5+rm5LrMTkKxtMR8lfnO9jlMYY54CYZXmZxbVVM2XrNGi5YM22HJ36Jqbf
        OI0+N3pMk/kttENoGTGMqprVtPEXFT0obRjJpc9UNoC/ZeAArmY/JDeiqPZySTD9BXhGvr
        QmCAC2N517acpiYf0Oqb1vwdbsuPRlvsu0Drmdh9SyRozY3MXYNgbx4DLofU1EW/sNVym0
        O2Zi6yyM009iaBfEieJYfhO8LqC03uBqniUBL6vdPSRVtPO0tNRrEEu6K8XDeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187364;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=T7ukGN4bM+gflCLO43W24GiEXTL1gig4f058wloVrgQ=;
        b=9dgheEA8S9H9LZMLCa9UU2nStCggbDAd7FXbthSmcdBUgQQNmQ/qx4ZnNPurMhz4wkizD/
        rd3YYQR0d8AFWvDA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Add --allcpus argument to the kvm.sh script
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618736410.4006.3706383349129713648.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     a3ba4972f2ef8408dcc8a2a3d433621d6c990594
Gitweb:        https://git.kernel.org/tip/a3ba4972f2ef8408dcc8a2a3d433621d6c990594
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 04 May 2020 16:41:53 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:01:44 -07:00

torture: Add --allcpus argument to the kvm.sh script

Leaving off the kvm.sh script's --cpus argument results in the script
testing the scenarios sequentially, which can be quite slow.  However,
having to specify the actual number of CPUs can be error-prone.
This commit therefore adds a --allcpus argument that causes kvm.sh to
use all available CPUs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index c279cf9..7dbce7a 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -73,6 +73,10 @@ usage () {
 while test $# -gt 0
 do
 	case "$1" in
+	--allcpus)
+		cpus=$TORTURE_ALLOTED_CPUS
+		max_cpus=$TORTURE_ALLOTED_CPUS
+		;;
 	--bootargs|--bootarg)
 		checkarg --bootargs "(list of kernel boot arguments)" "$#" "$2" '.*' '^--'
 		TORTURE_BOOTARGS="$2"
