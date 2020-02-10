Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE1EC35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9F5215A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mqEHj3cJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgBJTbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 14:31:07 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35625 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbgBJTbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 14:31:03 -0500
Received: by mail-oi1-f195.google.com with SMTP id b18so10367967oie.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 11:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hedv3uQpLYtG/8d40iSwsTwWwbRFJKr8vrN4ZiDg04Q=;
        b=mqEHj3cJctfFXlmy16cRdbd3ZRwBg+PBoqBPYVmqQH/qHbN5NUcjIYDQxGJmRKQ7wa
         Gh/oTcwv3s+WJTQGeN5oXvRGmYE52sD2Oy62uw9zNjtHK9oLi+CKMUz2V13jB1bNCceN
         HKebkK1prPWHrTSh29Rcs3l4gWJQcq2tOzhxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hedv3uQpLYtG/8d40iSwsTwWwbRFJKr8vrN4ZiDg04Q=;
        b=bb9ZvU2BXaNN8wthBWIjbXPqWZXMvAzw7qK2RAieX9SXticgP0akT/cdvuJ48Wsxaj
         VNUppNbDXOKf9Kr1dloZUNK8OrVDneIK93xsiFXPulD7leb4ProrVdrbih6r2xWPnSQi
         lpZFO7xy+uI/6Ylgv51iFmIbSKq9cdBoAHiTGm+ril1KH1Q7RQXyzbSeT1xoKi1I8cpa
         4rgCTnmvNHJHEUj9Ii9kX5+bzocDBlAZMxD/7nC+++OIfB1reYZlB7JihkhSxF3As/GP
         izRmpunOze943MhsvunM779tpddImqiNkDPgDCDYe9FiM+GJyBHuwHlyBcn4dc8PEc+b
         AUIA==
X-Gm-Message-State: APjAAAX5HLxzz+Heh/f6yUcaHXxGanW8oNTXHJTCPctVMWJsBRlSwST4
        pdAt+FfRdCg3FapIN0GokAVdDA==
X-Google-Smtp-Source: APXvYqxzrrMjKkyUG9U1mzxeIF/mXf4CdliJjd23xPg8Q25YEpKS/E/iAhQV5XTWVKedZ6gqCTRpxg==
X-Received: by 2002:aca:be57:: with SMTP id o84mr419172oif.138.1581363061318;
        Mon, 10 Feb 2020 11:31:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v23sm359350otj.61.2020.02.10.11.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 11:30:58 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Jann Horn <jannh@google.com>,
        Russell King <linux@armlinux.org.uk>, x86@kernel.org,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 3/7] x86/elf: Disable automatic READ_IMPLIES_EXEC for 64-bit address spaces
Date:   Mon, 10 Feb 2020 11:30:45 -0800
Message-Id: <20200210193049.64362-4-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200210193049.64362-1-keescook@chromium.org>
References: <20200210193049.64362-1-keescook@chromium.org>
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
---
 arch/x86/include/asm/elf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index a7035065377c..c9b7be0bcad3 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -287,7 +287,7 @@ extern u32 elf_hwcap2;
  *              CPU: | lacks NX*  | has NX, ia32     | has NX, x86_64 |
  * ELF:              |            |                  |                |
  * -------------------------------|------------------|----------------|
- * missing GNU_STACK | exec-all   | exec-all         | exec-all       |
+ * missing GNU_STACK | exec-all   | exec-all         | exec-none      |
  * GNU_STACK == RWX  | exec-stack | exec-stack       | exec-stack     |
  * GNU_STACK == RW   | exec-none  | exec-none        | exec-none      |
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

