Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D03C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2433207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FdoZFAIo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgEULKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 07:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbgEULKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 07:10:09 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C4FC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 04:10:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z7so4913720ybn.21
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 04:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yPM4FruOpCgqlY8Fa/KGpo+V+oloeiebiyu3mkE+4Yw=;
        b=FdoZFAIoZ9lYMKHv+3UXVCaSoD0i7e30+7M8ySFwV0gzUt4fbJv5ELwsrEL/OGywgn
         KkSYFWzgh5cHoxYOTABRWhkoavWLgNHinP0j0/Py3c/OGRVqo/2fsMpolLaVmyZYyvlG
         MpwCBGIXpUy+EkCt1/rlMHWofRvCB/P1PkINaywz95wFAInrX8IGnleGrXbO1AChGZwG
         UfhCwwkOIRYCYnax/EdBCHhRBaPRskjWiUBGPt0GSuq+x63u1LDjfecUlOPhD0ZBASOG
         KpMOdiR1812ga3xrnpPt5a4HInSAvyNEFmXmoaw04ULu/i4jsE2D4xPD20ZSUJ+8zBeh
         tqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yPM4FruOpCgqlY8Fa/KGpo+V+oloeiebiyu3mkE+4Yw=;
        b=mSWnHwHFwukuj1WbsDe1ravMFjftOHTZaVOY3WJC2vWTLINFBBGCPZ4eVgrZqZHG5U
         hz+QXpC8WD1ZlN36aMFN9DRCsf/N+KpE/v9H+kK3SkC00se453ObnFyLUoPTSVyGnXzj
         x/NEr79II9d+65VTORCxLRPx2Pug+8ZHpBMXvwCRLelRqAwvQsNxee81jvhCI7QpikQ7
         WfAKicRHyimMHQsjUTHlxxGaxoDWftm/+FvFQXU8VWs2GtWMT4TKwMF+UihoWShA281e
         SUZRDWx3PnYmx2cx7HcMc3nZBbHFfpV/DCCzY+qhndtGUpTL8o3Al4//JfyRXxhVWYoq
         9yCg==
X-Gm-Message-State: AOAM530KlXbONZQKD3DHD74crmfUhn42ui/Mmyvjf5GTloVywvVeqaeb
        QS4Y4goBGK+xfLdcpmZVkADSHpTRZw==
X-Google-Smtp-Source: ABdhPJxH/PO24wxdEIW7gDN62TZZo5QJjEtgTD5tNq6zp1WXvQZsIL4uCMZ6t5OVbWu0MA8MVaet3I298Q==
X-Received: by 2002:a5b:58a:: with SMTP id l10mr14644958ybp.483.1590059408475;
 Thu, 21 May 2020 04:10:08 -0700 (PDT)
Date:   Thu, 21 May 2020 13:08:51 +0200
In-Reply-To: <20200521110854.114437-1-elver@google.com>
Message-Id: <20200521110854.114437-9-elver@google.com>
Mime-Version: 1.0
References: <20200521110854.114437-1-elver@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH -tip v2 08/11] READ_ONCE, WRITE_ONCE: Remove data_race() and
 unnecessary checks
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, will@kernel.org,
        clang-built-linux@googlegroups.com, bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The volatile accesses no longer need to be wrapped in data_race(),
because we require compilers that emit instrumentation distinguishing
volatile accesses. Consequently, we also no longer require the explicit
kcsan_check_atomic*(), since the compiler emits instrumentation
distinguishing the volatile accesses. Finally, simplify
__READ_ONCE_SCALAR and remove __WRITE_ONCE_SCALAR.

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Remove unnecessary kcsan_check_atomic*() in *_ONCE.
* Simplify __READ_ONCE_SCALAR and remove __WRITE_ONCE_SCALAR. This
  effectively restores Will Deacon's pre-KCSAN version:
  https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/tree/include/linux/compiler.h?h=rwonce/cleanup#n202
---
 include/linux/compiler.h | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 17c98b215572..7444f026eead 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -228,9 +228,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 
 #define __READ_ONCE_SCALAR(x)						\
 ({									\
-	typeof(x) *__xp = &(x);						\
-	__unqual_scalar_typeof(x) __x = data_race(__READ_ONCE(*__xp));	\
-	kcsan_check_atomic_read(__xp, sizeof(*__xp));			\
+	__unqual_scalar_typeof(x) __x = __READ_ONCE(x);			\
 	smp_read_barrier_depends();					\
 	(typeof(x))__x;							\
 })
@@ -246,17 +244,10 @@ do {									\
 	*(volatile typeof(x) *)&(x) = (val);				\
 } while (0)
 
-#define __WRITE_ONCE_SCALAR(x, val)					\
-do {									\
-	typeof(x) *__xp = &(x);						\
-	kcsan_check_atomic_write(__xp, sizeof(*__xp));			\
-	data_race(({ __WRITE_ONCE(*__xp, val); 0; }));			\
-} while (0)
-
 #define WRITE_ONCE(x, val)						\
 do {									\
 	compiletime_assert_rwonce_type(x);				\
-	__WRITE_ONCE_SCALAR(x, val);					\
+	__WRITE_ONCE(x, val);						\
 } while (0)
 
 #ifdef CONFIG_KASAN
-- 
2.26.2.761.g0e0b3e54be-goog

