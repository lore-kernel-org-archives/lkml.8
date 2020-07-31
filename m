Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EFBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDB6C22B40
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2ZPq4bB+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lHrbhdWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732435AbgGaJZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:25:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56476 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732469AbgGaJX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:29 -0400
Date:   Fri, 31 Jul 2020 09:23:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187407;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=HOTZ3VG63wvLb+O9zPAgrkCJqaC+IiK7J0uqDgK/Jt0=;
        b=2ZPq4bB+20ekJ3dSasICSH+G39BMzaKQqXDJgGfFsPW8di3VR7WtUn8/AnOONMc9E6gyrj
        GhaISm2CaZstNkprxSuVk0F4bvRWq0IMnuY20AAnsN88Gvr8nvwpgeWb2gKmT6NBAyh/C+
        uMhRVSHGms0WlcovbY6rfIKQGJWLEBk3TKnLLplfgCgPpUuA6vvudiaDh5pyjbGWstA6xP
        S1gbLAeH034ALw7rY4SRUrpjsAMlcrWIGw6Libu9FH2zvt4AU+Rs5PQ5rMQEObYscALdBW
        ZOcN9THntkZYr8VSh7QMzVmecC2lOz9N7mp9XoBH/Atgf+Te9rBzCbAaFiwkYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187407;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=HOTZ3VG63wvLb+O9zPAgrkCJqaC+IiK7J0uqDgK/Jt0=;
        b=lHrbhdWsoD0LgloHkrG6WcOT25f2FWA/g63hk6UQfzDD7NxUmKB3Ev+MFlaMvQJrT8eCSc
        MhV7X3z4jzPBSkAg==
From:   "tip-bot2 for Wei Yang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: grpnum just records group number
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618740721.4006.4615319126948489953.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     7a0c2b0940c13a06573320ab7118375b35feef8b
Gitweb:        https://git.kernel.org/tip/7a0c2b0940c13a06573320ab7118375b35feef8b
Author:        Wei Yang <richard.weiyang@linux.alibaba.com>
AuthorDate:    Fri, 12 Jun 2020 10:07:54 +08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:58:51 -07:00

rcu: grpnum just records group number

The ->grpnum field in the rcu_node structure contains the bit position
in this structure's parent's bitmasks, which is not the CPU number.
This commit therefore adjusts this field's comment accordingly.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 9f903f5..c96ae35 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -75,7 +75,7 @@ struct rcu_node {
 				/*  Only one bit will be set in this mask. */
 	int	grplo;		/* lowest-numbered CPU here. */
 	int	grphi;		/* highest-numbered CPU here. */
-	u8	grpnum;		/* CPU/group number for next level up. */
+	u8	grpnum;		/* group number for next level up. */
 	u8	level;		/* root is at level 0. */
 	bool	wait_blkd_tasks;/* Necessary to wait for blocked tasks to */
 				/*  exit RCU read-side critical sections */
