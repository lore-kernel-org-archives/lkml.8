Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B55C31E49
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F9520658
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="WYxR9JOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbgICUek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728850AbgICUdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:33:08 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4E0C061258
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 13:31:48 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id l6so2488410pgm.15
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 13:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=cZOWhnp892SUnLhqC+1TPlOe8BVqsfDWwTFGwwryYEw=;
        b=WYxR9JOXeqHMLp90nNI8/6ltDzhvsuYjv6d1zFqp8zsjL+qJYufybBNzAbPMTkNNZl
         D7MpSi0LlP6FuYPjz4u35DCi8t432jxAgU18y16gIeH1WYnR8Oge5r65aJHFkr+O6ap5
         7Jb4/kJwsklpayP8Ru/q1xJFOJRx54JFuZjQSOGJapmUtPdOP08d8KZWkeRlM2D1Swzv
         SnITw4E+gwFNoLz9DvBEQEulPAjlW7Re+DfF/dU1eZIdgljsqQSczq8cMfTFPUsSyciF
         mvuZnj+9HqmA+LFzkWAsNTdETxPd/fZaNFdn6zEOPF2B4+IaWN0xMyzjF9d7hiT6GQ2b
         54pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cZOWhnp892SUnLhqC+1TPlOe8BVqsfDWwTFGwwryYEw=;
        b=kP2f/NiqP7DobG8Dng7jz6EWJtDFSmm7lHmm+JTHmqEACOFUHwIQYPrWgxE1r2XBms
         Hsv97QUlEIcsGFazzjoxjpWqJgufZmfiKSTLeQau+A8R64vKNBcUEq1CatOCR/5Ogw8m
         Z2+PQHxYzQCd8LoPjsFaSG1B2mX5r+NhJxt5jrwIjYe7kqGWCLia6McP69qEIlsVcoz1
         iV3bKt69jFW+9Y6xYYNEKxtc/zTPk1sCQxJlg1C7jEu6yap1b+q2MagkarFXtapBF3u0
         vuyHBVP1QKn941zYTIZPlcMO+7oqXWdfYMVLJ/stl71CidrKcPzgv2xexgOPoOYCpMCA
         SnzA==
X-Gm-Message-State: AOAM533kayxSWiO2ILGmyOVUx11fq5PfWoEPGkve8HXRhTRy13Q0de8P
        WD8JzwHVbG76A3wkE4gZ8hTgd53csqtASdHjME8=
X-Google-Smtp-Source: ABdhPJwa626CxZJt6X6ejRxk7e3J2MLsFDDgC11k4AQQkijvXAVNZFdD5YlGgxxeK9SEt/5A/DqexW+VRmPulFH2V5w=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a17:90b:4595:: with SMTP id
 hd21mr720735pjb.0.1599165107467; Thu, 03 Sep 2020 13:31:47 -0700 (PDT)
Date:   Thu,  3 Sep 2020 13:30:50 -0700
In-Reply-To: <20200903203053.3411268-1-samitolvanen@google.com>
Message-Id: <20200903203053.3411268-26-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200903203053.3411268-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 25/28] arm64: allow LTO_CLANG and THINLTO to be selected
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

Allow CONFIG_LTO_CLANG and CONFIG_THINLTO to be enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6d232837cbee..2699fc5d332e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -72,6 +72,8 @@ config ARM64
 	select ARCH_USE_SYM_ANNOTATIONS
 	select ARCH_SUPPORTS_MEMORY_FAILURE
 	select ARCH_SUPPORTS_SHADOW_CALL_STACK if CC_HAVE_SHADOW_CALL_STACK
+	select ARCH_SUPPORTS_LTO_CLANG
+	select ARCH_SUPPORTS_THINLTO
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && (GCC_VERSION >= 50000 || CC_IS_CLANG)
 	select ARCH_SUPPORTS_NUMA_BALANCING
-- 
2.28.0.402.g5ffc5be6b7-goog

