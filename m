Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AF9C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0A620757
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585834848;
	bh=PfXVwen4hTVjQMRYwec2sWG+kkHoy5njpKLA4uQB6ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=19xXjdV2ZnH7WRaU8s+D2GCEfDujp8JNwiXhZPZcjS7M2eJIRpHlVTg6IJzAUbTjp
	 oR1hK/eMgk7ZbvUZINW7SMwafjMoPTAI5Qviwa0n0DjGWbm463OGAp6ddPLuxxKVBW
	 PNliIOGnjp7OYgR0TD79vOBm0VQq9123VvUhfTgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388702AbgDBNkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:40:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388520AbgDBNkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:40:47 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57662206F5;
        Thu,  2 Apr 2020 13:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585834846;
        bh=PfXVwen4hTVjQMRYwec2sWG+kkHoy5njpKLA4uQB6ls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DrzESxqfJ7BHfotsVyOkEJMPp2Ro068kAZT13mGGzs0d4glTxeUOh6R09YTuWhmh/
         m7EX38Vk//CgxdSqfXFKDd2pcf+XsP6sdtamMe2pIf7YOdYSg3trcueKBQwvUY6XUD
         yQftC90pBapgQjneErycLmbyjEtyMtEhHtdQXEQQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@elte.hu>
Subject: [PATCH -tip V5 1/4] kprobes: Suppress the suspicious RCU warning on kprobes
Date:   Thu,  2 Apr 2020 22:40:42 +0900
Message-Id: <158583484186.26060.10457956369009643624.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158583483116.26060.10517933482238348979.stgit@devnote2>
References: <158583483116.26060.10517933482238348979.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Reported-by: Anders Roxell <anders.roxell@linaro.org>
Suggested-by: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/kprobes.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 2625c241ac00..bd484392d789 100644
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

