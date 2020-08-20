Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA919C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A716D20658
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597918764;
	bh=zPSdERwGkzmq8uLtFN9GL6TfGc4jrmcGfhiaNRPb2Fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VAmyM5MjB/i3Bj1ChmuelHBUWQ4opcH+macTOSj/TpBYGLxAv1/JfckARtBxw/+AO
	 LgfX/N14EGgGfQ+7swQc+JxFEvqMhe/HmPmSB86kfyC1F7gl0NGanYkQQ3YuHPZRCj
	 l61zqz95X6DLd6Zcf6/zuWl7wCAbuInKYQaY3ND4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731367AbgHTKTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:19:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731409AbgHTKSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:18:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED74720658;
        Thu, 20 Aug 2020 10:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918732;
        bh=zPSdERwGkzmq8uLtFN9GL6TfGc4jrmcGfhiaNRPb2Fk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zSwTTNQpQM3bPJtMvHHQYyr3GSlAQiYTeh6VqngSjrQn0zt0IHZCfIwrrHNu1frEv
         C3s8i6Jli6Prh+lrSb2TAq6nw7XIgSJo6Zk7b4k8tfWScljTrNqbBJ2fOaK7m0R26P
         X8hIUrwLRgMvsRuRgidWnjupb18BqTKUSpzuM6kI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Todd Kjos <tkjos@google.com>,
        Jann Horn <jannh@google.com>, Martijn Coenen <maco@android.com>
Subject: [PATCH 4.4 046/149] binder: Prevent context manager from incrementing ref 0
Date:   Thu, 20 Aug 2020 11:22:03 +0200
Message-Id: <20200820092127.961712863@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820092125.688850368@linuxfoundation.org>
References: <20200820092125.688850368@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

commit 4b836a1426cb0f1ef2a6e211d7e553221594f8fc upstream.

Binder is designed such that a binder_proc never has references to
itself. If this rule is violated, memory corruption can occur when a
process sends a transaction to itself; see e.g.
<https://syzkaller.appspot.com/bug?extid=09e05aba06723a94d43d>.

There is a remaining edgecase through which such a transaction-to-self
can still occur from the context of a task with BINDER_SET_CONTEXT_MGR
access:

 - task A opens /dev/binder twice, creating binder_proc instances P1
   and P2
 - P1 becomes context manager
 - P2 calls ACQUIRE on the magic handle 0, allocating index 0 in its
   handle table
 - P1 dies (by closing the /dev/binder fd and waiting a bit)
 - P2 becomes context manager
 - P2 calls ACQUIRE on the magic handle 0, allocating index 1 in its
   handle table
   [this triggers a warning: "binder: 1974:1974 tried to acquire
   reference to desc 0, got 1 instead"]
 - task B opens /dev/binder once, creating binder_proc instance P3
 - P3 calls P2 (via magic handle 0) with (void*)1 as argument (two-way
   transaction)
 - P2 receives the handle and uses it to call P3 (two-way transaction)
 - P3 calls P2 (via magic handle 0) (two-way transaction)
 - P2 calls P2 (via handle 1) (two-way transaction)

And then, if P2 does *NOT* accept the incoming transaction work, but
instead closes the binder fd, we get a crash.

Solve it by preventing the context manager from using ACQUIRE on ref 0.
There shouldn't be any legitimate reason for the context manager to do
that.

Additionally, print a warning if someone manages to find another way to
trigger a transaction-to-self bug in the future.

Cc: stable@vger.kernel.org
Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
Acked-by: Todd Kjos <tkjos@google.com>
Signed-off-by: Jann Horn <jannh@google.com>
Reviewed-by: Martijn Coenen <maco@android.com>
Link: https://lore.kernel.org/r/20200727120424.1627555-1-jannh@google.com
[manual backport: remove fine-grained locking and error reporting that
                  don't exist in <=4.9]
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/android/binder.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1415,6 +1415,10 @@ static void binder_transaction(struct bi
 			return_error = BR_DEAD_REPLY;
 			goto err_dead_binder;
 		}
+		if (WARN_ON(proc == target_proc)) {
+			return_error = BR_FAILED_REPLY;
+			goto err_invalid_target_handle;
+		}
 		if (security_binder_transaction(proc->tsk,
 						target_proc->tsk) < 0) {
 			return_error = BR_FAILED_REPLY;
@@ -1812,6 +1816,11 @@ static int binder_thread_write(struct bi
 			ptr += sizeof(uint32_t);
 			if (target == 0 && binder_context_mgr_node &&
 			    (cmd == BC_INCREFS || cmd == BC_ACQUIRE)) {
+				if (binder_context_mgr_node->proc == proc) {
+					binder_user_error("%d:%d context manager tried to acquire desc 0\n",
+							  proc->pid, thread->pid);
+					return -EINVAL;
+				}
 				ref = binder_get_ref_for_node(proc,
 					       binder_context_mgr_node);
 				if (ref->desc != target) {


