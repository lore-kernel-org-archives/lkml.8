Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4879AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 21:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 230D3206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 21:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYy025NM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgGHVKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 17:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgGHVKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 17:10:13 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0FAC061A0B;
        Wed,  8 Jul 2020 14:10:13 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l17so4685105wmj.0;
        Wed, 08 Jul 2020 14:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b784eys00Qgsi/BMM5jGhHc/bDGWKgJTJjPySpMRijA=;
        b=JYy025NMzEmNSpPgiMeWuuPkd5cl0MfwTVBJJZqahDI5dLyrIPOOC9114DaSoraiwb
         I5njcBEugFseAfRHPIpZMJZLYxQ8FWV9kfzv2edy60DBDq36VPQ136CfAbBAZogz4JVw
         inmYt3WV12JZyu6v5eASjLEmtXbbnODgPc8EvSD/lYXrkCW0PvujjLUdNg/PRRoJbz4X
         7NKNti9UxIlRh7PNJ02hb++EtUCk//KujORIriqXgzcp80FHa/qrMndtm82L9mBG7eM+
         z1W6Kg0QrR013Qsj9VYvBtwB5sEXwd3nLySjz5l5FO58XETC1M/fBriY8V7MPVcwLUtS
         tCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=b784eys00Qgsi/BMM5jGhHc/bDGWKgJTJjPySpMRijA=;
        b=qdryP8pPXpUnEwx8Pi8O8JGWyCQv32/PY7LHXVOF6pL67c1LeWk+oiEV4cZKANkCkF
         h4EemZI/7z5mdceLpg1oRQDGt+lZIQAad6FCXfI1ggb3lyjvtBCCqWzbl1A9kdQNeLJc
         +7OcwgiTYjbuvF6y8Aapo3fYKd/Qo6GwcBniJk6UCkq2hxwlxnGpcU0d9o0IJdlnc/N9
         ihSsU4hKg3sQBYeGOugVrv9lZMPqqfzDSORk4LMZh87DNRnSZjb6ujmBIsxVFbwLtyaf
         xvNGNFRbunZmt0RXvq3r1pbwa/2NTO5T08KTUnZiIIhEAE8FH3D5R8DcM8Eq4fwAo+0L
         3a0g==
X-Gm-Message-State: AOAM533FrNSVJGo1izHDzMho1Enqv/ROHaSulDmzxKKYBCoor9WrgtIH
        n19Im7OCIzHWOlaz8XSYTu4=
X-Google-Smtp-Source: ABdhPJymThfiher349tz4isk6gnnzkFVjonVUIrh96INg58P1oUW7qC2OG6tPlKOQAvlGqoyc84r2g==
X-Received: by 2002:a7b:cf10:: with SMTP id l16mr11193177wmg.93.1594242612326;
        Wed, 08 Jul 2020 14:10:12 -0700 (PDT)
Received: from localhost.localdomain ([80.71.140.73])
        by smtp.gmail.com with ESMTPSA id u23sm1971515wru.94.2020.07.08.14.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 14:10:11 -0700 (PDT)
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     linux-riscv@lists.infradead.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] riscv: Support R_RISCV_ADD64 and R_RISCV_SUB64 relocs
Date:   Wed,  8 Jul 2020 23:09:47 +0200
Message-Id: <20200708210948.34197-1-kernel@esmil.dk>
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
---

Tested on the HiFive Unleashed board.

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

