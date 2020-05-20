Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6ECAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 22:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DC3E20884
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 22:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgETW5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 18:57:00 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:36507 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbgETW46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 18:56:58 -0400
Received: by mail-qv1-f66.google.com with SMTP id f89so2225498qva.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 15:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oroy5IuCfj8lq18W1ZeqHx5gvyy3A0ZRqu7ynovXPPU=;
        b=FcU0c6PWz/kqm1p8QML2m6Yana8xN/ga9f6sRGffDnLEImrYkgeJ8yOW+5xJnIcseF
         j36eHs/0ZehkMxMNApZww4JkDwPPid1D1TMAjIHgBoy7txWe7nvrSFSzzSj/kmZb+t9u
         HWb1O0GX3LrkjRO7Yw25M3JbxtO1kqTU2LFjNCIzjFDtydB/djFjWt2D8NlhYSS1PRE6
         D8/D5NlECKwHVwtP6OFbGjYW51DThI7jSop9gi4LDSVeMLwWjK03ZFqz3wB8q69ALU4X
         lL5UGNEF5+DsQA0z0Ar/TyQL1vM9XYAOH/JWBVW4kxpqN0ymuDHh9Q55X5J/Nt9bXvhP
         9i4w==
X-Gm-Message-State: AOAM532BKzgyg7N2TlAAikvz1FLjzqqgicLaoG9a3DqdtCldlpAjjMEA
        2Hq+5n+X5uZPAiIo+tZno7k=
X-Google-Smtp-Source: ABdhPJyXczSgGGHpoFefBJcmUY1xbhkTb9J10adIvCXUJDxN4REyVATEEnBGfDTeYIiKzdEv4pipsQ==
X-Received: by 2002:ad4:4690:: with SMTP id bq16mr7104434qvb.20.1590015416896;
        Wed, 20 May 2020 15:56:56 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t195sm2221514qke.110.2020.05.20.15.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 15:56:56 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     clang-built-linux@googlegroups.com, x86@kernel.org
Cc:     Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] x86/boot: Add .text.startup to setup.ld
Date:   Wed, 20 May 2020 18:56:54 -0400
Message-Id: <20200520225654.4144534-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520225654.4144534-1-nivedita@alum.mit.edu>
References: <20200520225654.4144534-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc puts the main function into .text.startup when compiled with -Os (or
-O2). This results in arch/x86/boot/main.c having a .text.startup
section which is currently not included explicitly in the linker script
setup.ld in the same directory.

The BFD linker places this orphan section immediately after .text, so
this still works. However, LLD git, on 64-bit only, is choosing to place
it immediately after the .bstext section instead (this is the first code
section). This plays havoc with the section layout that setup.elf
requires to create the setup header:

    LD      arch/x86/boot/setup.elf
  ld.lld: error: section .text.startup file range overlaps with .header
  >>> .text.startup range is [0x200040, 0x2001FE]
  >>> .header range is [0x2001EF, 0x20026B]

  ld.lld: error: section .header file range overlaps with .bsdata
  >>> .header range is [0x2001EF, 0x20026B]
  >>> .bsdata range is [0x2001FF, 0x200398]

  ld.lld: error: section .bsdata file range overlaps with .entrytext
  >>> .bsdata range is [0x2001FF, 0x200398]
  >>> .entrytext range is [0x20026C, 0x2002D3]

  ld.lld: error: section .text.startup virtual address range overlaps
  with .header
  >>> .text.startup range is [0x40, 0x1FE]
  >>> .header range is [0x1EF, 0x26B]

  ld.lld: error: section .header virtual address range overlaps with
  .bsdata
  >>> .header range is [0x1EF, 0x26B]
  >>> .bsdata range is [0x1FF, 0x398]

  ld.lld: error: section .bsdata virtual address range overlaps with
  .entrytext
  >>> .bsdata range is [0x1FF, 0x398]
  >>> .entrytext range is [0x26C, 0x2D3]

  ld.lld: error: section .text.startup load address range overlaps with
  .header
  >>> .text.startup range is [0x40, 0x1FE]
  >>> .header range is [0x1EF, 0x26B]

  ld.lld: error: section .header load address range overlaps with
  .bsdata
  >>> .header range is [0x1EF, 0x26B]
  >>> .bsdata range is [0x1FF, 0x398]

  ld.lld: error: section .bsdata load address range overlaps with
  .entrytext
  >>> .bsdata range is [0x1FF, 0x398]
  >>> .entrytext range is [0x26C, 0x2D3]

Explicitly pull .text.startup into the .text output section to avoid
this.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/setup.ld | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
index 24c95522f231..ed60abcdb089 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -20,7 +20,7 @@ SECTIONS
 	.initdata	: { *(.initdata) }
 	__end_init = .;
 
-	.text		: { *(.text) }
+	.text		: { *(.text.startup) *(.text) }
 	.text32		: { *(.text32) }
 
 	. = ALIGN(16);
-- 
2.26.2

