Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D87C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 08:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9EA02074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 08:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j5MQecjE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgFEI2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 04:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgFEI2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 04:28:47 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18382C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 01:28:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id c17so10972759ybf.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 01:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3PKodQpvSJ7s5tO6EtbZDnjyyWXngJpHghjobV/Lh34=;
        b=j5MQecjEELNb1Z0YJBkwXEKeLK13XLeSkFMdOzfhYu/5hs+eo5NpZDYYX6F0CMe6bc
         hb81OABIchgkt06uTaLlJ5HtsHQ/qZrCNR00Xl/a2JMBE8i8jh9RzVewmYzhxxRgQoMk
         twILOaL6TdfXANBXPHLle3EtE41NJsahuKA2Ii6i1RfrJkG0AG/fss61c/Hbq/kgNXmO
         oIx+HTCUQ+7kjqKeW5DcK+xL8Gwyp66VTEAxdrI4uIKuiKRcgt9bH0sa6L14RG92/n/e
         eJChBwTUFM0fQ13DylVmahM67wrIeBI6t24NHMDIKbNUwWuxQT/dloKwAp/hAwKIpqT9
         OVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3PKodQpvSJ7s5tO6EtbZDnjyyWXngJpHghjobV/Lh34=;
        b=Z/t8A6MZX+wqMsDcwHfZ/kDGvDlIBtfNKjQJ0g0wRJdbuhEZQHflwUGxQTvbRGi1O0
         GVwEv+fBL9l5Dec7dkxNNVCuAoKeM+qCNJaOb3WZCaBOujk5kXmzpX808mooa03rD8Pg
         Y6kEG0E2esr+TslnpnXIpLZygcK1pUlwf+pDsXgzasffK12wuIAuj3XgQwjqBigMoqM0
         98doBXEsl6DWXTxZ15OyF6tnaRDRiNJM82WH5kSd3NhZH5vopb863/xrjtE3RvwRwlY2
         gS4zTSNjXgmXHrmOstBGo1u8uTiSD2PJJ7qTjOypSXVPHxxT5J+RlAYjTjdqRDzsi0lO
         35sw==
X-Gm-Message-State: AOAM5331QD6Q0DiK1J4NdzUN0mFxfy5Xd22H/U3nJkcy8khXUac/L7nA
        9BdPR7n9Bu0wm4HeFVGnzqqO91ljgA==
X-Google-Smtp-Source: ABdhPJxm4vKPvhZ0SK5v18C4PFHw23r9ZNCcL5PLgLQ7vdEu8JVgEBzy/pVdsf++kEqcXwxxqK2dqUja0A==
X-Received: by 2002:a25:9345:: with SMTP id g5mr13780734ybo.485.1591345725292;
 Fri, 05 Jun 2020 01:28:45 -0700 (PDT)
Date:   Fri,  5 Jun 2020 10:28:39 +0200
In-Reply-To: <20200605082839.226418-1-elver@google.com>
Message-Id: <20200605082839.226418-2-elver@google.com>
Mime-Version: 1.0
References: <20200605082839.226418-1-elver@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH -tip v3 2/2] kcov: Unconditionally add -fno-stack-protector to
 compiler options
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     peterz@infradead.org, bp@alien8.de, tglx@linutronix.de,
        mingo@kernel.org, clang-built-linux@googlegroups.com,
        paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        akpm@linux-foundation.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unconditionally add -fno-stack-protector to KCOV's compiler options, as
all supported compilers support the option. This saves a compiler
invocation to determine if the option is supported.

Because Clang does not support -fno-conserve-stack, and
-fno-stack-protector was wrapped in the same cc-option, we were missing
-fno-stack-protector with Clang. Unconditionally adding this option
fixes this for Clang.

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Marco Elver <elver@google.com>
---
v3:
* Do not wrap -fno-stack-protector in cc-option, since all KCOV-supported
  compilers support the option as pointed out by Nick.
---
 kernel/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/Makefile b/kernel/Makefile
index ce8716a04d0e..71971eb39ee7 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -35,7 +35,7 @@ KCOV_INSTRUMENT_stacktrace.o := n
 KCOV_INSTRUMENT_kcov.o := n
 KASAN_SANITIZE_kcov.o := n
 KCSAN_SANITIZE_kcov.o := n
-CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
+CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack) -fno-stack-protector
 
 # cond_syscall is currently not LTO compatible
 CFLAGS_sys_ni.o = $(DISABLE_LTO)
-- 
2.27.0.278.ge193c7cf3a9-goog

