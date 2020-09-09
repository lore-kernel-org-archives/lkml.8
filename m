Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2253C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA99520BED
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hdEHm7z6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgIIVRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 17:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgIIVRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 17:17:09 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA99CC061755
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 14:17:08 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id o68so3410766pfg.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 14:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CCe3ziH+ElemTVm2NqfWzU9PRtLXI604MAgAcQj1O7c=;
        b=hdEHm7z6jg8LsyV0hWWKIoyb509W1HSRjJPTgb0RNsN9MIU/VeTM4XVD4fCgOlssvS
         9aRXKuJu2OhmqVeFGdA/adLLrvq2aDyuOaON0YYTtPw8pgi5E4Rg7mqm4qmSHbGaXLR+
         GrsPXAmMOKCjthtoQDoYmyNycqKI6tTEUmsI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CCe3ziH+ElemTVm2NqfWzU9PRtLXI604MAgAcQj1O7c=;
        b=gEkuoHmQX9BS7YZbuqCJYC3ICpw/SgrTkpfRirQt5w9/J6MV+CuLzLP1+qGMiq8Z8a
         i9iX1LVaa9kjvNL4vKR09egnsogMG5AURU24RbTHZG/tb8xOJ4rwdeobpa/wG2xkj+EM
         74FyO4wZJQijOIMhbJGmu6jEiHOF/kW1Q8HwJiHetumkQSzSbQCgj0ayvv71uHvJPeql
         uZurYSYmZq5NaxiHgs8UOutryD/Tvk9rabUkET8SfB9IKhw+vXbhaimsaRlWSz8Mu2H1
         C/eLsr17RErL+ZCu9ZR0E92i5wG0eWaoKxp9MeUcX3CTelcMdjHdUrttciW6xFMB+0K0
         p0Ag==
X-Gm-Message-State: AOAM531vUlYXSB3j4lZPdFKZyGlDD8tp4IZ6DPDMAfY1cazVIMjzMx9S
        lm2zTEYa9AmW1eKJ8F9RmZjyUw==
X-Google-Smtp-Source: ABdhPJy8UUmcbw02VQE4xwOZuH25tjtT7DN/IXk9ewpMdTyFfoUhn/F4CyZLiVVtN/bQK7eC+MFIjQ==
X-Received: by 2002:a17:902:c149:: with SMTP id 9mr1381263plj.10.1599686228449;
        Wed, 09 Sep 2020 14:17:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j19sm3601421pfi.51.2020.09.09.14.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 14:17:07 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-kselftest@vger.kernel.org,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests/lkdtm: Use "comm" instead of "diff" for dmesg
Date:   Wed,  9 Sep 2020 14:17:00 -0700
Message-Id: <20200909211700.2399399-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of full GNU diff (which smaller boot environments may not have),
use "comm" which is more available.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Fixes: f131d9edc29d ("selftests/lkdtm: Don't clear dmesg when running tests")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: add --nocheck-order, thanks to Joe Lawrence
v1: https://lore.kernel.org/lkml/202006261358.3E8AA623A9@keescook/
---
 tools/testing/selftests/lkdtm/run.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/lkdtm/run.sh b/tools/testing/selftests/lkdtm/run.sh
index 8383eb89d88a..bb7a1775307b 100755
--- a/tools/testing/selftests/lkdtm/run.sh
+++ b/tools/testing/selftests/lkdtm/run.sh
@@ -82,7 +82,7 @@ dmesg > "$DMESG"
 ($SHELL -c 'cat <(echo '"$test"') >'"$TRIGGER" 2>/dev/null) || true
 
 # Record and dump the results
-dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$DMESG" - > "$LOG" || true
+dmesg | comm --nocheck-order -13 "$DMESG" - > "$LOG" || true
 
 cat "$LOG"
 # Check for expected output
-- 
2.25.1

