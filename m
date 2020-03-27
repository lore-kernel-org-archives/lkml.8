Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF256C2D0E7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 06:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923DB20714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 06:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QNhpPzdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgC0Gs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 02:48:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43845 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgC0GsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 02:48:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id u12so4130760pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 23:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RpYBuJfY08WhjaxaukJkaddMj0LXmdHxotG0jM4ptqg=;
        b=QNhpPzdqJpCei279jTF+h/ObhmvlR6FTP7G9SeLHFQQYYYl/hOo7K7A4ahYZW9rBTi
         CxTyqKu7s/VDnh0YhGgfs7LNY7Bn+lOco0Y3SE1ZH7MyzXiWqcevIJXEgNfXB9RcIubp
         WtzpdKV9R1aShxwRNBzHJ6OLnP2DSIhS0HLyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RpYBuJfY08WhjaxaukJkaddMj0LXmdHxotG0jM4ptqg=;
        b=CZB1LzTEwONFqH+zKtqCGqo6yroh/Fx7VqGRn+Zf+Ogoj5UfB4iQK8kgxJRcnEKWZl
         IOXExIFuV+JEY5coQwGdEF/JU0kC6OmmhDmjgNvptiIGd4P5WSj4Nanh2LfGQXEs6AIt
         1apRpxyXL36DBKFnwsqtXS7WrusKgU1EQg+udZ+vWMT2aUwNvxkzgEFCJlQIQfkPc3wA
         /4pkcWgKwSvy4hgu3FWDnGo/Tlo9yiANGgzMeyfg+LPCFZWaO16NL9LO4V/PyBGSuFJL
         cfp/JSWktKnaHExcDPaee/EHm0hJGb+CJKPZx0I/Q07Z1qMnlx4ttwT+GgCYIR13wh5V
         53bg==
X-Gm-Message-State: ANhLgQ2TJW3xgMmvPGcHGh0IdFxS4NZnn7fJZ4g9k0aAIwE5i/vJeLTe
        FimQ97T+sshrQfwYnomUxrW8bA==
X-Google-Smtp-Source: ADFU+vsCyDBR9n7viFoDu0Ekx+5WslhiT7XTciFmLxv2z4EAe6/t7zwz9Rj+ofshsa0IFDSE5S7sOw==
X-Received: by 2002:a62:75d0:: with SMTP id q199mr13127618pfc.72.1585291704670;
        Thu, 26 Mar 2020 23:48:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g14sm3227306pfb.131.2020.03.26.23.48.23
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
Subject: [PATCH v5 3/6] x86/elf: Disable automatic READ_IMPLIES_EXEC for 64-bit address spaces
Date:   Thu, 26 Mar 2020 23:48:17 -0700
Message-Id: <20200327064820.12602-4-keescook@chromium.org>
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

With modern x86 64-bit environments, there should never be a need for
automatic READ_IMPLIES_EXEC, as the architecture is intended to always
be execute-bit aware (as in, the default memory protection should be NX
unless a region explicitly requests to be executable).

There were very old x86_64 systems that lacked the NX bit, but for those,
the NX bit is, obviously, unenforceable, so these changes should have
no impact on them.

Suggested-by: Hector Marco-Gisbert <hecmargi@upv.es>
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
---
 arch/x86/include/asm/elf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 397a1c74433e..452beed7892b 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -287,7 +287,7 @@ extern u32 elf_hwcap2;
  *                 CPU: | lacks NX*  | has NX, ia32     | has NX, x86_64 |
  * ELF:                 |            |                  |                |
  * ---------------------|------------|------------------|----------------|
- * missing PT_GNU_STACK | exec-all   | exec-all         | exec-all       |
+ * missing PT_GNU_STACK | exec-all   | exec-all         | exec-none      |
  * PT_GNU_STACK == RWX  | exec-stack | exec-stack       | exec-stack     |
  * PT_GNU_STACK == RW   | exec-none  | exec-none        | exec-none      |
  *
@@ -303,7 +303,7 @@ extern u32 elf_hwcap2;
  *
  */
 #define elf_read_implies_exec(ex, executable_stack)	\
-	(executable_stack == EXSTACK_DEFAULT)
+	(mmap_is_ia32() && executable_stack == EXSTACK_DEFAULT)
 
 struct task_struct;
 
-- 
2.20.1

