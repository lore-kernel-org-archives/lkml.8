Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2350C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A96820729
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+8EdCnY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbgGUJh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 05:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgGUJh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 05:37:56 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7808FC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 02:37:56 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 8so733588pjj.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 02:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WYIe/jy5Dqr0y+oNjQbbwYu6KlJ30fL8Fok/qL9XnPk=;
        b=n+8EdCnYpI9w4QjiWRKAVS54jZ1Ps1uRqRUyeMZnXiDcZEXJSAelRlHz0Ml+F1dB9w
         fFBlVhu/3eQb2wXD3+96Bq2XlO0LoLyLpTLnOlg0yzKgsjkrjvtCmnVlbgvV+0ieLAZG
         CCTT0VONfgMu7+hMbwOVSaEHRYGxzqLHap34kqpqy2TsGBDWt/1WQb9AlK7/MTXPg41D
         8r44xA1GEWt/a0JFPXlZi4JR7h7DwAHMkFxofBpBZDDl15x0BlC/vPRcLCUmVnND6Tyc
         sDWmNFj604AKKYHszuohS7nTxYkpwr9WcQkGONHCI4XCtw7bYnECs7HfoJIpf2kvKtlX
         h0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WYIe/jy5Dqr0y+oNjQbbwYu6KlJ30fL8Fok/qL9XnPk=;
        b=H9LZFg8KYuEnrQ2LpmA29DmIvWJ8UI9jPqJNdRwlVZIDAz1C7tZzSYKKcsF651y8ZR
         JeA5qC0b/ne4L3V1XKcU4WaaLAO0oxXGqflNxCC/uC4MideDwh4nLwiZJD/GtGPFvRKA
         GnzMaOF+iTDwV5VESxWGzA2ewG0wmyOQYiiiBB86IqBx3lpiHUAyBSTheDAhKNQnwJ15
         a3CfqUtf0fH1ryULuc8HH2FN5uHsPJ/maJF3kdIW0rQw54Hf+QP1vyoUu7OeaaVUY7Dc
         tl+TILX/Vdfo6ToD4lJJdGxWhL9TQg0zFmosx/9mXmRHp59r2XUhYpPBVG23TUTPL98D
         I+JQ==
X-Gm-Message-State: AOAM533WfPc+C9W91v9/crSZ0VC4m6oC3fDj0ioBtHv80WSePacnYl/w
        Iuy+sOQa6rvCDnGcnO1pfBc=
X-Google-Smtp-Source: ABdhPJx3q2vePBy0C8LqpkO73icb5tIVTFbRJ/bGDIEVo3L/J0CavOVeYQJOv7m9OLf97F7tw0lBEw==
X-Received: by 2002:a17:90b:30d7:: with SMTP id hi23mr2989543pjb.69.1595324275934;
        Tue, 21 Jul 2020 02:37:55 -0700 (PDT)
Received: from octofox.cadence.com ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
        by smtp.gmail.com with ESMTPSA id g8sm17653264pgr.70.2020.07.21.02.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 02:37:55 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2] xtensa: add boot subdirectories targets to extra-y
Date:   Tue, 21 Jul 2020 02:37:48 -0700
Message-Id: <20200721093748.26627-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 8fe87a92f262 ("kbuild: always create directories of targets")
exposed an issue in the xtensa makefiles that results in the following
build error in a clean directory:
  scripts/Makefile.build:374: arch/xtensa/boot/boot-elf/boot.lds] Error 1
    arch/xtensa/boot/boot-elf/bootstrap.S:21: fatal error:
    opening dependency file arch/xtensa/boot/boot-elf/.bootstrap.o.d:
    No such file or directory

Intermediate targets in arch/xtensa/boot/boot-elf don't get into
'targets' and build directory is not created for them.
Add boot.lds and bootstrap.o to extra-y in subdirectories of
arch/xtensa/boot.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:
- update boot-redboot/Makefile in the same manner as boot-elf/Makefile.

 arch/xtensa/boot/boot-elf/Makefile     | 1 +
 arch/xtensa/boot/boot-redboot/Makefile | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/xtensa/boot/boot-elf/Makefile b/arch/xtensa/boot/boot-elf/Makefile
index 12ae1e91cb75..ad341c0fff15 100644
--- a/arch/xtensa/boot/boot-elf/Makefile
+++ b/arch/xtensa/boot/boot-elf/Makefile
@@ -15,6 +15,7 @@ export CPPFLAGS_boot.lds += -P -C
 export KBUILD_AFLAGS += -mtext-section-literals
 
 boot-y		:= bootstrap.o
+extra-y		:= boot.lds $(boot-y)
 
 OBJS		:= $(addprefix $(obj)/,$(boot-y))
 
diff --git a/arch/xtensa/boot/boot-redboot/Makefile b/arch/xtensa/boot/boot-redboot/Makefile
index 8632473ad319..022a76a2282a 100644
--- a/arch/xtensa/boot/boot-redboot/Makefile
+++ b/arch/xtensa/boot/boot-redboot/Makefile
@@ -13,6 +13,7 @@ endif
 LD_ARGS	= -T $(srctree)/$(obj)/boot.ld
 
 boot-y	:= bootstrap.o
+extra-y	:= $(boot-y)
 
 OBJS	:= $(addprefix $(obj)/,$(boot-y))
 LIBS	:= arch/xtensa/boot/lib/lib.a arch/xtensa/lib/lib.a
-- 
2.20.1

