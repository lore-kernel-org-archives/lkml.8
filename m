Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F275DC54E4B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE0562075E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589270583;
	bh=uEK/2a0UrijYpwZIvURwBp9H+zP0r43/NwKvgcUxSt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EjDmIkesQ70mxWem8lz20H8LK75CVbF8RC4+0EDXrKlIg5NN1ySyuyPUCIK9zsklH
	 TUInO/Dd2/6q3jY3MbznLajAsdAny0j23EGrlyE0QaBd5N6Xour05SMJVdfuJc7ttx
	 kx3BV8+mtzoIzkqt70N8sG+hokdWbIA2ahkqLqFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbgELIDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 04:03:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbgELIDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 04:03:02 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CCCB20733;
        Tue, 12 May 2020 08:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589270581;
        bh=uEK/2a0UrijYpwZIvURwBp9H+zP0r43/NwKvgcUxSt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sRRrdM+hiaXA1hHDjbrxdIuHK0mTtNtnu3u0SRrUGa+QOuwUc8H0zgPCOIOh/JLZG
         VTsKKFhZgQdL9RwBYxaSLkN6vjEtFfdYQntmcb0yb74H4BIZXkyyIzwck82XQvcmkR
         WPN0qucvdWUSVvmIskHLJcbLSlCK3YsdAJIxWrV8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@elte.hu>,
        Peter Zijlstra <peterz@infradead.org>,
        Ziqian SUN <zsun@redhat.com>
Subject: [PATCH -tip V6 3/6] kprobes: Fix to protect kick_kprobe_optimizer() by kprobe_mutex
Date:   Tue, 12 May 2020 17:02:56 +0900
Message-Id: <158927057586.27680.5036330063955940456.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158927054236.27680.18209720730136003586.stgit@devnote2>
References: <158927054236.27680.18209720730136003586.stgit@devnote2>
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

