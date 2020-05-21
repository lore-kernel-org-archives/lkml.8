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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E19C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAE1D207F7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L/OPRcba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbgEUOWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 10:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbgEUOWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:22:39 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A38C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:22:39 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id d11so7271790qvv.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dz729bx1Pa1pF4PgJy0kCf9Utra9WlCLoUyt1P9z0sg=;
        b=L/OPRcbazaq2P9GdeWFRmzgC6CARW2S10o2GP4Xoc0hpLGF/m1w2gH3BdB1duH0rSk
         sHAwprxdsCCmFioPdDgpxk0E5/yt0J/C6W/7iV5w5rc4ZUJWWSeeK6oLUlwRSoAllKx5
         nxfbcZ60Fiwd0HdsUSl7BnwCdZARDaF1kZH9fYF6gCzZj3ApA9kTCiKVIEZwjv1yz+Hi
         1TRjvV3CbThMI3qbE+RIJGtER4bV9kKcmEXMH3X6+Rz/EtH9HnQyr2qIjpcuHfMHerTq
         a6mjBK8NbmzylHaCc+BzFKu+j2DUGfMv0jz2u/fGfX+spoo79HqF//GT2hFMBQ8M1w6u
         lZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dz729bx1Pa1pF4PgJy0kCf9Utra9WlCLoUyt1P9z0sg=;
        b=VJ0KdBvGjAl06iMLnwxQReGe9UfbMnT77f/oPy4I6/se1oFyPLfLySEnHb9hHy+ueE
         BUtixSCCEVJasi1rd71TxPCAqRjDPjq8p/YY8sC7nosUv1dIo/5PQ1PWtnY0l8vTmL/l
         zT8DIlvvomcUV8q1qK8UPrq/vBPPGR/z7PRXpvZt9+iCw2Ds+/abknsv8nA1hxYsO/yY
         +0SzR2hS3Ya58Z1Kpl9fWf8OfCJR4FLYSCA75hpJX24ShUO7I+hwJ77hpvAnxejz1Jb/
         GWMDoN0hlNBU5HUfyusCakVNS0UlMlTDJSOR82EJFYo9yAPe2EhLg1iTF3/7WiDH7j2n
         AxHA==
X-Gm-Message-State: AOAM533KynB0e1O1vFcDDFD3HLMCaZuoETyF1PJWBBgF+ITSS9vEZQjt
        aa3HYyXyLj8xo3sKpDXHrcH8BdKYhg==
X-Google-Smtp-Source: ABdhPJwA6KstpYMq2Y70Qwk2d3mwXfEyfhyxA40V03sD+gaGWmNjEwXC9DB9mIBY5YVcXWzq4c4LpXZ7ww==
X-Received: by 2002:a0c:c991:: with SMTP id b17mr9979723qvk.16.1590070958659;
 Thu, 21 May 2020 07:22:38 -0700 (PDT)
Date:   Thu, 21 May 2020 16:20:44 +0200
In-Reply-To: <20200521142047.169334-1-elver@google.com>
Message-Id: <20200521142047.169334-9-elver@google.com>
Mime-Version: 1.0
References: <20200521142047.169334-1-elver@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH -tip v3 08/11] READ_ONCE, WRITE_ONCE: Remove data_race() and
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

Acked-by: Will Deacon <will@kernel.org>
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

