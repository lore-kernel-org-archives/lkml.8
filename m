Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174FAC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3F9E20771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oaXHw4Oo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506870AbgDPQNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2506832AbgDPQM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:12:57 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14CDC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 09:12:57 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id nk12so3348986pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 09:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0zoCAxwf9k6lfoo3cxV3l2Ts8Ighj8ILmpKvjJbqwvo=;
        b=oaXHw4OoNjSODYtqP+D86dNRDfH9pFvBIgL5AAghUBFYKnrbVWQbiCIYvMoV5G/92q
         eAijVWC8ga1IgT8f2InqqkXDfvnJOHAfEoJR4Tv3ygcBIFNB+3MRslx3FassUAy0Uatd
         KTgMwbBl3RKE4Te0j7hl6uSM+q2hHmXvTAE68O2Qqmw80ejmwBmIa/uQIk0Ea6awb4D/
         kiUfpIC642BpdAmbbEnAoxCTXQxQ62KaUPmVGWnjnutLyFbIJjdlfDx/bJhA/U7yXFFD
         en3fX1+ixzUBoNEWIbC1MibOBSiJdNjGY0/wQFmuEOqMPTQHYahJnCQZvu4lXlhPO+Ut
         3Uiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0zoCAxwf9k6lfoo3cxV3l2Ts8Ighj8ILmpKvjJbqwvo=;
        b=hcm3/VdLGQDfO/oCJ+EZYXbL6LwEAG0PJRUslspWAU7KsEkIAss27cfggX5+EQW3Lk
         dK1lMj1HPVRs3GaqOs90oj7w7IVf0c5ukNpDE7YKC+6VkOvPUKyVGLR5ztjiPZHre2I/
         cleUkc/AJG5HQ+yH31J6d0KktgNs21fB0utOT3gdLE6CuZGtF0fm48eNOCMjY2ANGqOL
         dtMQvA59i2fnnXocF4C5Qk62KKPS1oTK9qOV+5DkBd2f856A9JQcD7QkjWskhRz760Gm
         WkrF7KIRW3niWGktrHxClnRHb2Ecs71fngt6SO5zlbPOME8JJ9k1QIp3TME9bFzypSU3
         483Q==
X-Gm-Message-State: AGi0PuZeyAMPoDoUVz8jBjaay5nCQAZYwXS3MHFfndU3Az/bQBPqOZiK
        tMcQrlLK5Hui84orxrS/bngq8lCG8Z70hn0JT3o=
X-Google-Smtp-Source: APiQypKIig2VehAviH0oXuxl4EJ3M3D8ILlWZ/6oWMjPFzuhTA+6Vu4jAmcNZSFI+UI1yW8xrivvKTZYZblKhvZz34o=
X-Received: by 2002:a63:d049:: with SMTP id s9mr30834027pgi.384.1587053577150;
 Thu, 16 Apr 2020 09:12:57 -0700 (PDT)
Date:   Thu, 16 Apr 2020 09:12:36 -0700
In-Reply-To: <20200416161245.148813-1-samitolvanen@google.com>
Message-Id: <20200416161245.148813-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200416161245.148813-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v11 03/12] scs: add support for stack usage debugging
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
 kernel/scs.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/kernel/scs.c b/kernel/scs.c
index 5245e992c692..ad74d13f2c0f 100644
--- a/kernel/scs.c
+++ b/kernel/scs.c
@@ -184,6 +184,44 @@ int scs_prepare(struct task_struct *tsk, int node)
 	return 0;
 }
 
+#ifdef CONFIG_DEBUG_STACK_USAGE
+static inline unsigned long scs_used(struct task_struct *tsk)
+{
+	unsigned long *p = __scs_base(tsk);
+	unsigned long *end = scs_magic(p);
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
+	static DEFINE_SPINLOCK(lock);
+	static unsigned long highest;
+	unsigned long used = scs_used(tsk);
+
+	if (used <= highest)
+		return;
+
+	spin_lock(&lock);
+
+	if (used > highest) {
+		pr_info("%s (%d): highest shadow stack usage: %lu bytes\n",
+			tsk->comm, task_pid_nr(tsk), used);
+		highest = used;
+	}
+
+	spin_unlock(&lock);
+}
+#else
+static inline void scs_check_usage(struct task_struct *tsk)
+{
+}
+#endif
+
 bool scs_corrupted(struct task_struct *tsk)
 {
 	unsigned long *magic = scs_magic(__scs_base(tsk));
@@ -200,6 +238,7 @@ void scs_release(struct task_struct *tsk)
 		return;
 
 	WARN_ON(scs_corrupted(tsk));
+	scs_check_usage(tsk);
 
 	scs_account(tsk, -1);
 	task_set_scs(tsk, NULL);
-- 
2.26.1.301.g55bc3eb7cb9-goog

