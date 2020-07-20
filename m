Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12220C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 02:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFF982177B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 02:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="RzwVEkbt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgGTCVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 22:21:54 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:21224 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726510AbgGTCVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 22:21:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595211713; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=QCeLGXUUJPDQeHoRFw7rlWyuXvEvFyGagkbQpzgobm4=; b=RzwVEkbt/uBJSyNwBo0nU7Zk/ebl/GJM+mvmXXXRRK/S8FuNwO6PQdzHSuIcNUH63dXWtTNg
 9xmEL6IJ7UotneQ+ZwzzF/j3Az8HCDoCMIyLRpQr7bg7zxzkmx3EMSmy97zzyw8JoIbxVzFD
 8+AR6M/qfOXqugYAbYqHhQxLe8c=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n16.prod.us-west-2.postgun.com with SMTP id
 5f14ffb0166c1c5494558285 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 20 Jul 2020 02:21:36
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 77192C43391; Mon, 20 Jul 2020 02:21:36 +0000 (UTC)
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7C295C433C9;
        Mon, 20 Jul 2020 02:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7C295C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingwei@codeaurora.org
From:   Tingwei Zhang <tingwei@codeaurora.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] tracing: add trace_export support for event trace
Date:   Mon, 20 Jul 2020 10:21:15 +0800
Message-Id: <20200720022117.9375-3-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200720022117.9375-1-tingwei@codeaurora.org>
References: <20200720022117.9375-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only function traces can be exported to other destinations currently.
This patch exports event trace as well.

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
---
 kernel/trace/trace.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bb62269724d5..aef6330836e2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2697,17 +2697,6 @@ int tracepoint_printk_sysctl(struct ctl_table *table, int write,
 	return ret;
 }
 
-void trace_event_buffer_commit(struct trace_event_buffer *fbuffer)
-{
-	if (static_key_false(&tracepoint_printk_key.key))
-		output_printk(fbuffer);
-
-	event_trigger_unlock_commit_regs(fbuffer->trace_file, fbuffer->buffer,
-				    fbuffer->event, fbuffer->entry,
-				    fbuffer->flags, fbuffer->pc, fbuffer->regs);
-}
-EXPORT_SYMBOL_GPL(trace_event_buffer_commit);
-
 /*
  * Skip 3:
  *
@@ -2868,6 +2857,19 @@ int unregister_ftrace_export(struct trace_export *export)
 }
 EXPORT_SYMBOL_GPL(unregister_ftrace_export);
 
+void trace_event_buffer_commit(struct trace_event_buffer *fbuffer)
+{
+	if (static_key_false(&tracepoint_printk_key.key))
+		output_printk(fbuffer);
+
+	if (static_branch_unlikely(&ftrace_exports_enabled))
+		ftrace_exports(fbuffer->event);
+	event_trigger_unlock_commit_regs(fbuffer->trace_file, fbuffer->buffer,
+				    fbuffer->event, fbuffer->entry,
+				    fbuffer->flags, fbuffer->pc, fbuffer->regs);
+}
+EXPORT_SYMBOL_GPL(trace_event_buffer_commit);
+
 void
 trace_function(struct trace_array *tr,
 	       unsigned long ip, unsigned long parent_ip, unsigned long flags,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

