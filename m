Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808C6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 01:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56BB521775
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 01:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ZJrSkx77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgHMBqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 21:46:46 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:11293 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726673AbgHMBqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 21:46:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597283204; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=J+GkYlJeue+xhm0JgHaodonblQjXsPYjEk8/Vc2LCdw=; b=ZJrSkx77qpcfXjgAhIP25kVpsvuB2nuH0RovnEUk/pYZXe6tLpZrJ/HlP5WRL7dLwbJpLNiS
 lMOmFiCQx7zq/92/4oZ+xynIw+zhb1J8VfxBC8/td6YA5K2gwckKSIpRwM3BdyIXN+DqgMyH
 FkpRqlIW+xsvX+dhS8Z2usMJo00=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f349b6a2889723bf8da7be5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 13 Aug 2020 01:46:18
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AF09AC43391; Thu, 13 Aug 2020 01:46:17 +0000 (UTC)
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 49181C433A1;
        Thu, 13 Aug 2020 01:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 49181C433A1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingwei@codeaurora.org
From:   Tingwei Zhang <tingwei@codeaurora.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org
Subject: [PATCH v3 4/6] tracing: add trace_export support for trace_marker
Date:   Thu, 13 Aug 2020 09:45:50 +0800
Message-Id: <20200813014552.23539-5-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200813014552.23539-1-tingwei@codeaurora.org>
References: <20200813014552.23539-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the support to route trace_marker buffer to other destination
via trace_export.

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace.h | 1 +
 kernel/trace/trace.c  | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/trace.h b/include/linux/trace.h
index 5a01eeffb254..80b7df68bc0f 100644
--- a/include/linux/trace.h
+++ b/include/linux/trace.h
@@ -6,6 +6,7 @@
 
 #define TRACE_EXPORT_FUNCTION	BIT(0)
 #define TRACE_EXPORT_EVENT	BIT(1)
+#define TRACE_EXPORT_MARKER	BIT(2)
 
 /*
  * The trace export - an export of Ftrace output. The trace_export
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2f9302a8b322..67993abda394 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -271,6 +271,7 @@ static struct trace_export __rcu *ftrace_exports_list __read_mostly;
 
 static DEFINE_STATIC_KEY_FALSE(trace_function_exports_enabled);
 static DEFINE_STATIC_KEY_FALSE(trace_event_exports_enabled);
+static DEFINE_STATIC_KEY_FALSE(trace_marker_exports_enabled);
 
 static inline void ftrace_exports_enable(struct trace_export *export)
 {
@@ -279,6 +280,9 @@ static inline void ftrace_exports_enable(struct trace_export *export)
 
 	if (export->flags & TRACE_EXPORT_EVENT)
 		static_branch_inc(&trace_event_exports_enabled);
+
+	if (export->flags & TRACE_EXPORT_MARKER)
+		static_branch_inc(&trace_marker_exports_enabled);
 }
 
 static inline void ftrace_exports_disable(struct trace_export *export)
@@ -288,6 +292,9 @@ static inline void ftrace_exports_disable(struct trace_export *export)
 
 	if (export->flags & TRACE_EXPORT_EVENT)
 		static_branch_dec(&trace_event_exports_enabled);
+
+	if (export->flags & TRACE_EXPORT_MARKER)
+		static_branch_dec(&trace_marker_exports_enabled);
 }
 
 static void ftrace_exports(struct ring_buffer_event *event, int flag)
@@ -6648,6 +6655,8 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	} else
 		entry->buf[cnt] = '\0';
 
+	if (static_branch_unlikely(&trace_marker_exports_enabled))
+		ftrace_exports(event, TRACE_EXPORT_MARKER);
 	__buffer_unlock_commit(buffer, event);
 
 	if (tt)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

