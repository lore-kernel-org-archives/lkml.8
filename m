Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098B7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D74F92078D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LuGw15Zk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgHNR2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbgHNR2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:28:31 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC466C061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:30 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id d9so6485986qvl.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Aq2upZC9S5Ys9XP2AH7I4ISIryYXBDc2x7o0GoeV4Tk=;
        b=LuGw15Zke5Ae/pDbTgYTpYfh2zw7zg1gh8rl6NeN4AGUiGtOgQrWlvhHdiP01WtjeF
         gPbZdiTHKtVlNBMURMqJKH70HLuFDCcyY7K63iFcHcfiTqAy72YPVXO2s7tj6WUdasie
         LSNN56Qt2JsZQI6RoEJ6bqi8ZSk+tbIUZAyB0NyWM5Q+cWE4kks5klNCVCuWUA2AwdED
         Iiogfds/x//LanybCwaVx43Gg8FX0gPl+FenU8VBpe3VwGcqyx6IKKwcLN4CjN2/b8lW
         ezTn1x2aDEYLo2sh3zAh2430UJfQVAECwvvHTa7cQAdEt7xYMD1jNBIJBb2Z5DxWQroL
         oNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Aq2upZC9S5Ys9XP2AH7I4ISIryYXBDc2x7o0GoeV4Tk=;
        b=daYM8q+A1pKUbEKazmDEb/58GpRuW4M8Q0IhKDpfNDZEzCtvLTFNr8BWnPVWo8z+1U
         8Ta3uaYRyXCOSukBUZMaqvetQbdZKXKE//dmz2H55AgDiq9XhbFsk9CIleQ08wnlLOV7
         S5c5Qm2pP4puAptyZU4VJTXCntBbWHpxIG92Az8tpqeIj6DlJyZ8sZl7cCJZTP7hYFQH
         nuspJqR0oxMxTHSZS7SkoS4+Xp9DubBuwTKSVghg7Rg9lBorFwja7FbZM6kReVdyumVQ
         ZXfk9aEQRDrSkRxjejKtF5Ud09I6jhJx9QiyRsqXYTlNmND2Ld4j5UTdF02l1uIaY+pJ
         NMzg==
X-Gm-Message-State: AOAM532Q0R+qYVQHcPkRa+zRl3JZbTOHDy9Kyxsek+j+SamTAAGxKKHc
        N4e8GJoTWupERy0dWtpRTWwbeU3HuR/7E1On
X-Google-Smtp-Source: ABdhPJztNAgwVlYKdx1N8aglSzF1FROrdQbV1VPur/Gdjkp6gFX4cRqk46lqcix5COecb/sqk/aIJq04YlccAYyo
X-Received: by 2002:a0c:e883:: with SMTP id b3mr3537357qvo.133.1597426109995;
 Fri, 14 Aug 2020 10:28:29 -0700 (PDT)
Date:   Fri, 14 Aug 2020 19:27:10 +0200
In-Reply-To: <cover.1597425745.git.andreyknvl@google.com>
Message-Id: <07455abaab13824579c1b8e50cc038cf8a0f3369.1597425745.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH 28/35] kasan: define KASAN_GRANULE_SIZE for HW_TAGS
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

Hardware tag-based KASAN has granules of MTE_GRANULE_SIZE. Define
KASAN_GRANULE_SIZE to MTE_GRANULE_SIZE for CONFIG_KASAN_HW_TAGS.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/kasan.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 1d3c7c6ce771..4d8e229f8e01 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -5,7 +5,13 @@
 #include <linux/kasan.h>
 #include <linux/stackdepot.h>
 
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 #define KASAN_GRANULE_SIZE	(1UL << KASAN_SHADOW_SCALE_SHIFT)
+#else
+#include <asm/mte.h>
+#define KASAN_GRANULE_SIZE	(MTE_GRANULE_SIZE)
+#endif
+
 #define KASAN_GRANULE_MASK	(KASAN_GRANULE_SIZE - 1)
 
 #define KASAN_TAG_KERNEL	0xFF /* native kernel pointers tag */
-- 
2.28.0.220.ged08abb693-goog

