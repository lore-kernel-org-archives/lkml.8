Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C891EC38A2A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 21:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8A192075A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 21:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Txy06LIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbgEFVPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 17:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729916AbgEFVPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 17:15:36 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D65C061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 14:15:36 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x2so1758632pfx.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 14:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TpLLG3pWKEaOPKHac5Nkwz9KtMblvoPDFiZ/SitIX00=;
        b=Txy06LIk/ydKHtmNLAtvcMT48XfUpahkLBKCHntkIXGcYuuitksn6Ujhgb0yRJXnrE
         028IK5cQeQd3o5b9yievHYq1s04heCzgGC56pigiaNf9pjyFzwe+T497rhY5w823fpkV
         M99c7WWZZZten6T8yf8iEf0eyLGS/aZGltqBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TpLLG3pWKEaOPKHac5Nkwz9KtMblvoPDFiZ/SitIX00=;
        b=npa7aimo9R7OpRPU9jnSJBiu4g0faZ2r2+Ca3lGbm6L4VYNaj8iS/PfSs/PEZORXa5
         kNLxMZeHWIVIJ58EF5b3iAXpZ+ahgca5qllWSO0/KV0WnFfz/YW3MmhlFqVe7A9X/nKp
         Ca/zU0FacBrHts7JOpAO6R0euzgrV+BwYHSxZGtBzLy5QT6zlF18Q0loYmGsTn4oKQ/4
         hvyK62+Q0CC5nng4j1G9bEmntYm3QKHNqB2kzVr+oKxp5M/mneI+J6A//vDQDBdpVARv
         t3613dvALW9aXrREbuQ8oz64GI6ktlAvVJPpT1o3nzd9iTwy/EZVSpIzn/Tpo5QFeK0T
         bMWg==
X-Gm-Message-State: AGi0PuZqRbekXNkkj0NXaFYT2Kn1GHHSwDUuBFxXmw5lxgim4k6LiQ5L
        tj4hjMLmpd7sg1ABzLcPW/JgNw==
X-Google-Smtp-Source: APiQypK8UdDkIoIIO+IC1Ly/YfpTzLO1dFuZ9+vKGj8L8fRa2h/L7QWdnMlATD9BYmUl6aJoPv9b3w==
X-Received: by 2002:a63:150:: with SMTP id 77mr8334289pgb.136.1588799735729;
        Wed, 06 May 2020 14:15:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s22sm2721551pfd.51.2020.05.06.14.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 14:15:33 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, jmorris@namei.org,
        sashal@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 5/6] ramoops: Add max_reason optional field to ramoops DT node
Date:   Wed,  6 May 2020 14:15:22 -0700
Message-Id: <20200506211523.15077-6-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506211523.15077-1-keescook@chromium.org>
References: <20200506211523.15077-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Tatashin <pasha.tatashin@soleen.com>

Currently, it is possible to dump kmsges for panic, or oops.
With max_reason it is possible to dump messages for other
kmesg_dump events, for example reboot, halt, shutdown, kexec.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Link: https://lore.kernel.org/r/20200505154510.93506-6-pasha.tatashin@soleen.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../devicetree/bindings/reserved-memory/ramoops.txt | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/reserved-memory/ramoops.txt b/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
index 0eba562fe5c6..b7886fea368c 100644
--- a/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
+++ b/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
@@ -30,7 +30,7 @@ Optional properties:
 - ecc-size: enables ECC support and specifies ECC buffer size in bytes
   (defaults to 0: no ECC)
 
-- record-size: maximum size in bytes of each dump done on oops/panic
+- record-size: maximum size in bytes of each kmsg dump.
   (defaults to 0: disabled)
 
 - console-size: size in bytes of log buffer reserved for kernel messages
@@ -45,7 +45,16 @@ Optional properties:
 - unbuffered: if present, use unbuffered mappings to map the reserved region
   (defaults to buffered mappings)
 
-- no-dump-oops: if present, only dump panics (defaults to panics and oops)
+- max-reason: if present, sets maximum type of kmsg dump reasons to store
+  (defaults to 2: log Oopses and Panics). This can be set to INT_MAX to
+  store all kmsg dumps. See include/linux/kmsg_dump.h KMSG_DUMP_* for other
+  kmsg dump reason values. Setting this to 0 (KMSG_DUMP_UNDEF), means the
+  reason filtering will be controlled by the printk.always_kmsg_dump boot
+  param: if unset, it will be KMSG_DUMP_OOPS, otherwise KMSG_DUMP_MAX.
+
+- no-dump-oops: deprecated, use max_reason instead. If present, and
+  max_reason is not specified, it is equivalent to max_reason = 1
+  (KMSG_DUMP_PANIC).
 
 - flags: if present, pass ramoops behavioral flags (defaults to 0,
   see include/linux/pstore_ram.h RAMOOPS_FLAG_* for flag values).
-- 
2.20.1

