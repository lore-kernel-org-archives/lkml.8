Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A71BC2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 06:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72EE720700
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 06:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ChzEHTsG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgDXGOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 02:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726565AbgDXGOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 02:14:08 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7278C09B045
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 23:14:07 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id a6so7879651pfg.18
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 23:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ktlf9QISDdPRX1uK01ka9sL/IDfKnusqL4DRjBWXu7E=;
        b=ChzEHTsGqPRuCDwBSqzePHzbU3gd0vJ/obMVlNCqmZP6Bx9+LTIISm27bGINFK3ST6
         U6egrTXZiDrcvjehCTkYlvCU6d9nsry4pNfwODvaALAVcnhYTx5axmEwIuK/GPq9Cfz8
         UGfCyjVxVimTBu17eikwQb58W7KS5lsJoXPexDu9e8s4Peg0P3t/ZQHkcwab7oi7yoTM
         GLC50li+VxxNldpiZ2gmUfvc0iPOMQFq5Mp4IFhOcF+8qx+5jUNTDO2ek2PqzLQnG6bg
         7HreaMnVbHJmtsy4iqk8Nnut8zz6Smp6nnpdPPhjNz3hvUT561nE2fr4u5OMGoXJ/3kc
         XalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ktlf9QISDdPRX1uK01ka9sL/IDfKnusqL4DRjBWXu7E=;
        b=rUsiLTT2iN0l+S4aYFB1Kn4XOjh4ty3ZyODR3mHrFDOtHIPb65nFec0+XNIRN0Xukf
         XzaGytBm2rtQJkngqKHSIPKvPouPJ+iujFv9QnCgtdn+vMowxtvaPTHWk6VAu9bhVIwH
         jU6B8cB6N8eCPbIlxXY4CXIMQBnIeZRpvFlZC12/1pezsVAoae5ZRbqqcDB6o8i+vntB
         F9Xc86PnP6ncHT/5nPCoyUPqmSpbZZo18xf0/Hya57BX3ERI5rbUvzKfeZPzs6VICngT
         38hp22mLD+x9H0tW0MbgtZpJbtn+bMek7fD1TXA/igZnMxYdzvYQiynYylSNFC36u48e
         kHuQ==
X-Gm-Message-State: AGi0PuYVoA/rzxRZaiN2ALrR6b1W810hFHxE39lbS98U17m3k6y1T1L+
        Jr4SmXbsD7xxar8G8CjqvChV+tHEk/dz/Q==
X-Google-Smtp-Source: APiQypKOtuNJXwpmMrdTnwPQuAL+4H1Nq1T3AV8w+3m+0jNCAItOLBXkSV8iB3V7g9qIPYAGCP41cMK+FN/X1w==
X-Received: by 2002:a17:90a:ba88:: with SMTP id t8mr4757997pjr.182.1587708847422;
 Thu, 23 Apr 2020 23:14:07 -0700 (PDT)
Date:   Thu, 23 Apr 2020 23:13:42 -0700
In-Reply-To: <20200424061342.212535-1-davidgow@google.com>
Message-Id: <20200424061342.212535-6-davidgow@google.com>
Mime-Version: 1.0
References: <20200424061342.212535-1-davidgow@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v7 5/5] mm: kasan: Do not panic if both panic_on_warn and
 kasan_multishot set
From:   David Gow <davidgow@google.com>
To:     trishalfonso@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
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
2.26.2.303.gf8c07b1a785-goog

