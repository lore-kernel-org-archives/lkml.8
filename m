Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E829C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332632071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUE53ebr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390996AbgAXSSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 13:18:15 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35276 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387407AbgAXSSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 13:18:15 -0500
Received: by mail-pj1-f65.google.com with SMTP id q39so193462pjc.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 10:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VeYdzHBTXvWykrU+9dPvzQoIrSk/36JuoL4dl6ucfKw=;
        b=fUE53ebrr8thaaisHxNd6ye4r1UTyIesGmw7CWE4nJB5glAzKUqHqhmPzZia8oZYz7
         1A41t6GPozSzJuddkbiYVBl7yoi7QTn60s1Vaa7Hz06roL0d6YE1f0PE9Es88FOca2HP
         IK4ai98U29vXovpGBzcD25Glq8Iz/U/KFJOuX7SHTMHQXGGeP6BfnRRvsZUBNM83ppFx
         mNwgi5TFTA6Wt+rojcsz5dQt7PgjIoQ/9J37UilSy8C6KpDCYNTsMjALEseE1VgO94Q0
         eJEcX9PcEJuK6bURK/4Nn4Y/5YPt9c4+XvwHqUuea1HwkwBznWKBolvQYFDvOySdRk3b
         PwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VeYdzHBTXvWykrU+9dPvzQoIrSk/36JuoL4dl6ucfKw=;
        b=eDZvIQ/qFuZMm/2m0GnyEMwuoCVCCzRMBdxCXDOMwLwzPonV2q86mzdpGj/dn5W9t9
         rnkKqnK4pE0F2v/4sOzn2N/boeTffAWN8WAU9SVy/Gbi9sw3clDIiYuc4UPi+MUqxtW7
         XJrf+7Amjl7Q60RX8UZCDAS4nnnrnqbZkJhUloxrTOCK3WHeEn58d2EGE7RKIVU1Ovfv
         31cRqkf9yzHGLS9aiTkX4iVYM4XN8iFbv+B069Ukjp5qkJdI8g+V+x+GjQCGX4dITtWQ
         M+6E4Fw5KGGpDk6AF95tI7OUVUxXt3LqTY5Vy5JUTxpGX57XCxTfF/D40Xys4DG7nPo8
         LE1A==
X-Gm-Message-State: APjAAAVcno3iPHYuDt8uwy3l3f60eRhK/NvJe0HtG/tjMnvABBQ4ycbf
        L91bQPEd/AkmWbvsRY8qXrc=
X-Google-Smtp-Source: APXvYqwZSxsjR4PmU6D0ZxtGxQ2OweOomT3ELNRoPNWdaqCM4/yDGhldSxGE3VY2Osoi/5CguomjhA==
X-Received: by 2002:a17:902:848f:: with SMTP id c15mr4837693plo.182.1579889894356;
        Fri, 24 Jan 2020 10:18:14 -0800 (PST)
Received: from gnu-efi-2.localdomain ([172.58.35.93])
        by smtp.gmail.com with ESMTPSA id c22sm6967400pfo.50.2020.01.24.10.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 10:18:13 -0800 (PST)
Received: from gnu-efi-2.localdomain (localhost [IPv6:::1])
        by gnu-efi-2.localdomain (Postfix) with ESMTP id 7E3FD100AB8;
        Fri, 24 Jan 2020 10:18:11 -0800 (PST)
From:   "H.J. Lu" <hjl.tools@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH] x86: Don't clare __force_order in kaslr_64.c
Date:   Fri, 24 Jan 2020 10:18:11 -0800
Message-Id: <20200124181811.4780-1-hjl.tools@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 10 changed the default to -fno-common, which leads to

  LD      arch/x86/boot/compressed/vmlinux
ld: arch/x86/boot/compressed/pgtable_64.o:(.bss+0x0): multiple definition of `__force_order'; arch/x86/boot/compressed/kaslr_64.o:(.bss+0x0): first defined here
make[2]: *** [arch/x86/boot/compressed/Makefile:119: arch/x86/boot/compressed/vmlinux] Error 1

Since __force_order is already provided in pgtable_64.c, there is no
need to declare __force_order in kaslr_64.c.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/boot/compressed/kaslr_64.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr_64.c b/arch/x86/boot/compressed/kaslr_64.c
index 748456c365f4..9557c5a15b91 100644
--- a/arch/x86/boot/compressed/kaslr_64.c
+++ b/arch/x86/boot/compressed/kaslr_64.c
@@ -29,9 +29,6 @@
 #define __PAGE_OFFSET __PAGE_OFFSET_BASE
 #include "../../mm/ident_map.c"
 
-/* Used by pgtable.h asm code to force instruction serialization. */
-unsigned long __force_order;
-
 /* Used to track our page table allocation area. */
 struct alloc_pgt_data {
 	unsigned char *pgt_buf;
-- 
2.24.1

