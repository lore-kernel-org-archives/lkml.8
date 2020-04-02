Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EABFC2BA15
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0884E206E9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585834870;
	bh=uEK/2a0UrijYpwZIvURwBp9H+zP0r43/NwKvgcUxSt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P0qwOeHOKz8x3kVfdxA/OQVuNfkw5vEk7WXY6qIQbR4j6mqKVuT5oN2NVZBFvOMSo
	 D9RyC6KoImvaNcVaiz3Tv3jdORX6nvBKGbEq1yA2K/qtXatAqK6o3trr9xuAO1Dt3Q
	 3DjH4qwtuWSQ5S8Q+qJtIYpLfS6pUNqcWE5wZ3mo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388672AbgDBNlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:41:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388726AbgDBNlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:41:08 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54FBD20784;
        Thu,  2 Apr 2020 13:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585834868;
        bh=uEK/2a0UrijYpwZIvURwBp9H+zP0r43/NwKvgcUxSt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k541SYXbJU4SREIFY0c8Ic+6eTZPsKit15D4g8MixNU6A8FqjJ5Hk83qjuf9LE0xL
         0JJg5olUzRgbTme4SYoY24Mfte8umh1MdH5GbI7ZLyX1lFnULz7CMHWlfmmeX50/O8
         6Ts6qsFJ0P2TAwdF3q4zMIXXP5jyU7YyEbA2d0dM=
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
Subject: [PATCH -tip V5 3/4] kprobes: Fix to protect kick_kprobe_optimizer() by kprobe_mutex
Date:   Thu,  2 Apr 2020 22:41:02 +0900
Message-Id: <158583486275.26060.15040916028360337365.stgit@devnote2>
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

In kprobe_optimizer() kick_kprobe_optimizer() is called
without kprobe_mutex, but this can race with other caller
which is protected by kprobe_mutex.

To fix that, expand kprobe_mutex protected area to protect
kick_kprobe_optimizer() call.

Fixes: cd7ebe2298ff ("kprobes: Use text_poke_smp_batch for optimizing")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
  Changes in v5: Add Fixes and Cc:stable tags.
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

