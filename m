Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A9FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8084E207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SZSlqP2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgEOPED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726731AbgEOPD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:03:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7325AC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:03:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n77so2898390ybf.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=O66Rrrp+JcFi/5yju5R8rYLztnbdicYxc/HcFiSiC0Y=;
        b=SZSlqP2Zz7/IiH8vmfOLGm5Fr76hdqLoKSncO/ssRbjpDAhkmmA4O3HDISAIzYtp3+
         1mXXJ4xypoEbEJZ0Gp1czn88brlNSGbeodFpxtkck89ea0D5qOuEEI8V/3I8Ec7NzWzq
         2sB/qmKB7ocNAhwXBhclm/WqLaZ+W7W+ZzGG2hfk1754P6NYqAECkNEiVBmdZyCft0NI
         Q63rAZaer6HJdfHEtiWVNdT/tCxs4Cimzj3ppbtuYmVG8PoO5ADYym003WBXX9NmXziu
         kcXPIsoBaNUfrRHE6bFNYoa604YWpJKMzGCq+qaZlh98aRInFIn8inwLmCnN2hboLqys
         FHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=O66Rrrp+JcFi/5yju5R8rYLztnbdicYxc/HcFiSiC0Y=;
        b=JETyOgO551aa7RVLXuuSOFsEmO1EQ9576KdadPoUo5d6XcrOGJj9obX8pS9Xi9I1kA
         WYKTjljMIRYFswsclOJI90ulGVTORbMWyP3gn637TFZeIsmnerny7y2aXyi5+DaNDRdo
         f6JGLFJoS9gAm/LshwK0wvhLg+K1uWxGX/pR1PmQOo1e6H6ss5T/nRQ0A2NPB45JXmGG
         in9k8w+8GrvGQpFON3/98+mwH/f+ktPoKiGFCAQd8iMD12Jgjn/4hdz79b7rlT3k3c1v
         bx66t2/XsBmhAloD9jfFEr/TzXCEx4DM57s/WzGIfbt/TB2EOB+LlDFhvsTCuH7h5MHE
         lbXw==
X-Gm-Message-State: AOAM531aYYoKhFsNtsdYUl57plWxoqi2+yCyjVPVijEh0TH3yBVnUOQ2
        1GyS5Q3ibAOv6ge1V0J9DPw6ZfnoHQ==
X-Google-Smtp-Source: ABdhPJz5EORoeT/1t3fRBCIvH8eIrkX7vdbyI6d0s/C+zeVXlCTQTKQAO8hother9DvnPp7/AYFPKY9/gQ==
X-Received: by 2002:a25:874b:: with SMTP id e11mr6243676ybn.23.1589555037606;
 Fri, 15 May 2020 08:03:57 -0700 (PDT)
Date:   Fri, 15 May 2020 17:03:33 +0200
In-Reply-To: <20200515150338.190344-1-elver@google.com>
Message-Id: <20200515150338.190344-6-elver@google.com>
Mime-Version: 1.0
References: <20200515150338.190344-1-elver@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH -tip 05/10] kcsan: Remove 'noinline' from __no_kcsan_or_inline
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

Some compilers incorrectly inline small __no_kcsan functions, which then
results in instrumenting the accesses. For this reason, the 'noinline'
attribute was added to __no_kcsan_or_inline. All known versions of GCC
are affected by this. Supported version of Clang are unaffected, and
never inlines a no_sanitize function.

However, the attribute 'noinline' in __no_kcsan_or_inline causes
unexpected code generation in functions that are __no_kcsan and call a
__no_kcsan_or_inline function.

In certain situations it is expected that the __no_kcsan_or_inline
function is actually inlined by the __no_kcsan function, and *no* calls
are emitted. By removing the 'noinline' attribute we give the compiler
the ability to inline and generate the expected code in __no_kcsan
functions.

Link: https://lkml.kernel.org/r/CANpmjNNOpJk0tprXKB_deiNAv_UmmORf1-2uajLhnLWQQ1hvoA@mail.gmail.com
Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/compiler.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index e24cc3a2bc3e..17c98b215572 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -276,11 +276,9 @@ do {									\
 #ifdef __SANITIZE_THREAD__
 /*
  * Rely on __SANITIZE_THREAD__ instead of CONFIG_KCSAN, to avoid not inlining in
- * compilation units where instrumentation is disabled. The attribute 'noinline'
- * is required for older compilers, where implicit inlining of very small
- * functions renders __no_sanitize_thread ineffective.
+ * compilation units where instrumentation is disabled.
  */
-# define __no_kcsan_or_inline __no_kcsan noinline notrace __maybe_unused
+# define __no_kcsan_or_inline __no_kcsan notrace __maybe_unused
 # define __no_sanitize_or_inline __no_kcsan_or_inline
 #else
 # define __no_kcsan_or_inline __always_inline
-- 
2.26.2.761.g0e0b3e54be-goog

