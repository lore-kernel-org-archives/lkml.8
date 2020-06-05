Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0831BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 13:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D616E2065C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 13:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yYiav+kM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgFENWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 09:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgFENW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 09:22:26 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4F9C08C5C3
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 06:22:24 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r15so9092658wmh.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 06:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xAlKxt3CeRGgnokjPKgwbHDWms7QUL6gxBaF1E7hzHQ=;
        b=yYiav+kMyZ2Ix7WiVK7dI5HnTMjAng05HBGjcV43tWiZ6XDmWimy/6ZQNI7sxlIeF0
         ny/pb2rEHxegQzT78UTHLx57Bavu+D8NPjlonHJRBg6EZ9iiNlX+eQ7e1zjdEgQSejc6
         f20Onq0IJRAlGwXVdIKKG73OrUMooHFJPdDDKhBMmrFbRI7PzSYUnX5X7YwtML9MBhpb
         N6Ue6HDCNLoLE/Pwz9P/J0wj27Hid2yPPeQdp0icf93cf5xbDIpv2D/dhNngYGAyL/sg
         bDY9CaZ+0Fse6H5ZAjs5SGLwks3JyrNKZq5zD9AEb66Zor5YraVenWPJFPis3j/fjPgY
         0C8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xAlKxt3CeRGgnokjPKgwbHDWms7QUL6gxBaF1E7hzHQ=;
        b=n+/hHY3AD9NcqwrMkZ3Pf/iHRrBGdXcsYYbc4/ZDI94S4Xb8mtzl99Y4vqgOIJeOtq
         NafI8nw0+TJh8eRxPY0+qgmJtBN7b2we1dIx7knf73/w6m/hFWSBZHztyDGVdcHJfpvN
         v0yFjZ9Qvq79N+YLUlyKegL90bA3RabkT9GJ2WxuYGMp9CFq3s8XEchBkZD/rH0UFBW4
         7hEN++M5w8izoPacLU3ZyoOR1jNVZvZlAY//yXhnFlUA47GzJ47ej5Soax5bpC3Xxbvf
         RxXo/pUINjQQqP7lrLBkLJEhUDa45r8c6DPtS4ZE/Cs2biBGCJ0N0QeEER5bnx8tB1qj
         ON0g==
X-Gm-Message-State: AOAM533Wh1AZD072inh17tdinRZcI++1kkoOsyE1hcyeM4dxObvCY5nX
        9hdJKwa8MemadyqQCQSFjVS77A==
X-Google-Smtp-Source: ABdhPJyt8YO6c3MFb5eo6VCQfHwV4YCdIkN/j71Gnogub1Z5Ahg9B5DQxJEiYFr2NP7rx7grZEK9JQ==
X-Received: by 2002:a7b:c0cc:: with SMTP id s12mr2780173wmh.111.1591363343349;
        Fri, 05 Jun 2020 06:22:23 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id 1sm11419211wmz.13.2020.06.05.06.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 06:22:22 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, sumit.garg@linaro.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com, will@kernel.org,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [RFC PATCH 1/4] kgdb: Honour the kprobe blacklist when setting breakpoints
Date:   Fri,  5 Jun 2020 14:21:27 +0100
Message-Id: <20200605132130.1411255-2-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200605132130.1411255-1-daniel.thompson@linaro.org>
References: <20200605132130.1411255-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently kgdb has absolutely no safety rails in place to discourage or
prevent a user from placing a breakpoint in dangerous places such as
the debugger's own trap entry/exit and other places where it is not safe
to take synchronous traps.

Modify the default implementation of kgdb_validate_break_address() so
that we honour the kprobe blacklist (if there is one). The resulting
blacklist will include code that kgdb could, in fact, debug but I think
we can assume that anyone with sufficient knowledge to meaningfully
debug that code would trivially be able to find and remove the safety
rail if they need to.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/debug_core.c | 11 +++++++++++
 kernel/debug/kdb/kdb_bp.c |  9 +++++++++
 2 files changed, 20 insertions(+)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index ef94e906f05a..81f56d616e04 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -56,6 +56,7 @@
 #include <linux/vmacache.h>
 #include <linux/rcupdate.h>
 #include <linux/irq.h>
+#include <linux/kprobes.h>
 
 #include <asm/cacheflush.h>
 #include <asm/byteorder.h>
@@ -188,6 +189,16 @@ int __weak kgdb_validate_break_address(unsigned long addr)
 {
 	struct kgdb_bkpt tmp;
 	int err;
+
+	/*
+	 * Disallow breakpoints that are marked as unsuitable for kprobing.
+	 * This check is a little over-zealous because it does include
+	 * code that kgdb is entirely capable of debugging but in exchange
+	 * we can avoid recursive trapping (and all the problems that brings).
+	 */
+	if (within_kprobe_blacklist(addr))
+		return -EINVAL;
+
 	/* Validate setting the breakpoint and then removing it.  If the
 	 * remove fails, the kernel needs to emit a bad message because we
 	 * are deep trouble not being able to put things back the way we
diff --git a/kernel/debug/kdb/kdb_bp.c b/kernel/debug/kdb/kdb_bp.c
index d7ebb2c79cb8..ec4940146612 100644
--- a/kernel/debug/kdb/kdb_bp.c
+++ b/kernel/debug/kdb/kdb_bp.c
@@ -306,6 +306,15 @@ static int kdb_bp(int argc, const char **argv)
 	if (!template.bp_addr)
 		return KDB_BADINT;
 
+	/*
+	 * This check is redundant (since the breakpoint machinery should
+	 * be doing the same check during kdb_bp_install) but gives the
+	 * user immediate feedback.
+	 */
+	diag = kgdb_validate_break_address(template.bp_addr);
+	if (diag)
+		return diag;
+
 	/*
 	 * Find an empty bp structure to allocate
 	 */
-- 
2.25.4

