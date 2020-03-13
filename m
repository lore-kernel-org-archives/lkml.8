Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6ABC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 21:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D362074A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 21:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584134650;
	bh=gsKkEKc6d0k39o7jrA19JOlTMKCw+3VuNguQ2GPAzd0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=0AHKUjyBv8zhHoW7+2y020+J5jcPBY/h6eTuFX32JLSEGea1ur3xqTAk2nRxs2P55
	 386p8J8U/R60sfHrh6Sd8UxM+CO5mUmt5GOYpLTD6tv30qZPdGVaelKxxWu3mwKdwb
	 op3H37+dSiIh98W/9jibczIWY/dNfNJKuiM8dnl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbgCMVYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 17:24:09 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:34626 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbgCMVYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 17:24:08 -0400
Received: by mail-il1-f196.google.com with SMTP id c8so10554065ilm.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 14:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nh1n7M+VPSrWcMXPYIV91GLW2l6TAX14rIs4m1q72Xw=;
        b=Efks9xuN/oML/BqvA8mL5/SGY7ASxmBkfpBAscYoHao8obdSNy14z5ctKJ/W9oel+D
         Y/vAz9m+Efw7hAsy6BcaEKiS4tQFLBGtQGmLVLAm2ZFhf8eGvlu38VJ8OF6T30m5TzyH
         SAu2lauGOxX81iwxVtgjsYUKlVbdYx57cgbj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nh1n7M+VPSrWcMXPYIV91GLW2l6TAX14rIs4m1q72Xw=;
        b=akVTC3iZxv7xLeMWF99e0Uz5qAPrpDWHB8oF7NHOSv6VC7NQ1VB+LACRfi3lbscXPK
         9WKYB8KyQAXG1YOnLwPfz64ModZ+luropQDOQpsfdRQEVcsMeNrfIVR7+Bl9FsM+Y5DD
         1YgVAKV1fi3mMhEMB3pZUYDXDIRw11GwU26Ljkd0LN8Xa3jpve/tbzmfWF9dhoVGD3KI
         eIz54dB7M5NuAPWxMuUwCrtbsxT/m+SvMWIBTBsz2cxA4B/dp+8GFImt/tec7Ie0TqeG
         lMIyHUNtniPdDGecOpxCcLmfixDAZRMOgg3Qug7X8hDOYmPl6ngbDF+vnqwNPc6rGwFt
         ZpCA==
X-Gm-Message-State: ANhLgQ0NJ1pU/zsMcPMAUiH0Rr6GXoMJjxhRy3g6SsmOiKnAfGlUFoqd
        DuOl7J3pvpqfUJO1Vn/pEMf5FQ==
X-Google-Smtp-Source: ADFU+vuNMKlTjRy366EcWR9ptiTfmLmVzeHxrmdb75AGQiAghLVYgPBSaZofsKRoLtZ4NCp+pGIgbw==
X-Received: by 2002:a92:5fc5:: with SMTP id i66mr15532167ill.303.1584134646641;
        Fri, 13 Mar 2020 14:24:06 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y8sm6824029iot.14.2020.03.13.14.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:24:05 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, keescook@chromium.org, luto@amacapital.net,
        wad@chromium.org, daniel@iogearbox.net, kafai@fb.com, yhs@fb.com,
        andriin@fb.com, gregkh@linuxfoundation.org, tglx@linutronix.de
Cc:     Shuah Khan <skhan@linuxfoundation.org>, khilman@baylibre.com,
        mpe@ellerman.id.au, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH v3] selftests: Fix seccomp to support relocatable build (O=objdir)
Date:   Fri, 13 Mar 2020 15:24:04 -0600
Message-Id: <20200313212404.24552-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix seccomp relocatable builds. This is a simple fix to use the right
lib.mk variable TEST_GEN_PROGS with dependency on kselftest_harness.h
header, and defining LDFLAGS for pthread lib.

Removes custom clean rule which is no longer necessary with the use of
TEST_GEN_PROGS. 

Uses $(OUTPUT) defined in lib.mk to handle build relocation.

The following use-cases work with this change:

In seccomp directory:
make all and make clean

From top level from main Makefile:
make kselftest-install O=objdir ARCH=arm64 HOSTCC=gcc \
 CROSS_COMPILE=aarch64-linux-gnu- TARGETS=seccomp

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---

Changes since v2:
-- Using TEST_GEN_PROGS is sufficient to generate objects.
   Addresses review comments from Kees Cook.

 tools/testing/selftests/seccomp/Makefile | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/selftests/seccomp/Makefile
index 1760b3e39730..a0388fd2c3f2 100644
--- a/tools/testing/selftests/seccomp/Makefile
+++ b/tools/testing/selftests/seccomp/Makefile
@@ -1,17 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0
-all:
-
-include ../lib.mk
+CFLAGS += -Wl,-no-as-needed -Wall
+LDFLAGS += -lpthread
 
 .PHONY: all clean
 
-BINARIES := seccomp_bpf seccomp_benchmark
-CFLAGS += -Wl,-no-as-needed -Wall
+include ../lib.mk
+
+# OUTPUT set by lib.mk
+TEST_GEN_PROGS := $(OUTPUT)/seccomp_bpf $(OUTPUT)/seccomp_benchmark
 
-seccomp_bpf: seccomp_bpf.c ../kselftest_harness.h
-	$(CC) $(CFLAGS) $(LDFLAGS) $< -lpthread -o $@
+$(TEST_GEN_PROGS): ../kselftest_harness.h
 
-TEST_PROGS += $(BINARIES)
-EXTRA_CLEAN := $(BINARIES)
+all: $(TEST_GEN_PROGS)
 
-all: $(BINARIES)
-- 
2.20.1

