Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2607CC35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CD22176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EyPcT46l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbgBYRj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:39:57 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:41514 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730704AbgBYRjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:39:55 -0500
Received: by mail-qt1-f201.google.com with SMTP id z25so263245qto.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 09:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0f/RzoyEatytyatThC+F3eOfN2v+QCCQ4NfkPjtyieo=;
        b=EyPcT46lQh9aSHtmCQLytlqbk6ZyOPPLjYX5wx5scKW+7DdNTGkOrtr8WuC5C5A+kK
         M2BFBAAJx6JVs3WDRKsHQLLRO9BpOo3t8S+EeXvYD98qVLGaIk4n8lhxVg48BDxFZjs5
         Nc6k34FDhn5xt3oOYDagP97Jkr+plBtRe7++kD55djqzKodwN+PGU4IxKwvZGNmFBXDd
         8QcN5Mdz8zndha20IVl5BB1PTfJZ9LIAOFGvbOHNSUOX3dDBBKVjDDteDI9+2tlyB8v+
         Ocw5Df3CWfNU1rJlsPH4eLU/NoQ8/uHEpJR3GieaNAhgxd6/Vv7NFoxf5lF0teYb4qv/
         fWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0f/RzoyEatytyatThC+F3eOfN2v+QCCQ4NfkPjtyieo=;
        b=NYNbNnHpWfB0w1tySigTC3wkoU2TDVFeUTh4CgnYUkDbxM0HM+YBoxYDL6Q1OOdVrd
         LGoV3h8D8Zzo4yMN4MfHA1oQPOuRZ8CLLG6HpDXNOVD83WkGSl6weyK7wPTOLo/4NWbB
         wv4Uxejwnqcjdy6w/8QI89j7f2c1VKlZEiekjBIEIdkh3Q/OXZEfnVE8oxEyeOj5yOvK
         8UuJZyyodZfTUxQeGsMxTSMTrx4HgNRBJuNTo69CrGeLzrienmkMt2GLiH5ZNu++b/q+
         S+gFZVwMJZjZm0ORgfjNd6Se5hog1paOatwVuIq+I4l7TTlaxoj1H98wvJYAxPVS8Cl+
         8zmQ==
X-Gm-Message-State: APjAAAXTauzEqHcwW4lXqYEgonRmLtFbTQVF17k81OL4XnB18rMDzvh6
        T1ukLgZZt+Z8OCu5UErDeWtVUn23LE0LZan/2J8=
X-Google-Smtp-Source: APXvYqx4xojoNdX1jmjAi/7s33/U+0mXVBajNtGJvXPQGE5mjpgdpP3ETPZQPfufHi2tnyRoYGFEBUq0dG+s+BS43pM=
X-Received: by 2002:a05:6214:1874:: with SMTP id eh20mr53245231qvb.122.1582652393129;
 Tue, 25 Feb 2020 09:39:53 -0800 (PST)
Date:   Tue, 25 Feb 2020 09:39:24 -0800
In-Reply-To: <20200225173933.74818-1-samitolvanen@google.com>
Message-Id: <20200225173933.74818-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200225173933.74818-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v9 03/12] scs: add support for stack usage debugging
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
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
2.25.0.265.gbab2e86ba0-goog

