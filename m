Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2662C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7712077D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585234184;
	bh=gsiBdM4GJWRNPxCJKxgIFusNW93mPFGr2xfRoH1o6oU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vsg7qlnNHLkcMliaNizmZYEuWLz/4+uyVOv6Qp04QU0mmk+KVlvKxK7ZdkUKoa4dR
	 tVssmDHyjio3rSNI7CB43bUP4mwNai6PCpLanhI6xi3R5JZg0cfg3+WB2youDcU7dZ
	 sKS2lU1j3mYnbd+GD1GbDH2eS5MtpQhsCtPwrLPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgCZOtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:49:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgCZOtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 10:49:43 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1778D20775;
        Thu, 26 Mar 2020 14:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585234182;
        bh=gsiBdM4GJWRNPxCJKxgIFusNW93mPFGr2xfRoH1o6oU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I6pOYAMc3BykXzW7/u1TlepWN56skWAiUYjYyk0GbmNkMvSaybdWKp7v39LiLkmJX
         AeGEBL7Sy72sMEguWZzthv312Yr2j8i25rf0jD2jFX+CFzMWisWIVUa/GJ08v3stOt
         oP/miwH8kxnDNAEDDZOXV4BCd6hBNg4XMHYd+uDc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Paul McKenney <paulmck@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH -tip 1/4] kprobes: Lock kprobe_mutex while showing kprobe_blacklist
Date:   Thu, 26 Mar 2020 23:49:36 +0900
Message-Id: <158523417665.24735.10253198878535635600.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158523416289.24735.10455512519475919061.stgit@devnote2>
References: <158523416289.24735.10455512519475919061.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lock kprobe_mutex while showing kprobe_blacklist to prevent
updating the kprobe_blacklist.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 2625c241ac00..570d60827656 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2420,6 +2420,7 @@ static const struct file_operations debugfs_kprobes_operations = {
 /* kprobes/blacklist -- shows which functions can not be probed */
 static void *kprobe_blacklist_seq_start(struct seq_file *m, loff_t *pos)
 {
+	mutex_lock(&kprobe_mutex);
 	return seq_list_start(&kprobe_blacklist, *pos);
 }
 
@@ -2446,10 +2447,15 @@ static int kprobe_blacklist_seq_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+static void kprobe_blacklist_seq_stop(struct seq_file *f, void *v)
+{
+	mutex_unlock(&kprobe_mutex);
+}
+
 static const struct seq_operations kprobe_blacklist_seq_ops = {
 	.start = kprobe_blacklist_seq_start,
 	.next  = kprobe_blacklist_seq_next,
-	.stop  = kprobe_seq_stop,	/* Reuse void function */
+	.stop  = kprobe_blacklist_seq_stop,
 	.show  = kprobe_blacklist_seq_show,
 };
 

