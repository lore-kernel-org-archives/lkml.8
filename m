Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B58C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4B6A22B40
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yoRBA+Md";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="St7C/Mph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732617AbgGaJYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732473AbgGaJXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE19C061574;
        Fri, 31 Jul 2020 02:23:29 -0700 (PDT)
Date:   Fri, 31 Jul 2020 09:23:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187408;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hZ0iETc6Fxftps7FJxX2sD+6Gb+avVPysJwhlacdrr8=;
        b=yoRBA+MdhB2YA7tT1A1ICVcxyi8Ns25WxjWPWAR89Gz6oQjSHo6STd72rShDUbHbGCIb+Z
        y08nqCihkLywnMfmMq1zOSE3pz/V6qmt5azAr7tHKinJhojzuRSI6fuSa7yE0dCbRHDCak
        NJ/MJqSSFAHIQ7feufRxv5t6t98LT1DtaPe286Fqo/TxQA2psAVJL6iw1g/3tpVf1NNTAE
        iggkL80qjCuVSWtCduq1udozLGqk1hiBFBzySwN6JUzJLa4AKZcmy/M4njlIsPIYzKQc9Z
        S5U6jLZcDoXGpDgx+Sv6DE+TltOletXfxmZx4Ylb3W2za3y5Lcc2q+swLpyDQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187408;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hZ0iETc6Fxftps7FJxX2sD+6Gb+avVPysJwhlacdrr8=;
        b=St7C/Mph9rplz9QuorOm/tTgXSM6Kxp7q5iwrrUPga6ts1XhudvmShoX6bNmkoRCEI/ItY
        JkBba5JP8gbL8GAQ==
From:   "tip-bot2 for Wei Yang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: grplo/grphi just records CPU number
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618740785.4006.6566337381244546014.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     a2dae43088d51c4869e7fa91ca09bcc890e277fc
Gitweb:        https://git.kernel.org/tip/a2dae43088d51c4869e7fa91ca09bcc890e277fc
Author:        Wei Yang <richard.weiyang@linux.alibaba.com>
AuthorDate:    Fri, 12 Jun 2020 10:07:53 +08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:58:51 -07:00

rcu: grplo/grphi just records CPU number

The ->grplo and ->grphi fields store the lowest and highest CPU number
covered by to a rcu_node structure, which is not the group number.
This commit therefore adjusts these fields' comments to match reality.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 09ec93b..9f903f5 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -73,8 +73,8 @@ struct rcu_node {
 	unsigned long ffmask;	/* Fully functional CPUs. */
 	unsigned long grpmask;	/* Mask to apply to parent qsmask. */
 				/*  Only one bit will be set in this mask. */
-	int	grplo;		/* lowest-numbered CPU or group here. */
-	int	grphi;		/* highest-numbered CPU or group here. */
+	int	grplo;		/* lowest-numbered CPU here. */
+	int	grphi;		/* highest-numbered CPU here. */
 	u8	grpnum;		/* CPU/group number for next level up. */
 	u8	level;		/* root is at level 0. */
 	bool	wait_blkd_tasks;/* Necessary to wait for blocked tasks to */
