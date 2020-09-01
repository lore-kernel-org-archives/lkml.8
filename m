Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6AAC433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 00:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AF012073A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 00:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="vh0MrWbx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgIAAXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 20:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgIAAXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 20:23:45 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF6CC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 17:23:45 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id o184so1673935pfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 17:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=90voGTWRAh9zyb+/yxZJ0Qpab+sDHCs4FBicC4wnAQo=;
        b=vh0MrWbx8c75wggoN8fSxobI1hCwLxVpnv7SdzNrisbQNqFivlJkqv9L23p2waHNoH
         th7pQorhcMyzuGwgI6VHIGlBuz91DVuuVtIM1VaGFnRMyLY15cQcfGa85ISwr0eSrIFU
         FXFHy4VmczgmUG+HYNI2ECufDgVuiG5gY5IoXnoCNcWhGZih/PG21VDsWeVS+5K/avUI
         dK80fFxZVdGAGzkQHfLckGyMCN3Oi3QqsISMlO+MLJE/TTN8tL1NnUdSpzNRt/XSap6S
         KrY7zwouXXDiJxhwdHsKMeD4P1XH7QlBrFwXR7SeTTZCTgsnosz99ZJZFT6wL6S+S1Zq
         rc/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=90voGTWRAh9zyb+/yxZJ0Qpab+sDHCs4FBicC4wnAQo=;
        b=Z18VysyeXY91nnBg3/QoFWS8uBNPE3M/oXbP9vbWoKZSG4R1YaF7bMifZ4hAja4Pxz
         4b5hAVRsDcds9BKE+1Y0ot6X9/Ha0tNftITZPHQfoxWLGQ2iIb2LzOA4RVLdFp/rzSod
         1g1TBi7BzaHtGuisB0jTZj2E2g+WkR2vcBGTHlEXq31EKq9LQRBcXZe7cukvgbfnafUR
         sAWQdmAmbU2KZKRPcMuRfdgIb9VrarjJVdRP0TgQxU8LFv1I+a4mzkeaeNrcRuhhlRsN
         dHVc/nvu9VSVMwk3SCf5CEe4wihNgaBoud7z+u0MROFGgTQc+0s18xDhYWZd2Xh2Phb+
         uhnw==
X-Gm-Message-State: AOAM531avTjDA+XrCYRMD0w9sWYzcl/vbqxvIQqvTyavztmLHexpXbYi
        h/bVuGjG4AZWNQL2XRw7tQX4887Fqo4SVHQ/ops=
X-Google-Smtp-Source: ABdhPJwMXeaN4tNH9H5++r3kcrJCsz+x2BTYTZynMy7uqKGUJvgK01z0h6HMukItgUOz5RKuA84KGl6agOsCH8FHEYM=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a62:7e0e:: with SMTP id
 z14mr3356377pfc.56.1598919824832; Mon, 31 Aug 2020 17:23:44 -0700 (PDT)
Date:   Mon, 31 Aug 2020 17:23:26 -0700
In-Reply-To: <20200901002326.1137289-1-ndesaulniers@google.com>
Message-Id: <20200901002326.1137289-8-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200901002326.1137289-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v2 7/7] compiler-gcc: improve version error
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        clang-built-linux@googlegroups.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Kees suggests, do so provides developers with two useful pieces of
information:
- The kernel build was attempting to use GCC.
  (Maybe they accidentally poked the wrong configs in a CI.)
- They need 4.9 or better.
  ("Upgrade to what version?" doesn't need to be dug out of documentation,
   headers, etc.)

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/linux/compiler-gcc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 7a3769040d7d..d1e3c6896b71 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -12,7 +12,7 @@
 
 /* https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145 */
 #if GCC_VERSION < 40900
-# error Sorry, your compiler is too old - please upgrade it.
+# error Sorry, your version of GCC is too old - please use 4.9 or newer.
 #endif
 
 /* Optimization barrier */
-- 
2.28.0.402.g5ffc5be6b7-goog

