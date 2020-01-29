Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF114C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 00:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97BA72173E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 00:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W2ASFXDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgA2AWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 19:22:36 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:51993 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgA2AWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 19:22:36 -0500
Received: by mail-pl1-f201.google.com with SMTP id r2so6498651pls.18
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 16:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=TUeAzP1KPLnbgJ4pAq4woW7/EJW98hNHfTCwbLjLh1w=;
        b=W2ASFXDO0F+nOrHdNuVWJYhAvYy1ezS2ByLMRsPg4tm6WvfFZKFgekpaHVaM+rD0XF
         kBvE9Fdx9sPOLxXcYzqRL7QlWfUcogecvyvKwrep6sTLdfA2r6tonSwP6t3t5vYLEsqe
         RjbDyme6veZlvR8zHyp8uH/6JPHnSDQGPO2TwfgVkEZDcP9LL+Q898MFjVQlu2zzK0Lo
         Sf7TlvRLsXYeRcQpQyrCniV/x9W0x1InAZp+QTutM06PN3GHEbHMOYTHLIicz4lIBiXq
         WBsIfCP3TDk8OhfQlTHaspGALIcr3rMB2Lnm7+yEkBFujSt34AwONbZzWWKgRnxTH0KE
         ybyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=TUeAzP1KPLnbgJ4pAq4woW7/EJW98hNHfTCwbLjLh1w=;
        b=Q3E8oEWpV3os99CfZGyN0JtQgiZLvTfJcNY+NlrR9NSetkHuuOtyRG3etFJ9cITBEy
         km5zl96RZhyR3MSH/mxiSCKuWbTkxwHZFF74lvl4+qC6KhRVRH4mlCR1fUjlbdJd4+YJ
         7mrIjgGVNlvEReSEvj3CATTlYzQrU/qgNPaygqlbwQn0MtUgGx+Jrk2wAKTcNdWwQx9H
         7Q8vfXXmxycV5OWSotH2Y0wwLLLZu52eNGL3kcqlMBhdzZ1HpgRy0mry7Il2wM5BNdFx
         Lj4/sK/3RICDjxA3mAOKE8wkdYEgsWbtyCSEm2isljroeEOtQJo1nhkfz1nLxXR5uTeL
         Caiw==
X-Gm-Message-State: APjAAAUTWBow51bIFSu+jXuXzDAGaePwCl2hkEmdU2Utc6oh77JWW7kS
        EzPaP5Xa1xwi/0Mrwbbhky8sVXYevO6TOw==
X-Google-Smtp-Source: APXvYqxUX39srrGDo6zfgNrOlHMpUNc1+pzXn9wA5ccrj4KtHuLFy5rBx6EDwBGrE39T9TaIK8drk4HdgNBpUw==
X-Received: by 2002:a63:a55e:: with SMTP id r30mr168115pgu.109.1580257355597;
 Tue, 28 Jan 2020 16:22:35 -0800 (PST)
Date:   Tue, 28 Jan 2020 16:22:22 -0800
Message-Id: <20200129002222.213154-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH] x86/resctrl: fix redundant task movement
From:   Shakeel Butt <shakeelb@google.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Stephane Eranian <eranian@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently a task can be moved to a rdtgroup multiple times or between
resource or monitoring groups. This can cause multiple task works are
added, waste memory and degrade performance.

To fix the issue, only move the task to a rdtgroup when the task
is not in the rdgroup. Don't try to move the task to the rdtgroup
again when the task is already in the rdtgroup.

Also move the setting of tsk->closid and tsk->rmid before task_work_add
to remove a potential race where the task start executing the registered
callback before the request set its closid and rmid.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 61 ++++++++++++++++++--------
 1 file changed, 43 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index dac7209a0708..8ef10c626862 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -543,15 +543,57 @@ static void move_myself(struct callback_head *head)
 static int __rdtgroup_move_task(struct task_struct *tsk,
 				struct rdtgroup *rdtgrp)
 {
+	struct callback_head *head;
 	struct task_move_callback *callback;
 	int ret;
 
-	callback = kzalloc(sizeof(*callback), GFP_KERNEL);
+	/* If the task is already in rdtgrp, don't move the task. */
+	if ((rdtgrp->type == RDTCTRL_GROUP && tsk->closid == rdtgrp->closid &&
+	     tsk->rmid == rdtgrp->mon.rmid) ||
+	    (rdtgrp->type == RDTMON_GROUP &&
+	     rdtgrp->mon.parent->closid == tsk->closid &&
+	     tsk->rmid == rdtgrp->mon.rmid)) {
+		rdt_last_cmd_puts("Task is already in the rdgroup\n");
+		return 0;
+	}
+
+	/*
+	 * For monitor groups, we can move the tasks only from their parent
+	 * CTRL group.
+	 */
+	if (rdtgrp->type == RDTMON_GROUP &&
+	    rdtgrp->mon.parent->closid != tsk->closid) {
+		rdt_last_cmd_puts("Can't move task to different control group\n");
+		return -EINVAL;
+	}
+
+	/* Cancel exiting request and reuse the memory. */
+	head = task_work_cancel(tsk, move_myself);
+	if (head) {
+		callback = container_of(head, struct task_move_callback, work);
+		if (atomic_dec_and_test(&callback->rdtgrp->waitcount) &&
+		    (callback->rdtgrp->flags & RDT_DELETED))
+			kfree(callback->rdtgrp);
+	} else
+		callback = kzalloc(sizeof(*callback), GFP_KERNEL);
+
 	if (!callback)
 		return -ENOMEM;
 	callback->work.func = move_myself;
 	callback->rdtgrp = rdtgrp;
 
+	/*
+	 * For ctrl_mon groups move both closid and rmid.
+	 * For monitor groups, move the tasks only from their parent
+	 * CTRL group.
+	 */
+	if (rdtgrp->type == RDTCTRL_GROUP) {
+		tsk->closid = rdtgrp->closid;
+		tsk->rmid = rdtgrp->mon.rmid;
+	} else if (rdtgrp->type == RDTMON_GROUP &&
+		   rdtgrp->mon.parent->closid == tsk->closid) {
+		tsk->rmid = rdtgrp->mon.rmid;
+	}
 	/*
 	 * Take a refcount, so rdtgrp cannot be freed before the
 	 * callback has been invoked.
@@ -567,23 +609,6 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 		atomic_dec(&rdtgrp->waitcount);
 		kfree(callback);
 		rdt_last_cmd_puts("Task exited\n");
-	} else {
-		/*
-		 * For ctrl_mon groups move both closid and rmid.
-		 * For monitor groups, can move the tasks only from
-		 * their parent CTRL group.
-		 */
-		if (rdtgrp->type == RDTCTRL_GROUP) {
-			tsk->closid = rdtgrp->closid;
-			tsk->rmid = rdtgrp->mon.rmid;
-		} else if (rdtgrp->type == RDTMON_GROUP) {
-			if (rdtgrp->mon.parent->closid == tsk->closid) {
-				tsk->rmid = rdtgrp->mon.rmid;
-			} else {
-				rdt_last_cmd_puts("Can't move task to different control group\n");
-				ret = -EINVAL;
-			}
-		}
 	}
 	return ret;
 }
-- 
2.25.0.341.g760bfbb309-goog

