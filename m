Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E551C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 136E2207DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tFAsnU+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbgFDO4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 10:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbgFDO4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 10:56:49 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249C5C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 07:56:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a188so1740745ybg.20
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 07:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8zjrUygx4E8TnS8rYes620O5p8GaLeCkMw8lBo+Hhy8=;
        b=tFAsnU+f6zmpQj5uCOo2tgoFCj1cKGOkHDfZCougB7BkXJlUMDu6o6kXOIuUyAgFwt
         eCcvBREPGyzbeN5z9ZoXM9lKz16S6X1JoYeDuNwxt24M0npepVobQzMXtnjlMsxUOLav
         tDJTKwQA0kz6hh0HgAGOTWjpzOFCXjaY0tVfEoLaFEOBfLSrkVIJPlJiBDn7wuOPcKxR
         7mk+WPHVHp0RY9qlFYk4vaT5K02+JTwrkp5nLl8az3UdtM5NmXxrKCkozc+665ZGCiUq
         BnqrzZL6BGCk3GrxBzPDFgXgNsf6XpPmOdFXwgcByDMC2KcbRF5KpLZ0OW056g7u+m8s
         iw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8zjrUygx4E8TnS8rYes620O5p8GaLeCkMw8lBo+Hhy8=;
        b=ln0uXNOPQSq5aFJEsgoZEFahuVO0YbaWR8RTh5YXhLZz4zC+25u4herroxU/tH9gC6
         9dbcRdrypYmhy7XTUUn5FHDSo6WK8BTAZ0t+KrDVVfLX+/Aq5tAZRBlBEeKoNumwFhKz
         qBWLsAfTEvtqKPxtYzoxBcWwL1rh6+X5bxzgQnaHHXq9W1SK5YDBmrJ9fs3WcDzrU7lx
         1A5wc8r/XpnXTi4fzmxxoaffGAgpjFSbgEr7ZaCW6y663WkVxfQKJYzslO3LKxcl+1FW
         Qjf3k8IOry/3WRh/bglai/NPwTvw9oLGkUKXvsGsFjBkIElV9mgkDg0yUI90oignWlCE
         15ng==
X-Gm-Message-State: AOAM5305x1kClgprLRnlY3WzTpMBd8cNotcf8AXIcuWh1X1h9KeiD5Y5
        FAhN4yCm6OaPc6+ohrxLNBmNNbRq3w==
X-Google-Smtp-Source: ABdhPJwJjDn8P81owhHhwSX0cSGD7FNerNcC0uJMx1RQwTHkQynRrffPGQM9PdEtQmNjBOrHbJ4dB+87+w==
X-Received: by 2002:a25:6f44:: with SMTP id k65mr9347038ybc.101.1591282608295;
 Thu, 04 Jun 2020 07:56:48 -0700 (PDT)
Date:   Thu,  4 Jun 2020 16:56:35 +0200
In-Reply-To: <20200604145635.21565-1-elver@google.com>
Message-Id: <20200604145635.21565-2-elver@google.com>
Mime-Version: 1.0
References: <20200604145635.21565-1-elver@google.com>
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: [PATCH v2 2/2] kcov: Pass -fno-stack-protector with Clang
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     peterz@infradead.org, bp@alien8.de, tglx@linutronix.de,
        mingo@kernel.org, clang-built-linux@googlegroups.com,
        paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For Clang, correctly pass -fno-stack-protector via a separate cc-option,
as -fno-conserve-stack does not exist with Clang.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/Makefile b/kernel/Makefile
index ce8716a04d0e..82153c47d2a6 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -35,7 +35,7 @@ KCOV_INSTRUMENT_stacktrace.o := n
 KCOV_INSTRUMENT_kcov.o := n
 KASAN_SANITIZE_kcov.o := n
 KCSAN_SANITIZE_kcov.o := n
-CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
+CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack) $(call cc-option, -fno-stack-protector)
 
 # cond_syscall is currently not LTO compatible
 CFLAGS_sys_ni.o = $(DISABLE_LTO)
-- 
2.27.0.rc2.251.g90737beb825-goog

