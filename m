Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4336EC55196
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 05:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C86620724
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 05:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587793821;
	bh=xczF0e7z8FWiMckLdrl4XzFmaLTbH+PmPrAqeH1cxA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UtjwOeTXYM1bukraF1HJjRrlGF3lHscB2A/wRID+j+QGSkrR1LGXg5Ait8QD1u2tM
	 2AnCbJn1ip1jk+Yz2Nl7JBa77ZqBr9HvbtR36p/Q94KV28L4lZe3H4M+vdJb2SDcvj
	 C1I/+PPh/Fn1R1kCj5nK3wbRBuT7MvmZ5EYdsAGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgDYFtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 01:49:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgDYFtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 01:49:20 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD34221655;
        Sat, 25 Apr 2020 05:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587793760;
        bh=xczF0e7z8FWiMckLdrl4XzFmaLTbH+PmPrAqeH1cxA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kW1MT70/6d6ZaEUkvEi/4lYX+d/a6PK1ZeNJ1xR44zMzNWy+7A3rmMEJC2/d9nMf9
         Z31TuAOU0CQJIzS7ey+pxR3S7PI5nZs585JLZEjcFmaRfOLTwfD0YRijycvx+BonRK
         r08Ops6FQARlKY+KYjmvT3LppSQbFUaS4cMoRLU0=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 2/3] tracing/boottime: Fix kprobe event API usage
Date:   Sat, 25 Apr 2020 14:49:17 +0900
Message-Id: <158779375766.6082.201939936008972838.stgit@devnote2>
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

Fix boottime kprobe events to use API correctly for
multiple events.

For example, when we set a multiprobe kprobe events in
bootconfig like below,

  ftrace.event.kprobes.myevent {
  	probes = "vfs_read $arg1 $arg2", "vfs_write $arg1 $arg2"
  }

This cause an error;

  trace_boot: Failed to add probe: p:kprobes/myevent (null)  vfs_read $arg1 $arg2  vfs_write $arg1 $arg2

This shows the 1st argument becomes NULL and multiprobes
are merged to 1 probe.

Fixes: 29a154810546 ("tracing: Change trace_boot to use kprobe_event interface")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 kernel/trace/trace_boot.c |   20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 06d7feb5255f..9de29bb45a27 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -95,24 +95,20 @@ trace_boot_add_kprobe_event(struct xbc_node *node, const char *event)
 	struct xbc_node *anode;
 	char buf[MAX_BUF_LEN];
 	const char *val;
-	int ret;
+	int ret = 0;
 
-	kprobe_event_cmd_init(&cmd, buf, MAX_BUF_LEN);
+	xbc_node_for_each_array_value(node, "probes", anode, val) {
+		kprobe_event_cmd_init(&cmd, buf, MAX_BUF_LEN);
 
-	ret = kprobe_event_gen_cmd_start(&cmd, event, NULL);
-	if (ret)
-		return ret;
+		ret = kprobe_event_gen_cmd_start(&cmd, event, val);
+		if (ret)
+			break;
 
-	xbc_node_for_each_array_value(node, "probes", anode, val) {
-		ret = kprobe_event_add_field(&cmd, val);
+		ret = kprobe_event_gen_cmd_end(&cmd);
 		if (ret)
-			return ret;
+			pr_err("Failed to add probe: %s\n", buf);
 	}
 
-	ret = kprobe_event_gen_cmd_end(&cmd);
-	if (ret)
-		pr_err("Failed to add probe: %s\n", buf);
-
 	return ret;
 }
 #else

