Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E220C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A69D207D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbgEUPZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:25:07 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41691 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730387AbgEUPZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:25:02 -0400
Received: by mail-qk1-f193.google.com with SMTP id n11so2097812qkn.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 08:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aMU0eZ8AgltZAHYm5/2XnSEtaaUEJG/1Tqz8iUjHDdI=;
        b=pqJNblOU7lBXVHa5O9YhtxgblVrqqzM+egFwNXRiPfEfwoS6lGYMu97Im+AnCtjWc2
         5HyMYh6mD2uXm01TqS139Ig3RuFhKKT6WyC8RhrhzYgDAJSOnbyx5xmNVJBJBcKwAX8J
         cO48yoVaZsFB852bwMEXGIb9GjO2Wh2NKfocTL+Fg78xXZO6B/PbuqPXwtS7YzRBgvJE
         fY0pNcZ2f2JYRi6mGu9GYnFLN/5VPLIvmZtTmOgj4eVoiqhsVbB9KRQQEbiZuOsJ6t2L
         TwQa78N/SvwPltDjlwmEUqe+8b/dqTGZb9UCVjA1Zr67P7RLXVbFmoxoKmoTGfJkVBsi
         yUEQ==
X-Gm-Message-State: AOAM531sVe1VfZUunQwTMuura9kOnLZdxaJb+HetdJ4NgXy7Zd56jna7
        BzCXYDzSzqnHI76d3nbcqKfv81Uj
X-Google-Smtp-Source: ABdhPJx3B9QCDfXs08wgIejrcEh9M0Yv0jYerx/WP4aaJoq4zfqOqZiq8L5QQGuln+RrvC9TcAjQhg==
X-Received: by 2002:a37:b14:: with SMTP id 20mr4944373qkl.401.1590074700924;
        Thu, 21 May 2020 08:25:00 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k190sm4682687qkf.40.2020.05.21.08.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 08:25:00 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     x86@kernel.org
Cc:     Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/boot: Add .text.startup to setup.ld
Date:   Thu, 21 May 2020 11:24:59 -0400
Message-Id: <20200521152459.558081-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200521021217.yqsulqwfrhqorp7p@google.com>
References: <20200521021217.yqsulqwfrhqorp7p@google.com>
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
this still works. However, LLD git, since [1], is choosing to place it
immediately after the .bstext section instead (this is the first code
section). This plays havoc with the section layout that setup.elf
requires to create the setup header, for eg on 64-bit:

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

[1] https://reviews.llvm.org/D75225

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Reviewed-by: Fangrui Song <maskray@google.com>
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

