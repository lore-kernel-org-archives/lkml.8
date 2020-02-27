Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EB5C35E17
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E405024691
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GqYMFX/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbgB0Tfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:35:33 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:50449 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbgB0Tf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 14:35:27 -0500
Received: by mail-pj1-f68.google.com with SMTP id r67so223234pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 11:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AoE4OLd/IvDA6cmd9pXDgHl19RWwO6y4VAoz5pE6b4E=;
        b=GqYMFX/utzgItiW5PidQ11FE+lHI8vpi1sL09gpDitITyGvoCdgVofeyaea3HY9ipQ
         kI+V9aywVW0+oZ0T24u4PDmPMEExxMztSr66kCLpV0ML6Fdn0mDsyT0Mh3zdLeUDarW0
         cp8p5I5qVxBR8ULIBUY4ZLMoXbzGtmBCuNhWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AoE4OLd/IvDA6cmd9pXDgHl19RWwO6y4VAoz5pE6b4E=;
        b=Ky8xXnvDHjYFHDOlqGFeRTT2gU8ljJvj1ioKslFZSmNg4v7pJeIJXRQYUvlbzVygtD
         FyPRalCShukfUNNxeB+ton9gUutg0gO054pSgeTwBX46f1Mwi9nckBlJwt+fsq1uXWzH
         bUjHz/OW7JlrebHODCCW3Swhjfl3R/DvO/guS0Gie6I/KQSXkEzBJVh9F3igv6ShYd3S
         zF7Q98k0xGnSp9CP4Ztnk/DpNkR1n+rIcFZTDGvzkT2pBW1i8chCfY+0Lmd4RxP4+7LR
         c58YmA2OjprgC+023iSwanRtiS5xiOgTVaJrC5eYzjvbpTONySnWFeXd2V6vr8nkziBq
         ODEw==
X-Gm-Message-State: APjAAAVVZ300ZJyDvQt4uWTDZSU2x0dce6jCNkWbUmdXqNhaeKCtaqfb
        yKEKGv9qVmG1xEo72gyfVLL+8w==
X-Google-Smtp-Source: APXvYqyHH1OhEaAU0M9XGqSIh9GqdH9ygv+RYA1KOJ+P5VFzMpUGg9ipEsHxlmsPcfBpV6cJtwqGHg==
X-Received: by 2002:a17:90b:8ce:: with SMTP id ds14mr584791pjb.70.1582832124805;
        Thu, 27 Feb 2020 11:35:24 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e17sm8348002pfm.12.2020.02.27.11.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 11:35:20 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        syzkaller@googlegroups.com
Subject: [PATCH v5 0/6] ubsan: Split out bounds checker
Date:   Thu, 27 Feb 2020 11:35:10 -0800
Message-Id: <20200227193516.32566-1-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Argh, v4 missed uncommitted changes. v5 brown paper bag release! :)

This splits out the bounds checker so it can be individually used. This
is enabled in Android and hopefully for syzbot. Includes LKDTM tests for
behavioral corner-cases (beyond just the bounds checker), and adjusts
ubsan and kasan slightly for correct panic handling.

-Kees

v5:
 - _actually_ use hyphenated bug class names (andreyknvl)
v4: https://lore.kernel.org/lkml/20200227184921.30215-1-keescook@chromium.org
v3: https://lore.kernel.org/lkml/20200116012321.26254-1-keescook@chromium.org
v2: https://lore.kernel.org/lkml/20191121181519.28637-1-keescook@chromium.org
v1: https://lore.kernel.org/lkml/20191120010636.27368-1-keescook@chromium.org


Kees Cook (6):
  ubsan: Add trap instrumentation option
  ubsan: Split "bounds" checker from other options
  lkdtm/bugs: Add arithmetic overflow and array bounds checks
  ubsan: Check panic_on_warn
  kasan: Unset panic_on_warn before calling panic()
  ubsan: Include bug type in report header

 drivers/misc/lkdtm/bugs.c  | 75 ++++++++++++++++++++++++++++++++++++++
 drivers/misc/lkdtm/core.c  |  3 ++
 drivers/misc/lkdtm/lkdtm.h |  3 ++
 lib/Kconfig.ubsan          | 49 +++++++++++++++++++++----
 lib/Makefile               |  2 +
 lib/ubsan.c                | 47 +++++++++++++-----------
 mm/kasan/report.c          | 10 ++++-
 scripts/Makefile.ubsan     | 16 ++++++--
 8 files changed, 172 insertions(+), 33 deletions(-)

-- 
2.20.1

