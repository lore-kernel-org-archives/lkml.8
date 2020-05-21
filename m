Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FA7C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1D0E2072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AousQc5p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgEUOXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 10:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729617AbgEUOWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:22:37 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A206C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:22:37 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id o7so7364000qvm.15
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PgDY4jBoWDmqeTjpUELiZyK5eYsaiohYt+3kMWavVjU=;
        b=AousQc5p2kmc89WnzfvCyrVuxCJRXA1GX9peMVpbs3CCEiJXLW9LhAc/41YjKvLOX0
         jp6CsLS0CiFep/5Lqi2moJ5QnqRUckBNecZohu/LX89mphkE7GcFwhV7zS4HyyHKO/KX
         qDZZ4Kz/m+j87DQvf5myihJr/hOS49JlE4goViipXZchtzSBdLu6823bzHsdwCxXdwl8
         swZLF0C40fQhb8VYYj/qhoyGoV/PdtF02Dz3OX42dO9eIpFRUVHHXhHUaVkth2hVlL9C
         r1E+V7A7REeI5Nk+dMG/KQ78h4AiX6itTn0uV98hJjWrXskYNp50f2aMAhk1miUSwS9U
         r6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PgDY4jBoWDmqeTjpUELiZyK5eYsaiohYt+3kMWavVjU=;
        b=mtwMBje/300VNWQmzhrZoLPriAkgiG1lpKeJQOu3InOsYV+CNnwsd94SnF2WDdyHkh
         j05TAxcLY8w4bTwkK6/7w9Nm5PR1fmURgdPA+6dOQHxLmSKMcRhg+1ZmGXwX2Ks76Nlo
         WSJ5nBHS/JqabVedbP+9oMY6OzA+sjEpTjvnjV9ZuEQ/KqCtwHjFCf5w2/Wtcv9Q2jtS
         b0lAmwX6q1JB1iCWiBfNvRaR/Q4548R8WyEeKvY5EIwoEKYhQLpZPdgwY4/tCL624378
         moCrKMYBH44rPUe65XAgzMNhAu3MzzTZmL+15VXLdyQT8OhMg4NEh9tbWFhQqKIbj8LN
         eOXQ==
X-Gm-Message-State: AOAM5330TZL0bZBjYOj/szkdW8y1e4gjvtGWSm9+SU3rXVXHcMkCBCOV
        Mt6ucsPKaP/Yo+K58EwPiN5oHamE/A==
X-Google-Smtp-Source: ABdhPJwO7p4/RATu11945AzACzORSJUB2UbkD94tfByRbG2zgWyVR2y2XdGSRefi7hErmbeHCnNh2+7E+A==
X-Received: by 2002:ad4:4690:: with SMTP id bq16mr9884082qvb.20.1590070956501;
 Thu, 21 May 2020 07:22:36 -0700 (PDT)
Date:   Thu, 21 May 2020 16:20:43 +0200
In-Reply-To: <20200521142047.169334-1-elver@google.com>
Message-Id: <20200521142047.169334-8-elver@google.com>
Mime-Version: 1.0
References: <20200521142047.169334-1-elver@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH -tip v3 07/11] kcsan: Update Documentation to change supported compilers
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

Document change in required compiler version for KCSAN, and remove the
now redundant note about __no_kcsan and inlining problems with older
compilers.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
---
v3:
* Add missing commit message.
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

