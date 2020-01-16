Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60DBC32771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 01:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849552084D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 01:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Necsxt4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbgAPBYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 20:24:21 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44530 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbgAPBYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 20:24:21 -0500
Received: by mail-pg1-f196.google.com with SMTP id x7so9029401pgl.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 17:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ztBntqcbRDpikloUpN2F0KWZjGouqnztxdMWfXHrneU=;
        b=Necsxt4UM069dJn7UjGMxHP4B4Sb0ubZNcm+nTrWn7TXh6RK8XLGxhuR6iy+4r9KvX
         HtSp4KGSa43ZdYKf5GtwMSyGz/DsjpqSBBps9cJKtCKviSO7uwPrv9LibT7DWL71ALGF
         w4jbfha23PQIwPGtO/NJIuyW3VbmoDRbPfxSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ztBntqcbRDpikloUpN2F0KWZjGouqnztxdMWfXHrneU=;
        b=gB3P71WTyzCg0ow6WIezPAo9Ru7oOUshE1C6Y5IApM9Y3dToWe1d7A0xfFzqn8hGB1
         FhTHAWQJCx4M9Xm+kLnMW5K6+Nyps3HllR1lMiElPae3garI6pUmaP3d7SyzTKk5Lani
         J2EcV58crLZ6FeYf7T/V4KQu1mJmf4MPCd6rH8s7Z7ZuITFaEwhhlEH26CobKssYLoXx
         kaWsPfQINB4VDUvmi8mCXpVYI/APSq9OLeoFmHM0Xt6YtcaASUrpRDLxaYfCXdYT0Vco
         4ZPmvt71hd+AHk8icBGbPSsqB+lPmA6K7nlAghnzpieyb7WQy9NVojD0xTuBZOHt1wye
         7qXQ==
X-Gm-Message-State: APjAAAVhDKm2H+g/dRV/+92sxvO85UWPCM9JdNg2A5Om8GaBXGIlLfSr
        L31IJDSMxsbN6OuHv0kClSpWYQ==
X-Google-Smtp-Source: APXvYqyEY91Ps4j5Unu6q/04cKkVouK2+nDVdzN3lDLdlCCZsHk9TuTlpS854xybBZZK2RoncaRauQ==
X-Received: by 2002:a63:7843:: with SMTP id t64mr36298336pgc.144.1579137860501;
        Wed, 15 Jan 2020 17:24:20 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 144sm24408406pfc.124.2020.01.15.17.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 17:24:18 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        syzkaller@googlegroups.com
Subject: [PATCH v3 0/6] ubsan: Split out bounds checker
Date:   Wed, 15 Jan 2020 17:23:15 -0800
Message-Id: <20200116012321.26254-1-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This splits out the bounds checker so it can be individually used. This
is expected to be enabled in Android and hopefully for syzbot. Includes
LKDTM tests for behavioral corner-cases (beyond just the bounds checker),
and adjusts ubsan and kasan slightly for correct panic handling.

-Kees

v3:
 - use UBSAN menuconfig (will)
 - clean up ubsan report titles (dvyukov)
 - fix ubsan/kasan "panic" handling
 - add Acks
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

