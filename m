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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6B2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DE4220829
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DrFj49N6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgHNRaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728646AbgHNR16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:27:58 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28521C061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:27:58 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id c202so6488678qkg.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uzelTOrZuAbTWnllhx2uagoa2R4S00LwGFOB2texzaA=;
        b=DrFj49N6R4eCrQJphz6+ETLQSN0RvuR+8g3jRWO5Kv9Cu3h0thzUUGYLi70G7SUsL+
         kk40BvPcKjV4y5B+tEwCs0wOVQz3Qo6Srdv07PKEjyECoSiZoRIroE761xkoNWipUcMN
         roNpIlNYf89LDQz/ZqjUGEJZHvbnTtlRJ0+MUIuDazMnwFSw53XRUzj07eRKXWAfZijn
         dzNZO8q+k/fcomM5fZfG+FEMWYRiHVBFBoFFEBTlaayDyg+1daA7M4MSqNiq+43cjUm2
         g1oHg4iWrX+S5n5/Ax9bx6fOL4mospA1TbRF8FPjvTbwcC/rp93zDPO8bpBJknFheRvr
         RkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uzelTOrZuAbTWnllhx2uagoa2R4S00LwGFOB2texzaA=;
        b=UnQxbLuIkrDTicDQSuS9I2zZGhuUtF9zF8hRZ1JtCl8ESxSvtaTQqN3QgxB7mRNcDx
         kZz/YFDVMnjk140V06lKMR9SitbG6J2xFITmtWWnEr9J/TuZh/621QB+uoyJ6o66CP3/
         DKIq53ggJXdXbYCI6MgPRcsHtDVG6lSKeoRXPFP2kd1mgO31GialaBg0EtVeQi9DuGW9
         XYHV1FfC4G9kz9F9jetJlOlXi/q3Hk5dk/8Yjg5dV9VDTOwPpDHgRrXUNWeHYsa1uX13
         1RNFArcV9ATUipi+1CjFOD755sAtZsLJOiMJ5Nzu8BC9nyEliluUD2wxos7nEAeVScGY
         yo4g==
X-Gm-Message-State: AOAM531xZHPjzKBRPIqEl7a3qH8YcMpknkUU7W24catJqwt3AdRZitZ3
        ++75XO6bEFz9DBXje+fqY27ToRVXMVygXBnZ
X-Google-Smtp-Source: ABdhPJx9kLUufXWadY2TxpJl/SQvQjOV7v/3wKY2MxvbtkT8yluKpe6HFl7wJbjM0gRLHD3MjV79RqnFtPzqoG66
X-Received: by 2002:a05:6214:8a:: with SMTP id n10mr3654847qvr.13.1597426077265;
 Fri, 14 Aug 2020 10:27:57 -0700 (PDT)
Date:   Fri, 14 Aug 2020 19:26:56 +0200
In-Reply-To: <cover.1597425745.git.andreyknvl@google.com>
Message-Id: <82cf4f8007645f8c45e6e4847a28a743dfb9cbda.1597425745.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH 14/35] kasan: rename addr_has_shadow to addr_has_metadata
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

This is a preparatory commit for the upcoming addition of a new hardware
tag-based (MTE-based) KASAN mode.

Hardware tag-based KASAN won't be using shadow memory, but will reuse
this function. Rename "shadow" to implementation-neutral "metadata".

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/kasan.h          | 2 +-
 mm/kasan/report.c         | 6 +++---
 mm/kasan/report_generic.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 15cf3e0018ae..38fa4c202e9a 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -145,7 +145,7 @@ static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
 		<< KASAN_SHADOW_SCALE_SHIFT);
 }
 
-static inline bool addr_has_shadow(const void *addr)
+static inline bool addr_has_metadata(const void *addr)
 {
 	return (addr >= kasan_shadow_to_mem((void *)KASAN_SHADOW_START));
 }
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 8463e35b489f..ada3cfb43764 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -334,7 +334,7 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
 	untagged_addr = reset_tag(tagged_addr);
 
 	info.access_addr = tagged_addr;
-	if (addr_has_shadow(untagged_addr))
+	if (addr_has_metadata(untagged_addr))
 		info.first_bad_addr = find_first_bad_addr(tagged_addr, size);
 	else
 		info.first_bad_addr = untagged_addr;
@@ -345,11 +345,11 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
 	start_report(&flags);
 
 	print_error_description(&info);
-	if (addr_has_shadow(untagged_addr))
+	if (addr_has_metadata(untagged_addr))
 		print_tags(get_tag(tagged_addr), info.first_bad_addr);
 	pr_err("\n");
 
-	if (addr_has_shadow(untagged_addr)) {
+	if (addr_has_metadata(untagged_addr)) {
 		print_address_description(untagged_addr, get_tag(tagged_addr));
 		pr_err("\n");
 		print_shadow_for_address(info.first_bad_addr);
diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
index 427f4ac80cca..29d30fae9421 100644
--- a/mm/kasan/report_generic.c
+++ b/mm/kasan/report_generic.c
@@ -122,7 +122,7 @@ const char *get_bug_type(struct kasan_access_info *info)
 	if (info->access_addr + info->access_size < info->access_addr)
 		return "out-of-bounds";
 
-	if (addr_has_shadow(info->access_addr))
+	if (addr_has_metadata(info->access_addr))
 		return get_shadow_bug_type(info);
 	return get_wild_bug_type(info);
 }
-- 
2.28.0.220.ged08abb693-goog

