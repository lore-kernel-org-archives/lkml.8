Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3073C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B73DA2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1Z5+kKh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbgDMQMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731261AbgDMQMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:12:37 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEEFC0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 09:12:37 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id kx8so3962247pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 09:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=fDNE3d6mNUJZ48JEkXp4cIY6H74jiPrBKw5gp9a7Fs8=;
        b=I1Z5+kKh4OG4NI0RnJGh4hAXQSmKixqK0/ZtT+V/E1y/JONoKSMxkXDmwXpAfVUz9r
         HCq5fTUca2UWzaCsujqnOn3cHKcVMzGblJQff89Fg7EH3KDqO6DIVF1otfjCeMdQBaD6
         KalcJIn4NMTl2ImQ+5hoV6y+UX3RTtYPk9B0bw6zpyhoI9hA/tkcwcgcw4P0Ga187lUj
         Jg6tkz81l7gS6mPJD2417aQ7CrsgOVbP+drlbhUTMHf/V1EKJVXODgFTGOYR51pYO9z6
         9X7tuOo1wCT4rMAYQZO3Y5NiUPyd6ZADPhOYiTCDYn+4N/Esyx98Z9VllCXYO1QCuFXY
         gIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=fDNE3d6mNUJZ48JEkXp4cIY6H74jiPrBKw5gp9a7Fs8=;
        b=QP+kb55dljOSZe3NxDMDdyh0HgNxXNDVw2Y/QHhKO/YJAFwF0VBH0LAOaNdj9SRnuh
         iXtpe6LiIDbrA15jyJ2zudjKRS4hH53aLjaY//dBbOKIdk+intqbJGvHq+Ga9aN6DtWq
         4hLuPbSuP4u1NG4rFwvldhSHYhOSbRFg06JQaKwPhzUvCDHQa1WoSuyU8rKFuYbgfTRB
         pWwnTc5Y3gdSFdlUPgsjwxSoP4pyp8fxWqOumtwBEjs9kxG8Dl4A9zs684T2wXJ6A2d4
         eA3JE5Q/zeFFUL6ETKs7ndfisHVfNmKoDq4DUORXlFk54jesc76HQ6YJJkAxSdObSfhc
         1BfQ==
X-Gm-Message-State: AGi0Puag2w9Jva/l2s52yjnqOf2guFhL1LduiOKvjtdjkPUwAu4cO5nP
        7593id60z53tdbs5YPef9zs=
X-Google-Smtp-Source: APiQypIGgX8jar649ulqr3NbnDbLLAjHgdD2FwNMz8+gXeP4m4l0ak10Ae1rKAmbur6uSwcAvJB7kQ==
X-Received: by 2002:a17:90a:8c83:: with SMTP id b3mr21876434pjo.141.1586794356873;
        Mon, 13 Apr 2020 09:12:36 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u15sm4415133pjm.47.2020.04.13.09.12.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Apr 2020 09:12:36 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH] RISC-V: stacktrace: Declare sp_in_global outside ifdef
Date:   Mon, 13 Apr 2020 09:12:34 -0700
Message-Id: <20200413161234.78346-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

riscv:allnoconfig and riscv:tinyconfig fail to compile.

arch/riscv/kernel/stacktrace.c: In function 'walk_stackframe':
arch/riscv/kernel/stacktrace.c:78:8: error: 'sp_in_global' undeclared

sp_in_global is declared inside CONFIG_FRAME_POINTER but used outside
of it.

Fixes: 52e7c52d2ded ("RISC-V: Stop relying on GCC's register allocator's hueristics")
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Apologies for the noise if this has already been fixed somewhere.

 arch/riscv/kernel/stacktrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 02087fe539c6..6c854875ac74 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -12,6 +12,8 @@
 #include <linux/stacktrace.h>
 #include <linux/ftrace.h>
 
+register unsigned long sp_in_global __asm__("sp");
+
 #ifdef CONFIG_FRAME_POINTER
 
 struct stackframe {
@@ -19,8 +21,6 @@ struct stackframe {
 	unsigned long ra;
 };
 
-register unsigned long sp_in_global __asm__("sp");
-
 void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 			     bool (*fn)(unsigned long, void *), void *arg)
 {
-- 
2.17.1

