Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73349C4BA04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA6C24680
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582673296;
	bh=AXG9qY8xfxZfsbun6EMNib2ecZkzQ66WZo95/pA4kxU=;
	h=To:Cc:From:Subject:Date:List-ID:From;
	b=xR2RAcwprumS3k+adhXTpHgNQpKIaVI2Ot2OLkg9VrqZKzYANSyE92l+6MvdXZVpw
	 BFQbCnJgJ/jAWmGeIbUpUkhg7NSyg7LFyX7g68QYNSYW4zawpj6uA40uiJCkYlCM5u
	 4zubhfjHjmugbzmP1QlZgL+iksUpu90ZnaugA4bg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbgBYX2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:28:15 -0500
Received: from mail-il1-f170.google.com ([209.85.166.170]:37642 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730381AbgBYX0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:45 -0500
Received: by mail-il1-f170.google.com with SMTP id v13so732030iln.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 15:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=TDz13QYqhBENiS22vSmmhoGhcQjNfl8OARybiBG1Mrs=;
        b=HBnc/4KONIeGgrzzqFfzzttUZ+zEBOdpnk44/IB/4atZrHgxU3/zAAiAswYlUTaSae
         l9Ey3TdLyO1uiq1tUbiEMNXS1ulmtUTD8+6QKwxjbWV1YZtacKtp8BYUxz9UUROwWAFL
         JR/I1owdeTpO8ruSP+dcK0d/WF/xzXNC7av/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=TDz13QYqhBENiS22vSmmhoGhcQjNfl8OARybiBG1Mrs=;
        b=rM31XPFv8aZL9JZPZ4MymssjzyEc2B8eV5YTTEtGjxsAHZaZHFNirvKT/VWPghylZP
         AMHDWboVaEpopQggcHeN7esLFXpEfiVAEr0X9ntxe4nM0vAr/0KI02ykn1yDc9I0C+Ci
         rdHDekkdK37S7JA8+xHUIalPjclFMgJ3yBjC87jy3XwfVzyxlc06EBOmDyh7GgV5vxdg
         bcxa8TfBNx1h32HZydCl2k/3qOocQTCbJAbASdGq4hyF3eULorcL61K6yCj2wx6WDyiw
         h/88a3JPROJEw0l0hBfxvh5JqZOyQM36Wnl+oKv3oCfEVzAqnhia6cXeqtSNieM+KbOe
         +uEQ==
X-Gm-Message-State: APjAAAV+PqBt/X+l4K36OvLAFMUWnvRAtJWOTniZoFM3ktKmMfXRSg36
        rTuV1rIQ4QFP8Kg4ZtQ5i+PrpgGN0Pc=
X-Google-Smtp-Source: APXvYqzWBicpJuvTN7crMyGDBGE/zkCkHcJviVB5SzXZL5zSVMouo/XSxKGOPxmJLBko/qThhhiKyw==
X-Received: by 2002:a92:cb89:: with SMTP id z9mr1114854ilo.145.1582673204381;
        Tue, 25 Feb 2020 15:26:44 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z4sm105788ioh.26.2020.02.25.15.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 15:26:43 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest update for Linux 5.6-rc4
Message-ID: <94b64a48-a337-63c4-c504-7e9b0c29a7c6@linuxfoundation.org>
Date:   Tue, 25 Feb 2020 16:26:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------3D667C98074F277C68BC2557"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------3D667C98074F277C68BC2557
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 5.6-rc4.

This Kselftest update for Linux 5.6-rc4 consists of:

- fixes to TIMEOUT failures and out-of-tree compilation compilation
    errors from Michael Ellerman.
- Declutter git status fix from Christophe Leroy

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 9a0584f05687947d5a0b87f046bcd2592a55e67c:

   selftests: openat2: fix build error on newer glibc (2020-02-13 
13:15:45 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.6-rc4

for you to fetch changes up to ef89d0545132d685f73da6f58b7e7fe002536f91:

   selftests/rseq: Fix out-of-tree compilation (2020-02-20 08:57:12 -0700)

----------------------------------------------------------------
linux-kselftest-5.6-rc4

This Kselftest update for Linux 5.6-rc4 consists of:

-  fixes to TIMEOUT failures and out-of-tree compilation compilation
    errors from Michael Ellerman.
- Declutter git status fix from Christophe Leroy

----------------------------------------------------------------
Christophe Leroy (1):
       selftest/lkdtm: Don't pollute 'git status'

Michael Ellerman (2):
       selftests: Install settings files to fix TIMEOUT failures
       selftests/rseq: Fix out-of-tree compilation

  .gitignore                                 | 4 ++++
  tools/testing/selftests/ftrace/Makefile    | 2 +-
  tools/testing/selftests/livepatch/Makefile | 2 ++
  tools/testing/selftests/net/mptcp/Makefile | 2 ++
  tools/testing/selftests/rseq/Makefile      | 4 +++-
  tools/testing/selftests/rtc/Makefile       | 2 ++
  6 files changed, 14 insertions(+), 2 deletions(-)
----------------------------------------------------------------

--------------3D667C98074F277C68BC2557
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-5.6-rc4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.6-rc4.diff"

diff --git a/.gitignore b/.gitignore
index 72ef86a5570d..2763fce8766c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -100,6 +100,10 @@ modules.order
 /include/ksym/
 /arch/*/include/generated/
 
+# Generated lkdtm tests
+/tools/testing/selftests/lkdtm/*.sh
+!/tools/testing/selftests/lkdtm/run.sh
+
 # stgit generated dirs
 patches-*
 
diff --git a/tools/testing/selftests/ftrace/Makefile b/tools/testing/selftests/ftrace/Makefile
index cd1f5b3a7774..d6e106fbce11 100644
--- a/tools/testing/selftests/ftrace/Makefile
+++ b/tools/testing/selftests/ftrace/Makefile
@@ -2,7 +2,7 @@
 all:
 
 TEST_PROGS := ftracetest
-TEST_FILES := test.d
+TEST_FILES := test.d settings
 EXTRA_CLEAN := $(OUTPUT)/logs/*
 
 include ../lib.mk
diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
index 3876d8d62494..1acc9e1fa3fb 100644
--- a/tools/testing/selftests/livepatch/Makefile
+++ b/tools/testing/selftests/livepatch/Makefile
@@ -8,4 +8,6 @@ TEST_PROGS := \
 	test-state.sh \
 	test-ftrace.sh
 
+TEST_FILES := settings
+
 include ../lib.mk
diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 93de52016dde..ba450e62dc5b 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -8,6 +8,8 @@ TEST_PROGS := mptcp_connect.sh
 
 TEST_GEN_FILES = mptcp_connect
 
+TEST_FILES := settings
+
 EXTRA_CLEAN := *.pcap
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index d6469535630a..2af9d39a9716 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -4,7 +4,7 @@ ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
 CLANG_FLAGS += -no-integrated-as
 endif
 
-CFLAGS += -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./ \
+CFLAGS += -O2 -Wall -g -I./ -I../../../../usr/include/ -L$(OUTPUT) -Wl,-rpath=./ \
 	  $(CLANG_FLAGS)
 LDLIBS += -lpthread
 
@@ -19,6 +19,8 @@ TEST_GEN_PROGS_EXTENDED = librseq.so
 
 TEST_PROGS = run_param_test.sh
 
+TEST_FILES := settings
+
 include ../lib.mk
 
 $(OUTPUT)/librseq.so: rseq.c rseq.h rseq-*.h
diff --git a/tools/testing/selftests/rtc/Makefile b/tools/testing/selftests/rtc/Makefile
index 2d93d65723c9..55198ecc04db 100644
--- a/tools/testing/selftests/rtc/Makefile
+++ b/tools/testing/selftests/rtc/Makefile
@@ -6,4 +6,6 @@ TEST_GEN_PROGS = rtctest
 
 TEST_GEN_PROGS_EXTENDED = setdate
 
+TEST_FILES := settings
+
 include ../lib.mk

--------------3D667C98074F277C68BC2557--
