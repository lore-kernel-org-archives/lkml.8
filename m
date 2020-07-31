Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16F1C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 04:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DF8E2072A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 04:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nM1Ko5uZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbgGaEnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 00:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730173AbgGaEnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 00:43:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B120AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 21:43:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l15so3247897ybq.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 21:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=85loYESi4Z2DrhOdMAtj0xQZzuVg3GU4Cjv9w5JgQ2w=;
        b=nM1Ko5uZ5PaKCYqDU0NYwRa4XHN/6iUAMZ4+j+5QaGXLZRxZwQZf5LEc6+kAM2Psif
         aodCaQs23B9t2l+OM4rJPukl1RwNcw1W5Z63j+BtuCBi1z133KYzKXAIzaZxLahvPr3L
         yUM8scgAEetSOoLmpfNqgC84H5UNnXcbpyEDCXcn4m8Qm4ILVxIjN+UZ0g2dJ3tLYGLY
         qFxDMKpr1Ptj79QIrsIDfo3M+sPsG/MvaX5sKtmgq9/PKyCZ7tXezJVqPQKIv4JatMs+
         HEg2sgK/k5nGTU9KYSLCTZ21qWL94+72ZAsuoliRVTEiHEN2rWosgclnu6AHJK80/hkA
         5IFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=85loYESi4Z2DrhOdMAtj0xQZzuVg3GU4Cjv9w5JgQ2w=;
        b=QIn2dfoDdl2M38ukjwtQDOp5WbK3P52uW+Q9rxSZ1rogG5LENK2QC46iix3uMj1Xlx
         yNL7GlPPshsxfBBPkkGXA3kWbqxK/ekq+226sCxSHhhMVjpk6v6GlqBwkSL6ScHFdHN1
         ei1T9uHMPyhfCy1tPOno3tLR5Mx6dlt5YFMM8UrAq321DFJu4QpOEQ8tfe3ZlioZuO+r
         uIm7FVyGsqajWxbL5hz7yiNrq1vSqr6KnS3BT0/kkeihY2pKmRx7nMIjnFflMR/t0uAS
         aqpKqrKQzcAvQUbSSurpmgIxOuFxMGPnQht1UZGGqPENxmisdltQVttqhWSnIL6oHlia
         ehgQ==
X-Gm-Message-State: AOAM530h9M9x3BN9Nk6CaylOfLelftrUFbLwX0wcCHv1fS8pjx0G4D2h
        eK/IO/d1t8Q/j/lyu+7dwJceglHpWR+SOA==
X-Google-Smtp-Source: ABdhPJyP/mw67ayLNhKdDi8CnTcyvIx5quWF1/mZZvx61no3lP/ey5ookrMRZRyPQjQoDCQPjTLmvbv8g27ITw==
X-Received: by 2002:a25:e5c3:: with SMTP id c186mr3565894ybh.332.1596170589932;
 Thu, 30 Jul 2020 21:43:09 -0700 (PDT)
Date:   Thu, 30 Jul 2020 21:42:42 -0700
In-Reply-To: <20200731044242.1323143-1-davidgow@google.com>
Message-Id: <20200731044242.1323143-6-davidgow@google.com>
Mime-Version: 1.0
References: <20200731044242.1323143-1-davidgow@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v9 5/5] mm: kasan: Do not panic if both panic_on_warn and
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
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 mm/kasan/report.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 90a1348c8b81..c83d6fde9ee4 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -95,7 +95,7 @@ static void end_report(unsigned long *flags)
 	pr_err("==================================================================\n");
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 	spin_unlock_irqrestore(&report_lock, *flags);
-	if (panic_on_warn) {
+	if (panic_on_warn && !test_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags)) {
 		/*
 		 * This thread may hit another WARN() in the panic path.
 		 * Resetting this prevents additional WARN() from panicking the
-- 
2.28.0.163.g6104cc2f0b6-goog

