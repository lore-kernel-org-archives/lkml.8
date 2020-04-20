Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD7BC54FD3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 225B72071C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="kyZRc5F5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgDTSdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 14:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgDTSdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 14:33:18 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C4BC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 11:33:18 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 145so3092360pfw.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 11:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RNZ6wZHIoCirh6bnzVOiI/tU10+KcghF4YUOcqBYswc=;
        b=kyZRc5F5hPgOXNr2NFtPU0sE2V5+wPp/P5d3JKwgtHFRbGpHTET5c3Q7BrydCgOBfG
         wS4rZrdIcTkc0q9SatW/+C22bofReNuC9m5Tr6LOr8sMEzAjx6mWQ499/LPgum/b5ZBZ
         8Da14zKiF0u9nSUxwC4Q1D2as3qsU4WV6pzdGI6Ps5tndWYAZiKzJwF8U9pE4JtoBFc3
         QzYA/uq3kZcIrpj/+tB/jkeTwAyJTxcDFZWy8p7xsC39X9NMTIJ6aV82whNeJd/kvLP0
         ugUp9YlmC6TRYtRi+0qxmmqa3LPkBTC+KOIG1UwAs+9puk/r98daQF9ZZEFbaX+jTckI
         WH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RNZ6wZHIoCirh6bnzVOiI/tU10+KcghF4YUOcqBYswc=;
        b=JWVQBeWSxvZYLfmNhk2pyltS21M6HPIB9E1rROL+bl41aZAM/7UlAdBXkLe5chooOp
         LC8+dMyn2hxYmthKG5jblx35FUBwEi2axOjYYMbZ6QDK4fwDDMObNJGWx+5sywPykv5R
         gK9/4gvGW3cmGrA4h/3p5xV1JH4ZGH6+D7xvVe1UT3GtOS90gpaiFZHFl8w9p8oPbna6
         WxXKIJfo07QcNx/cPN0kD3qbuR/gWMsE0H794vXvWDZgvkDiiTdlZDk6FSipgHk43eap
         Eo1HYzSpRogJxeaSdU6OukTtzidt+djdSLEjSLZhtqedeVacTSdF9QHces3WxELYSDvb
         95ig==
X-Gm-Message-State: AGi0PubmUBLcHzEiM4m95sJn5X6lVo0Bfh/I4S6AZ7NmSy/Sp56Nc0rJ
        v/VCFVRVP2erSvv/ETCo4Ue4RQ6GrjK6KQ==
X-Google-Smtp-Source: APiQypIfVNlsOLYrNQRNjpQ5wW1lsVEfXxhXY3c5EfEBZZr2HdqkMyJo4FN+UYiM9Yr59reQPrRMYQ==
X-Received: by 2002:a63:2842:: with SMTP id o63mr18536937pgo.427.1587407597561;
        Mon, 20 Apr 2020 11:33:17 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l185sm172536pfl.104.2020.04.20.11.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 11:33:16 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>, x86@kernel.org,
        Andrei Vagin <avagin@openvz.org>
Subject: [PATCH 3/3] x86/vdso/Makefile: Add vobjs32
Date:   Mon, 20 Apr 2020 19:32:56 +0100
Message-Id: <20200420183256.660371-5-dima@arista.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200420183256.660371-1-dima@arista.com>
References: <20200420183256.660371-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Treat ia32/i386 objects in array the same as 64-bit vdso objects.

Co-developed-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/Makefile | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 433a1259f61d..54e03ab26ff3 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -24,6 +24,8 @@ VDSO32-$(CONFIG_IA32_EMULATION)	:= y
 
 # files to link into the vdso
 vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o
+vobjs32-y := vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
+vobjs32-y += vdso32/vclock_gettime.o
 
 # files to link into kernel
 obj-y				+= vma.o
@@ -37,10 +39,12 @@ vdso_img-$(VDSO32-y)		+= 32
 obj-$(VDSO32-y)			+= vdso32-setup.o
 
 vobjs := $(foreach F,$(vobjs-y),$(obj)/$F)
+vobjs32 := $(foreach F,$(vobjs32-y),$(obj)/$F)
 
 $(obj)/vdso.o: $(obj)/vdso.so
 
 targets += vdso.lds $(vobjs-y)
+targets += vdso32/vdso32.lds $(vobjs32-y)
 
 # Build the vDSO image C files and link them in.
 vdso_img_objs := $(vdso_img-y:%=vdso-image-%.o)
@@ -130,10 +134,6 @@ $(obj)/vdsox32.so.dbg: $(obj)/vdsox32.lds $(vobjx32s) FORCE
 CPPFLAGS_vdso32/vdso32.lds = $(CPPFLAGS_vdso.lds)
 VDSO_LDFLAGS_vdso32.lds = -m elf_i386 -soname linux-gate.so.1
 
-targets += vdso32/vdso32.lds
-targets += vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
-targets += vdso32/vclock_gettime.o
-
 KBUILD_AFLAGS_32 := $(filter-out -m64,$(KBUILD_AFLAGS)) -DBUILD_VDSO
 $(obj)/vdso32.so.dbg: KBUILD_AFLAGS = $(KBUILD_AFLAGS_32)
 $(obj)/vdso32.so.dbg: asflags-$(CONFIG_X86_64) += -m32
@@ -158,12 +158,7 @@ endif
 
 $(obj)/vdso32.so.dbg: KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
 
-$(obj)/vdso32.so.dbg: FORCE \
-		      $(obj)/vdso32/vdso32.lds \
-		      $(obj)/vdso32/vclock_gettime.o \
-		      $(obj)/vdso32/note.o \
-		      $(obj)/vdso32/system_call.o \
-		      $(obj)/vdso32/sigreturn.o
+$(obj)/vdso32.so.dbg: $(obj)/vdso32/vdso32.lds $(vobjs32) FORCE
 	$(call if_changed,vdso_and_check)
 
 #
-- 
2.26.0

