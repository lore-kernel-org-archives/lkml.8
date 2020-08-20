Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD84C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 19:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06CDB207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 19:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="i322tcU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgHTTlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 15:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgHTTlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 15:41:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800E3C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 12:41:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k11so3527330ybp.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 12:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=YgM2l06yXFrB/oTTXJnH10cRhyOfMBX9VKKhedx17aA=;
        b=i322tcU+qBMj6LloIDp+mYxoPICgPx3YYJN6DBJnDWHcw185Xvpj5nEUT3y2gzm6ww
         I9jfRtD8byBn+K9m80Xg2aIiHFpueYlXQZ2xEhjjeX7wwGZ3gy8n/bKi9RDUOcaVlhBr
         RNZ+5euCW/9prGh/rl9QHg43THCOCxGPyuT96GJxA9EdPIDsOLJQiOgpslcl5LMCm0Rr
         fKsCNSK6QvWAlBKlYejiCQLaz5F593k7m8fNPFNhycR49zUNf7rjancd4MrvGPa69VL9
         /K82sIQxDar5TDhiyf4EPGRCZpNriNPqSpT6aM2ewkFOAaQIy1aGifQfbXDDdQ0VKpOe
         zaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YgM2l06yXFrB/oTTXJnH10cRhyOfMBX9VKKhedx17aA=;
        b=DYDyDzBPOJkGCszKdvl4GgGKWSw8VhOUGCmHPyOuh0UPCeI0NgXvywBff7rRbmWAPO
         2rA+DeP2PzkT+tw9rmi1uuJJbwhA8tU7bVGlJEAKmHOJTFsBCuWU4KiVGBx+bunIgirT
         PQUQi0U2XwQleLSoJH4ZX/uRKc49aMtlC7h0Vga/pKMk/HLcfvdup4OOutMTtBqRXTLr
         fzWY+LRKw7E9x/jXPT3PoBnED8Rlj0w2cNsff/hwdTfpL6nxPYj80VR79vEbwYG4qnKk
         8XjjVIStavvuoy06vvMu6rFxqQEEoXy12oZrhJKw9zNseqCA5J4AnKQBVFBty1wJPoz9
         AGXw==
X-Gm-Message-State: AOAM532d3TsfBEzlGkqXm1Q8wwinN6w0JZsY5HR+ciLHDfh+a4McEg4D
        rtJw9+6Gcy1EIChD+8afDwyRtjo=
X-Google-Smtp-Source: ABdhPJwIti/cX9Fu840aWQ8uM7450Te50w1JQejov747b99RObmlZu6IiBiIiCaa4Edd1PbklZXlBGw=
X-Received: from lpy-goobuntu.mtv.corp.google.com ([2620:15c:211:2:5265:f3ff:fe23:c8be])
 (user=lpy job=sendgmr) by 2002:a25:4b47:: with SMTP id y68mr6381709yba.89.1597952504712;
 Thu, 20 Aug 2020 12:41:44 -0700 (PDT)
Date:   Thu, 20 Aug 2020 12:41:34 -0700
In-Reply-To: <20200813175037.48a16064@oasis.local.home>
Message-Id: <20200820194134.2176242-1-lpy@google.com>
Mime-Version: 1.0
References: <20200813175037.48a16064@oasis.local.home>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v3] Add power/gpu_frequency tracepoint.
From:   Peiyong Lin <lpy@google.com>
To:     rostedt@goodmis.org
Cc:     amit.kucheria@linaro.org, android-kernel@google.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        lpy@google.com, mingo@redhat.com, paul.walmsley@sifive.com,
        pavel@ucw.cz, prahladk@google.com, rafael.j.wysocki@intel.com,
        ulf.hansson@linaro.org, yamada.masahiro@socionext.com,
        zzyiwei@android.com, sidaths@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Historically there is no common trace event for GPU frequency, in
downstream Android each different hardware vendor implements their own
way to expose GPU frequency, for example as a debugfs node.  This patch
standardize it as a common trace event in upstream linux kernel to help
the ecosystem have a common implementation across hardware vendors.
Toolings in the Linux ecosystem will benefit from this especially in the
downstream Android, where this information is critical to graphics
developers.

