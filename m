Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D88C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBE76207FB
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593461112;
	bh=IPcRzfGVEeCIakQ1km6wz6nbtv/q2XHmTaiepMphpRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Irao9oeoMSEeIs+bAm1b4rAa7yPoGG+oTFR+HX9b3KhMPiaioAb1BkiexHXXO9Y2Q
	 gJ6aGekWuuUNeoURsd8F3tUQeIyorx9nLkBVJ5KWsXtK/KUcXW/E7sDRM2pyEpEHy3
	 yWv7QO3y8iusS9zMRwSHSa1YYw20FOqwAcWX51W4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732981AbgF2Ta3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:30:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732811AbgF2TaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:30:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 195BD248E9;
        Mon, 29 Jun 2020 15:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444919;
        bh=IPcRzfGVEeCIakQ1km6wz6nbtv/q2XHmTaiepMphpRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V8GHMxJCqjnayygVMOI/r9178K2ZmFoTiHBEfZoApBkmBr1sIKfLTKvJtPGj1FZ6R
         z6Tc2m4u9nPBrf6z9oq72FfyDKvwtXkv09kL2sYYQN1PLQG/EPvWRk0eCtJe014tH1
         LigYOIA+LRjPur10KHR+HK4iVJ27hQV/8ayqvvuw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>, Cyrill Gorcunov <gorcunov@gmail.com>,
        kernel test robot <rong.a.chen@intel.com>,
        John Johansen <john.johansen@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 016/131] apparmor: don't try to replace stale label in ptraceme check
Date:   Mon, 29 Jun 2020 11:33:07 -0400
Message-Id: <20200629153502.2494656-17-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629153502.2494656-1-sashal@kernel.org>
References: <20200629153502.2494656-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.131-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.131-rc1
X-KernelTest-Deadline: 2020-07-01T15:34+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

[ Upstream commit ca3fde5214e1d24f78269b337d3f22afd6bf445e ]

begin_current_label_crit_section() must run in sleepable context because
when label_is_stale() is true, aa_replace_current_label() runs, which uses
prepare_creds(), which can sleep.

Until now, the ptraceme access check (which runs with tasklist_lock held)
violated this rule.

Fixes: b2d09ae449ced ("apparmor: move ptrace checks to using labels")
Reported-by: Cyrill Gorcunov <gorcunov@gmail.com>
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/lsm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 5e32fe434140e..898752b818dc5 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -130,11 +130,11 @@ static int apparmor_ptrace_traceme(struct task_struct *parent)
 	struct aa_label *tracer, *tracee;
 	int error;
 
-	tracee = begin_current_label_crit_section();
+	tracee = __begin_current_label_crit_section();
 	tracer = aa_get_task_label(parent);
 	error = aa_may_ptrace(tracer, tracee, AA_PTRACE_TRACE);
 	aa_put_label(tracer);
-	end_current_label_crit_section(tracee);
+	__end_current_label_crit_section(tracee);
 
 	return error;
 }
-- 
2.25.1

