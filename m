Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A69DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A5A52071A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WhWZYW2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731327AbgFOSnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 14:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729842AbgFOSnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 14:43:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA5AC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 11:43:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s90so21893888ybi.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 11:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=E5J9eW43iWDhM6NCP/M18PRrar5zm+KpAYsU8FhxzQc=;
        b=WhWZYW2CdG1kpDcDysoN6KtDFTQIpIIflg2HZaEqMZQJrCAcLYbEl46vtnj35CXCC+
         5ceSCsA/pn5dFPW/pr85Zam374lvbi7hfyYfNyI+lHDwUJtkgqwCA/1h36Gzq9bYfN4z
         CoCvYVOEtkmFQ93AXjbKJWPv62SF6oonahpzjTUWrMSfDSPx/JgaDSY0ujweJsD4tEWP
         2qnmGkbkrON3W8RUkhaMK/fdpTgSWDr5cwlDi1MYjJ3ui0DSXTtoHsTtu1g/MrL+S6iN
         mZjTfqfTu/4NYt2FIHZeuPrtnarTcHt4ImiaIhyHuvbU0wFrcvAiFLjZqnVZRjiIv+k5
         669w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=E5J9eW43iWDhM6NCP/M18PRrar5zm+KpAYsU8FhxzQc=;
        b=Ner/Uwk8L+EIqdOgbI2U6Fcri4G88s0hJeixtR48h7xezmrczLlsWyAj2zGcPmOcxl
         6/XurTbIiSo9gqUPDXo6t1Ju5XrdbD8f75n0JhA/nVkfthnnym4Bd/2RJGSDl0hQ27Kj
         Pm9ShmsqCACY3K4BiadvT7RzkufYj1Kp+ye+q1j34qfpvndndbG4lEsU9bKXufpkcrWP
         4yPHQOZ5ND6PRMfxQ9dZHLPNEo4gMp7vRJVbaI9jT7WdioskKBjEdUcIsKU2+dj6OHgm
         wOu2wZdJI9F6+zSwUSSDajI6tqj8KDI8plFXxlFf7ngxpUhqxpiwsjXEYWWO/rmu6EUk
         n2AA==
X-Gm-Message-State: AOAM533IXBCMXFtudFO/mJsjW/G8fFkoAN7hKeCbeGbDYGoI4S7OoRvR
        3igFDeVtBv+OjvkXwcHeZk/B9RBi1g==
X-Google-Smtp-Source: ABdhPJyRxVOLLTWjGLjFIuGkIyj6kaIR1fRd19Wih9jzz6La/9185tm3DhACQJjrmwXu8rE0zaeNVO4W/g==
X-Received: by 2002:a25:50cc:: with SMTP id e195mr48552837ybb.483.1592246594106;
 Mon, 15 Jun 2020 11:43:14 -0700 (PDT)
Date:   Mon, 15 Jun 2020 20:43:02 +0200
Message-Id: <20200615184302.7591-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH] kcov: Unconditionally add -fno-stack-protector to compiler options
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     dvyukov@google.com, glider@google.com, andreyknvl@google.com,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
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
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Marco Elver <elver@google.com>
---
Split out from series:
	https://lkml.kernel.org/r/20200605082839.226418-2-elver@google.com
as there is no dependency on the preceding patch (which will be dropped).
---
 kernel/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/Makefile b/kernel/Makefile
index f3218bc5ec69..592cb549dcb8 100644
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
2.27.0.290.gba653c62da-goog

