Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F77C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB75207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579185898;
	bh=4upz+fdluUISoJZ33aDVbQ1x81k94Nw4AOfmfeoVQZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=agHQ7pWvEuryFYxhVfTmp0T2H6BDSkZyvUxzp25ZeHjVxvDHQdiyC0jHvXHpC3Nxw
	 Ue4w5PlOw4CdCihjJoZ7j2LIA7A69JtdrrwHZtdWkLFkbfM9iQsq6TjnLxdb6tGaV1
	 oAr9THcr1ZwnCZwuR2F3dz2pzFOwibMlG0NQr0s0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgAPOo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:44:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:35436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgAPOo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 09:44:57 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE1912075B;
        Thu, 16 Jan 2020 14:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579185896;
        bh=4upz+fdluUISoJZ33aDVbQ1x81k94Nw4AOfmfeoVQZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lSvM9Bj/NOwNqHbD6Pu9DMbkqlfc5gX1JoIItPS1FjXevogDBXBKS3FsMWOd5BcQM
         oDBxU3hJ0dnSiC5N/LfEPppkICShyhQsZd9Xzns7H/1eZNq6FcLG9CI3A55EQZyVSe
         2m6CFZpk+rqbCBYJZpH6MXCXEcHVZcTP017JKnsU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Brendan Gregg <brendan.d.gregg@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     mhiramat@kernel.org, Ingo Molnar <mingo@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "David S . Miller" <davem@davemloft.net>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: [RFT PATCH 04/13] kprobes: Make optimizer delay to 1 second
Date:   Thu, 16 Jan 2020 23:44:52 +0900
Message-Id: <157918589199.29301.4419459150054220408.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157918584866.29301.6941815715391411338.stgit@devnote2>
References: <157918584866.29301.6941815715391411338.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the 5 jiffies delay for the optimizer is too
short to wait for other probes, make it longer,
like 1 second.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 0dacdcecc90f..9c6e230852ad 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -469,7 +469,8 @@ static int kprobe_optimizer_queue_update;
 
 static void kprobe_optimizer(struct work_struct *work);
 static DECLARE_DELAYED_WORK(optimizing_work, kprobe_optimizer);
-#define OPTIMIZE_DELAY 5
+/* Wait 1 second for starting optimization */
+#define OPTIMIZE_DELAY HZ
 
 /*
  * Optimize (replace a breakpoint with a jump) kprobes listed on

