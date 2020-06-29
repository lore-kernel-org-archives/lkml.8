Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0D7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 787E520656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593461916;
	bh=zmb9aZXgj3+VHQSBwM4mMhdjrr/RkgwzppLqULpozgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kdbqqMYWeN8gz8AHSK8qAKzVbZMCr1yetIno+CuQ9E2b1g4ULtRvMnXz3MTuQkGvf
	 skrpiPfuzKKmlkKE/Snxnyn90VYy330urP5Hl1Y3tYUNfwlTdlnnTjUOgZ25IbH546
	 ufbM9zZ5BPKmG3w18CuQOa0KZ/o+4+rCJmdEbVO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388384AbgF2USf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:18:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732637AbgF2TZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:25:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7445253E3;
        Mon, 29 Jun 2020 15:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445328;
        bh=zmb9aZXgj3+VHQSBwM4mMhdjrr/RkgwzppLqULpozgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BXmD/OwQTpann1s9AVmUfUMYAHCl4IswcfGlNI+pYTkS8QZjrAdI2MneowH2n2hvl
         2YK5wDFQiaGc63jW7U3aGYuZUY+rUMcVFcTQgxPaL6hmZ2GVmFOZdHSiY8LAlCZpBk
         5xnfReoIrIly/mhtPT1wBISVM+N+1oq9pNCz1slc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Ingo Molnar <mingo@elte.hu>,
        Peter Zijlstra <peterz@infradead.org>,
        Ziqian SUN <zsun@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 092/191] kprobes: Fix to protect kick_kprobe_optimizer() by kprobe_mutex
Date:   Mon, 29 Jun 2020 11:38:28 -0400
Message-Id: <20200629154007.2495120-93-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629154007.2495120-1-sashal@kernel.org>
References: <20200629154007.2495120-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit 1a0aa991a6274161c95a844c58cfb801d681eb59 ]

In kprobe_optimizer() kick_kprobe_optimizer() is called
without kprobe_mutex, but this can race with other caller
which is protected by kprobe_mutex.

To fix that, expand kprobe_mutex protected area to protect
kick_kprobe_optimizer() call.

Link: http://lkml.kernel.org/r/158927057586.27680.5036330063955940456.stgit@devnote2

Fixes: cd7ebe2298ff ("kprobes: Use text_poke_smp_batch for optimizing")
Cc: Ingo Molnar <mingo@kernel.org>
Cc: "Gustavo A . R . Silva" <gustavoars@kernel.org>
Cc: Anders Roxell <anders.roxell@linaro.org>
Cc: "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: David Miller <davem@davemloft.net>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ziqian SUN <zsun@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kprobes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 1b75fb8c7735e..3db9cf412996c 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -561,11 +561,12 @@ static void kprobe_optimizer(struct work_struct *work)
 	do_free_cleaned_kprobes();
 
 	mutex_unlock(&module_mutex);
-	mutex_unlock(&kprobe_mutex);
 
 	/* Step 5: Kick optimizer again if needed */
 	if (!list_empty(&optimizing_list) || !list_empty(&unoptimizing_list))
 		kick_kprobe_optimizer();
+
+	mutex_unlock(&kprobe_mutex);
 }
 
 /* Wait for completing optimization and unoptimization */
-- 
2.25.1

