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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F198C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 05:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BABE208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 05:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpsYhtzN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgGUFrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 01:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgGUFq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 01:46:59 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E74C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 22:46:59 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o13so11444502pgf.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 22:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6bWhgtkGXl6Kr1YSJF6to7Kggw6JeAK3tzV29Pot9eE=;
        b=GpsYhtzNWnN0HW+fNwL7PAgSnz2F9w1gv/tLKcveDJgBQDYxUBUIW6gU5JOOUvk4gq
         amQNfoE0TPH/tgmQdNg7PiG2xDLyq81+78VOrdMoWyy8v3ataKm75lqQV7oNxr46xUiz
         GXvukLmAed2o9wya4/8gkYJMixGJjDSyhUDzFqSYVWHDMzdqR6WlhifWKCH2Ukyr3Ixm
         eupKPDtf3dt7R8lBIIHmbg+sFNGmvUYGZfjOzHugwyjp6mIZcBXsxIrQdIUdFv28WmY4
         ZrDBbvbbZUwVBLCvzpyLOdGcxr85p0BkLTqqkP3d6Bly3HTKzj0QVjB1W6vusWL0+m4P
         5g2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6bWhgtkGXl6Kr1YSJF6to7Kggw6JeAK3tzV29Pot9eE=;
        b=PvxApVt2ILdTPoTufxuYDlHpInKFy9VUquNRFLXNXvug9h6PWDuRUDKlHMhyu93xzk
         HXqSpPgcn7j1J74XO/aob24wmJLJ+Un74Ynt5NzcAR24utzZX8nVppFl5wGvQBF24Top
         nLJ/kJuZHkLobtlJJodAzaFXYgIb5z3aDzVVmhe2vM1VZerbMb3X5r6BGh1a66Uak9cz
         HdWm0QTUB7ylm+tPgCxY4RRGCXYu1sSPrgRH1pJlSaZ7FXJ5jYRWuB6gaWp65lCuYs6T
         TJH1PYB5CNINglquvFEQ+u0LFdGJqRwlLellWflCj1E25Tn5Vp2Fzk9SLndWSf/c+imk
         b0bA==
X-Gm-Message-State: AOAM532WEO3qr5iVERzhxXx3cs3Hr1fbgWpFszlmE6zo3ECI9cInShmm
        tcOtP9fc7RIZnsSC4pPWC64=
X-Google-Smtp-Source: ABdhPJzgNyDdEMqcJeYOIQMZCmFsOTkWrzjdoFB6sWgk19l9PRscppjrynFmSdft/NL58YhFviHVkw==
X-Received: by 2002:a62:346:: with SMTP id 67mr23020674pfd.111.1595310418976;
        Mon, 20 Jul 2020 22:46:58 -0700 (PDT)
Received: from octofox.cadence.com ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
        by smtp.gmail.com with ESMTPSA id h18sm19110280pfr.186.2020.07.20.22.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 22:46:58 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] xtensa: add boot-elf targets to extra-y
Date:   Mon, 20 Jul 2020 22:46:46 -0700
Message-Id: <20200721054646.18497-1-jcmvbkbc@gmail.com>
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
Add boot.lds and bootstrap.o to extra-y.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/boot/boot-elf/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/xtensa/boot/boot-elf/Makefile b/arch/xtensa/boot/boot-elf/Makefile
index a62a25506536..eb952d809d81 100644
--- a/arch/xtensa/boot/boot-elf/Makefile
+++ b/arch/xtensa/boot/boot-elf/Makefile
@@ -15,6 +15,7 @@ export CPPFLAGS_boot.lds += -P -C
 export KBUILD_AFLAGS += -mtext-section-literals
 
 boot-y		:= bootstrap.o
+extra-y		:= boot.lds $(boot-y)
 
 OBJS		:= $(addprefix $(obj)/,$(boot-y))
 
-- 
2.20.1

