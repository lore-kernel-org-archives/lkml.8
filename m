Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D1FC4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120B420781
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgCUPyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:54:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39078 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbgCUPyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:54:03 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFgRi-0005Wq-61; Sat, 21 Mar 2020 16:53:58 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 791541C22F0;
        Sat, 21 Mar 2020 16:53:53 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:53:53 -0000
From:   "tip-bot2 for Logan Gunthorpe" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] PCI/switchtec: Fix init_completion race condition
 with poll_wait()
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200313183608.2646-1-logang@deltatee.com>
References: <20200313183608.2646-1-logang@deltatee.com>
MIME-Version: 1.0
Message-ID: <158480603317.28353.1853956587316616991.tip-bot2@tip-bot2>
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

Commit-ID:     efbdc769601f4d50018bf7ca50fc9f7c67392ece
Gitweb:        https://git.kernel.org/tip/efbdc769601f4d50018bf7ca50fc9f7c67392ece
Author:        Logan Gunthorpe <logang@deltatee.com>
AuthorDate:    Sat, 21 Mar 2020 12:25:45 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 21 Mar 2020 16:00:20 +01:00

PCI/switchtec: Fix init_completion race condition with poll_wait()

The call to init_completion() in mrpc_queue_cmd() can theoretically
race with the call to poll_wait() in switchtec_dev_poll().

  poll()			write()
    switchtec_dev_poll()   	  switchtec_dev_write()
      poll_wait(&s->comp.wait);      mrpc_queue_cmd()
			               init_completion(&s->comp)
				         init_waitqueue_head(&s->comp.wait)

To my knowledge, no one has hit this bug.

Fix this by using reinit_completion() instead of init_completion() in
mrpc_queue_cmd().

Fixes: 080b47def5e5 ("MicroSemi Switchtec management interface driver")

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lkml.kernel.org/r/20200313183608.2646-1-logang@deltatee.com
---
 drivers/pci/switch/switchtec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index a823b4b..81dc7ac 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -175,7 +175,7 @@ static int mrpc_queue_cmd(struct switchtec_user *stuser)
 	kref_get(&stuser->kref);
 	stuser->read_len = sizeof(stuser->data);
 	stuser_set_state(stuser, MRPC_QUEUED);
-	init_completion(&stuser->comp);
+	reinit_completion(&stuser->comp);
 	list_add_tail(&stuser->list, &stdev->mrpc_queue);
 
 	mrpc_cmd_submit(stdev);
