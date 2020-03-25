Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA370C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 23:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA11C20714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 23:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585178166;
	bh=JcJoYCQCW+QHid7a0X7ntwkVFwLf+V3sZeX6MnneEbI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ylMvGg5bs45c2VE0jLbH9iOdKJcpOXoUvr5yDqM5goaO6jOw5u8ZXWAJC/SYRgBGu
	 8adi65ybTY+PkPMw+yozDVRUuWYH0p+IMjhZAGIuAOGGfjLfwqTtBm4ff+OeeAFTQa
	 i1eBJ4+G1QR5OPn7p7VpThNBt7LNNX2bH0ZLFgtk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgCYXQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 19:16:05 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:45671 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbgCYXQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 19:16:05 -0400
Received: by mail-il1-f194.google.com with SMTP id x16so3604488ilp.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 16:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NSRNCN/j478+x+CnZ0YXdwqIE1xrZ/myz7b/YSvrTrk=;
        b=aaHo4yEVDL1GvqdjKihvS4Vo7uEcUGRoKt6DzApCug8OYz8RyyTIf7FZYIkK8BRDjT
         Z/x1pxEZ/hPRmsQog/XjvnKI+fTOKNxA9PVfctfP/+Wbyihore6S2E9M8Bn3focb0/ns
         ggAhVp39/5+Ral0BHiplR8AjTLQDPuaHB2qvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NSRNCN/j478+x+CnZ0YXdwqIE1xrZ/myz7b/YSvrTrk=;
        b=pzBsX/ZI5/3KlTYHIIE/vakILX6ZHF/8TMaJcLUB5xh2P8ZV20FwecqBXWicJzO3n8
         Q128B5d2SP450cccGUf1zt0ROYjKxxtxhNm+AyMzvaAprokQe7ULPJh2HijWm4Q6fD0T
         l9COaPYy5+ibhfMCBKaTLfKn89hc6zYbe/U9oUp/Z/WzYBrOtDOkyx1mlgjxehzU5J03
         rrvwRTJ4nPIYqaPCW3Fv12o08goEe9LJXZp70Ml4z06u+lxdF3esvM1X/0D5s7LAvYfd
         eGJrb47GPY/IhRRou6fV+16TFyirRSpEP+/YykdIUiMIktbazIkXeLg2D79G0hSOBrXa
         dFpA==
X-Gm-Message-State: ANhLgQ3J4x41/MkELwdXZU2DaQHy9EbgHw+SHMNed+19BVHFVXDuUS9Y
        MAmQpNk0rm1p9T0z9GKZcCsxKQ==
X-Google-Smtp-Source: ADFU+vuIrCnX89jT/0He3a9PY5pOYUMa56VJw947AmN53eBLnKN2LzOLpyZAJbEaD9qMy8NGpHiNUg==
X-Received: by 2002:a92:778e:: with SMTP id s136mr6079726ilc.256.1585178164506;
        Wed, 25 Mar 2020 16:16:04 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k16sm205604ila.38.2020.03.25.16.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 16:16:03 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     keescook@chromium.org, luto@amacapital.net, wad@chromium.org,
        shuah@kernel.org, mpe@ellerman.id.au
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] selftests: Fix seccomp to support relocatable build (O=objdir)
Date:   Wed, 25 Mar 2020 17:16:02 -0600
Message-Id: <20200325231602.12964-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix seccomp relocatable builds. This is a simple fix to use the
right lib.mk variable TEST_GEN_PROGS. Local header dependency
is addressed in a change to lib.mk as a framework change that
enforces the dependency without requiring changes to individual
tests.

The following use-cases work with this change:

In seccomp directory:
make all and make clean

From top level from main Makefile:
make kselftest-install O=objdir ARCH=arm64 HOSTCC=gcc \
 CROSS_COMPILE=aarch64-linux-gnu- TARGETS=seccomp

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
Changes since v3:
Simplified logic based on comments from Kees and Michael

 tools/testing/selftests/seccomp/Makefile | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/selftests/seccomp/Makefile
index 1760b3e39730..0ebfe8b0e147 100644
--- a/tools/testing/selftests/seccomp/Makefile
+++ b/tools/testing/selftests/seccomp/Makefile
@@ -1,17 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-all:
-
-include ../lib.mk
-
-.PHONY: all clean
-
-BINARIES := seccomp_bpf seccomp_benchmark
 CFLAGS += -Wl,-no-as-needed -Wall
+LDFLAGS += -lpthread
 
-seccomp_bpf: seccomp_bpf.c ../kselftest_harness.h
-	$(CC) $(CFLAGS) $(LDFLAGS) $< -lpthread -o $@
-
-TEST_PROGS += $(BINARIES)
-EXTRA_CLEAN := $(BINARIES)
-
-all: $(BINARIES)
+TEST_GEN_PROGS := seccomp_bpf seccomp_benchmark
+include ../lib.mk
-- 
2.20.1

