Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCABC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 13:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AB0D21744
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 13:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vMkS12gy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732188AbgGaNUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 09:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730237AbgGaNUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 09:20:51 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316F6C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 06:20:51 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id m88so20841678qtd.15
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 06:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7/8tDu/TtZiPY9Lz5Bah3CGmQqypIOKTi+NtrfkKjDo=;
        b=vMkS12gygK9Xw4P59Fiv7cJwMrQ93BAaPBfBmGcNEx8scxjx4xBNY0Z5DJ/MBB2Dea
         L7zKRyke2NzvjTjHxlHQbN85nIRxs5CHI87zMSEmmNQiVmQkHyhaX/hbc7wGEK+nfJIc
         4ruGtxbCA5Q2Ev46/ow53zwWU+GzhAwIjg0Diz8dUxu7/dO96xBO/Vv4wERXaU6/qrCw
         dnxj4xVQAz45mjjpA0AZpQn6BV/wHEqi/ERr3LRP6/MaeFMwjaedG5rpY0lexD7F8hnf
         i8cjmd60gSMZNIGPQaWiArhxrfzwKRNlkGDLAGK3TMw8AWcD8FYFH+0FtQvEOlLp4iw+
         teWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7/8tDu/TtZiPY9Lz5Bah3CGmQqypIOKTi+NtrfkKjDo=;
        b=ozI1pe+2e6nQqwKwIbFam3ImexlLPmcbmwPz1Eeo+8+KhQS/AvR+FyL9eMwPfuFahg
         TzGMATqowZdUknOA4g+4LvqWx5N4OL/beoBgSdxcyJY8MfExKfrj2jK6mkdt2JWUQ37V
         jNH3lovKePXiyDSslG+jVuSYkZCr9wvKDT0WsoIikcAnSKlJc4VoFRoSGsuGZJOWSI4g
         /5PzwsUe2BlA1GDI45Zys7iuQ6/VpcMj+LAPj1ijdhwKt1625wrvumn8e3I23w48a6Z0
         v4iniBgrHWpmaEobB2zB/B5cOcNPHwYXwuubAMl+x58xFRsPBfjl6cGTVYq7eT7NNucd
         e1XQ==
X-Gm-Message-State: AOAM530+5gkuVhsm8fPTL6TJ673EG31q3traRsvwdHVfzqDfQrP2rgP2
        tZlBWf/4d91WPhj23lRn7y7QGEUmarQJrTqW
X-Google-Smtp-Source: ABdhPJy0gFHxEV1wl3Dbk7iuuzjXYNMyl9SjuV393XieuyfYdL8dFly/mgEhwyU1lEQZm5ZAPI9gCpXCyeUDp9Ll
X-Received: by 2002:a0c:ab16:: with SMTP id h22mr4018288qvb.72.1596201649557;
 Fri, 31 Jul 2020 06:20:49 -0700 (PDT)
Date:   Fri, 31 Jul 2020 15:20:37 +0200
Message-Id: <cover.1596199677.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH 0/4] kasan: support stack instrumentation for tag-based mode
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Elena Petrova <lenaptr@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This goes on top of Walter's patch titled "kasan: fix KASAN unit tests
for tag-based KASAN" (already in mm tree).

Bugzilla link: https://bugzilla.kernel.org/show_bug.cgi?id=203497

Thanks to Walter Wu for debugging and testing.

Andrey Konovalov (4):
  kasan: don't tag stacks allocated with pagealloc
  kasan, arm64: don't instrument functions that enable kasan
  kasan: allow enabling stack tagging for tag-based mode
  kasan: adjust kasan_stack_oob for tag-based mode

 arch/arm64/kernel/setup.c | 2 +-
 init/main.c               | 2 +-
 kernel/fork.c             | 3 ++-
 lib/test_kasan.c          | 2 +-
 scripts/Makefile.kasan    | 3 ++-
 5 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.28.0.163.g6104cc2f0b6-goog

