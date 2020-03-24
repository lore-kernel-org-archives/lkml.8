Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F897C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 07:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F82920735
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 07:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585035294;
	bh=3p7k+XNYmJjEY9kaw0/x9dsFk6M+aGq/xpxVRBNIW6g=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=gQ1B0BEO4aWO6O8pDAbiS1e4GJtefN37qI8LJs605a+UsUvHOjCTkNVEacZzhuYqf
	 nbcUd8mEIozK5QRNcwykdUBdwXXHsnNH1eRx+wFFKfmhqA09t98v5VxHyGJd1Wo5OS
	 fNsdBwy5JFMBMkCqE1Afm3RMSIjVUyxM5Ui+N+kI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgCXHex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 03:34:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgCXHex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 03:34:53 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 643CF20719;
        Tue, 24 Mar 2020 07:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585035292;
        bh=3p7k+XNYmJjEY9kaw0/x9dsFk6M+aGq/xpxVRBNIW6g=;
        h=From:To:Cc:Subject:Date:From;
        b=WLx84AyFiLEd8mViP9DzGOGsOyXycwW2BzJapP8bMB0CzgHxOyaJm0o4eUsEx6RVt
         1wfXJqb7JRlB6OhWt9RAFGQlQ3hExGRbkQjLXviuYiIY1+zHAfuMF2ZggrKKFxs+Fk
         IVKKV9j6Une21dUYoU0G2tjADbY0KwCSq+w03OlM=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org,
        Taeung Song <treeze.taeung@gmail.com>,
        linux-trace-users@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Alban Crequy <alban@kinvolk.io>
Subject: [PATCH] ftrace/kprobe: Show the maxactive number on kprobe_events
Date:   Tue, 24 Mar 2020 16:34:48 +0900
Message-Id: <158503528846.22706.5549974121212526020.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show maxactive parameter on kprobe_events.
This allows user to save the current configuration and
restore it without losing maxactive parameter.

Reported-by: Taeung Song <treeze.taeung@gmail.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 362cca52f5de..d0568af4a0ef 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1078,6 +1078,8 @@ static int trace_kprobe_show(struct seq_file *m, struct dyn_event *ev)
 	int i;
 
 	seq_putc(m, trace_kprobe_is_return(tk) ? 'r' : 'p');
+	if (trace_kprobe_is_return(tk) && tk->rp.maxactive)
+		seq_printf(m, "%d", tk->rp.maxactive);
 	seq_printf(m, ":%s/%s", trace_probe_group_name(&tk->tp),
 				trace_probe_name(&tk->tp));
 

