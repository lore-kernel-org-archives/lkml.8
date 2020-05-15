Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F745C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08278207C4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XabRop8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgEOPEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726879AbgEOPED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:04:03 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554ACC05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:04:03 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id a7so2885171qvl.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0j39NvXrsyBh4wsV8IVEExoloRXnW3VKds76JrKCKC0=;
        b=XabRop8tK1h28an1x7LJCVD4HeSuT2hdXYUuJr3M5Kvpu3co2l97LA7K1hagIIbBZB
         XOxiJwoRDk8RSV86zobtuQc3rcaptEwWqy8FFh+zZsXBS1GWleUzjDjeec97h4T2zXiB
         QATYP6GUomRJK7598Y70HX0WNyoUNf9ckf7tKLV3D88RTM1TqLzjSTDLFnKkqleYkmGd
         uS7NyOfNJUXHzy8+X3hVXQDoycPbxHk4quHccTPIy/KqFkceRDkuSy4zuay79Juo3AA+
         m13am3WymFIVGSr9h2ZHCUg3NDZwrUpiZscfPrYK9m1Uw3GKHyWq+WSReaFWgiTDn4Pd
         XL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0j39NvXrsyBh4wsV8IVEExoloRXnW3VKds76JrKCKC0=;
        b=qmQ8PxS9kLPGaeUszkj4YwKTElhT0KTGHCotpEpwl3kYf+2kPEmwWaxjBQtNwqNR41
         SHgFCT4LhII/UW/6k5e3gI0myvNhBWU6K1JNGLY8/VuOV+WShrPTbpPVE/xIyoMWwawb
         I75VJxQ4BQ4MUqN8i2UcK9WFbVaInwyY9SBfKpPhlZuuB8FIyABDKV4EwgMkbgUqN2j+
         yXNVOsAL9wwHSOUwgKYbD9/xZkSmU9J7xrsP+7zMNv1hV5YkwaRuB1THy8hEfNOT1o8n
         TMsoMY6LG5s+CL1kJuBCLaqAlRAS62fdtoVCPmGtlLWuTCtyMcgcqNAoSgrpAOyWp2ME
         mN6g==
X-Gm-Message-State: AOAM531iwMrydVUuNRcHgeLG2AB/ZrnJw2e0CQpLKHENN7ymJPg/EYsd
        l3xNTQPnqm9gxTGxoYoTIJmn4xwgLw==
X-Google-Smtp-Source: ABdhPJyBPw4RHtIf0yz3478t+CC7J8CekAFyRt5Q79feW/0GmryL/iqFy8yGlHYiczLcqfHz+8AM0FZh+Q==
X-Received: by 2002:ad4:5604:: with SMTP id ca4mr3961451qvb.6.1589555042352;
 Fri, 15 May 2020 08:04:02 -0700 (PDT)
Date:   Fri, 15 May 2020 17:03:35 +0200
In-Reply-To: <20200515150338.190344-1-elver@google.com>
Message-Id: <20200515150338.190344-8-elver@google.com>
Mime-Version: 1.0
References: <20200515150338.190344-1-elver@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH -tip 07/10] kcsan: Update Documentation to change supported compilers
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

