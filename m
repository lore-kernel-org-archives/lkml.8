Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683E0C55197
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 05:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A9520857
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 05:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587793821;
	bh=4r5CSvU+s72cUPpWeXl5tlXq2K72b9pI6RZJPtKhiJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wB/LtDbB1FDF5wBRGmPVsEDKfASGnpAEZBSVfJ+Cd2r6yoY9jgL77vi0jg73adZX3
	 qIPg6u/9Jl7ibgmxLu0vNwWVD7QUuajim86VNNaTgxPWUCJUt1oKNzbbUzwI66M5PD
	 a3Z5Z0hTb3yilOm4pLTteMKNhlyYVgyjzhbidhss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgDYFt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 01:49:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgDYFt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 01:49:29 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 180662098B;
        Sat, 25 Apr 2020 05:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587793769;
        bh=4r5CSvU+s72cUPpWeXl5tlXq2K72b9pI6RZJPtKhiJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wubMSlqOmZJ1zR4Fjf97ANO7mHgyEXb6StmI+RD9Ty2bzUUfQaoGlX0E+pEQKsnTr
         h1XymzVnRlnNWC2mMeVprnk+VD4V079OP8Culycn4LF9erqMLMqkwH5xktPUCw20tQ
         L/owFpRol6HoyzmgxbWAtdKzr1VMnVV+p6zuudo8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 3/3] tracing/kprobes: Reject new event if loc is NULL
Date:   Sat, 25 Apr 2020 14:49:26 +0900
Message-Id: <158779376597.6082.1411212055469099461.stgit@devnote2>
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

Reject the new event which has NULL location for kprobes.
For kprobes, user must specify at least the location.

Fixes: 2a588dd1d5d6 ("tracing: Add kprobe event command generation functions")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 kernel/trace/trace_kprobe.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 0d9300c3b084..35989383ae11 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -940,6 +940,9 @@ EXPORT_SYMBOL_GPL(kprobe_event_cmd_init);
  * complete command or only the first part of it; in the latter case,
  * kprobe_event_add_fields() can be used to add more fields following this.
  *
+ * Unlikely the synth_event_gen_cmd_start(), @loc must be specified. This
+ * returns -EINVAL if @loc == NULL.
+ *
  * Return: 0 if successful, error otherwise.
  */
 int __kprobe_event_gen_cmd_start(struct dynevent_cmd *cmd, bool kretprobe,
@@ -953,6 +956,9 @@ int __kprobe_event_gen_cmd_start(struct dynevent_cmd *cmd, bool kretprobe,
 	if (cmd->type != DYNEVENT_TYPE_KPROBE)
 		return -EINVAL;
 
+	if (!loc)
+		return -EINVAL;
+
 	if (kretprobe)
 		snprintf(buf, MAX_EVENT_NAME_LEN, "r:kprobes/%s", name);
 	else

