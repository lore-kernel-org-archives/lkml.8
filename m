Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B230C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 22:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D729120797
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 22:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgIEWXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 18:23:31 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42781 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728740AbgIEWX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 18:23:27 -0400
Received: by mail-qt1-f196.google.com with SMTP id y11so1381327qtn.9
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 15:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6VKPGQC771vLuZ22hJIQJu8j65qHx+zzwcv0HoMyALk=;
        b=I6+9fHDPgvjARdka1ZNLOb4yQs5dtdlAb+Gbmg4H9dMQ0UXC14A/oFtw0JuHq6Ddwu
         ggieAecZmqySH4515FPoram+iV6R+0gBMmaahV1RPucV/MjU2Y3J27D7MwojNWvF5Hdc
         WSHlr/uBr+8zReTe7WljdpwMMsmZTwcTmW/Xg4X1DRpu+oT+qD8nsC/Kh7SE6bCE+L/r
         zZFGYUNxAVn1LeFJ2LpUk2IZYiHKir2T5NSly9Cwep7FT/s125B3Sdz5r+PL1q9XYlZO
         c0cY7DqqVRV2jVNE24CjRKoKuxkjKcWZFsJ9td8o8a5jEKrfBadq7/S5Mt4snbcplrfb
         qi/A==
X-Gm-Message-State: AOAM531Q3TNKZi5nQmw6fy4sPh/M8IlJy/6aiMRVbFdCpT9Xy69oLwGB
        6tL1xkyqrkesw5SbtcBD05s=
X-Google-Smtp-Source: ABdhPJy25YxLs8A/wyWC4Xxmny36u8p0zSKqAgwRY/X5KqPvAX3cTPnsmTAA8t+qP/sDCe7QIx04Ag==
X-Received: by 2002:ac8:7650:: with SMTP id i16mr15068556qtr.268.1599344605851;
        Sat, 05 Sep 2020 15:23:25 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n203sm7323886qke.66.2020.09.05.15.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 15:23:25 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     x86@kernel.org, kasan-dev@googlegroups.com
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] x86/cmdline: Use strscpy to initialize boot_command_line
Date:   Sat,  5 Sep 2020 18:23:23 -0400
Message-Id: <20200905222323.1408968-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200905222323.1408968-1-nivedita@alum.mit.edu>
References: <20200905222323.1408968-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The x86 boot protocol requires the kernel command line to be a
NUL-terminated string of length at most COMMAND_LINE_SIZE (including the
terminating NUL). In case the bootloader messed up and the command line
is too long (hence not NUL-terminated), use strscpy to copy the command
line into boot_command_line. This ensures that boot_command_line is
NUL-terminated, and it also avoids accessing beyond the actual end of
the command line if it was properly NUL-terminated.

Note that setup_arch() will already force command_line to be
NUL-terminated by using strlcpy(), as well as boot_command_line if a
builtin command line is configured. If boot_command_line was not
initially NUL-terminated, the strlen() inside of strlcpy()/strlcat()
will run beyond boot_command_line, but this is almost certainly
harmless in practice.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/kernel/head64.c  |  2 +-
 arch/x86/kernel/head_32.S | 11 +++++------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index cbb71c1b574f..740dd05b9462 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -410,7 +410,7 @@ static void __init copy_bootdata(char *real_mode_data)
 	cmd_line_ptr = get_cmd_line_ptr();
 	if (cmd_line_ptr) {
 		command_line = __va(cmd_line_ptr);
-		memcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
+		strscpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
 	}
 
 	/*
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 7ed84c282233..2a7ced159d6b 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -102,13 +102,12 @@ SYM_CODE_START(startup_32)
 	cld
 	rep
 	movsl
-	movl pa(boot_params) + NEW_CL_POINTER,%esi
-	andl %esi,%esi
+	movl pa(boot_params) + NEW_CL_POINTER,%edx
+	testl %edx,%edx
 	jz 1f			# No command line
-	movl $pa(boot_command_line),%edi
-	movl $(COMMAND_LINE_SIZE/4),%ecx
-	rep
-	movsl
+	movl $pa(boot_command_line),%eax
+	movl $COMMAND_LINE_SIZE,%ecx
+	call strscpy
 1:
 
 #ifdef CONFIG_OLPC
-- 
2.26.2

