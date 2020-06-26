Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6552C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F6D4207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V1+QvbzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgFZUe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgFZUe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 16:34:28 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FEDC03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:34:28 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id b92so5395195pjc.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=BIox9/QXM98eZxjkWVOWgYUVhYwZS0Exqz5rkKqCo9o=;
        b=V1+QvbzD6RsSp7YX1TrReV0/M3cz6EXYAUBl9ZOtIvRJKuAnG+NemgbbMbRcIJL7l3
         Aux+V79eMCvM8uN98nIn66sTit5+PMbxgUuaT+E4kSaB7BbuvrN5JAtcHguv8uzZOWf6
         RwJzz4vexyIEDaM2DLCiCAU/c0yawzxUWw9lU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=BIox9/QXM98eZxjkWVOWgYUVhYwZS0Exqz5rkKqCo9o=;
        b=Ftf0xZb7U3VN+2lNCZYNtxyP+ad1m1D/k6eAAyviGzEjYI3SqWRFGjFxUzKHKjzCcD
         /d/FMzj65n74Nb17+LY/Ol0ntJOyNRr6JqlhVaOI1QIIU3OiC2FplBwluQUtR09aq6UY
         jxjE7++laW60Jfu8k/bkT+xOHR3AqJhgQcGd2vXWYqWmNo2GVam0czR1f8JF85l+6GV6
         7HK2dUL5cd5dcx0AfxOnmUtvvnNwJbb3409lZGJPOdU38jFV9eatfGnebgNHJSbQAiT3
         sJ5n15f6b790qBubdpDa9WGgdEufkzuKvlldcPlN7xT99zXzNzTCvG3sXZx8ll15J4oJ
         6v6w==
X-Gm-Message-State: AOAM533SDboGzOzZnuBWq5VAQkJwWmeuERgoqL4lw47VP7hkKrrb8+Mi
        2cSIhDqjHQcbkWYHTTM4ENQ6NQs+xqk=
X-Google-Smtp-Source: ABdhPJxOGRtzLC8iSOTv73ksZgqpMB2QfKhEIDFraskWuwRPaqcPMcajZ1bUrXxTo3KsPhsmEU5K4w==
X-Received: by 2002:a17:902:aa92:: with SMTP id d18mr4092904plr.210.1593203667481;
        Fri, 26 Jun 2020 13:34:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i3sm23649403pgj.52.2020.06.26.13.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 13:34:26 -0700 (PDT)
Date:   Fri, 26 Jun 2020 13:34:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/asm/entry: Actually disable stack protector
Message-ID: <202006261333.585319CA6B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some builds of GCC enable stack protector by default. Simply removing
the arguments is not sufficient to disable stack protector, as the stack
protector for those GCC builds must be explicitly disabled. Remove the
argument removals and add -fno-stack-protector. Additionally include
missed x32 argument updates, and adjust whitespace for readability.

Fixes: 20355e5f73a7 ("x86/entry: Exclude low level entry code from sanitizing")
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
RESEND (missed lkml)...
---
 arch/x86/entry/Makefile | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index b7a5790d8d63..08bf95dbc911 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -7,12 +7,20 @@ KASAN_SANITIZE := n
 UBSAN_SANITIZE := n
 KCOV_INSTRUMENT := n
 
-CFLAGS_REMOVE_common.o = $(CC_FLAGS_FTRACE) -fstack-protector -fstack-protector-strong
-CFLAGS_REMOVE_syscall_32.o = $(CC_FLAGS_FTRACE) -fstack-protector -fstack-protector-strong
-CFLAGS_REMOVE_syscall_64.o = $(CC_FLAGS_FTRACE) -fstack-protector -fstack-protector-strong
+CFLAGS_REMOVE_common.o		= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_syscall_64.o	= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_syscall_32.o	= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_syscall_x32.o	= $(CC_FLAGS_FTRACE)
+
+CFLAGS_common.o			+= -fno-stack-protector
+CFLAGS_syscall_64.o		+= -fno-stack-protector
+CFLAGS_syscall_32.o		+= -fno-stack-protector
+CFLAGS_syscall_x32.o		+= -fno-stack-protector
 
 CFLAGS_syscall_64.o		+= $(call cc-option,-Wno-override-init,)
 CFLAGS_syscall_32.o		+= $(call cc-option,-Wno-override-init,)
+CFLAGS_syscall_x32.o		+= $(call cc-option,-Wno-override-init,)
+
 obj-y				:= entry_$(BITS).o thunk_$(BITS).o syscall_$(BITS).o
 obj-y				+= common.o
 
-- 
2.25.1


-- 
Kees Cook
