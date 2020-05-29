Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FEEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50CB3207D4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e1eTWdUf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgE2UEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 16:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgE2UD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 16:03:58 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A3AC08C5C9
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 13:03:58 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u5so437856pgn.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 13:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jc9W1lwloD2dKjs9tH5GF5HCcPhR+AQW3rE24ig1wNo=;
        b=e1eTWdUfj0/uemCZrZndDP84V6F6lpImOpHhDUyzllRqWZlnKM6KITsLSam+a0R/bv
         PoMO4JXmtX5ZMB9fmem1FG9RAtKBlLDbpHqrYncYIJYyEwBjuW+oJ6SrHW3Pv5OpoR/R
         OoIyqaaLzHdjAuD1n5MLYvZmuqZghAa+a2OnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jc9W1lwloD2dKjs9tH5GF5HCcPhR+AQW3rE24ig1wNo=;
        b=TgSLsV/V2M6sQp8glpG1YYSQHjCulB8gs0bwQV4PbVNNPB/H3Vin31QWPhhKPBX38V
         xqmX4m4xPBxn6xGaC03dfUlN+DAjnacJ5nbeHLFw9qfS1Ta0xj4ExksiSidSKoswutM2
         t150oJ4mgVZXl3tXz2quLLgPLLTJVyVcczTorQ52iQVrPZiHkRwfkI5anb3poe1ZQt6A
         i5/mnjc425BG9AWf1Iz884kQ1+ERmvD83n2FMi2E5flqIDLEADE/bljG7Chxb7ya/CVE
         6+9mPEjB82x5AN99HyAr4e2cTRYCwXic/e7oo8rkoiV73whe+IzBlSo2u51HhgZ2IBrw
         Sr8A==
X-Gm-Message-State: AOAM531qVuC9FcTiHSbFfYM6X2blwbits0TErf84/0cGWXCKo1VwsggP
        ep6mI91XRr3KqsLzJqJftPOGQw==
X-Google-Smtp-Source: ABdhPJwP7z6gIJI+dnYxn8KJ2aoaoXPzR+vI9pyJIkXlzmzjD/z7ey7U1doHvuvot75KEkzxR06v1g==
X-Received: by 2002:a62:178b:: with SMTP id 133mr9871040pfx.238.1590782637803;
        Fri, 29 May 2020 13:03:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q28sm8137946pfg.180.2020.05.29.13.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 13:03:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH drivers/misc 0/4] lkdtm: Various clean ups
Date:   Fri, 29 May 2020 13:03:43 -0700
Message-Id: <20200529200347.2464284-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Can you please apply these patches to your drivers/misc tree for LKDTM?
It's mostly a collection of fixes and improvements and tweaks to the
selftest integration.

Thanks!

-Kees

Kees Cook (4):
  lkdtm: Avoid more compiler optimizations for bad writes
  lkdtm/heap: Avoid edge and middle of slabs
  selftests/lkdtm: Reset WARN_ONCE to avoid false negatives
  lkdtm: Make arch-specific tests always available

 drivers/misc/lkdtm/bugs.c               | 45 +++++++++++++------------
 drivers/misc/lkdtm/heap.c               |  9 ++---
 drivers/misc/lkdtm/lkdtm.h              |  2 --
 drivers/misc/lkdtm/perms.c              | 22 ++++++++----
 drivers/misc/lkdtm/usercopy.c           |  7 ++--
 tools/testing/selftests/lkdtm/run.sh    |  6 ++++
 tools/testing/selftests/lkdtm/tests.txt |  1 +
 7 files changed, 56 insertions(+), 36 deletions(-)

-- 
2.25.1

