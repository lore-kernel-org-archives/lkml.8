Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16727C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4BCA20760
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ln/C0tld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgFKOUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgFKOUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 10:20:16 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C0FC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 07:20:15 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id m2so4625015otr.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 07:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BybovOO8aGpPoJmwvFFOk1oZZ9OgiFYtM64KL0CWDSo=;
        b=ln/C0tldnlBqP2JY7r30qgmpHUsWBEAC2rZ3OXMTkOqFaCx0hMMmN9XNhA9U1Zxvs5
         s+Yr6jqkFPO1+AbEVfTMWcCqc7jJ/9spAmqtzXO346Fpn7tozqPoF/SC9gc2OxWf957M
         +/dIGvtNkHY3nqY7+LDv/6GDOgp5cG5h3Pz4bwffSObjF0OGFpyyAWNg2NUEb+ZLHEtI
         q6CtI3w/dOnNVhAOWGAUomIXd8OIKCpJyNX00hm1DVY9xBNDgMks4JhjWNm4ZpRJ2MQ8
         EfDrAhC+Lg00O1avAuRWvO5bB5FUxoiQU4pokXPbXGwJn1YKKsVb2KwIoGlQrW5GvGz5
         15yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BybovOO8aGpPoJmwvFFOk1oZZ9OgiFYtM64KL0CWDSo=;
        b=mZtaZho6PbRO+7C23zor2xPepeAJReENmSBg6EH0JeXQ5P5+QXjeIyEdxt3R0b9Hz5
         iId3LBatIO65KiRSRh9xJKuPF3Eshx+6vq4eAL3NHiSuCjKk0Ue+5zk5Ka7eXLr41RUL
         JpTM7WcVHv8MjEl8Kbdd/OZjMj8pAk3aPhSOaeSgQsqlmV78e9oQPxFxLZbQqLl67xuv
         rUKVo8pFTseDqEBywCwe56b7+FE8PR4glIEpB/i5+GJ7QQL7BXPMc3F2M61/2ZoW0ewT
         yNJ3a9oSIU6CPcgEy+DQ+4/JfSa3L3MWKKZed+pndlNo80ggmmaDOKRLQuoqIMHl9AeG
         t2GQ==
X-Gm-Message-State: AOAM533BSbzzmgtcvswE1gfF2Nv9uDeHm728xnHCi4sA16X0rzuOVVo7
        sOON/EOyKmtgIwBddCoihgw=
X-Google-Smtp-Source: ABdhPJzsSwGRg5KS494MWN5qdmfKD42/C2xRKuUTtkxjGyOQlhzhi5pK5uqU+jLFGBZt7JTMX0BRfw==
X-Received: by 2002:a05:6830:2:: with SMTP id c2mr7348944otp.9.1591885215122;
        Thu, 11 Jun 2020 07:20:15 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id x191sm693874oix.35.2020.06.11.07.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 07:20:14 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     tobyboy0@gmail.com
Cc:     Jim Cromie <jim.cromie@gmail.com>, Jessica Yu <jeyu@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/module:  add name size info to pr_debug() calls
Date:   Thu, 11 Jun 2020 08:20:09 -0600
Message-Id: <20200611142009.1098058-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when booted with arg: module.dyndbg=+p
dmesg gets volumes of info about loaded modules.
This adds module & symbol names, and sizes where pertinent.
Now I can know which module's info Im looking at.
---
 kernel/module.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index e8a198588f26..d871d9cee9eb 100644
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
+	pr_debug("Core section allocation order for: %s\n", mod->name);
 	for (m = 0; m < ARRAY_SIZE(masks); ++m) {
 		for (i = 0; i < info->hdr->e_shnum; ++i) {
 			Elf_Shdr *s = &info->sechdrs[i];
@@ -2442,7 +2442,7 @@ static void layout_sections(struct module *mod, struct load_info *info)
 		}
 	}
 
-	pr_debug("Init section allocation order:\n");
+	pr_debug("Init section allocation order for: %s\n", mod->name);
 	for (m = 0; m < ARRAY_SIZE(masks); ++m) {
 		for (i = 0; i < info->hdr->e_shnum; ++i) {
 			Elf_Shdr *s = &info->sechdrs[i];
@@ -3276,7 +3276,7 @@ static int move_module(struct module *mod, struct load_info *info)
 		mod->init_layout.base = NULL;
 
 	/* Transfer each section which specifies SHF_ALLOC */
-	pr_debug("final section addresses:\n");
+	pr_debug("final section addresses for: %s\n", mod->name);
 	for (i = 0; i < info->hdr->e_shnum; i++) {
 		void *dest;
 		Elf_Shdr *shdr = &info->sechdrs[i];
@@ -3294,8 +3294,8 @@ static int move_module(struct module *mod, struct load_info *info)
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

