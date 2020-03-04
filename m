Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BE6C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 22:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5BC2084E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 22:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583360062;
	bh=9xkWWaunI0gSEGO5Cx/X+dLsjBfzYO7QN/sVfu/HjV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uk8awbjhOO0eLeZ11UR+tqV54qN2m1sBF3MUnL+TebuTFSQBud497Ms3QmwK0r3ED
	 oLkpn8OkW3bDiXVb7kEV1OZgM/x5LXdYIMhyimTTN82O8MpQ9IhmQS5l5vkyEbfYIU
	 M/P7u2lN/pYA04jiH4MZLwFwtNHh+/uqWkZqfKWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388506AbgCDWOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 17:14:21 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:33729 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388483AbgCDWOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 17:14:21 -0500
Received: by mail-io1-f68.google.com with SMTP id r15so4250538iog.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 14:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0yZwBZUwL8PIwAcU8o7bWc8CP5XNPRFSTvCyJ7jQ5mQ=;
        b=I4UUtFHvX08Sx91UacVsT5PS2tj7qzVvr6l/ln4WrvjZxc/i8jv/oFJQOcNxDSmPBd
         ybh5nq8cpARJYCIJvgXwLurW1TEnq2g9Nv81GdPBn4liETzXdczFoTIvy6Zw3R1y+sam
         aa2bFrPARsOlrcGFyug0jM1U6XwTvVb4XBbbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0yZwBZUwL8PIwAcU8o7bWc8CP5XNPRFSTvCyJ7jQ5mQ=;
        b=sNCINEbf6HWnZ6Wg9dMEqBjpgP+rW/MtkeV7ThTQ4Gs9T4xahp9R7gfDECWZj8DS7h
         WLtW+oHFDz6zEQISLavghvOjYu2Evw6DKI56PrUtpKdBluSadqvsdeKgEMnDJ1Oy3UhU
         iBIF0fOef4y0PbRqn+4Yosjl7Z9U41KHwxobDsYCbChp0PRlEWz7Vd1OFqivqqz/yn+Y
         Cct7NAnlxMMmCPl0Vh/jUqDp/ZaodONWq3mQ6jz07Uq2vT7zTSS01UMP+aF/Wma9Gz2j
         QU0Bs+clZ8g7Rxr2rGsmz+GpPWHIkCirEBQwPUYWi96lyuFLdnDo1dgDXWVdEuXafqHL
         VF8g==
X-Gm-Message-State: ANhLgQ0HN0yCInM1p2lzKldT+814R859tqUC6LxgW3OtmxTDLiUJfKbq
        gHNTzj9vQag+jdfP50GyGaVKEA==
X-Google-Smtp-Source: ADFU+vu9yfqsq5F9oa+zo3RCZeuK0hGfEJ8oFClTaKU0IJAaGmFuBoMBmSAKAqtJ7WlWRbKZ5R7jew==
X-Received: by 2002:a5d:9697:: with SMTP id m23mr4104634ion.45.1583360060224;
        Wed, 04 Mar 2020 14:14:20 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g12sm6850409iom.5.2020.03.04.14.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 14:14:19 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, keescook@chromium.org, luto@amacapital.net,
        wad@chromium.org, daniel@iogearbox.net, kafai@fb.com, yhs@fb.com,
        andriin@fb.com, gregkh@linuxfoundation.org, tglx@linutronix.de
Cc:     Shuah Khan <skhan@linuxfoundation.org>, khilman@baylibre.com,
        mpe@ellerman.id.au, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH 2/4] selftests: Fix seccomp to support relocatable build (O=objdir)
Date:   Wed,  4 Mar 2020 15:13:33 -0700
Message-Id: <11967e5f164f0cd717921bd382ff9c13ef740146.1583358715.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1583358715.git.skhan@linuxfoundation.org>
References: <cover.1583358715.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix seccomp relocatable builds. This is a simple fix to use the
right lib.mk variable TEST_GEN_PROGS for objects to leverage
lib.mk common framework for relocatable builds.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/seccomp/Makefile | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/selftests/seccomp/Makefile
index 1760b3e39730..a8a9717fc1be 100644
--- a/tools/testing/selftests/seccomp/Makefile
+++ b/tools/testing/selftests/seccomp/Makefile
@@ -1,17 +1,7 @@
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
+TEST_GEN_PROGS := seccomp_bpf seccomp_benchmark
 
-all: $(BINARIES)
+include ../lib.mk
-- 
2.20.1

