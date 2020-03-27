Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF64C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 06:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E8220716
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 06:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EN7/Lyg4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgC0Gsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 02:48:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43850 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbgC0Gsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 02:48:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id u12so4130816pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 23:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZTdPh9cpqKAayj+42mk/55nYw+jDQf8ejhb0i9ICEnI=;
        b=EN7/Lyg4dzcL5ijfnBiELInv0uwpf9cILpg/iZy1MhtJP1dlI3p/fZu6C0tEtWRcDT
         ciM1ErpmM6twLHmMQ5krksVL0jrw2o1Sla9jBavUg7zJVC/sMQ1TuM1swfQeu6hgQTqQ
         uBfbOptJ0cLByC0Y+tB/fdPP50WYBdQ1ETwDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZTdPh9cpqKAayj+42mk/55nYw+jDQf8ejhb0i9ICEnI=;
        b=L1+R/JiOD0SMLtLoMntXsifafwq6yt8Cri9RZWwkVQ8r3i0pteQRzjMBdXtKr5Rwzj
         oOn9trOkDgFA3Ted2crZwrDgbL+KwxwD2YL2RNxgDq7PwOzA9UblQm+Q1BD/GYKucrkk
         XSIHuzhupFgpktuJJPC7z923U2PPeZrexhx8AhGVwdrHZpJfEYodWg4i/MUoxHEvbd4A
         Oy+z2XTW5v9y/gcIx4Fx28w4JvNf/rv15nfLj5IV9Jb8zRSKMbyJvZ+k13jsu/cQaHo5
         7q74uhm+ZON7aOU9zdI9CUJ+HYhQv4gV/88zNH0iVvp1g+r4ipQJ8NtBAQP+4BS+XfIU
         mFAg==
X-Gm-Message-State: ANhLgQ2d3DgoBFhsqZeWZdMpiXsEx80M/oNDKpe8bSiI0hGUHad/0ZgZ
        9cWiO6EX9MP5rVWgGXZNHRQh+w==
X-Google-Smtp-Source: ADFU+vt7GOdG4GJrRj468GubEkFUve/2A0teR6lM1LEYtLCojGHgXFTocsSWpD7m1gRNKoJs8FD9zw==
X-Received: by 2002:a62:170f:: with SMTP id 15mr12765680pfx.12.1585291707764;
        Thu, 26 Mar 2020 23:48:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a18sm3314835pfr.109.2020.03.26.23.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 23:48:23 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Jann Horn <jannh@google.com>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/6] x86/elf: Split READ_IMPLIES_EXEC from executable PT_GNU_STACK
Date:   Thu, 26 Mar 2020 23:48:16 -0700
Message-Id: <20200327064820.12602-3-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200327064820.12602-1-keescook@chromium.org>
References: <20200327064820.12602-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The READ_IMPLIES_EXEC work-around was designed for old toolchains that
lacked the ELF PT_GNU_STACK marking under the assumption that toolchains
that couldn't specify executable permission flags for the stack may not
know how to do it correctly for any memory region.

This logic is sensible for having ancient binaries coexist in a system
with possibly NX memory, but was implemented in a way that equated having
a PT_GNU_STACK marked executable as being as "broken" as lacking the
PT_GNU_STACK marking entirely. Things like unmarked assembly and stack
trampolines may cause PT_GNU_STACK to need an executable bit, but they
do not imply all mappings must be executable.

This confusion has led to situations where modern programs with explicitly
marked executable stack are forced into the READ_IMPLIES_EXEC state when
no such thing is needed. (And leads to unexpected failures when mmap()ing
regions of device driver memory that wish to disallow VM_EXEC[1].)

In looking for other reasons for the READ_IMPLIES_EXEC behavior, Jann
Horn noted that glibc thread stacks have always been marked RWX (until
2003 when they started tracking the PT_GNU_STACK flag instead[2]). And
musl doesn't support executable stacks at all[3]. As such, no breakage
for multithreaded applications is expected from this change.

[1] https://lkml.kernel.org/r/20190418055759.GA3155@mellanox.com
[2] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=54ee14b3882
[3] https://lkml.kernel.org/r/20190423192534.GN23599@brightrain.aerifal.cx

Suggested-by: Hector Marco-Gisbert <hecmargi@upv.es>
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
---
 arch/x86/include/asm/elf.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index ee459d4c3b45..397a1c74433e 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -288,12 +288,13 @@ extern u32 elf_hwcap2;
  * ELF:                 |            |                  |                |
  * ---------------------|------------|------------------|----------------|
  * missing PT_GNU_STACK | exec-all   | exec-all         | exec-all       |
- * PT_GNU_STACK == RWX  | exec-all   | exec-all         | exec-all       |
+ * PT_GNU_STACK == RWX  | exec-stack | exec-stack       | exec-stack     |
  * PT_GNU_STACK == RW   | exec-none  | exec-none        | exec-none      |
  *
  *  exec-all  : all PROT_READ user mappings are executable, except when
  *              backed by files on a noexec-filesystem.
  *  exec-none : only PROT_EXEC user mappings are executable.
+ *  exec-stack: only the stack and PROT_EXEC user mappings are executable.
  *
  *  *this column has no architectural effect: NX markings are ignored by
  *   hardware, but may have behavioral effects when "wants X" collides with
@@ -302,7 +303,7 @@ extern u32 elf_hwcap2;
  *
  */
 #define elf_read_implies_exec(ex, executable_stack)	\
-	(executable_stack != EXSTACK_DISABLE_X)
+	(executable_stack == EXSTACK_DEFAULT)
 
 struct task_struct;
 
-- 
2.20.1

