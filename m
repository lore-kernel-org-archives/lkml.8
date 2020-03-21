Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF3BC4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D510520754
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgCUPy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:54:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39083 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbgCUPyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:54:04 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFgRf-0005WP-VX; Sat, 21 Mar 2020 16:53:56 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 174A01C22F4;
        Sat, 21 Mar 2020 16:53:53 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:53:52 -0000
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] pci/switchtec: Replace completion wait queue
 usage for poll
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200321113240.936097534@linutronix.de>
References: <20200321113240.936097534@linutronix.de>
MIME-Version: 1.0
Message-ID: <158480603267.28353.9251472096966677257.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     deaa0a8a74d86573f190e21ae9a444ea5e3bceee
Gitweb:        https://git.kernel.org/tip/deaa0a8a74d86573f190e21ae9a444ea5e3bceee
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Sat, 21 Mar 2020 12:25:46 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 21 Mar 2020 16:00:20 +01:00

pci/switchtec: Replace completion wait queue usage for poll

The poll callback is using the completion wait queue and sticks it into
poll_wait() to wake up pollers after a command has completed.

This works to some extent, but cannot provide EPOLLEXCLUSIVE support
because the waker side uses complete_all() which unconditionally wakes up
all waiters. complete_all() is required because completions internally use
exclusive wait and complete() only wakes up one waiter by default.

This mixes conceptually different mechanisms and relies on internal
implementation details of completions, which in turn puts contraints on
changing the internal implementation of completions.

Replace it with a regular wait queue and store the state in struct
switchtec_user.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200321113240.936097534@linutronix.de
---
 drivers/pci/switch/switchtec.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 81dc7ac..e69cac8 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -52,10 +52,11 @@ struct switchtec_user {
 
 	enum mrpc_state state;
 
-	struct completion comp;
+	wait_queue_head_t cmd_comp;
 	struct kref kref;
 	struct list_head list;
 
+	bool cmd_done;
 	u32 cmd;
 	u32 status;
 	u32 return_code;
@@ -77,7 +78,7 @@ static struct switchtec_user *stuser_create(struct switchtec_dev *stdev)
 	stuser->stdev = stdev;
 	kref_init(&stuser->kref);
 	INIT_LIST_HEAD(&stuser->list);
-	init_completion(&stuser->comp);
+	init_waitqueue_head(&stuser->cmd_comp);
 	stuser->event_cnt = atomic_read(&stdev->event_cnt);
 
 	dev_dbg(&stdev->dev, "%s: %p\n", __func__, stuser);
@@ -175,7 +176,7 @@ static int mrpc_queue_cmd(struct switchtec_user *stuser)
 	kref_get(&stuser->kref);
 	stuser->read_len = sizeof(stuser->data);
 	stuser_set_state(stuser, MRPC_QUEUED);
-	reinit_completion(&stuser->comp);
+	stuser->cmd_done = false;
 	list_add_tail(&stuser->list, &stdev->mrpc_queue);
 
 	mrpc_cmd_submit(stdev);
@@ -222,7 +223,8 @@ static void mrpc_complete_cmd(struct switchtec_dev *stdev)
 		memcpy_fromio(stuser->data, &stdev->mmio_mrpc->output_data,
 			      stuser->read_len);
 out:
-	complete_all(&stuser->comp);
+	stuser->cmd_done = true;
+	wake_up_interruptible(&stuser->cmd_comp);
 	list_del_init(&stuser->list);
 	stuser_put(stuser);
 	stdev->mrpc_busy = 0;
@@ -529,10 +531,11 @@ static ssize_t switchtec_dev_read(struct file *filp, char __user *data,
 	mutex_unlock(&stdev->mrpc_mutex);
 
 	if (filp->f_flags & O_NONBLOCK) {
-		if (!try_wait_for_completion(&stuser->comp))
+		if (!stuser->cmd_done)
 			return -EAGAIN;
 	} else {
-		rc = wait_for_completion_interruptible(&stuser->comp);
+		rc = wait_event_interruptible(stuser->cmd_comp,
+					      stuser->cmd_done);
 		if (rc < 0)
 			return rc;
 	}
@@ -580,7 +583,7 @@ static __poll_t switchtec_dev_poll(struct file *filp, poll_table *wait)
 	struct switchtec_dev *stdev = stuser->stdev;
 	__poll_t ret = 0;
 
-	poll_wait(filp, &stuser->comp.wait, wait);
+	poll_wait(filp, &stuser->cmd_comp, wait);
 	poll_wait(filp, &stdev->event_wq, wait);
 
 	if (lock_mutex_and_test_alive(stdev))
@@ -588,7 +591,7 @@ static __poll_t switchtec_dev_poll(struct file *filp, poll_table *wait)
 
 	mutex_unlock(&stdev->mrpc_mutex);
 
-	if (try_wait_for_completion(&stuser->comp))
+	if (stuser->cmd_done)
 		ret |= EPOLLIN | EPOLLRDNORM;
 
 	if (stuser->event_cnt != atomic_read(&stdev->event_cnt))
@@ -1272,7 +1275,8 @@ static void stdev_kill(struct switchtec_dev *stdev)
 
 	/* Wake up and kill any users waiting on an MRPC request */
 	list_for_each_entry_safe(stuser, tmpuser, &stdev->mrpc_queue, list) {
-		complete_all(&stuser->comp);
+		stuser->cmd_done = true;
+		wake_up_interruptible(&stuser->cmd_comp);
 		list_del_init(&stuser->list);
 		stuser_put(stuser);
 	}
