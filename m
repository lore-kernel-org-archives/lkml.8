Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBF1C35DF9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26530246C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M2bJFwGR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbgB0Stc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:49:32 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42145 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730027AbgB0St3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:49:29 -0500
Received: by mail-pf1-f196.google.com with SMTP id 15so275082pfo.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 10:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uio9MFsHXugpSMEN2c2VbCCKbgwswLA7MQ9KMJphrpM=;
        b=M2bJFwGRUurTAq2OXqUC83zEYHOro2pmObSwZO6Bo+WiLoXHkYK1zpCQs6116+4JSv
         uGBJpDdGelG5RJ4fgFLQViDWAnSVRj/IlZJnNp11SqCTTBtNIN/T9W+56EdwZbVGngSB
         VI85KVSzpvpJNyvsflH49hczSrHzddFNtjqT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uio9MFsHXugpSMEN2c2VbCCKbgwswLA7MQ9KMJphrpM=;
        b=eLF4OdfAqK6z/b3XGzYgYkx3vQPeX7BG6DejGR0rSxJCQNsXR6VvvqgkEFFfSaN5hJ
         HRfJcU5VOgZZoyVuVlbqhW2PNv4Zd1gTjtbzIS38whu8nDJMrJuJOIjfvbJFEza5y8F7
         qeyQRy9gdBeLTmPhYWxlFHnjG4nzpDhwi8JvdwVZxZTCSljQPaBP1tstvfMb0/zjH6p9
         qg4BokkCDnS28ueje9xDDv+7qjdQSbcCGltK34W38WUSZ++PdxcPxhIEuH12dY5D845J
         Ovx7TftF9mjb8IwlLiN0wzxKbMglMqbr3xcdMpWybKN2V5piI43yLGrEhjoJJq+WaRMb
         TyGQ==
X-Gm-Message-State: APjAAAWj6KBqehOOuuhKOhPF8nIzNDmWGvR9HkDou2zEYA1iLImQDg0I
        dL8nMDcMhQmgYfZc6MTXGBoltQ==
X-Google-Smtp-Source: APXvYqzjFLlBwzUnS9Buay5SU6EClRdGPy50Ngz3GJVvxZkvUCu0e9OzvgVYH7vICIR7BSm10X7QoA==
X-Received: by 2002:a62:e414:: with SMTP id r20mr371760pfh.154.1582829368003;
        Thu, 27 Feb 2020 10:49:28 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h3sm8314321pfr.15.2020.02.27.10.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 10:49:26 -0800 (PST)
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
Subject: [PATCH v4 0/6] ubsan: Split out bounds checker
Date:   Thu, 27 Feb 2020 10:49:15 -0800
Message-Id: <20200227184921.30215-1-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This splits out the bounds checker so it can be individually used. This
is enabled in Android and hopefully for syzbot. Includes LKDTM tests for
behavioral corner-cases (beyond just the bounds checker), and adjusts
ubsan and kasan slightly for correct panic handling.

-Kees

v4:
 - use hyphenated bug class names (andreyknvl)
 - add Acks
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

