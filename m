Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E25FC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5851F207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u3XCGmVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgIBUBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 16:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbgIBUBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 16:01:37 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA08C06124F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 13:01:35 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w186so966106qkd.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 13:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=5PQwohRRxjQaQChGN57VL8dJoHWO/Os9V4h+vF4YaHg=;
        b=u3XCGmVT0bTToU6qRHpbvhcuB7v5sgvTlUXVAlxzPqBJhV+WDoLFMukHBDIErEaoTu
         7WjgCYwMtRo91InzMmLzi5ZX6FyimBjEOhnCigxDzjq8mrarfmVQ+6aHsWzTxGAsPu4V
         VkHcd8OZv4zPUGREtDMOTnwPd9ZzkFaRD1PnInOAyZoyjf1q7R8XqXgCMTehEfBHd8Ol
         iTohoMysSEOGJZ8/le2mDnuGhJB9JDyi88yhkvEZWm/P5UfY9F7U/Z4UI9vCRdKMRoaL
         5T3A3jlVuDKOGRjUTghdHyWg4LL6Lmc+26bpc95G5i6tzJ0LItOBPcQgtIJZy6sfVWT8
         STIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=5PQwohRRxjQaQChGN57VL8dJoHWO/Os9V4h+vF4YaHg=;
        b=pjtW+ggysgT72pi+vXeM1DWs+yRj5r699JeT2PP4UQEbMV2DAgcNc+c0HQZY/x32TM
         ODeMjJiB/DrYzhOt4ygCc+r1cwlYRiWq2XL1PYyNXuY/pEA9QQTefcbF0GWoTeboK8mn
         GhkATE+i4oQdtZix0QuOHmUqXUwWBnBWqvAY012FLfOB9vx6yFH3+QkhbYzMfKG0pjNx
         KE7GdxDqgFdZtlOLhZNFuKf/Y/9hH8caZy+0EZ+KjjoRqvYJXlTEiiACAla78q/41V6x
         NfK26aw9SXMYsYxIUCZe6L0s8fFXeNusIAG1s4HSmrGmBeeV8NqOfc/T9gw+KKucgcmo
         6AmQ==
X-Gm-Message-State: AOAM532FYhTd0lBgI8QJo0yHbVJwWzEVFUJS6WsF3u+AyCWbdWv2A8Dc
        li3zG3wrs8fS2+h+gemG+Z0=
X-Google-Smtp-Source: ABdhPJxWZKDD/hIcVtnfH6gmE27LuTkJ9+pyAZX9JDWJny0knA4LKTk7W/nXorfWQxVTjHdhyanoFQ==
X-Received: by 2002:a37:5646:: with SMTP id k67mr8603049qkb.476.1599076894997;
        Wed, 02 Sep 2020 13:01:34 -0700 (PDT)
Received: from ubuntu (69-220-158-6.lightspeed.rlghnc.sbcglobal.net. [69.220.158.6])
        by smtp.gmail.com with ESMTPSA id p68sm562541qka.78.2020.09.02.13.01.34
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2020 13:01:34 -0700 (PDT)
From:   Nachammai Karuppiah <nachukannan@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        Nachammai Karuppiah <nachukannan@gmail.com>
Subject: [RFC PATCH 7/7] dt-bindings: ramtrace: Add ramtrace DT node
Date:   Wed,  2 Sep 2020 13:00:22 -0700
Message-Id: <b65b3116d90e7e5969ad6c1509a24e04f39ee4e9.1599072725.git.nachukannan@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1599072725.git.nachukannan@gmail.com>
References: <cover.1599072725.git.nachukannan@gmail.com>
In-Reply-To: <cover.1599072725.git.nachukannan@gmail.com>
References: <cover.1599072725.git.nachukannan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ramtrace as child node of /reserved-memory.

Signed-off-by: Nachammai Karuppiah <nachukannan@gmail.com>
---
 .../devicetree/bindings/reserved-memory/ramtrace.txt        | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/ramtrace.txt

diff --git a/Documentation/devicetree/bindings/reserved-memory/ramtrace.txt b/Documentation/devicetree/bindings/reserved-memory/ramtrace.txt
new file mode 100644
index 0000000..0a8515c
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/ramtrace.txt
@@ -0,0 +1,13 @@
+Ramtrace trace events logger
+============================
+
+ramtrace provides persistent RAM storage for ring buffer in which the trace
+events are recorded, so they can be recovered after a reboot. This is a
+child-node of "/reserved-memory", and is named "ramtrace" after the backend,
+rather than "pstore" which is the subsystem.
+
+Required properties:
+
+- compatible: must be "ramtrace"
+
+- reg: region of memory that is preserved between reboots
-- 
2.7.4

