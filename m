Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBABC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 142FE2074A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VmnqZ2EA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgGXHAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgGXHAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:00:23 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732ECC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 00:00:23 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id f14so1857125wrm.22
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 00:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nYhmgKcIIGxCsAi7Og+Yd3I+h1LrKRUSXiXnS3u5PnU=;
        b=VmnqZ2EAprygZLrhVFCDi1Q7n6PIAKLoT1x9Cs7iRuMS9jOciQw4aEchwk0UUJj/gw
         y57PDiIC8p+PXhimWgNMj9P6oIq9m3Zy7zJUxtFTEhP3eNPohY76S0hioVUMfGuGIlCO
         ywRo1uwLVvKZjpg14Khds/2WCEasTQy/V71ZaxJcybYQQeTglIFrfgeGdJawJTshRfMA
         lAKfjy7kNTAneGiNTkiyKuKrajor9Fc0cqJl+JXvUfmShF4AjflzwPA7/HqygLYj/Osc
         ro6YVGAxUZzX2cIlgbfc7vclHWfJCIRel0mSHx9ttd8IAWj6QMQNof8cxr1i2zKwPjMx
         92Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nYhmgKcIIGxCsAi7Og+Yd3I+h1LrKRUSXiXnS3u5PnU=;
        b=mA2EKTq6EzHmGSv8zDOVF/ywg2dhm7lJcrD4KU1UuEqeDIZEkHGcD0J+5AXIRDaw/C
         zL6YoI5VOwsEl/nEDs2qXBBpE/dN2DLoe2+Pz10kcHBlDP1yOi/JXi6jnBbmcu7mr+Ku
         iNxUWEOAO/otHHKd0kHZ0p3MKj/xtxFciOMyHECzpASn9v2MfxCxF8xUMX1TOj0y4zxL
         AcmbOhI2p07kil1NwPjlT4iPHbBShwx0gby7dHp+6Wkpet2PHcBKUTJ8zfEKyHjFpQhs
         j/Y+MIdwbDCrbv3wXFwiT1UdaIjeBfmAIj3xIofwyB2am+1IkXTVRzOghIjjqebnslhE
         MKOw==
X-Gm-Message-State: AOAM531ODBW0DML11doV6gtxjfG2nZIer1a+fJsRYxco7JoaEPrOo8uA
        L8jrHhusizEcM59UeJ6mOHH0jxVuag==
X-Google-Smtp-Source: ABdhPJwyFtmvu9bRVNtMmlRK6Q0X/qg/iAtZTfSgzPG7LzT+yt9euH/Zilz9OA5fKWTwtXmakhuSPXqthA==
X-Received: by 2002:a7b:c4d3:: with SMTP id g19mr939521wmk.29.1595574022053;
 Fri, 24 Jul 2020 00:00:22 -0700 (PDT)
Date:   Fri, 24 Jul 2020 09:00:00 +0200
Message-Id: <20200724070008.1389205-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v2 0/8] kcsan: Compound read-write instrumentation
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     will@kernel.org, peterz@infradead.org, arnd@arndb.de,
        mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for enabling compounded read-write
instrumentation, if supported by the compiler (Clang 12 will be the
first compiler to support the feature). The new instrumentation is
emitted for sets of memory accesses in the same basic block to the same
address with at least one read appearing before a write. These typically
result from compound operations such as ++, --, +=, -=, |=, &=, etc. but
also equivalent forms such as "var = var + 1".

We can then benefit from improved performance (fewer instrumentation
calls) and better reporting for such accesses. In addition, existing
explicit instrumentation via instrumented.h was updated to use explicit
read-write instrumentation where appropriate, so we can also benefit
from the better report generation.

v2:
* Fix CC_HAS_TSAN_COMPOUND_READ_BEFORE_WRITE: s/--param -tsan/--param tsan/
* Add some {} for readability.
* Rewrite commit message of 'kcsan: Skew delay to be longer for certain
  access types'.
* Update comment for gen-atomic-instrumented.sh.

Marco Elver (8):
  kcsan: Support compounded read-write instrumentation
  objtool, kcsan: Add __tsan_read_write to uaccess whitelist
  kcsan: Skew delay to be longer for certain access types
  kcsan: Add missing CONFIG_KCSAN_IGNORE_ATOMICS checks
  kcsan: Test support for compound instrumentation
  instrumented.h: Introduce read-write instrumentation hooks
  asm-generic/bitops: Use instrument_read_write() where appropriate
  locking/atomics: Use read-write instrumentation for atomic RMWs

 include/asm-generic/atomic-instrumented.h     | 330 +++++++++---------
 .../asm-generic/bitops/instrumented-atomic.h  |   6 +-
 .../asm-generic/bitops/instrumented-lock.h    |   2 +-
 .../bitops/instrumented-non-atomic.h          |   6 +-
 include/linux/instrumented.h                  |  30 ++
 include/linux/kcsan-checks.h                  |  45 ++-
 kernel/kcsan/core.c                           |  51 ++-
 kernel/kcsan/kcsan-test.c                     |  65 +++-
 kernel/kcsan/report.c                         |   4 +
 lib/Kconfig.kcsan                             |   5 +
 scripts/Makefile.kcsan                        |   2 +-
 scripts/atomic/gen-atomic-instrumented.sh     |  21 +-
 tools/objtool/check.c                         |   5 +
 13 files changed, 354 insertions(+), 218 deletions(-)

-- 
2.28.0.rc0.142.g3c755180ce-goog