Signed-off-by: Peiyong Lin <lpy@google.com>
---

Changelog sice v2:
 - Add more comments to indicate when the event should be emitted.
 - Change state to frequency.

Changelog since v1:
 - Use %u in TP_printk

 drivers/gpu/Makefile                    |  1 +
 drivers/gpu/trace/Kconfig               |  3 +++
 drivers/gpu/trace/Makefile              |  1 +
 drivers/gpu/trace/trace_gpu_frequency.c | 13 ++++++++++
 include/trace/events/power.h            | 33 +++++++++++++++++++++++++
 5 files changed, 51 insertions(+)
 create mode 100644 drivers/gpu/trace/trace_gpu_frequency.c

diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
index 835c88318cec..f289a47eb031 100644
--- a/drivers/gpu/Makefile
+++ b/drivers/gpu/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_TEGRA_HOST1X)	+= host1x/
 obj-y			+= drm/ vga/
 obj-$(CONFIG_IMX_IPUV3_CORE)	+= ipu-v3/
 obj-$(CONFIG_TRACE_GPU_MEM)		+= trace/
+obj-$(CONFIG_TRACE_GPU_FREQUENCY)		+= trace/
diff --git a/drivers/gpu/trace/Kconfig b/drivers/gpu/trace/Kconfig
index c24e9edd022e..ac4aec8d5845 100644
--- a/drivers/gpu/trace/Kconfig
+++ b/drivers/gpu/trace/Kconfig
@@ -2,3 +2,6 @@
 
 config TRACE_GPU_MEM
 	bool
+
+config TRACE_GPU_FREQUENCY
+	bool
diff --git a/drivers/gpu/trace/Makefile b/drivers/gpu/trace/Makefile
index b70fbdc5847f..2b7ae69327d6 100644
--- a/drivers/gpu/trace/Makefile
+++ b/drivers/gpu/trace/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_TRACE_GPU_MEM) += trace_gpu_mem.o
+obj-$(CONFIG_TRACE_GPU_FREQUENCY) += trace_gpu_frequency.o
diff --git a/drivers/gpu/trace/trace_gpu_frequency.c b/drivers/gpu/trace/trace_gpu_frequency.c
new file mode 100644
index 000000000000..f5af5800b52d
--- /dev/null
+++ b/drivers/gpu/trace/trace_gpu_frequency.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * GPU frequency trace points
+ *
+ * Copyright (C) 2020 Google, Inc.
+ */
+
+#include <linux/module.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/power.h>
+
+EXPORT_TRACEPOINT_SYMBOL(gpu_frequency);
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index af5018aa9517..343825a76953 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -500,6 +500,39 @@ DEFINE_EVENT(dev_pm_qos_request, dev_pm_qos_remove_request,
 
 	TP_ARGS(name, type, new_value)
 );
+
+/**
+ * gpu_frequency - Reports the GPU frequency in GPU clock domains.
+ *
+ * This event should be emitted whenever there's a GPU frequency change happens,
+ * or a GPU goes from idle state to active state, or vice versa.
+ *
+ * When the GPU goes from idle state to active state, this event should report
+ * the GPU frequency of the active state. When the GPU goes from active state to
+ * idle state, this event should report a zero frequency value.
+ *
+ * @frequency:  New frequency (in KHz)
+ * @gpu_id: Id for each GPU clock domain
+ */
+TRACE_EVENT(gpu_frequency,
+
+	TP_PROTO(unsigned int frequency, unsigned int gpu_id),
+
+	TP_ARGS(frequency, gpu_id),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, frequency)
+		__field(unsigned int, gpu_id)
+	),
+
+	TP_fast_assign(
+		__entry->frequency = frequency;
+		__entry->gpu_id = gpu_id;
+	),
+
+	TP_printk("frequency=%u gpu_id=%u",
+		__entry->frequency, __entry->gpu_id)
+);
 #endif /* _TRACE_POWER_H */
 
 /* This part must be outside protection */
-- 
2.28.0.297.g1956fa8f8d-goog

