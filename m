Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169D9C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B022078C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585834881;
	bh=uGqLN9OKnBbyA8w53Dt2jn5v0hokTKXjpPNu+Z3TREY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sYZkHWYrTFB2cRPj+OB8uNHGQfnmsf9HWGGwInf4L6zc1Tr3kx5YL9cVVH7igYmRL
	 zzcHlNtR/zYgGdxxuJQkqfiNWKYQLg/kc2bwa36wazpWhV7Hrn7LWS32j6QXx45LFF
	 wYHNnrAN+tMME/7CLijdmpgqYhSN1vGyB40luRTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388783AbgDBNlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:41:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388745AbgDBNlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:41:19 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16A81206F5;
        Thu,  2 Apr 2020 13:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585834878;
        bh=uGqLN9OKnBbyA8w53Dt2jn5v0hokTKXjpPNu+Z3TREY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GOJ3w8OZMnBouSV0+oG0BDUA7+OfMQbvPkjbRwZ+h6eU0Fr3RQUI/U7l0o5uBd89z
         tETCeGxIDLn74TNnEQ3l652BWURBpVsqjJ41wVpMuvr8P3c9gahlxvbz8HxMd95+QC
         FmoVcGqoMWvYVoFC9jtzLfy2D8F7QK/xMuTYbzTI=
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
Subject: [PATCH -tip V5 4/4] kprobes: Remove redundant arch_disarm_kprobe() call
Date:   Thu,  2 Apr 2020 22:41:13 +0900
Message-Id: <158583487360.26060.7561147147547003265.stgit@devnote2>
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

Fix to remove redundant arch_disarm_kprobe() call in
force_unoptimize_kprobe(). This arch_disarm_kprobe()
will be invoked if the kprobe is optimized but disabled,
but that means the kprobe (optprobe) is unused (and
unoptimized) state.

In that case, unoptimize_kprobe() puts it in freeing_list
and kprobe_optimizer (do_unoptimize_kprobes()) automatically
disarm it. Thus this arch_disarm_kprobe() is redundant.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 6d76a6e3e1a5..627fc1b7011a 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -675,8 +675,6 @@ static void force_unoptimize_kprobe(struct optimized_kprobe *op)
 	lockdep_assert_cpus_held();
 	arch_unoptimize_kprobe(op);
 	op->kp.flags &= ~KPROBE_FLAG_OPTIMIZED;
-	if (kprobe_disabled(&op->kp))
-		arch_disarm_kprobe(&op->kp);
 }
 
 /* Unoptimize a kprobe if p is optimized */

