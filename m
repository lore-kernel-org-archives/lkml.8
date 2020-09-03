Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38323C2D0E0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18DC42071B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="b5tk49KK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbgICUcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729273AbgICUbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:31:20 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19687C06124F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 13:31:08 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id ff20so2520262qvb.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 13:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=wK1JwNZBEF40N5fcic2drFAc7pvy5JBQESDnmBr5608=;
        b=b5tk49KKD8j0uO3HReOPELDX6rYUucGnG4IzHyDxn6fDckayxGEUatWRFd27ufwbN3
         LjHaKo6hawTTCLkFq/jB8M9122OZSHcLgzaa1kZ5TFxETy4pPx2LsDP8oo9eOYjDXBz7
         gNpyQkQIvkYvnL5+EjfoeJN95WFjivWmiIbSp2qvJ03cyGsJSq1lYlWvaFOZhIdNaq+5
         j6+vcEESIOZXWOu6Is/sHhbycCztGA5Mt6Pgiu+Wg6bUXf3c+poWdfZZ6+6srlaCIaFO
         pcBRWSF8ZbXrir1GVg/PkMsK2/dchsv3U7ph0bwwq2vz87O6fqdiQ1ehoBzkWoRkVWQL
         mL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wK1JwNZBEF40N5fcic2drFAc7pvy5JBQESDnmBr5608=;
        b=W+YR5SN/Ic3DwTSj7CqqO9AwKp4Ule0y36gNbjd9W5j1CPek69cMFySz4l+otAmKmy
         9HPi8MvnyWXUnCpB399A1yWVGJmvGTME9TFJtiiLAl03CKPjx14IoF9GkxVp9cLjETUS
         fYaTXSDGkgQeFhxAQZx1T3j3XU/EfqS1B7sbhQjOkRXQA1QLvjknvuqNF6hi/SjHkrun
         +zkfe5oR+tZrj338l7Wdck8GmSUtdovTe4raLAptzZN4omXzSLdWdJOrHJi2LkVLiUL6
         t4s5HujqqJdlUwZVsMQ8LZEt/4gTtwtds7S2AEeGDoOK3QpjnsGTiRpG4+Flkk2+lt5D
         OoYg==
X-Gm-Message-State: AOAM532Rk+Qnxsw9gOkpJENKCvPw7rjZVeIPx2GIh5vq3Aa/FPQizu0F
        CcmsiXOfxum9z9y0NiSygRX9OT+XAJjCaBCiYSA=
X-Google-Smtp-Source: ABdhPJz4POZjDvj1G4FCKsXnFupG7AWZGi6zga2my5XWqYNc1MAqG6z13ElXHTlIUNSUYKf3wk2VH6yuqmwJK87vTpw=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a0c:f982:: with SMTP id
 t2mr3575617qvn.5.1599165067207; Thu, 03 Sep 2020 13:31:07 -0700 (PDT)
Date:   Thu,  3 Sep 2020 13:30:31 -0700
In-Reply-To: <20200903203053.3411268-1-samitolvanen@google.com>
Message-Id: <20200903203053.3411268-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200903203053.3411268-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 06/28] objtool: Don't autodetect vmlinux.o
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With LTO, we run objtool on vmlinux.o, but don't want noinstr
validation. This change requires --vmlinux to be passed to objtool
explicitly.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 scripts/link-vmlinux.sh       |  2 +-
 tools/objtool/builtin-check.c | 10 +---------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index e6e2d9e5ff48..372c3719f94c 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -64,7 +64,7 @@ objtool_link()
 	local objtoolopt;
 
 	if [ -n "${CONFIG_VMLINUX_VALIDATION}" ]; then
-		objtoolopt="check"
+		objtoolopt="check --vmlinux"
 		if [ -z "${CONFIG_FRAME_POINTER}" ]; then
 			objtoolopt="${objtoolopt} --no-fp"
 		fi
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 71595cf4946d..eaa06eb18690 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -41,18 +41,10 @@ const struct option check_options[] = {
 
 int cmd_check(int argc, const char **argv)
 {
-	const char *objname, *s;
-
 	argc = parse_options(argc, argv, check_options, check_usage, 0);
 
 	if (argc != 1)
 		usage_with_options(check_usage, check_options);
 
-	objname = argv[0];
-
-	s = strstr(objname, "vmlinux.o");
-	if (s && !s[9])
-		vmlinux = true;
-
-	return check(objname, false);
+	return check(argv[0], false);
 }
-- 
2.28.0.402.g5ffc5be6b7-goog

