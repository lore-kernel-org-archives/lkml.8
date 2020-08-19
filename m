Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE262C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C6E52072D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LSG+aO4h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jw82X8mN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgHSMeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbgHSMdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:33:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AF0C061342;
        Wed, 19 Aug 2020 05:33:19 -0700 (PDT)
Date:   Wed, 19 Aug 2020 12:33:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597840391;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T9fPHyYxK2WJXfENDHSTUTGjWlR73RDUiFY+SA8qYu8=;
        b=LSG+aO4hozDo7IIGk1j2XBfPrntsWAfZp18ORi52xU4mz3+MeqiyVld8rI4rSM/k26FUqu
        HA/iQt2TH3sXtWumyclzMmfR3meJEEeY5sXQrqT5XkUqMsbrXYe1D1TDUZnUgSAOVA3f1H
        4vsVTeaOkIQS2CZrgjb8EUsCGMJEO408jMCSrwsTK7FLb3tkNVgnenBXYZpG2cJF6IB0YV
        2NKzbeOxZq8FGdc7WCaIBYQ/lD1xJ5lg38K64ZbZYjXJaBz6BZFVnZzNUeTCaspoSFDOXS
        4H+2srLg/3ENf0MpN5T83sYHjoJC2wDsEI0b+YJ6JjLjzE2PsflHC03Ny6csFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597840391;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T9fPHyYxK2WJXfENDHSTUTGjWlR73RDUiFY+SA8qYu8=;
        b=Jw82X8mN4hHVqJjCbV124GUHYXRHdAfURd21lgsE7ZW9lylhhrvM03egY80AKMdJl8oLxb
        2DRm1LIauvcSc7AQ==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Use is_closid_match() in more places
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200708163929.2783-7-james.morse@arm.com>
References: <20200708163929.2783-7-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <159784039041.3192.5381309474151543574.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     e6b2fac36fcc0b73cbef063d700a9841850e37a0
Gitweb:        https://git.kernel.org/tip/e6b2fac36fcc0b73cbef063d700a9841850e37a0
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 08 Jul 2020 16:39:25 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 19 Aug 2020 09:08:36 +02:00

x86/resctrl: Use is_closid_match() in more places

rdtgroup_tasks_assigned() and show_rdt_tasks() loop over threads testing
for a CTRL/MON group match by closid/rmid with the provided rdtgrp.
Further down the file are helpers to do this, move these further up and
make use of them here.

These helpers additionally check for alloc/mon capable. This is harmless
as rdtgroup_mkdir() tests these capable flags before allowing the config
directories to be created.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lkml.kernel.org/r/20200708163929.2783-7-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 30 +++++++++++--------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index b044617..78f3be1 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -592,6 +592,18 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 	return ret;
 }
 
+static bool is_closid_match(struct task_struct *t, struct rdtgroup *r)
+{
+	return (rdt_alloc_capable &&
+	       (r->type == RDTCTRL_GROUP) && (t->closid == r->closid));
+}
+
+static bool is_rmid_match(struct task_struct *t, struct rdtgroup *r)
+{
+	return (rdt_mon_capable &&
+	       (r->type == RDTMON_GROUP) && (t->rmid == r->mon.rmid));
+}
+
 /**
  * rdtgroup_tasks_assigned - Test if tasks have been assigned to resource group
  * @r: Resource group
@@ -607,8 +619,7 @@ int rdtgroup_tasks_assigned(struct rdtgroup *r)
 
 	rcu_read_lock();
 	for_each_process_thread(p, t) {
-		if ((r->type == RDTCTRL_GROUP && t->closid == r->closid) ||
-		    (r->type == RDTMON_GROUP && t->rmid == r->mon.rmid)) {
+		if (is_closid_match(t, r) || is_rmid_match(t, r)) {
 			ret = 1;
 			break;
 		}
@@ -706,8 +717,7 @@ static void show_rdt_tasks(struct rdtgroup *r, struct seq_file *s)
 
 	rcu_read_lock();
 	for_each_process_thread(p, t) {
-		if ((r->type == RDTCTRL_GROUP && t->closid == r->closid) ||
-		    (r->type == RDTMON_GROUP && t->rmid == r->mon.rmid))
+		if (is_closid_match(t, r) || is_rmid_match(t, r))
 			seq_printf(s, "%d\n", t->pid);
 	}
 	rcu_read_unlock();
@@ -2245,18 +2255,6 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	return 0;
 }
 
-static bool is_closid_match(struct task_struct *t, struct rdtgroup *r)
-{
-	return (rdt_alloc_capable &&
-		(r->type == RDTCTRL_GROUP) && (t->closid == r->closid));
-}
-
-static bool is_rmid_match(struct task_struct *t, struct rdtgroup *r)
-{
-	return (rdt_mon_capable &&
-		(r->type == RDTMON_GROUP) && (t->rmid == r->mon.rmid));
-}
-
 /*
  * Move tasks from one to the other group. If @from is NULL, then all tasks
  * in the systems are moved unconditionally (used for teardown).
