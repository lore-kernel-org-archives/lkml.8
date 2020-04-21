Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7394CC54FCB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 02:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D16022202
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 02:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NsWMsy0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgDUCPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 22:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726751AbgDUCPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 22:15:05 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA1DC061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 19:15:05 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id 18so11801121pfu.22
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 19:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xI7CPVWDT3QMUi6LNO2ihZsKVC6mOuE8D9NTHDoSwRg=;
        b=NsWMsy0tc64m0JGczaV7LdhsLlL0muqBD3WWfrrfmgnLPP65xuxkorBExS9/txu1L5
         Q2FJmS/0GsmmQwHFFjgD0hHMN3SkL6X6n/bRzCTBpT4oi51norYdtt3JUCFXVOjTMdTU
         zX8qkKvs2OaLrSgua66YBsJS5dPG7c4gwq9VOIKkM0/eRtYaRNYKG9cyZ+LyS4DClEmY
         pzaQabeig0ncHcCbBfaRPkwq2fH/qcg3/pcn9c8yO0GtAogCHIQRoSTaV4t4e26dPKt2
         J+40ix1dhL7f8bY+j+WCwuKnG8V6/Z8OrBwNRE8fUqsNlBYUL0T0J2gmXjjCrX5qDTjh
         JDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xI7CPVWDT3QMUi6LNO2ihZsKVC6mOuE8D9NTHDoSwRg=;
        b=QFMpMRCDpxWFQ/n/3yDn8aKSC0VGdGGxVlH5OBaMZDk2NHkNoz2afDsG5Waz9txDmo
         2c2CdQS9wwPbmlsdO1ggJ32Nx4fUVne09jSvgpMfnlbVDNTOrMOIilX0/5bfw6DRDM/a
         B9orDyLHonk11y/FbOKGcoaRKAgB2v9o8EiJY7qCHzN9gs//9DL2Kf+O27vnvhGfsvjf
         laNsVW7LTM8MYNwtIPI+UmCsKYc/I+PKlh+mzzmpn/wD290zH1s/ZUppKmXe1rK8Xud9
         /pNZZ8b3kGck1KUr4kUWTeUhtv4soo5GZPI8i6Qf8hA47HAjakwLqHiLUiHdI1vZO8Dj
         YjFg==
X-Gm-Message-State: AGi0PuYtGrn4OVNx+GfnQ3f+4IRMsti3cvY2D08HMBaRLrHWSUL9uw0g
        e5b+a6kVWHhx4UOhGy8gRr7w1AXXgxToyd3YOF0=
X-Google-Smtp-Source: APiQypJjnJg3+R91MxtHFmJsG6lvv1/O5kXjFyDygKT9qrQWp/wDoIt6jjVQ8Gq3+RwTYIGrFi4A9oqrPtVBx7q8Lmw=
X-Received: by 2002:a17:90a:1f4b:: with SMTP id y11mr2841747pjy.136.1587435304444;
 Mon, 20 Apr 2020 19:15:04 -0700 (PDT)
Date:   Mon, 20 Apr 2020 19:14:44 -0700
In-Reply-To: <20200421021453.198187-1-samitolvanen@google.com>
Message-Id: <20200421021453.198187-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200421021453.198187-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v12 03/12] scs: add support for stack usage debugging
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
---
 kernel/scs.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/kernel/scs.c b/kernel/scs.c
index 7eea2d97bd2d..147917e31adf 100644
--- a/kernel/scs.c
+++ b/kernel/scs.c
@@ -68,6 +68,43 @@ int scs_prepare(struct task_struct *tsk, int node)
 	return 0;
 }
 
+#ifdef CONFIG_DEBUG_STACK_USAGE
+static unsigned long __scs_used(struct task_struct *tsk)
+{
+	unsigned long *p = __scs_base(tsk);
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
+		prev = cmpxchg(&highest, curr, used);
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
2.26.1.301.g55bc3eb7cb9-goog

