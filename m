Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A73C433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 06:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A737C20771
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 06:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XyO2RmkE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgGEGMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 02:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgGEGMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 02:12:38 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0ACC061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 23:12:38 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f2so14100865plr.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 23:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s7QQXwEm4dnmq+jlTbXbOEq302bTMUVfN5lq4IjhYc8=;
        b=XyO2RmkEGRaFfFZkIuTkygla4ZXv0c89QtCF7yaqlKX3Gr5EOroGlW72oG3IyXMG92
         BEK5FUNsUTcLlnU41uBg2FuxDaX5Bq0y0zjTFTZnAAqHSX2RpiF8SjE1qjAu2zG+G2rH
         a8rEmOxPZky9FBjyj5nqDoD79Riqo9Nvbu6ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s7QQXwEm4dnmq+jlTbXbOEq302bTMUVfN5lq4IjhYc8=;
        b=IVRQOCtjwyeQAau5MygTVlsR5KsNlYlPZAySP4W2+ktTmToLnAGtE3nFC+Y4qqlL1k
         ZJFiW+wQNWOkB3n+hCgnu8mfbW7dHfJKRIj9ceVhB+3dI9A48zZczQsb+U+piEFAEjGN
         LpbZEifgUGU1Mm2jHq/jwHjvzveYzYIGsNBz1CrbSTnGhbhJLK26cfQ7kIp0cYYjA77G
         BzhbNo95aETcm65yyQkiuJJAczSV7ZTX5lrpfKIrmQSc5A+lutvciBdh1dyrZH48pxgE
         +2Rbc/eeMCDGOxGj8CetjpxbVgtXH5s0NB2uKr8kreBmQDRnwHvvJ2rI7gbQitStOLHJ
         fhpg==
X-Gm-Message-State: AOAM533Dvn6Np0qE+hQ4umEGZy4tNY6dLXz68596wobi2kVfdDw100Ul
        vyBzy9fMgeNVPwNDuZ+21IRpJA==
X-Google-Smtp-Source: ABdhPJygzPaieVb3XQ6+2JIScvsgING0EAgONcSvvoMj/Xyn1uQ6SLPo+DogPpeL8b3+2sdKe8YpEA==
X-Received: by 2002:a17:90b:3842:: with SMTP id nl2mr44572479pjb.111.1593929558010;
        Sat, 04 Jul 2020 23:12:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a9sm15525789pfr.103.2020.07.04.23.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 23:12:37 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH for-next/seccomp 0/3] Check ENOSYS under tracing
Date:   Sat,  4 Jul 2020 23:12:29 -0700
Message-Id: <20200705061232.4151319-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This expands the seccomp selftest to poke a architectural behavior corner
that Keno Fischer noticed[1]. In the process, I took the opportunity
to do the kselftest harness variant refactoring I'd been meaning to do,
which made adding this test much nicer.

I'd prefer this went via the seccomp tree, as it builds on top of the
other recent seccomp feature addition tests. Testing and reviews are
welcome! :)

Thanks,

-Kees

[1] https://lore.kernel.org/lkml/CABV8kRxA9mXPZwtYrjbAfOfFewhABHddipccgk-LQJO+ZYu4Xg@mail.gmail.com

Kees Cook (3):
  selftests/harness: Clean up kern-doc for fixtures
  selftests/seccomp: Refactor to use fixture variants
  selftests/seccomp: Check ENOSYS under tracing

 tools/testing/selftests/kselftest_harness.h   |  15 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 217 ++++++------------
 2 files changed, 72 insertions(+), 160 deletions(-)

-- 
2.25.1

