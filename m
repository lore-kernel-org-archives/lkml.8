Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9B9C55186
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 05:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBC0820857
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 05:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587793821;
	bh=A5I0zjalWHaqyVHBItrDx5bgxBzVTkfvZ+G7hcy05Zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QzMWW0mXy+Fntsfuy8qsSeNpZDR17/lW/dSJNXKDULDk0B0Nhi/0vxlAUVA1cFhaB
	 wHsWJezzs3Oxze17D01p7n6OBBvU4Ab9302C9UHa/9BiKgA2rdayU4c/jPQZwBC6FB
	 BPT2PmTF96dajvH+BTyk/KMtXusri/A7U//88MOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgDYFtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 01:49:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgDYFtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 01:49:12 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 806E420857;
        Sat, 25 Apr 2020 05:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587793752;
        bh=A5I0zjalWHaqyVHBItrDx5bgxBzVTkfvZ+G7hcy05Zo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GgWMAu7xzTzZVCMRjFZ7mYgT4SCLBkj26i+gPxOJCPT72gxS7pCAbi+W7bQAbHwTT
         tcGGOHIAyTAX/v++mLX64K5rNpuyseYZl5zMHPS5Y6gJ6zq7aYNH1WsWu9rTSvZB2n
         NH/kAUYpCCw52tgxubwW4rrPx9rREUZ6NSUM7db8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 1/3] tracing/kprobes: Fix a double initialization typo
Date:   Sat, 25 Apr 2020 14:49:09 +0900
Message-Id: <158779374968.6082.2337484008464939919.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158779373972.6082.16695832932765258919.stgit@devnote2>
References: <158779373972.6082.16695832932765258919.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo that resulted in an unnecessary double
initialization to addr.

Fixes: c7411a1a126f ("tracing/kprobe: Check whether the non-suffixed symbol is notrace")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 kernel/trace/trace_kprobe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index d0568af4a0ef..0d9300c3b084 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -453,7 +453,7 @@ static bool __within_notrace_func(unsigned long addr)
 
 static bool within_notrace_func(struct trace_kprobe *tk)
 {
-	unsigned long addr = addr = trace_kprobe_address(tk);
+	unsigned long addr = trace_kprobe_address(tk);
 	char symname[KSYM_NAME_LEN], *p;
 
 	if (!__within_notrace_func(addr))

