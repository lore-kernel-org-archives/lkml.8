Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E2CC433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 06:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34D1220BED
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 06:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eHez7mRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgGEGMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 02:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgGEGMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 02:12:40 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33503C08C5DE
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 23:12:40 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id cm21so6129331pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 23:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fPweZ6DZU1ENxuozio/NA02HLt4qwCgCF26PVdwgmUw=;
        b=eHez7mRezl3LRANbjE9V3fYHuiKTipMbrZxyLSQ8DYa+CsUnkd7R93uYjLh8qhclBF
         astTE3wzBXb6w0ko4CNb3iCWSSyKMABzRVflBHuKZATMtETPiDqIYxCGlugWhQxJnQAe
         tcWFVOjHZeqkFFnKprhnoBDKbp1h+KP0S01jU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fPweZ6DZU1ENxuozio/NA02HLt4qwCgCF26PVdwgmUw=;
        b=Cphm9w0uk/x5zKlfc6/6SG3BQG/0RY8SfU/uCyWF3yvBoJSym5dQNlOr8I/SWg/udJ
         K27inkHf2vxYE3BBoufjd6nPlgvxy0zz0IIGsXNEB0qK348agUGQ9kj9x75SaZ4oGbG1
         avDHnAkf/w4yL1RLT8orENkqsu284aMr6ONIHdCsfZXeFVk3VLlx7+Lj4fHbosOh4QCO
         b9i5z1dhFH/ZBjq+i9BjjftkcjOrB1Iop2C67ToJZCRASet8CrAOAstSU91DaX/gND0A
         C4+nzb4vON1DQzxt/a3AWdJ0A/xqIfyLKfgzdDLxtrqP8QAcSBQss2ZhN0QvXOpFtHuQ
         1dxA==
X-Gm-Message-State: AOAM5331VntEMLCgK6EMou8qDvhkHdAsDz5I62A4ipPnW3IEjYGSmfSs
        NKZHe7AuzwBI1x0SxgLam5gHnw==
X-Google-Smtp-Source: ABdhPJz3fz9uNnH3pm1N5xpLDXk919zAKiGqawBuegK156HeIrG5riLllTgK7fEcIVuXZxaN1UTCSw==
X-Received: by 2002:a17:90a:c5:: with SMTP id v5mr46527588pjd.192.1593929559801;
        Sat, 04 Jul 2020 23:12:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n62sm5275663pjb.28.2020.07.04.23.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 23:12:37 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Oleg Nesterov <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] selftests/seccomp: Check ENOSYS under tracing
Date:   Sat,  4 Jul 2020 23:12:32 -0700
Message-Id: <20200705061232.4151319-4-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200705061232.4151319-1-keescook@chromium.org>
References: <20200705061232.4151319-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There should be no difference between -1 and other negative syscalls
while tracing.

Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: Will Deacon <will@kernel.org>
Cc: Keno Fischer <keno@juliacomputing.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 966dec340ea8..bf6aa06c435c 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1973,6 +1973,32 @@ FIXTURE_TEARDOWN(TRACE_syscall)
 	teardown_trace_fixture(_metadata, self->tracer);
 }
 
+TEST(negative_ENOSYS)
+{
+	/* Untraced negative syscalls should return ENOSYS. */
+	errno = 0;
+	EXPECT_EQ(-1, syscall(-1));
+	EXPECT_EQ(errno, ENOSYS);
+	errno = 0;
+	EXPECT_EQ(-1, syscall(-101));
+	EXPECT_EQ(errno, ENOSYS);
+}
+
+TEST_F(TRACE_syscall, negative_ENOSYS)
+{
+	/*
+	 * There should be no difference between an "internal" skip
+	 * and userspace asking for syscall "-1".
+	 */
+	errno = 0;
+	EXPECT_EQ(-1, syscall(-1));
+	EXPECT_EQ(errno, ENOSYS);
+	/* And no difference for "still not valid but not -1". */
+	errno = 0;
+	EXPECT_EQ(-1, syscall(-101));
+	EXPECT_EQ(errno, ENOSYS);
+}
+
 TEST_F(TRACE_syscall, syscall_allowed)
 {
 	/* getppid works as expected (no changes). */
-- 
2.25.1

