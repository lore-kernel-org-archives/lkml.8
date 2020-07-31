Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547ABC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C79822CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1EnvyjEK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7RgWL2/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbgGaJW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:22:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56344 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732219AbgGaJWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:47 -0400
Date:   Fri, 31 Jul 2020 09:22:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187365;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dowDzxrx0cH3kBJV27Nf0cWNT3F5Dt2g+taZL4TRWhU=;
        b=1EnvyjEK9hIMUDhFqvoUpK2N+wZus3GjjqGr/DRfVTEgGgPG2jPDdCUV6ohj12F0qQlobx
        FScvLgShfn2eU8E5lKkMfdHVdevTvg8pi4r+UFQJykok0urwH3z52QxbAE4xZKzu2qnM3z
        x+to2iV2DgXstl90vQlDPjUVyul3TDX8Hc0Er4atr/xk84/d8ew/ALUoru8u6PfViTfFkj
        wBnz21E6okynq8ViHYgy+W5dWGWwIjoaDYxFxWUIdZY1ngMHnCf/m2FvHItEs3eYruJkGE
        rM3FeuxMJEpS3EcrJyvOfCaDjWphtsTH6iy94k8CFeC165eeFRArnyKgKI89oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187365;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dowDzxrx0cH3kBJV27Nf0cWNT3F5Dt2g+taZL4TRWhU=;
        b=7RgWL2/q5NH6f12LrYwufdB1b+ZhJLSrIEgZdP1jlOjdjy8kGWV/RDtupp5dR6GmN9VmAf
        I67FcDmX+fnFnRAQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Remove whitespace from identify_qemu_vcpus output
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618736473.4006.4218065887176193335.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     d3cb26312ecfdb4ee8dedf931e24e60df1d7fbc9
Gitweb:        https://git.kernel.org/tip/d3cb26312ecfdb4ee8dedf931e24e60df1d7fbc9
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 04 May 2020 16:40:53 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:01:44 -07:00

torture: Remove whitespace from identify_qemu_vcpus output

The identify_qemu_vcpus bash function can return numbers including
whitespace characters, which can be a bit annoying in some bash
dollar-sign substitutions.  This commit therefore strips all spaces and
tabs from the value that identify_qemu_vcpus outputs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index 436b154..51f3464 100644
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -231,7 +231,7 @@ identify_qemu_args () {
 # Returns the number of virtual CPUs available to the aggregate of the
 # guest OSes.
 identify_qemu_vcpus () {
-	lscpu | grep '^CPU(s):' | sed -e 's/CPU(s)://'
+	lscpu | grep '^CPU(s):' | sed -e 's/CPU(s)://' -e 's/[ 	]*//g'
 }
 
 # print_bug
