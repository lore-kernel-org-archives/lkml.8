Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9048AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 22:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CD9720771
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 22:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aiZSNhPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgHLWPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 18:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgHLWPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 18:15:47 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B15BC061384
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 15:15:47 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id l84so3259545oig.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 15:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zkFmS4lhourxIPS4nRwSR7knOjqPCKlD3ZtMlJSoIPw=;
        b=aiZSNhPwl1N0n/NAAMFyLI1hcEPsUdLvv5dTjX3oVZVhZszLgaR8Dm/uS7n1SVcw2w
         j6BXwSWxbdy1ib0yKE7cepkpNJMztwvYqfQH8WxS6BITMO0nv9zbBz/coztDcR58/1gJ
         MGFbAD2vN0QM7l4ijcu6KSnFENpDP+4KOT72zPgkjl3rAMHjjfrZFB8362nsEDQvOv+c
         gG6RV5ewfhhf/AdQYiJxp9RTk/PQFUzdHSlZliLpNEc6NhAIi/fDRv1iMbJQM3WvhFtm
         4Oj/QtKQCJ2lyJwHXwrU0byJTmpRbARW2U6LPc+iV6Yy5RVA+fk4/UosMEc+FuS4p7fo
         Pdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zkFmS4lhourxIPS4nRwSR7knOjqPCKlD3ZtMlJSoIPw=;
        b=jtdgjp33g/y//Q88MFV1J4afUMEC+mvcROJ/OCSoPo9Axl8TwPgPs0K47GAVtcPsdD
         A6Efqwn+trzCDld2xMfF84TUJg2PDjVPiOVl0V4AU2v+lIiVEulwMHr18Td0rwEWbt9m
         TrILZhHWmecdfTlIBqQcSiKl17aSD5wgme30emV/6UqfuTNkh3jbtK6yEBoe6Nd0v14Y
         f/T+u5gHLK00fuYeEHxtYC1nhuNojiDmELXxqbrSt35R1ZfcboeUNNM9o6YUHemHGWKC
         4CTzZxLpEyS9lYQYuoOQ61q32vBiq2AQDT335DdO/XF1oR3cGVgbJ0LCYrCKuauG066u
         HiaQ==
X-Gm-Message-State: AOAM533MhNNZGNok9FMD1o59GODr+ptMZhH21WLReetVBK463/U91CBM
        RVNRfv82G9BfJ0/yQ4+1GbGKvQ==
X-Google-Smtp-Source: ABdhPJxUJvudfvVYCwSyrWgrpazlrDLoii6vv6fDp5AwJjZ7DgFzOhwZz8DIcb5zuMXrkd5on8PlZQ==
X-Received: by 2002:a54:4f1a:: with SMTP id e26mr1095994oiy.171.1597270546628;
        Wed, 12 Aug 2020 15:15:46 -0700 (PDT)
Received: from alago.cortijodelrio.net (CableLink-189-219-73-83.Hosts.InterCable.net. [189.219.73.83])
        by smtp.googlemail.com with ESMTPSA id l17sm720788otn.2.2020.08.12.15.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 15:15:46 -0700 (PDT)
From:   =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Thomas Hebb <tommyhebb@gmail.com>,
        =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Stephane Eranian <eranian@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        netdev@vger.kernel.org (open list:BPF (Safe dynamic programs and tools)),
        bpf@vger.kernel.org (open list:BPF (Safe dynamic programs and tools))
Subject: [PATCH] tools build feature: Quote CC and CXX for their arguments
Date:   Wed, 12 Aug 2020 17:15:17 -0500
Message-Id: <20200812221518.2869003-1-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using a cross-compilation environment, such as OpenEmbedded,
the CC an CXX variables are set to something more than just a
command: there are arguments (such as --sysroot) that need to be
passed on to the compiler so that the right set of headers and
libraries are used.

For the particular case that our systems detected, CC is set to
the following:

  export CC="aarch64-linaro-linux-gcc  --sysroot=/oe/build/tmp/work/machine/perf/1.0-r9/recipe-sysroot"

Without quotes, detection is as follows:

  Auto-detecting system features:
  ...                         dwarf: [ OFF ]
  ...            dwarf_getlocations: [ OFF ]
  ...                         glibc: [ OFF ]
  ...                          gtk2: [ OFF ]
  ...                        libbfd: [ OFF ]
  ...                        libcap: [ OFF ]
  ...                        libelf: [ OFF ]
  ...                       libnuma: [ OFF ]
  ...        numa_num_possible_cpus: [ OFF ]
  ...                       libperl: [ OFF ]
  ...                     libpython: [ OFF ]
  ...                     libcrypto: [ OFF ]
  ...                     libunwind: [ OFF ]
  ...            libdw-dwarf-unwind: [ OFF ]
  ...                          zlib: [ OFF ]
  ...                          lzma: [ OFF ]
  ...                     get_cpuid: [ OFF ]
  ...                           bpf: [ OFF ]
  ...                        libaio: [ OFF ]
  ...                       libzstd: [ OFF ]
  ...        disassembler-four-args: [ OFF ]

  Makefile.config:414: *** No gnu/libc-version.h found, please install glibc-dev[el].  Stop.
  Makefile.perf:230: recipe for target 'sub-make' failed
  make[1]: *** [sub-make] Error 2
  Makefile:69: recipe for target 'all' failed
  make: *** [all] Error 2

With CC and CXX quoted, some of those features are now detected.

Fixes: e3232c2f39ac ("tools build feature: Use CC and CXX from parent")

Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
---
 tools/build/Makefile.feature | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 774f0b0ca28a..e7818b44b48e 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -8,7 +8,7 @@ endif
 
 feature_check = $(eval $(feature_check_code))
 define feature_check_code
-  feature-$(1) := $(shell $(MAKE) OUTPUT=$(OUTPUT_FEATURES) CC=$(CC) CXX=$(CXX) CFLAGS="$(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))" CXXFLAGS="$(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" LDFLAGS="$(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" -C $(feature_dir) $(OUTPUT_FEATURES)test-$1.bin >/dev/null 2>/dev/null && echo 1 || echo 0)
+  feature-$(1) := $(shell $(MAKE) OUTPUT=$(OUTPUT_FEATURES) CC="$(CC)" CXX="$(CXX)" CFLAGS="$(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))" CXXFLAGS="$(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" LDFLAGS="$(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" -C $(feature_dir) $(OUTPUT_FEATURES)test-$1.bin >/dev/null 2>/dev/null && echo 1 || echo 0)
 endef
 
 feature_set = $(eval $(feature_set_code))
-- 
2.25.1

