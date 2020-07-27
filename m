Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E03C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 04:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75D9520719
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 04:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLJpwy/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgG0EIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 00:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgG0EIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 00:08:25 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0A9C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 21:08:24 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id o22so8467466pjw.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 21:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jKgXPHuanETb6NKgX4EbBQFIax+y6guFENgQ12rvRUU=;
        b=JLJpwy/IS8n1zugslKCBC4sqQUeqaWOQRkC9BbSQY0Y72nSTy1m+Vwp/F3naHRyshX
         0MqX9nEOiMq9XJoaZuSK4pYLyWuF5YCFmgaNSjfbG+YAuN2r7qHaBfv/nVgN+PakbqHB
         XXGCxR7VTjGj+DrZB+/1Khy8XFqt6kf5rVoeQtROSsmBw6nqQAIEA3VApUL+8Hm2GzMf
         0t81fnKP6qDtPxnuNCzRwPRLMvwJGtl1f69ao7KeY+37bLxkISbE60MAVA7KoL0kcCBw
         HmSzyM1oQAeuygFZ1mvxbx3QYzFHv9tSeIHsGTgNSvt+L8MfzwTTZVXkoMrnzXUXy/Vz
         WIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jKgXPHuanETb6NKgX4EbBQFIax+y6guFENgQ12rvRUU=;
        b=EiDZ55+vZAKX4p0ihhfOXlq6onrrlJkHXs1FMV9Oep9ThZBZJt6J8bF5C+qFphkSo7
         qwMaDdRqGKQH4Gx3ne/ZCTXvVVpQoVOMogteb6b+exxA9fYBRwcLH5qPell2B6OVCUDP
         +HOeGKH5m0n9S1p+ZyyBHa6sLCSI7k97TdTiUt8TcuSJbAMg4943MYqYZwNXnLICSIrP
         ZaVO6W4FACRdlrgwDyyqORyfI2wGWMoUw+EtRaqqAS2DR8sFA+2i/+7+VEHTS9zizYED
         9NKmHwuvWoxi23fEw4Tjl3v2XP5F8kJnF/jNks5j99sFyFNDYTjSoPYRTEafYBFM/jGR
         CIBg==
X-Gm-Message-State: AOAM532C3GfjEP3g0XkKBiVLGpOunrIADSfWrAd/rXOhaNngy6uWyMjI
        GRbzo1I1JIIG9d1MQJN9p1Ha+bt+zJeaWw==
X-Google-Smtp-Source: ABdhPJyQbCKR9Z/UH9snvh8EHh2w7W9mu7J97KYNBf3jjjWsMJISyjgB7VwzeqHRUXCqV5US674/UA==
X-Received: by 2002:a17:90a:9e7:: with SMTP id 94mr3893850pjo.97.1595822904050;
        Sun, 26 Jul 2020 21:08:24 -0700 (PDT)
Received: from glados.lan ([2601:647:4c01:6541:fa16:54ff:fed1:1bd6])
        by smtp.gmail.com with ESMTPSA id e129sm6542501pfe.94.2020.07.26.21.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 21:08:23 -0700 (PDT)
From:   Thomas Hebb <tommyhebb@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Hebb <tommyhebb@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Ian Rogers <irogers@google.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 1/3] tools build feature: Use CC and CXX from parent
Date:   Sun, 26 Jul 2020 21:08:14 -0700
Message-Id: <0a6e69d1736b0fa231a648f50b0cce5d8a6734ef.1595822871.git.tommyhebb@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit c8c188679ccf ("tools build: Use the same CC for feature detection
and actual build") changed these assignments from unconditional (:=) to
conditional (?=) so that they wouldn't clobber values from the
environment. However, conditional assignment does not work properly for
variables that Make implicitly sets, among which are CC and CXX. To
quote tools/scripts/Makefile.include, which handles this properly:

  # Makefiles suck: This macro sets a default value of $(2) for the
  # variable named by $(1), unless the variable has been set by
  # environment or command line. This is necessary for CC and AR
  # because make sets default values, so the simpler ?= approach
  # won't work as expected.

In other words, the conditional assignments will not run even if the
variables are not overridden in the environment; Make will set CC to
"cc" and CXX to "g++" when it starts[1], meaning the variables are not
empty by the time the conditional assignments are evaluated. This breaks
cross-compilation when CROSS_COMPILE is set but CC isn't, since "cc"
gets used for feature detection instead of the cross compiler (and
likewise for CXX).

To fix the issue, just pass down the values of CC and CXX computed by
the parent Makefile, which gets included by the Makefile that actually
builds whatever we're detecting features for and so is guaranteed to
have good values. This is a better solution anyway, since it means we
aren't trying to replicate the logic of the parent build system and so
don't risk it getting out of sync.

Leave PKG_CONFIG alone, since 1) there's no common logic to compute it
in Makefile.include, and 2) it's not an implicit variable, so
conditional assignment works properly.

[1] https://www.gnu.org/software/make/manual/html_node/Implicit-Variables.html

Fixes: c8c188679ccf ("tools build: Use the same CC for feature detection and actual build")
Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
---

 tools/build/Makefile.feature | 2 +-
 tools/build/feature/Makefile | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index cb152370fdef..774f0b0ca28a 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -8,7 +8,7 @@ endif
 
 feature_check = $(eval $(feature_check_code))
 define feature_check_code
-  feature-$(1) := $(shell $(MAKE) OUTPUT=$(OUTPUT_FEATURES) CFLAGS="$(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))" CXXFLAGS="$(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" LDFLAGS="$(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" -C $(feature_dir) $(OUTPUT_FEATURES)test-$1.bin >/dev/null 2>/dev/null && echo 1 || echo 0)
+  feature-$(1) := $(shell $(MAKE) OUTPUT=$(OUTPUT_FEATURES) CC=$(CC) CXX=$(CXX) CFLAGS="$(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))" CXXFLAGS="$(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" LDFLAGS="$(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" -C $(feature_dir) $(OUTPUT_FEATURES)test-$1.bin >/dev/null 2>/dev/null && echo 1 || echo 0)
 endef
 
 feature_set = $(eval $(feature_set_code))
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index b1f0321180f5..93b590d81209 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -74,8 +74,6 @@ FILES=                                          \
 
 FILES := $(addprefix $(OUTPUT),$(FILES))
 
-CC ?= $(CROSS_COMPILE)gcc
-CXX ?= $(CROSS_COMPILE)g++
 PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
 LLVM_CONFIG ?= llvm-config
 CLANG ?= clang
-- 
2.27.0

