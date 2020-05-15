Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26D1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D49D0207CD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H9vVXern"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgEOPEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726948AbgEOPEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:04:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8DFC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:04:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s8so2831157ybj.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bOmDunhfUaahaaiKVLHLTe7nnH/k9WP55G/+iETR4Xc=;
        b=H9vVXern9rQlSCkWN6cJri4qpvTSvDQ+XyA5HZCmdoHBWyKOW9AXcUWBWjH1hT8MYf
         clXHX9rWsmDhpfkER35klYaEnlM71Vyddf+bQIbTE3YTPAbP+LN0EUhcERiBWFHHxv0y
         qjrRKkP2kgSr28zIEAmbjgegZ+AjBroIw6vQ5X9fCG0szdyV2gt8+rsEb4Qn0bStPQjh
         LFYXIR+OfiUE8pBcPSFafrLlpVHvslGxti0xfV0E9aYzWFZiUM2zS+sYes8pgVrOJEG9
         x8+/GBoWWG2pwkonjaaxGqiA5si7/N4/seynPw6womoYOhT/lGSKtIdrc9CKPEamqoAk
         8/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bOmDunhfUaahaaiKVLHLTe7nnH/k9WP55G/+iETR4Xc=;
        b=GWsnh5Ey5Lr0BXT4g6XbZjjsz+kd60EUi5l9hWHoomB3eIVsS3iEUhZ1nSqhcHb7or
         jZbEucdyNYiGj89LvUI/+ohj5ORZoRsPq9Nr5flrgOnf8uPWOX37eJAY9Io6BbRiIBSS
         9iA+TKt+Ftj1SMUfZ8V1Y0xKQ5CAAcU5bhkf9CuAKIXP/X0FHyWZnUwbsEhDiRcCLmv1
         X7xo0emZScyc55jotUvDvYcfNHQVDC8ijZ8PaYVqRomhe2WT4LSIphObCeD9CYXoPO0D
         YY26OyE9MlfeWjmkZgAPswSUD4V22og/XTtaw5BN2szLvpXBjzGkdo38kwc8PnRYot7G
         qUiQ==
X-Gm-Message-State: AOAM530QQ6WjuKKLkSyXw/CGr9gpPSf1XPRzbB8ND+HNNGkvszJ+BkKy
        ipicyrr1AYO1qF8InwL43uJFwSeQyA==
X-Google-Smtp-Source: ABdhPJzHNvOh6utxf80pvXkEfp6huzTyX1tIpDpSlMdH7iU5qpuglvMC/4Kw7iIGRzCWndRCEeLasx5zVA==
X-Received: by 2002:a25:d786:: with SMTP id o128mr5956484ybg.519.1589555044732;
 Fri, 15 May 2020 08:04:04 -0700 (PDT)
Date:   Fri, 15 May 2020 17:03:36 +0200
In-Reply-To: <20200515150338.190344-1-elver@google.com>
Message-Id: <20200515150338.190344-9-elver@google.com>
Mime-Version: 1.0
References: <20200515150338.190344-1-elver@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH -tip 08/10] READ_ONCE, WRITE_ONCE: Remove data_race() wrapping
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, will@kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The volatile access no longer needs to be wrapped in data_race(),
because we require compilers that emit instrumentation distinguishing
volatile accesses.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/compiler.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 17c98b215572..fce56402c082 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -229,7 +229,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #define __READ_ONCE_SCALAR(x)						\
 ({									\
 	typeof(x) *__xp = &(x);						\
-	__unqual_scalar_typeof(x) __x = data_race(__READ_ONCE(*__xp));	\
+	__unqual_scalar_typeof(x) __x = __READ_ONCE(*__xp);		\
 	kcsan_check_atomic_read(__xp, sizeof(*__xp));			\
 	smp_read_barrier_depends();					\
 	(typeof(x))__x;							\
@@ -250,7 +250,7 @@ do {									\
 do {									\
 	typeof(x) *__xp = &(x);						\
 	kcsan_check_atomic_write(__xp, sizeof(*__xp));			\
-	data_race(({ __WRITE_ONCE(*__xp, val); 0; }));			\
+	__WRITE_ONCE(*__xp, val);					\
 } while (0)
 
 #define WRITE_ONCE(x, val)						\
-- 
2.26.2.761.g0e0b3e54be-goog

