Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF67C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C5120708
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B++G553D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgHNR3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbgHNR2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:28:33 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF1DC061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:33 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id d6so6500996qkg.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lhqV5mQvN7E+6IRby7TSffIB2FjRKGUNLHJKKPPYQHw=;
        b=B++G553D5YRfzBibD52/YbmLsetWRzAA+mz8eYde400Dt3AEX/vseByvilgBu/RIty
         m11Xpzhzd4fCTyIgDM3Aczj2BOJayGGNmGHctNqvXNTkecsq8v3oeABP2jnHSM5Sy/oT
         TRlXjAJ0TBbepqTIGEs3YLtgZQZ77lzQJPQ/C8eCHyjGN8okRpzyZYmC+oSiUmjgSH8d
         GO69c6LHJqVmLxayxM0kpmxCGfm+uXZCCzh2zdglLXW4JcO9BNFJdnkCs9ihI/YbjeUt
         PY221wPX7nEb3zD22xIzTFeLGFYldtf8rkWyhu3EMaLFbGQb1pdI0FM0lUdnMNysOTrI
         Ochg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lhqV5mQvN7E+6IRby7TSffIB2FjRKGUNLHJKKPPYQHw=;
        b=b8LtOg2MUewVr4yzM12Pz4VlVSAsiXx3tQ+J9OvbwoYkoambJXpUCGw9Lj9qQOKRsk
         2DVpNC9GmPKOTOin7lLJnO3H/37SteNyzxSJtAvu2J3wXVigZW8hHYnaNhUYP3Zb7yve
         xt7DmU0NRv6CN88sM+6Qs2EQeapyRSC+GDCUTk1HaLJ3118KM1xPM6Kj3JdN3ai16Y3z
         f/tWKzDkoePI72TLnXzn145hLL/mOQCf1PGbaOiwV9Gwl9RAlrow75pwSNu/C5IP+PhQ
         ZaLxEWRrr1QJq4ae2n/PdEta1pb29ZB2QAoiGJ9JVJ9NKrS3GABjfiplvTT6mTyExnJ/
         d6Mg==
X-Gm-Message-State: AOAM530cYDKvB7w2Kqrwphf+55tlQlTzcW5eOfav1rOpscHnlzAkbSeH
        DQY1E5pQ4d1IS5NmdMqFDyJ08VcLna/9C9/L
X-Google-Smtp-Source: ABdhPJyEB6r3EZb1/dD1PV8DgiQHfViC9Gw1KcFHaQCLBJDygARswv1n+YYRwOw9Yas1PVhHZwOIsetdUJwayE9i
X-Received: by 2002:a0c:e00c:: with SMTP id j12mr3697232qvk.127.1597426112116;
 Fri, 14 Aug 2020 10:28:32 -0700 (PDT)
Date:   Fri, 14 Aug 2020 19:27:11 +0200
In-Reply-To: <cover.1597425745.git.andreyknvl@google.com>
Message-Id: <042119d239d929be8d4b479825091fb088c7543a.1597425745.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH 29/35] kasan, x86, s390: update undef CONFIG_KASAN
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the intoduction of hardware tag-based KASAN some kernel checks of
this kind:

  ifdef CONFIG_KASAN

will be updated to:

  if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)

x86 and s390 use a trick to #undef CONFIG_KASAN for some of the code
that isn't linked with KASAN runtime and shouldn't have any KASAN
annotations.

Also #undef CONFIG_KASAN_GENERIC with CONFIG_KASAN.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/s390/boot/string.c         | 1 +
 arch/x86/boot/compressed/misc.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/s390/boot/string.c b/arch/s390/boot/string.c
index b11e8108773a..faccb33b462c 100644
--- a/arch/s390/boot/string.c
+++ b/arch/s390/boot/string.c
@@ -3,6 +3,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #undef CONFIG_KASAN
+#undef CONFIG_KASAN_GENERIC
 #include "../lib/string.c"
 
 int strncmp(const char *cs, const char *ct, size_t count)
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 726e264410ff..2ac973983a8e 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -12,6 +12,7 @@
 #undef CONFIG_PARAVIRT_XXL
 #undef CONFIG_PARAVIRT_SPINLOCKS
 #undef CONFIG_KASAN
+#undef CONFIG_KASAN_GENERIC
 
 /* cpu_feature_enabled() cannot be used this early */
 #define USE_EARLY_PGTABLE_L5
-- 
2.28.0.220.ged08abb693-goog

