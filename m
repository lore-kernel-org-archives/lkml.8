Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8834C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 03:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A45B3206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 03:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="wJ+x0qTe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgGZDAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 23:00:13 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:20344 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728263AbgGZDAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 23:00:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595732412; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=kKtbWF1Oubqhm2kDRww7WqHfhP1TPH4aURnvAU7qMr0=; b=wJ+x0qTebw2cExGmxpnUjmWGy35xC8hxq0XQSuzkjWQRD6vpDBUGbQSPJimM6PrpNcNJHoL0
 pVEKNi0h5ojdIFuhJ1XBkwrYLB4uNU05dqdRa4Bj+qUDIhlhGFXOPBiwr4D5BJISLPFubdoS
 28677KNR1KeRF99CIBSmUhYjA7s=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n19.prod.us-west-2.postgun.com with SMTP id
 5f1cf1af98acebb4e989751c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 26 Jul 2020 02:59:59
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 26F8DC43391; Sun, 26 Jul 2020 02:59:59 +0000 (UTC)
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 09DE3C433C9;
        Sun, 26 Jul 2020 02:59:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 09DE3C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingwei@codeaurora.org
From:   Tingwei Zhang <tingwei@codeaurora.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] tracing: add trace_export support for trace_marker
Date:   Sun, 26 Jul 2020 10:59:29 +0800
Message-Id: <20200726025931.30510-5-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200726025931.30510-1-tingwei@codeaurora.org>
References: <20200726025931.30510-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the support to route trace_marker buffer to other destination
via trace_export.

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
---
 include/linux/trace.h | 1 +
 kernel/trace/trace.c  | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/trace.h b/include/linux/trace.h
index 91f6f1c0f2db..4bb6918fbf44 100644
--- a/include/linux/trace.h
+++ b/include/linux/trace.h
@@ -6,6 +6,7 @@
 
 #define TRACE_EXPORT_FUNCTION	BIT_ULL(0)
 #define TRACE_EXPORT_EVENT	BIT_ULL(1)
+#define TRACE_EXPORT_MARKER	BIT_ULL(2)
 
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

