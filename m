Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65580C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 319ED20771
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v3lpyN+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgGUKad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 06:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgGUKad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:30:33 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E5AC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 03:30:33 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id u68so832505wmu.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 03:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PTq4pBrZslvVrftV71rNSLVaaKAAwjQ/mh+57cb51SY=;
        b=v3lpyN+v5uiSgtKl83T3bJDY0Dgu6WCaffNU5GUJwTq+G5OsfVU6qOuHzw859TpfUe
         A994HP607x7re+wDCAV0Y5FFVKbTZaRjaQsWRzYdfHuo/jJQv9l+Mwtkwu7yQGg4uHV0
         eq25QzEUFXWXO53AQVIDwdleYGfgbffrjVCoLcYrx1L8C7E+cQlZvNdI3G9ZN/RUwRjN
         ogkLuUeWDgkbszWbrbcu4ay3e1o5ZTWduDxzhwkEIZHDlOK6c3RIId/CWHgP9Qy74sO2
         TnYVqB+/5F7rVFGgJYEgLHF4X6AXGKs9mxbsBdc+d7X9nbLuSlia5Yq1AzKf3RkPyfDD
         311g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PTq4pBrZslvVrftV71rNSLVaaKAAwjQ/mh+57cb51SY=;
        b=echub7d7r7hwJFPtTNW2tRe4FVofpnN8T62mrTfFpUfIEDCAs+dBK90au7Rp1TZz4C
         NK+ly6mXGNQxAC3F0ApfgQ8PzkSElVuh9is9nqHrSf4zJYoyTYQZuLU/bjVfDYQYzHMF
         BhHXrNQHthTURSY9eMUbUDuG3bn24bs3BHFmVUQE+2burgB3vwPCS9rivRIh+1hHTHtz
         FyN8znM/nhzAfcsCtjFWGBgxsOdOCPwdFS2Jbuah7VmJQQ9p1tkC0JE0SfDP6gYB1v7c
         uMseTdYi5iKpGuG9a/j1xbRmgrGH6q8trPFzBWVKYNkJbJyZJBCQ+YgM+nm0l6o+aXZb
         5sHQ==
X-Gm-Message-State: AOAM533lUJFOg9xJD3x+WszguRo8jOFXnI8fWqc7pMYBGbNsmXKF1IkX
        Wzo8nu5E00/xXX1RGxk7rCIUpo3o9w==
X-Google-Smtp-Source: ABdhPJxpNlMs+cKmlZhsXDdcELP5hZqBFrXH0KSdu+z91oR4PxGPuvtmv/czs2p0r4bS4SA5PtNEnDu3LQ==
X-Received: by 2002:adf:b74b:: with SMTP id n11mr13648048wre.310.1595327430479;
 Tue, 21 Jul 2020 03:30:30 -0700 (PDT)
Date:   Tue, 21 Jul 2020 12:30:08 +0200
Message-Id: <20200721103016.3287832-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH 0/8] kcsan: Compound read-write instrumentation
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
 kernel/kcsan/core.c                           |  46 ++-
 kernel/kcsan/kcsan-test.c                     |  65 +++-
 kernel/kcsan/report.c                         |   4 +
 lib/Kconfig.kcsan                             |   5 +
 scripts/Makefile.kcsan                        |   2 +-
 scripts/atomic/gen-atomic-instrumented.sh     |  20 +-
 tools/objtool/check.c                         |   5 +
 13 files changed, 348 insertions(+), 218 deletions(-)

-- 
2.28.0.rc0.105.gf9edc3c819-goog

