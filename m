Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253DDC5519A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 043E1206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LKPo6Bc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgD0QAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728517AbgD0QAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:00:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841AEC0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:00:34 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j14so20899138ybt.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kikYfFSTfca/HkjJiT4VwZFMKgohIqKorfyIql1wDNc=;
        b=LKPo6Bc/Q5MtQzUK3oQa6NKadNaC15z3lO/zjdaounxLr3Yr/P6IlUdUGblL+xU5k4
         spAtU8NF5ubk32gUq0m5VXjp6kv3GAFhZ4b47WHO1jV9Re1P0wgxqNnIy78PYlqK6iHg
         Lz7JdX7MXdIx+DHcDceIZRSq68+3ppbTa32fDBBMVQUsXCdSeZ2Rk0+iayOXLcIpH0mh
         1y8jfaqoFffOSgqi3glfbRygtn76YwRgqeTcaTsWT5Ma8vEPSbQu5Sf1lQXSpiWIQ5jH
         osRX2DeCrw1RtV2JiczAkw6ANMNeNCpzDPw4w/B5fxj55cgpesof+s+eghyxXIYIpJqz
         Cp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kikYfFSTfca/HkjJiT4VwZFMKgohIqKorfyIql1wDNc=;
        b=gbzteNDEEiJ2C2oosz4Y0fKUOO27RWPGhp7CBNZJ8/u93GFsNpSG7Ft09TO3I+5w7q
         n9oltMGyg+mot4ex1gQoaFULSuBSW0VNMNyWnBuJBknZoMRLzux9qQhyl61Clrp8THqV
         DPRQRgmYXRDK5oeUSg9xGoiOnmVjfZS19xA8Dam2XTNFITxjSt7fLxjGwFDK96+XmbqV
         mecQipRnW8GRqngw60Bx21AHBzo2WIjwEagEYDss3MTmHd4OzL7DxcbogFFcep6kt2AY
         044Cc31vwrGsL4u/B6ZUewcy6vnEKgTOVhW5LA0OFQz7lHkC/RS3zBv9lsWd44Nie+Wq
         e8SA==
X-Gm-Message-State: AGi0PubYv4piYN69PZDtIXqXe6zOcP8ADnBEH1+2Rh6zcDyGaTbSc2HL
        5IWT/Coqh2ZoRCykGxhOtoSS3wDFOe8fBszT9ug=
X-Google-Smtp-Source: APiQypIgO4clcO6Z7kvhUaBuvYACtL+F9hDoKmeBmaTp5Edf0BzJT+qKnh+MwC69KhaGLcQ8wc5C0JEBbMo44i2AOQM=
X-Received: by 2002:a25:ddc3:: with SMTP id u186mr36888616ybg.383.1588003232559;
 Mon, 27 Apr 2020 09:00:32 -0700 (PDT)
Date:   Mon, 27 Apr 2020 09:00:09 -0700
In-Reply-To: <20200427160018.243569-1-samitolvanen@google.com>
Message-Id: <20200427160018.243569-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200427160018.243569-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v13 03/12] scs: add support for stack usage debugging
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implements CONFIG_DEBUG_STACK_USAGE for shadow stacks. When enabled,
also prints out the highest shadow stack usage per process.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Will Deacon <will@kernel.org>
---
 kernel/scs.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/kernel/scs.c b/kernel/scs.c
index 8769016c714c..2a96573f2b1b 100644
--- a/kernel/scs.c
+++ b/kernel/scs.c
@@ -68,6 +68,43 @@ int scs_prepare(struct task_struct *tsk, int node)
 	return 0;
 }
 
+#ifdef CONFIG_DEBUG_STACK_USAGE
+static unsigned long __scs_used(struct task_struct *tsk)
+{
+	unsigned long *p = task_scs(tsk);
+	unsigned long *end = __scs_magic(p);
+	unsigned long s = (unsigned long)p;
+
+	while (p < end && READ_ONCE_NOCHECK(*p))
+		p++;
+
+	return (unsigned long)p - s;
+}
+
+static void scs_check_usage(struct task_struct *tsk)
+{
+	static unsigned long highest;
+	unsigned long used = __scs_used(tsk);
+	unsigned long prev;
+	unsigned long curr = highest;
+
+	while (used > curr) {
+		prev = cmpxchg_relaxed(&highest, curr, used);
+
+		if (prev == curr) {
+			pr_info("%s (%d): highest shadow stack usage: "
+				"%lu bytes\n",
+				tsk->comm, task_pid_nr(tsk), used);
+			break;
+		}
+
+		curr = prev;
+	}
+}
+#else
+static inline void scs_check_usage(struct task_struct *tsk) {}
+#endif
+
 void scs_release(struct task_struct *tsk)
 {
 	void *s;
@@ -77,6 +114,7 @@ void scs_release(struct task_struct *tsk)
 		return;
 
 	WARN_ON(scs_corrupted(tsk));
+	scs_check_usage(tsk);
 
 	scs_account(tsk, -1);
 	scs_free(s);
-- 
2.26.2.303.gf8c07b1a785-goog

