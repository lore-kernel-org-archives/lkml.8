Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B398BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FAB520772
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNKvEm91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387428AbgF3RJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbgF3RJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:09:14 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0420BC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 10:09:15 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id h17so18122868oie.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 10:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k6xOYRCnbnCwhMTbrNVFqeA6/rrYwhxJ6Anj7rJmp94=;
        b=hNKvEm91oQmOFCsp4nHDM2vQ1IeL/5wqVTenZfCJwm/PaIRy5sw9Sr9QXeUCXb7X/N
         zSkHn4sc7qcLAUG7t0S1TKARQuToYGIShoF06c9yuTqP2Jmdo/d0iGp6GgHgV0OWCQAF
         p0t25gUazhHNUZb+LmidFPdxmqGrryNu10gykMTqHHkLwnwSpUPE792ykmyN4KltwAT+
         db1wv9lqRDpGDxWIJZIi2Scv/D5bWkyANMr2yh0ViilSqJOgxN0hctDncCs2uk1ism0H
         RyOWc4BsAmf6GKD7hbYbLtKTmnEWSwVthGOMtcvP+olRGpimGH8Cl1FayO9m3NkDzf68
         PFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k6xOYRCnbnCwhMTbrNVFqeA6/rrYwhxJ6Anj7rJmp94=;
        b=ZQmPV9Qj8mciT9KXAvQDigO0PP1oXLF8lt88EzybM76X0wjw6pH1cFgW+89DPD7sjA
         zIETCCgsWKI/BLcyu3mJNIpPUT0dcrvbikVKMlqWAZxRNyZ/oFzy6mqR4yVESOxQQufa
         R2gs0gLh7QgHOcdLSjgjgbthBl3f3MYIdg6/h88GPwAOsDZy0PAzzNFFPccYpiYAlzus
         P0+/PPr+HPcPDJXcOprqn+cqyjJGiXEAQZ8bILgyW1PFTbZM9wmU0NoknLPpkmM7BZtN
         fBM7oq4EYUmKyw9kVdx2oomPdd46FocELRAQAvO0QJaVfHFn7MKJWdhbq8RYoWNXNgc9
         x8Vg==
X-Gm-Message-State: AOAM531AoxDea+UV4i8oUMTw9urdPQRpGL6W0q/oWr1svn6Z/K7nZj/v
        0DarsUavgizEXe0ZneaJlwU=
X-Google-Smtp-Source: ABdhPJw0YqnH4tYDVvxI2wrN373sX59dCUnOJErGJHHo5pDbdtIG5QeqewqAo1b5hSsSZiUASLNiPw==
X-Received: by 2002:aca:a88a:: with SMTP id r132mr9061725oie.48.1593536954218;
        Tue, 30 Jun 2020 10:09:14 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0:d2d5:b03d:84f7:d145])
        by smtp.googlemail.com with ESMTPSA id a204sm800995oii.34.2020.06.30.10.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 10:09:13 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2] kernel/module:  add name size info to pr_debug() calls
Date:   Tue, 30 Jun 2020 11:09:03 -0600
Message-Id: <20200630170903.1320459-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the kernel is booted with arg: module.dyndbg=+p, dmesg gets
volumes of info about layout details of loaded modules.  This adds
module & symbol names to those messages, and sizes where pertinent.
Since these are debug messages, I thought sizes might be useful to
somebody, without adding clutter or or too much info.

Now a reader can know which module's info they're looking at, or which
2 modules they are comparing.

--
v2 has:
better commit message
s/:%s/%s:/
s/final/Final/

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 kernel/module.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 0c6573b98c36..809490145b77 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2294,8 +2294,8 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
 
 		case SHN_ABS:
 			/* Don't need to do anything */
-			pr_debug("Absolute symbol: 0x%08lx\n",
-			       (long)sym[i].st_value);
+			pr_debug("Absolute symbol: 0x%08lx %s\n",
+				 (long)sym[i].st_value, name);
 			break;
 
 		case SHN_LIVEPATCH:
@@ -2409,7 +2409,7 @@ static void layout_sections(struct module *mod, struct load_info *info)
 	for (i = 0; i < info->hdr->e_shnum; i++)
 		info->sechdrs[i].sh_entsize = ~0UL;
 
-	pr_debug("Core section allocation order:\n");
+	pr_debug("Core section allocation order for %s:\n", mod->name);
 	for (m = 0; m < ARRAY_SIZE(masks); ++m) {
 		for (i = 0; i < info->hdr->e_shnum; ++i) {
 			Elf_Shdr *s = &info->sechdrs[i];
@@ -2442,7 +2442,7 @@ static void layout_sections(struct module *mod, struct load_info *info)
 		}
 	}
 
-	pr_debug("Init section allocation order:\n");
+	pr_debug("Init section allocation order for %s:\n", mod->name);
 	for (m = 0; m < ARRAY_SIZE(masks); ++m) {
 		for (i = 0; i < info->hdr->e_shnum; ++i) {
 			Elf_Shdr *s = &info->sechdrs[i];
@@ -3278,7 +3278,7 @@ static int move_module(struct module *mod, struct load_info *info)
 		mod->init_layout.base = NULL;
 
 	/* Transfer each section which specifies SHF_ALLOC */
-	pr_debug("final section addresses:\n");
+	pr_debug("Final section addresses for %s:\n", mod->name);
 	for (i = 0; i < info->hdr->e_shnum; i++) {
 		void *dest;
 		Elf_Shdr *shdr = &info->sechdrs[i];
@@ -3296,8 +3296,8 @@ static int move_module(struct module *mod, struct load_info *info)
 			memcpy(dest, (void *)shdr->sh_addr, shdr->sh_size);
 		/* Update sh_addr to point to copy in image. */
 		shdr->sh_addr = (unsigned long)dest;
-		pr_debug("\t0x%lx %s\n",
-			 (long)shdr->sh_addr, info->secstrings + shdr->sh_name);
+		pr_debug("\t0x%lx 0x%.8lx %s\n", (long)shdr->sh_addr,
+			 (long)shdr->sh_size, info->secstrings + shdr->sh_name);
 	}
 
 	return 0;
-- 
2.26.2

