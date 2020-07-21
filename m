Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF27FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9761D20714
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MwwVb4fG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgGUKbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 06:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbgGUKam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:30:42 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14A9C0619DB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 03:30:41 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id s16so12891560wrv.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 03:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LMk4339Zjhhu0K58clMlPfJmEmRgvFiVE2OU6iIU7ro=;
        b=MwwVb4fGj4UF6WUdljPc2Yyh7/QUZ3SHJv2NwaZ4xQTH8XfmMwDR9wkH0TDBatmSkQ
         lKpbRekcC6QG1WNEDOaS8beQqoMJJSNrt8T603+xGu2Pj6OgIoowA3eWC9HjT+4rbSCP
         Xi6w/Wo454/e7IfrHEZStyPqoPdh2/dg4SGj8IdcRFL8vde9MhXZ/8UyQeSl3V37HqVT
         bDTZLEGQr+lBUHLiy/Jkkn/AeBVoZzo1/io0ZXL/6y3zs9nLoxgJzqcsZyC7W+F0BefV
         91KH6W0enHrIcuTzYuz2CEqzbNFkaw11X/zZNrsISCQYX9tOPI3aItyNNJuBjQzYLnec
         AkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LMk4339Zjhhu0K58clMlPfJmEmRgvFiVE2OU6iIU7ro=;
        b=JY6No3xHBPNWCBBowTL6K+hWp1lfFl2dGmTXpWfwkFQ7WrrGvWyilIcIBXcEyh8ysK
         GPITLMMaGo7lpSOv/QwmKOcNCiIX1yT45m0l+0flgHfwtM8jaV9iOPJh6zDdDhWyhjVl
         yT0yAtLd25kqmO7wouYYLbHn3wD2KQoi8pRg3XeeU69x3Qr8GrKqFaC7HWX49qlKoXYO
         jcgFo8wzlJO4kzUTJo59dkwzLy9dvrgePNJR4MEHnTljkff6EsHHvE53sx3B0tUcxlma
         DS/TLXluTTvmNgIR/GFDxDSBMdqQk5RFPqkXL6lFS5tcAcYFmJRTHg063396hyDC29h2
         Uf+w==
X-Gm-Message-State: AOAM530zIIREsBEkhGlp3wuAn4DHPUGHReKKmz8jRhoHm26MY4px0RHE
        wRZ97AWksTzi1pyT+j2CqIDf8kBe7A==
X-Google-Smtp-Source: ABdhPJxmyS4vwAM8i+9rhvqtd6A42ZE9DqAAf0SiBEc/vJycx4V7hZmCBcRyew9iQzlsiCxvXrQBrLErmQ==
X-Received: by 2002:a1c:cc09:: with SMTP id h9mr407498wmb.1.1595327439944;
 Tue, 21 Jul 2020 03:30:39 -0700 (PDT)
Date:   Tue, 21 Jul 2020 12:30:12 +0200
In-Reply-To: <20200721103016.3287832-1-elver@google.com>
Message-Id: <20200721103016.3287832-5-elver@google.com>
Mime-Version: 1.0
References: <20200721103016.3287832-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH 4/8] kcsan: Add missing CONFIG_KCSAN_IGNORE_ATOMICS checks
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     will@kernel.org, peterz@infradead.org, arnd@arndb.de,
        mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing CONFIG_KCSAN_IGNORE_ATOMICS checks for the builtin atomics
instrumentation.

Signed-off-by: Marco Elver <elver@google.com>
---
Added to this series, as it would otherwise cause patch conflicts.
---
 kernel/kcsan/core.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 4633baebf84e..f53524ea0292 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -892,14 +892,17 @@ EXPORT_SYMBOL(__tsan_init);
 	u##bits __tsan_atomic##bits##_load(const u##bits *ptr, int memorder);                      \
 	u##bits __tsan_atomic##bits##_load(const u##bits *ptr, int memorder)                       \
 	{                                                                                          \
-		check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_ATOMIC);                      \
+		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS))                                      \
+			check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_ATOMIC);              \
 		return __atomic_load_n(ptr, memorder);                                             \
 	}                                                                                          \
 	EXPORT_SYMBOL(__tsan_atomic##bits##_load);                                                 \
 	void __tsan_atomic##bits##_store(u##bits *ptr, u##bits v, int memorder);                   \
 	void __tsan_atomic##bits##_store(u##bits *ptr, u##bits v, int memorder)                    \
 	{                                                                                          \
-		check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC); \
+		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS))                                      \
+			check_access(ptr, bits / BITS_PER_BYTE,                                    \
+				     KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC);                    \
 		__atomic_store_n(ptr, v, memorder);                                                \
 	}                                                                                          \
 	EXPORT_SYMBOL(__tsan_atomic##bits##_store)
@@ -908,8 +911,10 @@ EXPORT_SYMBOL(__tsan_init);
 	u##bits __tsan_atomic##bits##_##op(u##bits *ptr, u##bits v, int memorder);                 \
 	u##bits __tsan_atomic##bits##_##op(u##bits *ptr, u##bits v, int memorder)                  \
 	{                                                                                          \
-		check_access(ptr, bits / BITS_PER_BYTE,                                            \
-			     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC);    \
+		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS))                                      \
+			check_access(ptr, bits / BITS_PER_BYTE,                                    \
+				     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
+					     KCSAN_ACCESS_ATOMIC);                                 \
 		return __atomic_##op##suffix(ptr, v, memorder);                                    \
 	}                                                                                          \
 	EXPORT_SYMBOL(__tsan_atomic##bits##_##op)
@@ -937,8 +942,10 @@ EXPORT_SYMBOL(__tsan_init);
 	int __tsan_atomic##bits##_compare_exchange_##strength(u##bits *ptr, u##bits *exp,          \
 							      u##bits val, int mo, int fail_mo)    \
 	{                                                                                          \
-		check_access(ptr, bits / BITS_PER_BYTE,                                            \
-			     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC);    \
+		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS))                                      \
+			check_access(ptr, bits / BITS_PER_BYTE,                                    \
+				     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
+					     KCSAN_ACCESS_ATOMIC);                                 \
 		return __atomic_compare_exchange_n(ptr, exp, val, weak, mo, fail_mo);              \
 	}                                                                                          \
 	EXPORT_SYMBOL(__tsan_atomic##bits##_compare_exchange_##strength)
@@ -949,8 +956,10 @@ EXPORT_SYMBOL(__tsan_init);
 	u##bits __tsan_atomic##bits##_compare_exchange_val(u##bits *ptr, u##bits exp, u##bits val, \
 							   int mo, int fail_mo)                    \
 	{                                                                                          \
-		check_access(ptr, bits / BITS_PER_BYTE,                                            \
-			     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC);    \
+		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS))                                      \
+			check_access(ptr, bits / BITS_PER_BYTE,                                    \
+				     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
+					     KCSAN_ACCESS_ATOMIC);                                 \
 		__atomic_compare_exchange_n(ptr, &exp, val, 0, mo, fail_mo);                       \
 		return exp;                                                                        \
 	}                                                                                          \
-- 
2.28.0.rc0.105.gf9edc3c819-goog

