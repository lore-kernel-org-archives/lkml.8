Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88686C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6243A20890
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sV9A8Wyw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgGNHoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 03:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgGNHoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 03:44:02 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92B4C061755;
        Tue, 14 Jul 2020 00:44:01 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l2so3826993wmf.0;
        Tue, 14 Jul 2020 00:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ggXdkn23ixk1Eve60r7XsjTKStmlo12q+Yq1AjF/zbA=;
        b=sV9A8Wyw30q66lBJw75cNAYblVVxR1Ju0crsh9peDxz10t/CMyrWUzW6lfU9EvJe+q
         2jE815KHbIiAMgITgukjEU3bUFXUZ+MJiz8dBjCT4RPfyeTrUCUzZ7T77BASyy3lfVyt
         wxI/2DgTfW7E3AoviAOzGx7njKtYrfm6Cn49beXITRrgDvi6NX3FJodC6GeW1G/laOyl
         oQf6FAbTCGr4RMI23L+42PAwIdxSQkKB91wLs8SwHNYxkCK8MFRzviiWc0IbrJCweUoh
         5MvLjdtjGbyOWdT8isHBEUWM9HDA7x/HJafsBOVo/3hOvnh33KA2YC6g/k0Uwn0ffBzD
         KQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ggXdkn23ixk1Eve60r7XsjTKStmlo12q+Yq1AjF/zbA=;
        b=GNz0r9jeBkbnk9/LS90P2Jg1+A9r9WXTwmIjINvVmF+CBL+6eCbyNtubydUxlvcFSL
         ysg0wjaAxHA5gaAPldQZ83r2ehdsHM7AqwXp9QLu61b2MehJLNEk5EsKpPHpEVvvVzrn
         gZmTdtFQJ/H4nxLIkU5zQgdpD5R9orV02DpdfpjQN3iI8zwUvV+c2u4toOl+MhfKKBGK
         hwtgw7209JjnkHkXiober8lyTdoilcJ9bSc6phXOpHuB1zQOElcAyLLSRkCg+55lyRhw
         yU/SwecG+U8OgAhQ/SuAvCT31zo60+NtqrnBWUWN4Fl2BFXh4U4qtIQHl08MuQDL3VR9
         pPfw==
X-Gm-Message-State: AOAM531shZtqJrBYLg5ul3oASclU7Gv/h+EvP1xf277V/MaJWcmDpIYw
        0cm/M0ZfKGhWhO92CIRM1pIhGTSc3mo=
X-Google-Smtp-Source: ABdhPJwgLr6/ik4l/zvr0ggsE8Od1DP35wwSRZ5i7xL33XAbT6BgrVkW4V/iAqZEsGT5XXC881P39w==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr2982303wmj.136.1594712640353;
        Tue, 14 Jul 2020 00:44:00 -0700 (PDT)
Received: from localhost.localdomain ([80.71.140.73])
        by smtp.gmail.com with ESMTPSA id l132sm3226956wmf.6.2020.07.14.00.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 00:43:59 -0700 (PDT)
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     linux-riscv@lists.infradead.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] riscv: Support R_RISCV_ADD64 and R_RISCV_SUB64 relocs
Date:   Tue, 14 Jul 2020 09:40:43 +0200
Message-Id: <20200714074044.10031-1-kernel@esmil.dk>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are needed for the __jump_table in modules using
static keys/jump-labels with the layout from
HAVE_ARCH_JUMP_LABEL_RELATIVE on 64bit kernels.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Reviewed-by: Björn Töpel <bjorn.topel@gmail.com>
Tested-by: Björn Töpel <bjorn.topel@gmail.com>
---
Tested on the HiFive Unleashed board.

No changes since v2.

This patch is new in v2. It fixes an error loading modules
containing static keys found by Björn Töpel.

 arch/riscv/kernel/module.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 7191342c54da..104fba889cf7 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -263,6 +263,13 @@ static int apply_r_riscv_add32_rela(struct module *me, u32 *location,
 	return 0;
 }
 
+static int apply_r_riscv_add64_rela(struct module *me, u32 *location,
+				    Elf_Addr v)
+{
+	*(u64 *)location += (u64)v;
+	return 0;
+}
+
 static int apply_r_riscv_sub32_rela(struct module *me, u32 *location,
 				    Elf_Addr v)
 {
@@ -270,6 +277,13 @@ static int apply_r_riscv_sub32_rela(struct module *me, u32 *location,
 	return 0;
 }
 
+static int apply_r_riscv_sub64_rela(struct module *me, u32 *location,
+				    Elf_Addr v)
+{
+	*(u64 *)location -= (u64)v;
+	return 0;
+}
+
 static int (*reloc_handlers_rela[]) (struct module *me, u32 *location,
 				Elf_Addr v) = {
 	[R_RISCV_32]			= apply_r_riscv_32_rela,
@@ -290,7 +304,9 @@ static int (*reloc_handlers_rela[]) (struct module *me, u32 *location,
 	[R_RISCV_RELAX]			= apply_r_riscv_relax_rela,
 	[R_RISCV_ALIGN]			= apply_r_riscv_align_rela,
 	[R_RISCV_ADD32]			= apply_r_riscv_add32_rela,
+	[R_RISCV_ADD64]			= apply_r_riscv_add64_rela,
 	[R_RISCV_SUB32]			= apply_r_riscv_sub32_rela,
+	[R_RISCV_SUB64]			= apply_r_riscv_sub64_rela,
 };
 
 int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
-- 
2.27.0

