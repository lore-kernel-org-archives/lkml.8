Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E22CC33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 13:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66BC21569
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 13:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbgAMNPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 08:15:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38503 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgAMNPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 08:15:02 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iqzYT-0000SU-1u; Mon, 13 Jan 2020 14:14:53 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A42C51C18BC;
        Mon, 13 Jan 2020 14:14:52 +0100 (CET)
Date:   Mon, 13 Jan 2020 13:14:52 -0000
From:   "tip-bot2 for Xiaochen Shen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Do not reconfigure exiting tasks
Cc:     Xiaochen Shen <xiaochen.shen@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1578500026-21152-1-git-send-email-xiaochen.shen@intel.com>
References: <1578500026-21152-1-git-send-email-xiaochen.shen@intel.com>
MIME-Version: 1.0
Message-ID: <157892129247.19145.17833326698641017024.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     dc433797c6f639e46824585bbf943578f13d54bf
Gitweb:        https://git.kernel.org/tip/dc433797c6f639e46824585bbf943578f13d54bf
Author:        Xiaochen Shen <xiaochen.shen@intel.com>
AuthorDate:    Thu, 09 Jan 2020 00:13:46 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Jan 2020 14:10:21 +01:00

x86/resctrl: Do not reconfigure exiting tasks

When writing a pid to file "tasks", a callback function move_myself() is
queued to this task to be called when the task returns from kernel mode
or exits. The purpose of move_myself() is to activate the newly assigned
closid and/or rmid associated with this task. This activation is done by
calling resctrl_sched_in() from move_myself(), the same function that is
called when switching to this task.

If this work is successfully queued but then the task enters PF_EXITING
status (e.g., receiving signal SIGKILL, SIGTERM) prior to the
execution of the callback move_myself(), move_myself() still calls
resctrl_sched_in() since the task status is not currently considered.

When a task is exiting, the data structure of the task itself will
be freed soon. Calling resctrl_sched_in() to write the register that
controls the task's resources is unnecessary and it implies extra
performance overhead.

Add check on task status in move_myself() and return immediately if the
task is PF_EXITING.

 [ bp: Massage. ]

Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lkml.kernel.org/r/1578500026-21152-1-git-send-email-xiaochen.shen@intel.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 2e3b06d..205925d 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -532,11 +532,15 @@ static void move_myself(struct callback_head *head)
 		kfree(rdtgrp);
 	}
 
+	if (unlikely(current->flags & PF_EXITING))
+		goto out;
+
 	preempt_disable();
 	/* update PQR_ASSOC MSR to make resource group go into effect */
 	resctrl_sched_in();
 	preempt_enable();
 
+out:
 	kfree(callback);
 }
 
