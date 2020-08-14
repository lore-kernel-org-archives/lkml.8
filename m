Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4ACC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C017120866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZgHPshRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgHNRae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbgHNR1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:27:47 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8585C061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:27:47 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id r12so6488801qvx.20
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=e2KGLRW+d0jj4Tv+MmRAX362NCHhZR9ltOsxskRbVvg=;
        b=ZgHPshRZ26bIOrhPnGktEcpoM4tZV4RKhQX3lqJKd1EpP9qvxqZkoQ//TjgMjABFsP
         X4gQzs7rYpoHS2j8HMRZztH46nKFN0f8FoOm4ob/a3l2ZAjbQkoVpjfH0/yaE8dhumd5
         0d8vZL/unnnvG/TDju1HNtgWXEaMJOg6eIp7UdcXay50olpfSsmyekAAVaugXR0dJeTn
         e6Hn3yxKQdUb8ljAVhNKjg3fW9gUk6qdz8mWkrgF8LJzugzhP7SbGwS52yR0QKSQjGte
         vQNf9bfUTgTroD3lX0ezS8EKcqrPggGHqoco7Cc/jgGCX2K7ESwOHrmo0C8LEp+z1fH/
         hmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e2KGLRW+d0jj4Tv+MmRAX362NCHhZR9ltOsxskRbVvg=;
        b=LNwsYJVUmb5ODz66h+i0y7YQFTrjzpm3VsaHd5OMMqEXhZ8b7AJy4sTpw6App3p8RS
         A+ZHJTLXOMj559djXK0hjh/ihbzttRXOshSWDX3lFsVelJ+382T4zm5AHW449LvZ3HXK
         /7APtG+V7/W1deL6/SeecAvjTEYqwn3Q03PekunwSPM5b81Z77Y17Df+t8140p+bSraE
         Wx6Ltl86YVePyNcm1+1KDybxsbNtrZzSTv1S2o7ZRh2qr2RQqlC3uDCLgz/vDt2rfqWC
         TdOb85immMbBrbIKai+EkI4TGoKNoKNd79SdvL8ohAAHwHWa48ibq9C92748BB5OsPrn
         WdqA==
X-Gm-Message-State: AOAM530z6InqtT0KiPTjH/BdOZJzZaOZE97k249LQu3fjDGC4zIAyoxb
        Vo5VBlI9uLMAzucNPYt3Jvq53CKqHBtzdrPI
X-Google-Smtp-Source: ABdhPJwvFCW71RrNBIBisU3qDI9g+D96gmQLmIYvDx+uRAkaisRTQSBeyenTGfi9SpAFmB/JOXIpogKSN0EeD35Y
X-Received: by 2002:a05:6214:1086:: with SMTP id o6mr3450750qvr.41.1597426066233;
 Fri, 14 Aug 2020 10:27:46 -0700 (PDT)
Date:   Fri, 14 Aug 2020 19:26:51 +0200
In-Reply-To: <cover.1597425745.git.andreyknvl@google.com>
Message-Id: <0197bbc0050e20ffdbf43eb8300af245c5c169db.1597425745.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH 09/35] kasan: don't duplicate config dependencies
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

Both KASAN_GENERIC and KASAN_SW_TAGS have common dependencies, move
those to KASAN.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/Kconfig.kasan | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index e1d55331b618..b4cf6c519d71 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -24,6 +24,9 @@ menuconfig KASAN
 		   (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)
 	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
 	depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
+	select SLUB_DEBUG if SLUB
+	select CONSTRUCTORS
+	select STACKDEPOT
 	help
 	  Enables KASAN (KernelAddressSANitizer) - runtime memory debugger,
 	  designed to find out-of-bounds accesses and use-after-free bugs.
@@ -46,10 +49,6 @@ choice
 config KASAN_GENERIC
 	bool "Generic mode"
 	depends on HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC
-	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
-	select SLUB_DEBUG if SLUB
-	select CONSTRUCTORS
-	select STACKDEPOT
 	help
 	  Enables generic KASAN mode.
 
@@ -70,10 +69,6 @@ config KASAN_GENERIC
 config KASAN_SW_TAGS
 	bool "Software tag-based mode"
 	depends on HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS
-	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
-	select SLUB_DEBUG if SLUB
-	select CONSTRUCTORS
-	select STACKDEPOT
 	help
 	  Enables software tag-based KASAN mode.
 
-- 
2.28.0.220.ged08abb693-goog

