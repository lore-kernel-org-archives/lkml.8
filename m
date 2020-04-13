Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A903EC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86EA520780
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586796831;
	bh=xeWLJ5bbYzC5ofnPbd+yDJyUexrL+I58u1pgHQo6oLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ts/qNw57S89BaiVMv357iv/JAAqKxwktHKCmMn4bDfA8LrnzDlyo0nI7IJNn1q50Q
	 5SLGa29jI/Mec7PRuBF7n+26sXyn+tPq3/icCg15vZmpDML/XDV68klfuK1PtaUycO
	 IzZEakY8zMiBEybvaYp42H5gnkRdOqLE5xYC64t8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732053AbgDMQxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:53:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731988AbgDMQxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:53:41 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F16420739;
        Mon, 13 Apr 2020 16:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586796820;
        bh=xeWLJ5bbYzC5ofnPbd+yDJyUexrL+I58u1pgHQo6oLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zqDHhfC06ex8OBDN1q1WKRQmUQkA+5eSO7FlQAn9nZsImiK7BEw3Dfv8jn1WGMGox
         jcOVezJ9xnkjS5ralrFuyz2masZAX+q8dm9RMRjNsMn/Ap+a/kl6bwdrPvaa7zqXA1
         Ntxmqx/kIMd56xHdPWa4K4waPGTtuVXMKnQlajqw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 17/26] perf python: Check if clang supports -fno-semantic-interposition
Date:   Mon, 13 Apr 2020 13:51:54 -0300
Message-Id: <20200413165203.1816-18-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200413165203.1816-1-acme@kernel.org>
References: <20200413165203.1816-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The set of C compiler options used by distros to build python bindings
may include options that are unknown to clang, we check for a variety of
such options, add -fno-semantic-interposition to that mix:

This fixes the build on, among others, Manjaro Linux:

    GEN      /tmp/build/perf/python/perf.so
  clang-9: error: unknown argument: '-fno-semantic-interposition'
  error: command 'clang' failed with exit status 1
  make: Leaving directory '/git/perf/tools/perf'

  [perfbuilder@602aed1c266d ~]$ gcc -v
  Using built-in specs.
  COLLECT_GCC=gcc
  COLLECT_LTO_WRAPPER=/usr/lib/gcc/x86_64-pc-linux-gnu/9.3.0/lto-wrapper
  Target: x86_64-pc-linux-gnu
  Configured with: /build/gcc/src/gcc/configure --prefix=/usr --libdir=/usr/lib --libexecdir=/usr/lib --mandir=/usr/share/man --infodir=/usr/share/info --with-pkgversion='Arch Linux 9.3.0-1' --with-bugurl=https://bugs.archlinux.org/ --enable-languages=c,c++,ada,fortran,go,lto,objc,obj-c++,d --enable-shared --enable-threads=posix --with-system-zlib --with-isl --enable-__cxa_atexit --disable-libunwind-exceptions --enable-clocale=gnu --disable-libstdcxx-pch --disable-libssp --enable-gnu-unique-object --enable-linker-build-id --enable-lto --enable-plugin --enable-install-libiberty --with-linker-hash-style=gnu --enable-gnu-indirect-function --enable-multilib --disable-werror --enable-checking=release --enable-default-pie --enable-default-ssp --enable-cet=auto gdc_include_dir=/usr/include/dlang/gdc
  Thread model: posix
  gcc version 9.3.0 (Arch Linux 9.3.0-1)
  [perfbuilder@602aed1c266d ~]$

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/setup.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 347b2c0789e4..c5e3e9a68162 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -21,6 +21,8 @@ if cc_is_clang:
             vars[var] = sub("-fstack-clash-protection", "", vars[var])
         if not clang_has_option("-fstack-protector-strong"):
             vars[var] = sub("-fstack-protector-strong", "", vars[var])
+        if not clang_has_option("-fno-semantic-interposition"):
+            vars[var] = sub("-fno-semantic-interposition", "", vars[var])
 
 from distutils.core import setup, Extension
 
-- 
2.21.1

