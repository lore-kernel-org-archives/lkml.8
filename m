Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4B7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3AE1208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593459729;
	bh=FhmwB88O57CR0ErdjSaM/GnQ/TxWai5+2EiBJyy0BBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YIIbiQgoo85ulOoXSs/XAY5QfZwOSyJ52/QCWG5Cff+5X+zqO3kNjRbdT3vZrtjdL
	 ksJ/idJgDDbOS0Ybx7/BRFTJhMPePICpM5eT0RYr8JUBzUaD2r/wncDz6ZgpPKyLFs
	 jJt7b+vIyOzTmAUVdwGckMSkycHETT7+IcpdCiwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387931AbgF2Tl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:41:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387849AbgF2Tkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:40:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E88F724900;
        Mon, 29 Jun 2020 15:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444455;
        bh=FhmwB88O57CR0ErdjSaM/GnQ/TxWai5+2EiBJyy0BBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bc342iEoLXa135VjLEIkGct8bRl9wte/kxHn5PIAyH71KZbbf8XMOkdhqRN2sBemF
         XXjZZABpGbW+/poJZTLZvx7AA1JXj+IHifPBYH30l2SF8VhflWD3UJQRlBJbsi3MXc
         61q8Vx+WVSkw0Fu42j0YP50eOz82yPTS/RX44aok=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 135/178] kprobes: Suppress the suspicious RCU warning on kprobes
Date:   Mon, 29 Jun 2020 11:24:40 -0400
Message-Id: <20200629152523.2494198-136-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629152523.2494198-1-sashal@kernel.org>
References: <20200629152523.2494198-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.50-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.50-rc1
X-KernelTest-Deadline: 2020-07-01T15:25+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit 6743ad432ec92e680cd0d9db86cb17b949cf5a43 ]

Anders reported that the lockdep warns that suspicious
RCU list usage in register_kprobe() (detected by
CONFIG_PROVE_RCU_LIST.) This is because get_kprobe()
access kprobe_table[] by hlist_for_each_entry_rcu()
without rcu_read_lock.

If we call get_kprobe() from the breakpoint handler context,
it is run with preempt disabled, so this is not a problem.
But in other cases, instead of rcu_read_lock(), we locks
kprobe_mutex so that the kprobe_table[] is not updated.
So, current code is safe, but still not good from the view
point of RCU.

Joel suggested that we can silent that warning by passing
lockdep_is_held() to the last argument of
hlist_for_each_entry_rcu().

Add lockdep_is_held(&kprobe_mutex) at the end of the
hlist_for_each_entry_rcu() to suppress the warning.

Link: http://lkml.kernel.org/r/158927055350.27680.10261450713467997503.stgit@devnote2

Reported-by: Anders Roxell <anders.roxell@linaro.org>
Suggested-by: Joel Fernandes <joel@joelfernandes.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kprobes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 195ecb955fcc5..950a5cfd262ce 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -326,7 +326,8 @@ struct kprobe *get_kprobe(void *addr)
 	struct kprobe *p;
 
 	head = &kprobe_table[hash_ptr(addr, KPROBE_HASH_BITS)];
-	hlist_for_each_entry_rcu(p, head, hlist) {
+	hlist_for_each_entry_rcu(p, head, hlist,
+				 lockdep_is_held(&kprobe_mutex)) {
 		if (p->addr == addr)
 			return p;
 	}
-- 
2.25.1

