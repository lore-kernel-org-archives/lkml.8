Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495B2C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2660220721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YM6yTs41"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgEULKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 07:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729084AbgEULKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 07:10:01 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554B1C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 04:10:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d7so4890751ybp.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 04:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=maeQQXffB2UguUhgEnnewdiQJy0yPCx7FVOuZ5TWJ5k=;
        b=YM6yTs41M64rlxp3Icmd/f607+aA3s2rrYqipArr3qXRMeEgF5VKYwm89HTr68H+0a
         7sPYBdkTfTsb679x/SQszIG0GNyr4q3mBcY3wQ2qVjJJDqbJ8gpPElSxIQfbdIL+vNSy
         zrey6KtFkx/+78+5Arf83emIm//qJC6jwZyWSFUokHYh5nh6IeDb8t5VKKYOD4N/GaYI
         fLQ3hRpEZyZutK5v/cH9Q06xRWPDfAQguVQNJj1ghAfdOj4Z4UG3wSg1h73RXPb674Q3
         nqZGDmzLOcrh75aBNsT3jAfSbtZd6ay7zotwBtis9oVmjXijl6Vs3kO3Qcxy1ZeR8+t8
         R3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=maeQQXffB2UguUhgEnnewdiQJy0yPCx7FVOuZ5TWJ5k=;
        b=RS/vWaOH1aqF6ZWejs1jTgDHAK3t/PpfLZUTRAWAOcM4zx6QSU+Pe4Erld9UIvdd96
         iaD0t+iPWJfp0dLzGvo42AfZZx30t8WCuiLjO9iVaqUhO8O6uccoi+CyDXqSPBARYZyy
         eTJ1swalMKrlbplCXK631WHHyLw9M2/lz2HRdz+i0ZqWMQ+PYpY3C3tBR5lLxwmORFJI
         ex+fTZZb+0ssynZEYXgtEpzQjMJun8JSE7axl3LdAtQsOn/IPEDPtLQQFtC7OYMTRI3q
         R8aduJzllbBLSEwq+12ptIlGBi8DoxKR6uSBJPGwgCndxOoIsTmCb63hFTg8/JykoZbM
         Hsxw==
X-Gm-Message-State: AOAM530ZiG/yoItUYhNLa5Z0RTq/l3Tm9rpfPC4uqJ3rQdTVtt/LmBcr
        ApMQsnlIRHEnAR1cRyt5PcNiAuboSA==
X-Google-Smtp-Source: ABdhPJw7I/jqWVrYgyoHZn+Dhh5CftKhAGfvG9IOI7lBomWxfH3oBEGL2BowsjtJYGUVXdfuKPVnLMGjNg==
X-Received: by 2002:a25:9010:: with SMTP id s16mr1833681ybl.2.1590059399495;
 Thu, 21 May 2020 04:09:59 -0700 (PDT)
Date:   Thu, 21 May 2020 13:08:47 +0200
In-Reply-To: <20200521110854.114437-1-elver@google.com>
Message-Id: <20200521110854.114437-5-elver@google.com>
Mime-Version: 1.0
References: <20200521110854.114437-1-elver@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH -tip v2 04/11] kcsan: Pass option tsan-instrument-read-before-write
 to Clang
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, will@kernel.org,
        clang-built-linux@googlegroups.com, bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang (unlike GCC) removes reads before writes with matching addresses
in the same basic block. This is an optimization for TSAN, since writes
will always cause conflict if the preceding read would have.

However, for KCSAN we cannot rely on this option, because we apply
several special rules to writes, in particular when the
KCSAN_ASSUME_PLAIN_WRITES_ATOMIC option is selected. To avoid missing
potential data races, pass the -tsan-instrument-read-before-write option
to Clang if it is available [1].

[1] https://github.com/llvm/llvm-project/commit/151ed6aa38a3ec6c01973b35f684586b6e1c0f7e

Signed-off-by: Marco Elver <elver@google.com>
---
 scripts/Makefile.kcsan | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/Makefile.kcsan b/scripts/Makefile.kcsan
index 75d2942b9437..bd4da1af5953 100644
--- a/scripts/Makefile.kcsan
+++ b/scripts/Makefile.kcsan
@@ -13,6 +13,7 @@ endif
 # of some options does not break KCSAN nor causes false positive reports.
 CFLAGS_KCSAN := -fsanitize=thread \
 	$(call cc-option,$(call cc-param,tsan-instrument-func-entry-exit=0) -fno-optimize-sibling-calls) \
+	$(call cc-option,$(call cc-param,tsan-instrument-read-before-write=1)) \
 	$(call cc-param,tsan-distinguish-volatile=1)
 
 endif # CONFIG_KCSAN
-- 
2.26.2.761.g0e0b3e54be-goog

