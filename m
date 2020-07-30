Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB98C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 10:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 224B020809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 10:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oUu4IYhl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgG3KHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 06:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgG3KHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 06:07:09 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D76C061794
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 03:07:07 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id p25so10308020oto.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 03:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=K1KeR4D4Cxr6B4E3uVwjEh93DRQqIOh/GgbC/7cyyaA=;
        b=oUu4IYhlER2voSG0IDa0ssQAiKm1SxB+GsAtXLX1HEacoQg30fXFyu45kI219HcSRy
         4B0BNLsGNa7cMsL/eblAZ8l1bJu1o6//rDqNeEIvJ9oCFNWvQOhbRaEMdNGfN08Zuj+N
         BEV934DtGapCWpH1AjBhOvdaK3ZAPAfltklfB1SB9xgxB//Kdf2RVstSDo/nBUB5wCgU
         wSxIov0jcHzBb6jlwLESRBxMThgdnd6+opiqEIYF01N1IKdrd4jxlZ3W733TYt+6WNMz
         hvKumlKouGQp/e/7OSMpxQcqEao13+ajZ4luYpeYC2nzfEdj+cGrMGf4igUt6GO+H5WH
         EYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=K1KeR4D4Cxr6B4E3uVwjEh93DRQqIOh/GgbC/7cyyaA=;
        b=EsHD4fHwqD5zuLgs14dmBc3DITHGXwIbT57HIxWJd03d5WMN2aHToqyy0ZXaLxEhO9
         Sgn4SSBj5Y6D1PE44W6KRvGFVbTzZNMAEniFkb42HIXjieCkbqMjlt9wf3iZpRhdNrA/
         6RY/e4zSiDnhPa6nwRXHR+HrWt6cz5wQhkov8ONDqCwX9dsBHngT4UPfiC/zT14wSO3t
         GoxngwTWZG9JADgV11ZmxKj1hgyPrYNSWfXVF3/ONOqpl0kWVzXD7js8q04eH6H6eoPr
         0YfVspgtNlMUtGfTTBotvBidv7tHWrhY1PyAKJsyDFIRz6CLNjBUB8xMQ4//TbD08cWU
         g0ag==
X-Gm-Message-State: AOAM533O7IpCjf85MjaqJjjK33m3qP1ajgggGl8BB3YFG1QzsriDNH3D
        0OLOcSzRGikqsLS+PraLRxgm4OqIeGJjV2iDOc0=
X-Google-Smtp-Source: ABdhPJzHFmMNoo3Zw6OznnTP9qoFuJG+FqDsEcSDl4GFkzVrZsUGn1SIe+dTpbnUKQ7oQadDtJP5rrPYVlPoHxJaadk=
X-Received: by 2002:a9d:5e9a:: with SMTP id f26mr1565839otl.109.1596103627030;
 Thu, 30 Jul 2020 03:07:07 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 30 Jul 2020 12:06:55 +0200
Message-ID: <CA+icZUXiz52bk+8bbLTuYCDLqoF9zLiV6NEjzPRgodu3FzCFLg@mail.gmail.com>
Subject: [perf] Explicitly use python[3]-[config]
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wanted to have some detailed numbers for building a Linux-kernel
with GNU-eco-system means GNU/gcc-10 and GNU/binutils-2,35 VS.
LLVM/Clang with its utils version 11.0.0-rc1.

Arnd recommended me to use "perf stat make ...".

First, I tried to build it out of tools/perf from linux.git:

MAKE_OPTS="HOSTCC=clang-11 HOSTCXX=clang++-11 HOSTLD=ld.lld-11
HOSTAR=llvm-ar-11 CC=clang-11 LD=ld.lld-11 AR=llvm-ar-11 NM=llvm-nm-11
OBJCOPY=llvm-objcopy-11 OBJDUMP=llvm-objdump-11 OBJSIZE=llvm-size-11
READELF=llvm-readelf-11 STRIP=llvm-strip-11 LLVM_IAS=1"

LC_ALL=C make V=1 $MAKE_OPTS -C tools/ perf 2>&1 | tee ../build-perf.txt

That showed me - it is building against libpython2.

As python3 is now default for Debian/unstable (and AFAICS
Debian/testing) I wanted to build explicitly against libpython3 at its
python3-config.

This needs some hacks like (furthermore I do not want CID in my version-string):

$ cat ~/src/linux-kernel/perf.diff
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 513633809c81..b4da50754b19 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -225,12 +225,13 @@ endif
 # python[2][-config] in weird combinations but always preferring
 # python2 and python2-config as per pep-0394. If we catch a
 # python[-config] in version 3, the version check will kill it.
-PYTHON2 := $(if $(call get-executable,python2),python2,python)
-override PYTHON := $(call get-executable-or-default,PYTHON,$(PYTHON2))
-PYTHON2_CONFIG := \
+# XXX: Explicitly use python3[-config]. -dileks
+PYTHON3 := $(if $(call get-executable,python3),python3,python)
+override PYTHON := $(call get-executable-or-default,PYTHON,$(PYTHON3))
+PYTHON3_CONFIG := \
   $(if $(call get-executable,$(PYTHON)-config),$(PYTHON)-config,python-config)
 override PYTHON_CONFIG := \
-  $(call get-executable-or-default,PYTHON_CONFIG,$(PYTHON2_CONFIG))
+  $(call get-executable-or-default,PYTHON_CONFIG,$(PYTHON3_CONFIG))

 grep-libs  = $(filter -l%,$(1))
 strip-libs  = $(filter-out -l%,$(1))
diff --git a/tools/perf/util/PERF-VERSION-GEN b/tools/perf/util/PERF-VERSION-GEN
index 59241ff342be..eed9be9a13de 100755
--- a/tools/perf/util/PERF-VERSION-GEN
+++ b/tools/perf/util/PERF-VERSION-GEN
@@ -28,6 +28,8 @@ if test -z "$TAG"
 then
        TAG=$(MAKEFLAGS= make -sC ../.. kernelversion)
 fi
+# XXX: Do not use Git Commit-ID (CID) in version string. -dileks
+CID=
 VN="$TAG$CID"
 if test -n "$CID"
 then

In Debian/unstable libpython-dev:amd64 is version 2.7.17-2 and thus
ships appropriate python[2]-config.

What are your recommendations to build explicitly against python3 and
its python3-config (here: Debian ships python3 version 3.8.5)?

I can send you my build-perf.txt if needed (approx. 830kiB).

Thanks.

Regards,
- Sedat -

[1] https://github.com/ClangBuiltLinux/linux/issues/1086#issuecomment-665540053

P.S.: Uninstall all python2 dev packages and replace them via python3
dev packages.

# diff -uprN packages_0518.txt packages_0519.txt | egrep '^[+|-]ii'
-ii libpython-dev:amd64 2.7.17-2
-ii libpython2-dev:amd64 2.7.17-2
-ii libpython2.7-dev:amd64 2.7.18-1
+ii libpython3-dev:amd64 3.8.2-3
+ii libpython3.8-dev:amd64 3.8.5-1
+ii libunwind-dev:amd64 1.2.1-11
+ii libzstd-dev:amd64 1.4.5+dfsg-3
+ii lz4 1.9.2-2
-ii python-dev 2.7.17-2
-ii python2-dev 2.7.17-2
-ii python2.7-dev 2.7.18-1
+ii python3-dev 3.8.2-3
+ii python3.8-dev 3.8.5-1
+ii systemtap-sdt-dev 4.3-1

- EOT -
