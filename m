Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542E6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F8BF2068E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbgHYK6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 06:58:49 -0400
Received: from sym2.noone.org ([178.63.92.236]:33364 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgHYK6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 06:58:48 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4BbQw63TxPzvjcX; Tue, 25 Aug 2020 12:58:46 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH] ipc: adjust proc_ipc_sem_dointvec definition to match prototype
Date:   Tue, 25 Aug 2020 12:58:46 +0200
Message-Id: <20200825105846.5193-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
changed ctl_table.proc_handler to take a kernel pointer. Adjust the
signature of proc_ipc_sem_dointvec to match ctl_table.proc_handler which
fixes the following sparse error/warning:

ipc/ipc_sysctl.c:94:47: warning: incorrect type in argument 3 (different address spaces)
ipc/ipc_sysctl.c:94:47:    expected void *buffer
ipc/ipc_sysctl.c:94:47:    got void [noderef] __user *buffer
ipc/ipc_sysctl.c:194:35: warning: incorrect type in initializer (incompatible argument 3 (different address spaces))
ipc/ipc_sysctl.c:194:35:    expected int ( [usertype] *proc_handler )( ... )
ipc/ipc_sysctl.c:194:35:    got int ( * )( ... )

Fixes: 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 ipc/ipc_sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index d1b8644bfb88..3f312bf2b116 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -85,7 +85,7 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
 }
 
 static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
-	void __user *buffer, size_t *lenp, loff_t *ppos)
+	void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret, semmni;
 	struct ipc_namespace *ns = current->nsproxy->ipc_ns;
-- 
2.27.0

