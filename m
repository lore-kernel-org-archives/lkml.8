Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02689C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 09:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D147D20767
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 09:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ON70wM29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgFPJuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 05:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgFPJuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 05:50:02 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5AAC05BD43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 02:50:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e82so23709738ybh.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 02:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=IEOhiucuBJ/KD8n8JX6Fqs7j+NCQAoB88CGBLL1yHLU=;
        b=ON70wM29pNL8PMIrB1afYrBLyKFOeka3Vl5NxJ00ntOpkJGImvXTgMk+hDrT0eo+A6
         takau6hHHwRDZ2ylDPK141S73OaTI+hGqoITLzmDA7LoqPpavV+kekGnh+iVbSOQusSj
         iexRlk84fHEAFEYNqvTon0kOjyh6t97mxbq4WP2oifCi2CUwCEKke0voQb0nIVQ1f2w6
         80kR7g3OT2Z0e3Q2bpeskk/WLnRn5yjamHf6j1pFV6Yb/DXPvJImx1h2M/HmUEubVsSx
         rc1GR8Mpg1xZTFv11/a/pKBxRUOjvHb24ZIrBQBUlhntdz8NOc16MGTplZ8CtVzBTFvO
         fAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=IEOhiucuBJ/KD8n8JX6Fqs7j+NCQAoB88CGBLL1yHLU=;
        b=GlU2XOwK9oZAA5nKmjqu59Jx55JOpkSBuT4/0lykhm2lPXruOsMtqLRNva3gre9Cju
         6f6krboel1B45CHvSbJnSeIZKnweH4JLy0lj3hfUWCKomNGN0aC01wisW9/GJC/J1jQV
         5btW9KsOKZWgwOpk3gi9xYjjjSMPCBL0spLdaTAGFmuz0dkd3IA7Fh2Y8MAx0c9gnzkt
         BJtAMnU2C3WaHy4pW097G7CcKaQyaFomNhMvxOygHPp8OLkFCkthhmHyW2B46yktLX3C
         Uwtv9VowzQSM5t7xkeP/6NHBj3GG0LraaSOgUy6UWj/2sNpcJPDmyGNx3Ld26UKnqBhI
         oFkg==
X-Gm-Message-State: AOAM532Aa0Pk0kQ+9PQLPm+RLQaEKCYwGXydD8ThxpBa0K0NVcGNSJpM
        x6KyXBodB2dzHblRLGEeznI1x+XTtg==
X-Google-Smtp-Source: ABdhPJwI1NfCdqG00Qq++my5I/CvMzNwn79kMguUXhY5VGw1tqdWTsUlT+ft5O8RsGtOI+TwGXbq+Cypyg==
X-Received: by 2002:a25:e795:: with SMTP id e143mr2911433ybh.181.1592301001423;
 Tue, 16 Jun 2020 02:50:01 -0700 (PDT)
Date:   Tue, 16 Jun 2020 11:49:24 +0200
Message-Id: <20200616094924.159539-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH] torture: Pass --kmake-arg to all make invocations
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, shuah@kernel.org, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to pass the arguments provided to --kmake-arg to all make
invocations. In particular, the make invocations generating the configs
need to see the final make arguments, e.g. if config variables depend on
particular variables that are passed to make.

For example, when using '--kcsan --kmake-arg CC=clang-11', we would lose
CONFIG_KCSAN=y due to 'make oldconfig' not seeing that we want to use a
compiler that supports KCSAN.

Signed-off-by: Marco Elver <elver@google.com>
---
 tools/testing/selftests/rcutorture/bin/configinit.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/configinit.sh b/tools/testing/selftests/rcutorture/bin/configinit.sh
index 93e80a42249a..d6e5ce084b1c 100755
--- a/tools/testing/selftests/rcutorture/bin/configinit.sh
+++ b/tools/testing/selftests/rcutorture/bin/configinit.sh
@@ -32,11 +32,11 @@ if test -z "$TORTURE_TRUST_MAKE"
 then
 	make clean > $resdir/Make.clean 2>&1
 fi
-make $TORTURE_DEFCONFIG > $resdir/Make.defconfig.out 2>&1
+make $TORTURE_KMAKE_ARG $TORTURE_DEFCONFIG > $resdir/Make.defconfig.out 2>&1
 mv .config .config.sav
 sh $T/upd.sh < .config.sav > .config
 cp .config .config.new
-yes '' | make oldconfig > $resdir/Make.oldconfig.out 2> $resdir/Make.oldconfig.err
+yes '' | make $TORTURE_KMAKE_ARG oldconfig > $resdir/Make.oldconfig.out 2> $resdir/Make.oldconfig.err
 
 # verify new config matches specification.
 configcheck.sh .config $c
-- 
2.27.0.290.gba653c62da-goog

