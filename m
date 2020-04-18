Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0068BC38A2B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 03:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF75C21D94
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 03:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tsvxfJmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgDRDTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 23:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725991AbgDRDS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 23:18:59 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326EEC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 20:18:59 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id w14so3979713pfq.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 20:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3docRvuzttJC+Wkb9Bk065FrkPZtq4zMQ8pW4rPpfW0=;
        b=tsvxfJmTMqQagdYMcGxWaiaBVUv/Xj9MJWLW8Dkj2Rh+QyEZNG2meafwJo1YjCR9XR
         5kx/fQJl2afogVcJn5Fxz2Yyqo1pSLded1b4yj6BSbRR1X95xnMUj3NqcfpA+oTcmuck
         tSepuqs2CyUuCHzyjGJkqpQsPa9q+FIQrEEcEiqjfrxZw0D2zASxS1frtHURyy5tmApZ
         jhOTxK+GmZ1vc4ixnC/CjwFtdbHrQZQu2edc8kcXC+9dYUYgxU7QpnWG5zWylmT1HWaz
         I43ZoSfAC+4PqweU7MfKrkmONOwe8xum+hRW/iXwKhmNMNScqfk044TyaoabJvSyyda5
         Qf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3docRvuzttJC+Wkb9Bk065FrkPZtq4zMQ8pW4rPpfW0=;
        b=W3f7PP+fzYvrMcuWKKFu0wvJjOPk94kPTHclz6y9y0LEyoMhBbx/9kEpjAroL7Nhlc
         HpdLNxJ0sNxwabbBcIiRlHtLuBHXH7lDWZaBHE7IP4qNvseREbiZWm9r4EHU2Dd9tgak
         cezSY0WVk0SB3KI1fSVakxzB0sRCfDXhxhRFIdID8k6UEPR7GUVMxmekgSGyaOXOZiCD
         QFVfiXtIcqcYbd7ruhi7VUOENpOHlnb8Tyyzgi6f52hN8RaTzIwKSebtnEPvpUz34V/5
         Xg3a8AYxen+hBo9xfJ7sAxbZjkDTWN2MQNv1iptbyjIHnBVxVsHSVmXVBHBQi/2i1nvS
         9NbQ==
X-Gm-Message-State: AGi0PuZQ6umre5l2i/mpu/UFXaUVoHywAmqHnJMIMvtcPNQnfoWxGL+C
        Aiz20mLsvy5Muzb37VrpkvkkR/LTELHwmg==
X-Google-Smtp-Source: APiQypJ0AKcRxyISi/BREL+Gq9cGtfXhBaacb3y/m8Wu+YUwFvaWrTgT/CZZ/6bzqf8Z0LckGONfr57QZCTIUw==
X-Received: by 2002:a63:f64d:: with SMTP id u13mr6075605pgj.151.1587179938644;
 Fri, 17 Apr 2020 20:18:58 -0700 (PDT)
Date:   Fri, 17 Apr 2020 20:18:33 -0700
In-Reply-To: <20200418031833.234942-1-davidgow@google.com>
Message-Id: <20200418031833.234942-6-davidgow@google.com>
Mime-Version: 1.0
References: <20200418031833.234942-1-davidgow@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v6 5/5] mm: kasan: Do not panic if both panic_on_warn and
 kasan_multishot set
From:   David Gow <davidgow@google.com>
To:     trishalfonso@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
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
---
 mm/kasan/report.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 0c206bbf9cb3..79fe23bd4f60 100644
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
2.26.1.301.g55bc3eb7cb9-goog

