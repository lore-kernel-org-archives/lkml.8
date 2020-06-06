Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B34EC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 04:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 042FC20723
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 04:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YHJ+OxXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgFFEEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 00:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbgFFEEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 00:04:06 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58B8C08C5C3
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 21:04:04 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s90so14280134ybi.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 21:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Bno6lpmXJK51n5a5Nx8tNY64fz3MIJ1lkOtErirSr6A=;
        b=YHJ+OxXkKPDeM+7ELMewnwd+Ffd3T7tSXxbbkvE9Wj7weFnG3Q8LKA8LUT6tXC6f/p
         sIbOnONsYBskP1Y3SPq2vQzpvPJEUP7+B1ZmGjvQSssiGqqjj5HDdRcFvZ2ybIK9yWf/
         j6j+GMKsYKIw3LH4dk2PCMfZxUdt8GXgai1P/MTj0v2UoF/gav8ycpZBleH2wMzxIfyc
         Y0V54/Ag7MMP61uxDwq4z3o6dkh9u5457FPbAcgHRve6KHb0x3bDwJjxvxYNIyQxV+wK
         fCUxURx9kmWQWcwPOAjcLTShq1EL1uQoIYCXlGem4xyMNw85p0u6XL/OzfNBBbBQsg0c
         I2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Bno6lpmXJK51n5a5Nx8tNY64fz3MIJ1lkOtErirSr6A=;
        b=fXDTsxcDlV+gcw2QDszbzEaqQviMuRYwOj2UEFRrmRdfbD89N0cUPkE4og2V9PWAZu
         UbQEizMExv/DTEjK9u+S0gAYGUj4mGnZ6QwwVsUweSFHQ8/wEjCLfMuLfPXwB3Bjc/jO
         IqTkvtbF2BN/oWqPSWL2WceQiqA5+52UBz34wVn9A8X50sr4twqOSheeobGVRbMfjATA
         o0yIMVunjtQIQO4+Rcb06aklZCziaZ31+O7lhfLKgOrZLQcE+Uxn0cXe2rUDyjZiJtym
         M5xo8UneoTSYLCOJgzBMbabiBDRA1JyLng2nD93U5FDz2cZilkXtM7UGhpENgMnmscOw
         gWGg==
X-Gm-Message-State: AOAM531nB29EHYcWiIsDkGjHVVUA6Yyzt/03BR/iSCV/cPiS9Wxi2pdA
        VQN4oCHntQYCFBTrXL4wbYF2La4bgZMwAg==
X-Google-Smtp-Source: ABdhPJxlU491uKsxwRao6XvYxlOdKzykd3Y4Y+nbo1iQnitptU5xhr1Ml21x6KURK0uGhshDvIETBl7GDDZr/A==
X-Received: by 2002:a5b:785:: with SMTP id b5mr20722587ybq.96.1591416244078;
 Fri, 05 Jun 2020 21:04:04 -0700 (PDT)
Date:   Fri,  5 Jun 2020 21:03:49 -0700
In-Reply-To: <20200606040349.246780-1-davidgow@google.com>
Message-Id: <20200606040349.246780-6-davidgow@google.com>
Mime-Version: 1.0
References: <20200606040349.246780-1-davidgow@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH v8 5/5] mm: kasan: Do not panic if both panic_on_warn and
 kasan_multishot set
From:   David Gow <davidgow@google.com>
To:     trishalfonso@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, andreyknvl@google.com, shuah@kernel.org
Cc:     David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN errors will currently trigger a panic when panic_on_warn is set.
This renders kasan_multishot useless, as further KASAN errors won't be
reported if the kernel has already paniced. By making kasan_multishot
disable this behaviour for KASAN errors, we can still have the benefits
of panic_on_warn for non-KASAN warnings, yet be able to use
kasan_multishot.

This is particularly important when running KASAN tests, which need to
trigger multiple KASAN errors: previously these would panic the system
if panic_on_warn was set, now they can run (and will panic the system
should non-KASAN warnings show up).

Signed-off-by: David Gow <davidgow@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/report.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 45f3c23f54cb..dc9fc5c09ea3 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -94,7 +94,7 @@ static void end_report(unsigned long *flags)
 	pr_err("==================================================================\n");
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 	spin_unlock_irqrestore(&report_lock, *flags);
-	if (panic_on_warn) {
+	if (panic_on_warn && !test_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags)) {
 		/*
 		 * This thread may hit another WARN() in the panic path.
 		 * Resetting this prevents additional WARN() from panicking the
-- 
2.27.0.278.ge193c7cf3a9-goog

