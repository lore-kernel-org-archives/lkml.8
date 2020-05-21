Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FDCC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 471C820721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KobY7OKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgEULK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 07:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbgEULKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 07:10:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D508AC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 04:10:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 137so4908061ybf.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 04:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0j39NvXrsyBh4wsV8IVEExoloRXnW3VKds76JrKCKC0=;
        b=KobY7OKpOjcJrCs1UCrg3A/K8q3UW15eKhrkOqIHariMS2YIDNGYTidYgj+lzlQERE
         0K5RwMrdp/I8md56mRlI/WK0SDhQnezB5yx/jEwStZzb0NlcP33NQZD4Kd0WmA4oZX1N
         lHp7coHXvOdhhUMSsDwvdWGIJZUFsC0n8Vit2Oe0eAjObZ0VV9mgWYv0oKofKAw+I+Z9
         73s23JbJji4r8icjOehsT6CUCuN0YvcAl6jYFCwcTJ/03zMedfszwGxbdKjXurIGJaey
         6GXjOV8bcjwywk7wMruefhrO4MLakuqFN8RAG8UZqUSJhatoVRIdldXEXISq41R30P8O
         npdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0j39NvXrsyBh4wsV8IVEExoloRXnW3VKds76JrKCKC0=;
        b=YRBJ8+aTTiwTbNcmlbYwiPGz1Q9VLxQFLXglEUAaWIQg/t0KDCJJyp/kw3w+SnLXWK
         8h/Jk2xQOxjsoDsKdHZ0NfiN6eTe9Nw1d6tJFS6+98+W0psWrLudKxFwGMPF9riSBN9z
         kQiGteGd3f2Hg8UwXt+2Sy1BEeQI5SktIkN/Dr5xkjvaApoF29zqsESCN5gwl0caaZ6I
         9uWHRKmVoIVP42VN7poT7EAW9wWSSXunMSkeeX4WB3QYiMtrItKEe4tvMvN8ZFWkobcv
         f2lX7SdIeftfhm2KS1pDyOXzLN6+y/LU8LzA4XOwdk658yq2Jn/+Icz03SNcqSA/pBZX
         g+3Q==
X-Gm-Message-State: AOAM53128HzVKrh0hgS5eHn8qYrLFNdbJcY7ckG9IsjQnDlwpOa9tMBy
        0talNcOEx8DYY7Vx2AFrBv1Qib+mKA==
X-Google-Smtp-Source: ABdhPJxnfsQfwXk+6qawRzxgyOrK3qyR7BXzD2Q/yn3oNfEnOyP0Kl8egaai2WqaPXR1lx5JguUgTB6oTQ==
X-Received: by 2002:a25:d181:: with SMTP id i123mr13986899ybg.316.1590059406104;
 Thu, 21 May 2020 04:10:06 -0700 (PDT)
Date:   Thu, 21 May 2020 13:08:50 +0200
In-Reply-To: <20200521110854.114437-1-elver@google.com>
Message-Id: <20200521110854.114437-8-elver@google.com>
Mime-Version: 1.0
References: <20200521110854.114437-1-elver@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH -tip v2 07/11] kcsan: Update Documentation to change supported compilers
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

Signed-off-by: Marco Elver <elver@google.com>
---
 Documentation/dev-tools/kcsan.rst | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
index f4b5766f12cc..ce4bbd918648 100644
--- a/Documentation/dev-tools/kcsan.rst
+++ b/Documentation/dev-tools/kcsan.rst
@@ -8,8 +8,7 @@ approach to detect races. KCSAN's primary purpose is to detect `data races`_.
 Usage
 -----
 
-KCSAN is supported in both GCC and Clang. With GCC it requires version 7.3.0 or
-later. With Clang it requires version 7.0.0 or later.
+KCSAN requires Clang version 11 or later.
 
 To enable KCSAN configure the kernel with::
 
@@ -121,12 +120,6 @@ the below options are available:
     static __no_kcsan_or_inline void foo(void) {
         ...
 
-  Note: Older compiler versions (GCC < 9) also do not always honor the
-  ``__no_kcsan`` attribute on regular ``inline`` functions. If false positives
-  with these compilers cannot be tolerated, for small functions where
-  ``__always_inline`` would be appropriate, ``__no_kcsan_or_inline`` should be
-  preferred instead.
-
 * To disable data race detection for a particular compilation unit, add to the
   ``Makefile``::
 
-- 
2.26.2.761.g0e0b3e54be-goog

