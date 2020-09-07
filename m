Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF57EC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 13:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C3BA20757
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 13:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="gJMepwpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbgIGNri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 09:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729596AbgIGNoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 09:44:08 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5999C06179F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 06:41:28 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id w10so5559032ejq.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 06:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6l8eSHfBJbgjXLH4YKy244cAN4v6gWSGUkqWIYWs5l8=;
        b=gJMepwpDD2I7mUYxDrgz/A+g9gfSD/BA/UuHnQFWRrhx63jrzAm++vIK181a9bjlv9
         +fyJs0UBhDwHyL6bmgDBoBCj+YXB5NcIWStWKiSyw+U5jw3hXU5qNrqCgVh70poBTziM
         hVjzHzlUPAP+6ZrjPMb0VVDUmjdbm+Fic5uHT4D0LLJBRfryu3ilfMTyrvJ6Pe67zAKM
         QPB1+20ESihTrASldDU+keBcOA+VdB6aTwV7W7EB3NGfe+MymBScoWc26UcdcpDZRQUj
         K7o1qF+WpCWcT7AO1+jrbBJd9uRJMgPkaub7KeMCED/zCqeZW5LsKuVbAAFjxIU1VdGp
         kNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6l8eSHfBJbgjXLH4YKy244cAN4v6gWSGUkqWIYWs5l8=;
        b=Izp9TYcpWOw1IKKxhv+DO4xWdPXLHjaqpmBYaxpgnrlK6DMTu/fPrGzGKWhUu4UBNz
         ds9g5lDRZ6JehwDznachPXILMDvivxPO3MYtSUIkXUFzpwNjYBgTLLFz37wR2GA5WKY9
         KNo9vcIbxAcOOF47N/TZ4RGAxYVOgoqYFve2VrykjDys3Xz8mWYriE6rp5NLbqChFO3z
         V47fc9LNmQa0A9LCsZObmusJjmS0FbC6vO5CqkAic5V/T7o3VAOgWQyiBqa1JS/tgYVT
         +bJXb/lMDvz9Xpfeux0HZm725Yqkw12ToHbynv4acyQlVFe7s0Gzntys+PjqBmnVY00l
         Fr5A==
X-Gm-Message-State: AOAM533lwbi5vahqdG4wmkthE0XeTV2/HZTqAEXdrjyDTmaM9mwAzE3d
        NLmMiUrcmC5YVf5piAtAIx1+hkbUxA==
X-Google-Smtp-Source: ABdhPJyZu6FsfB3DPagX7+/xIWmjZXKqXJcTOhpqkU8N9KdWRQ4MmOfijnPAcqP/AO+UJAuVA1aIngFA6A==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a50:be82:: with SMTP id b2mr22342862edk.303.1599486086811;
 Mon, 07 Sep 2020 06:41:26 -0700 (PDT)
Date:   Mon,  7 Sep 2020 15:40:52 +0200
In-Reply-To: <20200907134055.2878499-1-elver@google.com>
Message-Id: <20200907134055.2878499-8-elver@google.com>
Mime-Version: 1.0
References: <20200907134055.2878499-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH RFC 07/10] kfence, kmemleak: make KFENCE compatible with KMEMLEAK
From:   Marco Elver <elver@google.com>
To:     elver@google.com, glider@google.com, akpm@linux-foundation.org,
        catalin.marinas@arm.com, cl@linux.com, rientjes@google.com,
        iamjoonsoo.kim@lge.com, mark.rutland@arm.com, penberg@kernel.org
Cc:     hpa@zytor.com, paulmck@kernel.org, andreyknvl@google.com,
        aryabinin@virtuozzo.com, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, dvyukov@google.com,
        edumazet@google.com, gregkh@linuxfoundation.org, mingo@redhat.com,
        jannh@google.com, corbet@lwn.net, keescook@chromium.org,
        peterz@infradead.org, cai@lca.pw, tglx@linutronix.de,
        will@kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Potapenko <glider@google.com>

Add compatibility with KMEMLEAK, by making KMEMLEAK aware of the KFENCE
memory pool. This allows building debug kernels with both enabled, which
also helped in debugging KFENCE.

Co-developed-by: Marco Elver <elver@google.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 mm/kmemleak.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 5e252d91eb14..2809c25c0a88 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -97,6 +97,7 @@
 #include <linux/atomic.h>
 
 #include <linux/kasan.h>
+#include <linux/kfence.h>
 #include <linux/kmemleak.h>
 #include <linux/memory_hotplug.h>
 
@@ -1946,8 +1947,18 @@ void __init kmemleak_init(void)
 	/* register the data/bss sections */
 	create_object((unsigned long)_sdata, _edata - _sdata,
 		      KMEMLEAK_GREY, GFP_ATOMIC);
+#if defined(CONFIG_KFENCE) && defined(CONFIG_HAVE_ARCH_KFENCE_STATIC_POOL)
+	/* KFENCE objects are located in .bss, which may confuse kmemleak. Skip them. */
+	create_object((unsigned long)__bss_start, __kfence_pool - __bss_start,
+		      KMEMLEAK_GREY, GFP_ATOMIC);
+	create_object((unsigned long)__kfence_pool + KFENCE_POOL_SIZE,
+		      __bss_stop - (__kfence_pool + KFENCE_POOL_SIZE),
+		      KMEMLEAK_GREY, GFP_ATOMIC);
+#else
 	create_object((unsigned long)__bss_start, __bss_stop - __bss_start,
 		      KMEMLEAK_GREY, GFP_ATOMIC);
+#endif
+
 	/* only register .data..ro_after_init if not within .data */
 	if (&__start_ro_after_init < &_sdata || &__end_ro_after_init > &_edata)
 		create_object((unsigned long)__start_ro_after_init,
-- 
2.28.0.526.ge36021eeef-goog

