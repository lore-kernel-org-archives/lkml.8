Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777DBC4BA11
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45FA724656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582707598;
	bh=49tfpGRVnqBQTopxUDbKTPCXsBFDOff5Cwem9g40BwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iILobBhyDhYLZnyV8eMTUUwt1g4m6z693NU4tjqQFbpDjCEYSEQVJ4dRq70UZwtEA
	 FsRMYBjKl9sIoAfo2VuONe0gaDTGdr8uLuOJhq87ax2HepKYBAh6zyVYGojr0RjTTQ
	 HLENAZ3f2SjvDkKQcN/4An/yEpZyFSbxRvOaZZkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbgBZI74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:59:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:49474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgBZI74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:59:56 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72AA620732;
        Wed, 26 Feb 2020 08:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582707595;
        bh=49tfpGRVnqBQTopxUDbKTPCXsBFDOff5Cwem9g40BwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=grHCW+GTMaYqs3IAf4tKY/ui3x21b3rIUcWd+NzTXwuOn1I81O+RLAvMM6NPusd6J
         9LKyDYy3X0R9I8Ag6/mczYan/W9Epn+e5bxoD4Cu5YW6MehYFzmq2cICOIpNPAOUWJ
         Fqql4fPl/zN4J+EpQNqIfk0zst+ez1pHjiFt39/Y=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH -tip V4 3/4] kprobes: Fix to protect kick_kprobe_optimizer() by kprobe_mutex
Date:   Wed, 26 Feb 2020 17:59:51 +0900
Message-Id: <158270759113.18966.8938334321921933993.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158270755997.18966.3544449431956918068.stgit@devnote2>
References: <158270755997.18966.3544449431956918068.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kprobe_optimizer() kick_kprobe_optimizer() is called
without kprobe_mutex, but this can race with other caller
which is protected by kprobe_mutex.

To fix that, expand kprobe_mutex protected area to protect
kick_kprobe_optimizer() call.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 38d9a5d7c8a4..6d76a6e3e1a5 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -592,11 +592,12 @@ static void kprobe_optimizer(struct work_struct *work)
 	mutex_unlock(&module_mutex);
 	mutex_unlock(&text_mutex);
 	cpus_read_unlock();
-	mutex_unlock(&kprobe_mutex);
 
 	/* Step 5: Kick optimizer again if needed */
 	if (!list_empty(&optimizing_list) || !list_empty(&unoptimizing_list))
 		kick_kprobe_optimizer();
+
+	mutex_unlock(&kprobe_mutex);
 }
 
 /* Wait for completing optimization and unoptimization */

