Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FCEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C47920774
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mFuZaL8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgFHM4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 08:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbgFHM4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 08:56:00 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF530C08C5C3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 05:55:59 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id y13so18178718eju.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 05:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xZSmmZRxwaSFlAQ/QPHWTlQ0XQomYLOTrs+C/wJekUA=;
        b=mFuZaL8Amji3XMg7qBHt7NINexu2PtEC0PZmD6/aic1G6PxN3jrHLJhlfgHB+Nz/A3
         R4tJ/+qCzUaAXSjccefK4FZu8QdxG3Tngq6xK3TiD+n3MFguSlSYgovB921h5N0CM2ju
         e4jfx/ygOkF+OHIDkGxJBqAhqtxsv/luEXU0HzeOU6xuSoxfrESAaN4SJbJRSjroDDtK
         YACni5/Fuk9coJZC7Bk5QKOtrXBbwn5QfyYY0XtgvsIQy/haDuPfFSvqW4LT0ZRfEMyM
         uS6qlWTjEerIRGZF3JHB3ZcBIGdK8N9NQEfAlJbDKMYg9ZBzfBolw2RmzDLckWoby07p
         J5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xZSmmZRxwaSFlAQ/QPHWTlQ0XQomYLOTrs+C/wJekUA=;
        b=a63gAlc8oTQNC+A+6OySFm6rwqpnBN7N4DyWMUqJGZCqxfwbk1CQBVn92S6IfOJw98
         2EelApt+JQC/jc0T4JeGjjMg+N+IB+/kFcwYViSaytiF4dp13hkZwZzLXl1nTVfoAGwq
         DfNsqBXTvQ1P9PflIXVA+wiWReCDv60n0vLa98hX4lvmpfHfuN9Rbrau8fSsMrtPgOIv
         +UOQf66c1WulezCEn8jLgohgAaNihs/890P1Nrn3qOwGKUKk7o/pl081X0lHQNWPCa05
         AeU07b5cnPOsfIRIjRvsH1tSrFvRNcRTKM3H+nOYVY355f/OVJfUXdgSzxv+jmsfGdza
         SuZA==
X-Gm-Message-State: AOAM530i9wDZnPDJxeaGTKQo63c37vggV/4YmofrkZL/51DqRusUxd3R
        PdoRhEysiaOoCzUdav8uE60A9/dwicN+Xg==
X-Google-Smtp-Source: ABdhPJyRYlLmXuOs2DMxSSDWSWQfxH/DHqvXwEjiSNo2xPN+Oc3rBv33mEMqAe7gDQBH8U9xTnMiug==
X-Received: by 2002:a17:906:39d9:: with SMTP id i25mr20331284eje.510.1591620958326;
        Mon, 08 Jun 2020 05:55:58 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id h9sm10602388ejc.96.2020.06.08.05.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 05:55:57 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     mhiramat@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH] tracing/probe: Fix bpf_task_fd_query() for kprobes and uprobes
Date:   Mon,  8 Jun 2020 14:45:32 +0200
Message-Id: <20200608124531.819838-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 60d53e2c3b75 ("tracing/probe: Split trace_event related data from
trace_probe") removed the trace_[ku]probe structure from the
trace_event_call->data pointer. As bpf_get_[ku]probe_info() were
forgotten in that change, fix them now. These functions are currently
only used by the bpf_task_fd_query() syscall handler to collect
information about a perf event.

Fixes: 60d53e2c3b75 ("tracing/probe: Split trace_event related data from trace_probe")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
Found while trying to run the task_fd_query BPF sample. I intend to try
and move that sample to kselftests since it seems like a useful
regression test.
---
 kernel/trace/trace_kprobe.c | 2 +-
 kernel/trace/trace_uprobe.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 35989383ae113..8eeb95e04bf52 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1629,7 +1629,7 @@ int bpf_get_kprobe_info(const struct perf_event *event, u32 *fd_type,
 	if (perf_type_tracepoint)
 		tk = find_trace_kprobe(pevent, group);
 	else
-		tk = event->tp_event->data;
+		tk = trace_kprobe_primary_from_call(event->tp_event);
 	if (!tk)
 		return -EINVAL;
 
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 2a8e8e9c1c754..fdd47f99b18fd 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1412,7 +1412,7 @@ int bpf_get_uprobe_info(const struct perf_event *event, u32 *fd_type,
 	if (perf_type_tracepoint)
 		tu = find_probe_event(pevent, group);
 	else
-		tu = event->tp_event->data;
+		tu = trace_uprobe_primary_from_call(event->tp_event);
 	if (!tu)
 		return -EINVAL;
 
-- 
2.27.0

