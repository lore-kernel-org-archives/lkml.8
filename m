Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F45CC3404C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D0E24654
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xx3FHDhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgBTFP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 00:15:59 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34475 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgBTFP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 00:15:57 -0500
Received: by mail-oi1-f194.google.com with SMTP id l136so26347288oig.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 21:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vI7Ptj3tyiI6Bv9R/KxNJDPiLdqKFuHEWY4U42IkyNA=;
        b=Xx3FHDhVfLZEkroQaeX3VQq7Ab3/xB9qwIFvpQHqKhD3YRtcbu7ME1pEiRTe5EglhA
         9+xRZuuXJjIvODxi8ljQNn7EfcpMUj5s1dfUeCNazpZEKLitPFqVOWvn8gb6GaNcNSMu
         g45N4HO0etsz1s+K4dIUjwy1q0KsK+pjN5hhzgJMzouDldSUT8zIH0Mv6SGVuKy+hXII
         0SQWGrJ1e8m7Umil/IQLznTX5AvEwi8psnserhQMK5JfVcI1rz0+ZQ3AplZtJWAaNmYk
         dslrthV9NHe+qRO0LuwDJnX0uxJu8quxpjs/lzi4DX7HO+I5z7m3UxYaKJjwTEFzC2vo
         PF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vI7Ptj3tyiI6Bv9R/KxNJDPiLdqKFuHEWY4U42IkyNA=;
        b=hPEBYyQgoOJpgQMYVp+13wFHoEdlFXvkLdcWM7ZG+WddJfOnrD9VZjXZLy/jJm5Q1I
         qEeKlP5vkQeX0xv1j2m978CSyTj7Ae1UK81RbeDZTIKBYqWxVtRX7nvqieShS6KT5pIN
         VfEu9sia+G1HumOBtuKAs9jelGzrC2FaQrRlP84m2Z0XfIEiBVWTh1v3dnlZF/YIkpNh
         jCojZwg1zYLnii+FFjGjIXJd7aR0GkRy2ZNti1tLLiezB1SlIe7zHXOnPjH2rDfYUlvP
         aUna5Zaj4R79V4Z+y4kciD51/DRzwfBCebcSbFz8kqvdafXFFSDccLm9jZFw6PrS4c62
         2ttQ==
X-Gm-Message-State: APjAAAXbvf3zrt5QLeIWgZrGRYEcr1Z3k/XdPXeneOSxNfbPbgyQunEY
        66H/dKnM5oosKxavyOirbKo=
X-Google-Smtp-Source: APXvYqzLhYgiQPTpzyMusksg+32NvOyeip6pnteaQB8FdBhJwdu5dbcEm0EpZwfEdvYHwFQeEq5Pfw==
X-Received: by 2002:aca:4b0f:: with SMTP id y15mr786374oia.153.1582175755792;
        Wed, 19 Feb 2020 21:15:55 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id s12sm756411oic.31.2020.02.19.21.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 21:15:55 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2] mm: kmemleak: Use address-of operator on section symbols
Date:   Wed, 19 Feb 2020 22:15:51 -0700
Message-Id: <20200220051551.44000-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

These are not true arrays, they are linker defined symbols, which are
just addresses. Using the address of operator silences the warning and
does not change the resulting assembly with either clang/ld.lld or
gcc/ld (tested with diff + objdump -Dr).

Link: https://github.com/ClangBuiltLinux/linux/issues/895
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2: https://lore.kernel.org/lkml/20200219045423.54190-6-natechancellor@gmail.com/

* No longer a series because there is no prerequisite patch.
* Use address-of operator instead of casting to unsigned long.

 mm/kmemleak.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index aa6832432d6a..788dc5509539 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1952,7 +1952,7 @@ void __init kmemleak_init(void)
 	create_object((unsigned long)__bss_start, __bss_stop - __bss_start,
 		      KMEMLEAK_GREY, GFP_ATOMIC);
 	/* only register .data..ro_after_init if not within .data */
-	if (__start_ro_after_init < _sdata || __end_ro_after_init > _edata)
+	if (&__start_ro_after_init < &_sdata || &__end_ro_after_init > &_edata)
 		create_object((unsigned long)__start_ro_after_init,
 			      __end_ro_after_init - __start_ro_after_init,
 			      KMEMLEAK_GREY, GFP_ATOMIC);
-- 
2.25.1

