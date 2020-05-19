Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E517C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1BFD20578
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S8dNvEpv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbgESSZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729480AbgESSZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:25:08 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BF3C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 11:25:07 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id dm14so637040qvb.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 11:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/YztpDs6K8vdorsBByvnDRj+nEKIuoGb/xCbk1LxXf8=;
        b=S8dNvEpvhE+IfpPm75giwVCaRp7o63rsUkXLxrj7ImLgHdi2CIWaV2uRWaWULAp2hb
         BdHfYBPV3qB1TwxRVPVHr3NEjOJNkTFj/3DHOifWLY5AvwISft0kCLQe7amSF4DDzham
         TngA37tIZZN0J1lnHTIaF4s0bKvAZzJR0Fwr2gV3phXscBjJxO31CR9TkxU1YajXB/I+
         N7/1vqQX+QKWF0J5ogpoosa3s99vmKO6BwAljPiJI7wtzqYDSM9/YZ/sjWrGV6IX+83h
         5QfBWwhuT/IksEOCobJwVwxSS8OAGkzeaQVFoIL4khU76tyzhc95TyDjxNCXiSx1a1Si
         gqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/YztpDs6K8vdorsBByvnDRj+nEKIuoGb/xCbk1LxXf8=;
        b=TETE9Zjnn3nJsIIAWfB5M5zESTJg91eZ1Opp1VhMkbVPliTyrgCD6/Yci0zajoqM05
         dqgdMl5nG03Kod7U4/WQje+ubBeLDQ1NcDBRe1ajoVbAiaJu065ZU5oyY1fUqmAckDOu
         Ao5TRv9STbuYTvvFlFBdqTV+8XBjZbCI1D9dPyQ1k7UoKT7EWiTgl2WemkLjQPkE5jNi
         l45E/aUBmlzVmJRQlBMmXne+rPFZEeCVcjbAEC1QUitwIFGYhPgatI2LlS3x/g7oLRuo
         i4JCKBgTCg5LLgnKpiTw0SHkz7JuOvMH0B8RAp178o33zIEaUlpxwO21O/VG391RpjJG
         uUGw==
X-Gm-Message-State: AOAM533IFpTi0dinLNrMbmNWxmY6TycG4kDjdg4rvId+vlidOAjRVtPb
        X2rqF3gNWCQzYdiVsApiUw3PZzaqoA==
X-Google-Smtp-Source: ABdhPJyqBjGg13VhNhrrjBOPZY6akdM/gNnnfWvsAighzQLtbRMd1TtH6DpRkH6RXRujb4mwRLYmtIE4+Q==
X-Received: by 2002:a05:6214:3f0:: with SMTP id cf16mr1034113qvb.4.1589912706953;
 Tue, 19 May 2020 11:25:06 -0700 (PDT)
Date:   Tue, 19 May 2020 20:24:59 +0200
Message-Id: <20200519182459.87166-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH] kasan: Disable branch tracing for core runtime
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     dvyukov@google.com, glider@google.com, andreyknvl@google.com,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        aryabinin@virtuozzo.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, kernel test robot <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During early boot, while KASAN is not yet initialized, it is possible to
enter reporting code-path and end up in kasan_report(). While
uninitialized, the branch there prevents generating any reports,
however, under certain circumstances when branches are being traced
(TRACE_BRANCH_PROFILING), we may recurse deep enough to cause kernel
reboots without warning.

To prevent similar issues in future, we should disable branch tracing
for the core runtime.

Link: https://lore.kernel.org/lkml/20200517011732.GE24705@shao2-debian/
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 mm/kasan/Makefile  | 16 ++++++++--------
 mm/kasan/generic.c |  1 -
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
index 434d503a6525..de3121848ddf 100644
--- a/mm/kasan/Makefile
+++ b/mm/kasan/Makefile
@@ -15,14 +15,14 @@ CFLAGS_REMOVE_tags_report.o = $(CC_FLAGS_FTRACE)
 
 # Function splitter causes unnecessary splits in __asan_load1/__asan_store1
 # see: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63533
-CFLAGS_common.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
-CFLAGS_generic.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
-CFLAGS_generic_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
-CFLAGS_init.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
-CFLAGS_quarantine.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
-CFLAGS_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
-CFLAGS_tags.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
-CFLAGS_tags_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
+CFLAGS_common.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
+CFLAGS_generic.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
+CFLAGS_generic_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
+CFLAGS_init.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
+CFLAGS_quarantine.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
+CFLAGS_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
+CFLAGS_tags.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
+CFLAGS_tags_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
 
 obj-$(CONFIG_KASAN) := common.o init.o report.o
 obj-$(CONFIG_KASAN_GENERIC) += generic.o generic_report.o quarantine.o
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 56ff8885fe2e..098a7dbaced6 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -15,7 +15,6 @@
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-#define DISABLE_BRANCH_PROFILING
 
 #include <linux/export.h>
 #include <linux/interrupt.h>
-- 
2.26.2.761.g0e0b3e54be-goog

