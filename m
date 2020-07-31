Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A044CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EDCE208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IQillPht";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="am4gTxnY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732938AbgGaJ3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:29:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56338 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732178AbgGaJWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:43 -0400
Date:   Fri, 31 Jul 2020 09:22:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187361;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Dd/P+4IRUPb/oWgVp8GSJDEr5SVFmnIcSTd1/RuQYlk=;
        b=IQillPht1mvLb2MuET3cTn1Ny9b+KNtj+AQLRf1lSD8CxjZZI+CEPbZNW7zi9F7lJnGE2+
        Bgqd/DC4mb+i6b8XEobskEAgG/PpeWfybxK1wE3YAsyDCSGWmhugYl1qE5/db3HFNyiLlQ
        6QDe5Zbol7dPM0VsnxoDantYbg6weEkAhCZaME7kbb14ryFTZgPajMt9mvux4MvLCdqEkq
        fwZHAcij34YBOK0/l3FTZY0EGNT2viWq1TZs8+FHSCeTLLVL9YWvDNyuJI/9k/Sz48xV2E
        a15nN8YhZLaG+jIFPakmDfubbS9ywAnSBfWDheC5Lgubs/o5lGqyhgkyw8ov/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187361;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Dd/P+4IRUPb/oWgVp8GSJDEr5SVFmnIcSTd1/RuQYlk=;
        b=am4gTxnYVXRWm+KcOiA5lHqUC069BtBMoAlDFxO/g5OugXy06mQ3u6wKFEc9rv1qsHNlM/
        xfJmlfS+HGAVLqDQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Check for unwatched readers
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618736083.4006.18312756613398565511.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     775227511843202e65a7f194cbf64f38de01f004
Gitweb:        https://git.kernel.org/tip/775227511843202e65a7f194cbf64f38de01f004
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 11 Jun 2020 16:43:14 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:01:44 -07:00

rcutorture: Check for unwatched readers

RCU is supposed to be watching all non-idle kernel code and also all
softirq handlers.  This commit adds some teeth to this statement by
adding a WARN_ON_ONCE().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 37455a1..9c31001 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1377,6 +1377,7 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp)
 	struct rt_read_seg *rtrsp1;
 	unsigned long long ts;
 
+	WARN_ON_ONCE(!rcu_is_watching());
 	newstate = rcutorture_extend_mask(readstate, trsp);
 	rcutorture_one_extend(&readstate, newstate, trsp, rtrsp++);
 	started = cur_ops->get_gp_seq();
