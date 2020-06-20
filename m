Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7315C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 03:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF4C5233A0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 03:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592624896;
	bh=z256JtWU17ygIEPGlf5ik8tfeEi33L/eZkEqpyJhPiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Ew8q0+XQt/k5QqRoLJNDjtBA4RlfmZE188OvVEbla9fNRbwc9hkOgd1YIW9Y+8EZ
	 Kp2SaCUg5GOa0nP92aYhRkRofpTtiyr+Ecm6gkkiIu2lDDHkileQl211GeIM/DKL7Q
	 q3QtmlyX2f/ebahasO8JVOfTZlY1R9tsJCRAMfSs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgFTDsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 23:48:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgFTDp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 23:45:58 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A9E72100A;
        Sat, 20 Jun 2020 03:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592624758;
        bh=z256JtWU17ygIEPGlf5ik8tfeEi33L/eZkEqpyJhPiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UvQyfM3JgEnijk4mfEFV1o6ToajPwaZ6oinwciEX1LQhn7V5bXd8+AuSm0+rkNdeH
         0StLkkNqxGgkyDE8nAskpQfxv1bZLsM0CeVLOCVY1Q7xHcRM2U61rcM2c+a5gOE+Q6
         VyuI5oqWuwTr+muI/3qipT4uTnvP3fVkKnPzmdvQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 1/2] tracing/boot: Fix config dependency for synthedic event
Date:   Sat, 20 Jun 2020 12:45:54 +0900
Message-Id: <159262475441.185015.5300725180746017555.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159262474473.185015.177609153974879988.stgit@devnote2>
References: <159262474473.185015.177609153974879988.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 726721a51838 ("tracing: Move synthetic events to
a separate file") decoupled synthetic event from histogram,
boot-time tracing also has to check CONFIG_SYNTH_EVENT instead
of CONFIG_HIST_TRIGGERS.

Fixes: 726721a51838 ("tracing: Move synthetic events to a separate file")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_boot.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 9de29bb45a27..8b5490cb02bb 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -120,7 +120,7 @@ trace_boot_add_kprobe_event(struct xbc_node *node, const char *event)
 }
 #endif
 
-#ifdef CONFIG_HIST_TRIGGERS
+#ifdef CONFIG_SYNTH_EVENTS
 static int __init
 trace_boot_add_synth_event(struct xbc_node *node, const char *event)
 {

