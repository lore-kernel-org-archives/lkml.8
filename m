Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF472C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 05:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8684B24683
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 05:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gdPEq+Jj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgBYFNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 00:13:16 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38499 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgBYFNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 00:13:15 -0500
Received: by mail-pg1-f194.google.com with SMTP id d6so6294739pgn.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 21:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZNLE8qanU9tB+qprhCqb5JhCmvZIHAS4t1qFulujc3c=;
        b=gdPEq+JjTnrTNZqPxDtXj3Xt27Obpw016njmHmr0gwgR2L0EhflW7LupjRtFxw9Gzn
         d6sOQ9k8yYEGUOhzaE7ZBqcsy7EJW5gT+CjF9zvaZkZkitVMHy3UQiBPck0XAuOlr352
         foYbhGhFwUKbexhzLsmgLzdkttIU4h/cxj6PY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZNLE8qanU9tB+qprhCqb5JhCmvZIHAS4t1qFulujc3c=;
        b=D1YeRyZlBQowcRGBrF77D8VjWnoJHctNLrXuTdZaFkWpuoRJftfh9aIkxLjL8YaQax
         RgQE6S8OBLSlRrM9juIF6ei87EVADC6wwLtDKBjZgkWSo130dEpausRGsX94EB0E0Hwm
         /FuT2xQ+u8/qH6nhdHfjJHOe8oq4SG6Se85GH0Q7i9JDOFixtkd/6hTa8n1cIx91opRR
         8R/4YioXwv85VOtuh45y1YFMIylgVWZej3Ykwoz3p2q9Pb8zSKtFDH+ofGcQlngRR7iV
         O4rd/2JxZO+Jvrl12WjViFWG6P6LpXuTisTyNsn2k/7Zo0NSqrIDYxSoWkwYEcV1twF3
         B2+w==
X-Gm-Message-State: APjAAAUSQGj9pAZITITfKs6s3hQ3IyM+N+Pmq6KigiiVTjRj0LMjLsr6
        J73Wle4AyaszezRsstA4RJ3RpA==
X-Google-Smtp-Source: APXvYqzhhwjL9Yg+ZfnqgfEq+io+9jGp/eGcRcIoZfPqoFZ+RQ/M8xfh20Jez7PEOAC4j9RETiwkqw==
X-Received: by 2002:aa7:8703:: with SMTP id b3mr53336326pfo.67.1582607593189;
        Mon, 24 Feb 2020 21:13:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z13sm14462509pge.29.2020.02.24.21.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 21:13:11 -0800 (PST)
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
Subject: [PATCH v4 3/6] x86/elf: Disable automatic READ_IMPLIES_EXEC for 64-bit address spaces
Date:   Mon, 24 Feb 2020 21:13:04 -0800
Message-Id: <20200225051307.6401-4-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225051307.6401-1-keescook@chromium.org>
References: <20200225051307.6401-1-keescook@chromium.org>
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

