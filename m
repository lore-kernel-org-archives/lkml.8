Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83CEC18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA562208CD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uLX+Fb8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgCII4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 04:56:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34310 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCII4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:56:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id x3so9126206wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 01:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wxf00PuRVN/WLyVWtUJDrkQpOrg9G+jatLQyEfb16Ik=;
        b=uLX+Fb8S4OrtC4i0SunLJeRFWEytWavRUwR1mhe7lIo8PeogehU50RaqMQaVIeTfGD
         FeAtGe2Ykki0zNusb7Wsc4GKlqAJLGYvvU4pQv/3LJRf3gxQXeTU1gaWC1QZbu1aHUBR
         /FuUPPgibHvaQJDjHzD93O/8UNlujZeU0sVjv6LqRV2xUn4BbFy6RdeacykQQTSxycoy
         ABQppnfgKyoyRKxD5WqfqA6ymIG/XFYR89yVGcygH3jx2igN+1z4ZjwCkxG3fXmpiAmu
         eosPeR2WOtjSysqCQo+rz2RcE58Pj7GdXBWP/msMtj1H+E4G4nd9Bf5sSqDtuoXia6BT
         qjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wxf00PuRVN/WLyVWtUJDrkQpOrg9G+jatLQyEfb16Ik=;
        b=YuJjrv/ewnmmBtePpmC5O3LhWloGYkdOWxwjNWJKUdaLeqq9JyvCrbE2JLYwVeRu8u
         yCEKplUk3XJT8zK7qM6ntJ/cinulheEiMQ1NmtemLUXsNoSoql/6KxzXmVqP8vkgOQD9
         m+p/FaQW/LxuyxoIdSGTvn0QI9ZuauGkjq/XSXdHtSnidn9lNeRdn0isGpgC78Ch2Zuu
         Y77wN0AE6SfwBwyXlmcutpHcO6MOsXUs/gmWMYuPe1wt1XWR+lJJbOMeOxOj3a7eY59m
         kvqN7vt6kAZTAXS39RCFptwdC+xWJDVbvXEpbk3xsDw9k1bt/sIXp5ZYCCLYIVcXnbUA
         mrKw==
X-Gm-Message-State: ANhLgQ1sgKtegFGObxuVjnt6+4uesw+fksFhXKfTft7foDPJ54KLpzNX
        Atl9KHfYToRPqncKQDiLt+IoWIant2o=
X-Google-Smtp-Source: ADFU+vsqyTAiqbhuA20TE7VuTlFy5s3S5EXsCCb3Adjtse8Pcue/vXeH9lqFz6BJ5ZwlRzLjvudr4w==
X-Received: by 2002:a05:600c:2:: with SMTP id g2mr18683528wmc.18.1583744188803;
        Mon, 09 Mar 2020 01:56:28 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a58:8532:8700:ad0e:6d33:2184:cead])
        by smtp.gmail.com with ESMTPSA id y12sm18899538wmi.48.2020.03.09.01.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 01:56:28 -0700 (PDT)
From:   Ilie Halip <ilie.halip@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ilie Halip <ilie.halip@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Igor Lubashev <ilubashe@akamai.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] perf python: better clang detection
Date:   Mon,  9 Mar 2020 10:56:17 +0200
Message-Id: <20200309085618.14307-1-ilie.halip@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the setup.py script detects the clang compiler only when invoked
with CC=clang. But when using a specific version (e.g. CC=clang-11), this
doesn't work correctly and wrong compiler flags are set, leading to build
errors.

To properly detect clang, invoke the compiler with -v and check the output.
The first line should start with "clang version ...".

Link: https://github.com/ClangBuiltLinux/linux/issues/903
Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
---
 tools/perf/util/setup.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index aa344a163eaf..8a065a6f9713 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -2,11 +2,13 @@ from os import getenv
 from subprocess import Popen, PIPE
 from re import sub
 
+cc = getenv("CC")
+cc_is_clang = b"clang version" in Popen([cc, "-v"], stderr=PIPE).stderr.readline()
+
 def clang_has_option(option):
-    return [o for o in Popen(['clang', option], stderr=PIPE).stderr.readlines() if b"unknown argument" in o] == [ ]
+    return [o for o in Popen([cc, option], stderr=PIPE).stderr.readlines() if b"unknown argument" in o] == [ ]
 
-cc = getenv("CC")
-if cc == "clang":
+if cc_is_clang:
     from distutils.sysconfig import get_config_vars
     vars = get_config_vars()
     for var in ('CFLAGS', 'OPT'):
@@ -40,7 +42,7 @@ class install_lib(_install_lib):
 cflags = getenv('CFLAGS', '').split()
 # switch off several checks (need to be at the end of cflags list)
 cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls' ]
-if cc != "clang":
+if not cc_is_clang:
     cflags += ['-Wno-cast-function-type' ]
 
 src_perf  = getenv('srctree') + '/tools/perf'
-- 
2.17.1

