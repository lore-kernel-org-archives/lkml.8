Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B483C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9C8220739
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWQyWe8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgGPXQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgGPXQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:16:22 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A9BC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 16:16:22 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id z63so7213523qkb.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 16:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tP4Cttrqlt778V4hKdyccGRNUrN6EWX/eaRs+bR7mIs=;
        b=NWQyWe8/Jw7d6xhMG5PKg5v53PMxsVJWfG+PDv5Jotk4MzwLRy4K3Sy1yzPHZU8CMW
         XEdpCxn2hdPlqAvgiN8XPBuZ0scL6517nlUpuFtFx6hfpkZjmENBY5CP7nZt2OnaUFB9
         g2Mkov4unQ62RvX8GGukI81uH5DCFdIjdZKVFWp+B5KgJjAg8ISxyoD6IgedElMOfFcX
         f/nLBWzwHJh3WjCOqNA9KTELvFxpLOL3ZB+iAzjD0w6rytZwxAFqC9+8SroXsS6F+hx7
         w0p1oHFxTFkTLHKAnSbuf7GCLDBjZ01Mz92pmTGAkYJ3tbU4n51aAF6Q7DSFzknheJfZ
         BTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tP4Cttrqlt778V4hKdyccGRNUrN6EWX/eaRs+bR7mIs=;
        b=nLTnd4/DqQxydzrtB6oQBwgBxM+OPOXcwauZLJTzj4p7KcqbtT47mZdMklmKJDDiGb
         X/lzyFL7Qom1WwZv9BFhQvwxBIfMq5pZVttJ2tU7PzLbkGuHSKZ5YEZ2wqQu3M1G7MXy
         ix1KSnKft9jecBFb1oTYmnZvYFidNc8HV0WTzg1ViQFtFAnphqvKy7ruIe/cNK8KoCqU
         FlUMQ6dKihvAVqYlbuhMl90B+Fq9tccgYU4MNaqWc6DfBSOPnCetIVgWGs4y6qOG3PDR
         imJIGTE7QNwMeh5sUtbAMnymqOO+I12whUSts/aVv7horhddIxpWvRESDiTNSIWSlKCf
         n1MA==
X-Gm-Message-State: AOAM530vuXY/cJSsACP6jhoZ6ZvupfgJUgGZ77uQlYE0wnxW1vSnRoJn
        aSvnEz0wY7buQwBR/YbCvSI=
X-Google-Smtp-Source: ABdhPJw32rZJoKjJL/Yf8r2h2VtaxwJOXWaEfSeoVPpf16lYne8NBhwRkmf91pbtkjlsHfegSAYjcA==
X-Received: by 2002:a05:620a:22a3:: with SMTP id p3mr6414774qkh.501.1594941381534;
        Thu, 16 Jul 2020 16:16:21 -0700 (PDT)
Received: from DESKTOP-JC0RTV5.neu.edu ([155.33.134.7])
        by smtp.gmail.com with ESMTPSA id y45sm9877577qtk.19.2020.07.16.16.16.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jul 2020 16:16:21 -0700 (PDT)
From:   Changming Liu <charley.ashbringer@gmail.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, rdunlap@infradead.org, keescook@chromium.org,
        mcgrof@kernel.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org,
        Changming Liu <charley.ashbringer@gmail.com>
Subject: [PATCH v3] panic: prevent panic_timeout * 1000 from overflow
Date:   Thu, 16 Jul 2020 19:15:53 -0400
Message-Id: <1594941353-13089-1-git-send-email-charley.ashbringer@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20200714025058.GZ12769@casper.infradead.org>
References: <20200714025058.GZ12769@casper.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since panic_timeout is an s32 integer passed in through sysctl, the
loop boundary panic_timeout * 1000 could overflow and result in
a zero-delay panic when panic_timeout is greater than INT_MAX/1000.

Fix this by elevating the precision of the loop boundary via 
assigning the result to a u64 integer, also in case the loop 
counter i might never be greater than u64 timeout = panic_timeout*1000,
elevate its precision to u64(timer) as well. The same applies to
timer_next replacing i_next which is initialized to 0.

Signed-off-by: Changming Liu <charley.ashbringer@gmail.com>
---
Changes in v3:
- change the loop in panic, instead of change the sysctl
- avoid using 64-bit division, doing 64-bit mult instead

 kernel/panic.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index e2157ca..ef6cd57 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -313,13 +313,16 @@ void panic(const char *fmt, ...)
 		 * Delay timeout seconds before rebooting the machine.
 		 * We can't use the "normal" timers since we just panicked.
 		 */
+		u64 timeout = panic_timeout * 1000ULL;	/* avoid overflow */
+		u64 timer, timer_next = 0;
+
 		pr_emerg("Rebooting in %d seconds..\n", panic_timeout);
 
-		for (i = 0; i < panic_timeout * 1000; i += PANIC_TIMER_STEP) {
+		for (timer = 0; timer < timeout; timer += PANIC_TIMER_STEP) {
 			touch_nmi_watchdog();
-			if (i >= i_next) {
-				i += panic_blink(state ^= 1);
-				i_next = i + 3600 / PANIC_BLINK_SPD;
+			if (timer >= timer_next) {
+				timer += panic_blink(state ^= 1);
+				timer_next = timer + 3600 / PANIC_BLINK_SPD;
 			}
 			mdelay(PANIC_TIMER_STEP);
 		}
-- 
2.7.4

