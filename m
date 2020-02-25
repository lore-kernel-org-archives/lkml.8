Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83891C35DF2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 05:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59ADF24689
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 05:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DcHSUo+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgBYFNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 00:13:19 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35683 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbgBYFNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 00:13:16 -0500
Received: by mail-pf1-f195.google.com with SMTP id i19so6559783pfa.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 21:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QU6tarMcleK7JZEKv6NGFcAaaMn8J85o/O86pl2boI8=;
        b=DcHSUo+5uhomdqc7fCqlU3p2aWJnrlaigJaUEKSmf+9FQuRxJNZKzo7AgMVRkj+enj
         PYAibvmj1Z4N2moDH7SYmegC9w9CQ+j3GWVpJV9v6+s1bSScng2s38DzUzJ80Wqsf+5R
         8k71AqQfgLS9wzWOi0XFRsHjemnvNdL8m/Jzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QU6tarMcleK7JZEKv6NGFcAaaMn8J85o/O86pl2boI8=;
        b=h5zgrOGJ1gtqjsxoy7eTmtK6R8XZ8UHVgOa6ygUar4XuM7lUn/ODyZufqR24r2gbaI
         8RPIUJGo7o1hjmN3Pqe/pC1y/jbbbyTfnngod3jaQa2rm3/Fc+NkE1Lhw8GRlOG7Zuy4
         u3nQr9FfkC0ip5DGkL8v5vOB0hUzhDegHYHt+i0SNFoJYIV0RRKD8+Tip/4cW2E8iMX3
         S3ScnUWqOA1kC8KVaTpOlHho1KqVYjd4j5ctfcOU+dejiEZ8uwHZ1WxoeuEdwmmusbEQ
         AmR4uv4VcP6uLg9GX0gOoFqAn3wjoHDZ2F7S5JhumKO4iswVEhEPC3p3EZ+doEJXVSvJ
         H8Ag==
X-Gm-Message-State: APjAAAWYoNFWRyQfXRbyahmWoD3dETGHfPvXklu1gHKL2IL4nn8oMw5h
        0ThZyv42BHGC5Q8COGrzZIaJZA==
X-Google-Smtp-Source: APXvYqzirNh6rCEGPBMMTd96cFvNHpeUqARTXcwmJmqfs1UtEUIGNuIRJqZRDNbnRdSDNFi3a6YNbQ==
X-Received: by 2002:aa7:9e0b:: with SMTP id y11mr57940549pfq.182.1582607595420;
        Mon, 24 Feb 2020 21:13:15 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s14sm14472732pgv.74.2020.02.24.21.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 21:13:11 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Jann Horn <jannh@google.com>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/6] arm32/64, elf: Add tables to document READ_IMPLIES_EXEC
Date:   Mon, 24 Feb 2020 21:13:05 -0800
Message-Id: <20200225051307.6401-5-keescook@chromium.org>
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

Add tables to document the current behavior of READ_IMPLIES_EXEC in
preparation for changing the behavior for both arm64 and arm.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/kernel/elf.c        | 24 +++++++++++++++++++++---
 arch/arm64/include/asm/elf.h | 20 ++++++++++++++++++++
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/elf.c b/arch/arm/kernel/elf.c
index 182422981386..2f69cf978fe3 100644
--- a/arch/arm/kernel/elf.c
+++ b/arch/arm/kernel/elf.c
@@ -78,9 +78,27 @@ void elf_set_personality(const struct elf32_hdr *x)
 EXPORT_SYMBOL(elf_set_personality);
 
 /*
- * Set READ_IMPLIES_EXEC if:
- *  - the binary requires an executable stack
- *  - we're running on a CPU which doesn't support NX.
+ * An executable for which elf_read_implies_exec() returns TRUE will
+ * have the READ_IMPLIES_EXEC personality flag set automatically.
+ *
+ * The decision process for determining the results are:
+ *
+ *              CPU: | lacks NX*  | has NX     |
+ * ELF:              |            |            |
+ * -------------------------------|------------|
+ * missing GNU_STACK | exec-all   | exec-all   |
+ * GNU_STACK == RWX  | exec-all   | exec-all   |
+ * GNU_STACK == RW   | exec-all   | exec-none  |
+ *
+ *  exec-all  : all PROT_READ user mappings are executable, except when
+ *              backed by files on a noexec-filesystem.
+ *  exec-none : only PROT_EXEC user mappings are executable.
+ *
+ *  *this column has no architectural effect: NX markings are ignored by
+ *   hardware, but may have behavioral effects when "wants X" collides with
+ *   "cannot be X" constraints in memory permission flags, as in
+ *   https://lkml.kernel.org/r/20190418055759.GA3155@mellanox.com
+ *
  */
 int arm_elf_read_implies_exec(int executable_stack)
 {
diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index b618017205a3..7fc779e3f1ec 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -96,6 +96,26 @@
  */
 #define elf_check_arch(x)		((x)->e_machine == EM_AARCH64)
 
+/*
+ * An executable for which elf_read_implies_exec() returns TRUE will
+ * have the READ_IMPLIES_EXEC personality flag set automatically.
+ *
+ * The decision process for determining the results are:
+ *
+ *             CPU*: | arm32      | arm64      |
+ * ELF:              |            |            |
+ * -------------------------------|------------|
+ * missing GNU_STACK | exec-all   | exec-all   |
+ * GNU_STACK == RWX  | exec-all   | exec-all   |
+ * GNU_STACK == RW   | exec-none  | exec-none  |
+ *
+ *  exec-all  : all PROT_READ user mappings are executable, except when
+ *              backed by files on a noexec-filesystem.
+ *  exec-none : only PROT_EXEC user mappings are executable.
+ *
+ *  *all arm64 CPUs support NX, so there is no "lacks NX" column.
+ *
+ */
 #define elf_read_implies_exec(ex,stk)	(stk != EXSTACK_DISABLE_X)
 
 #define CORE_DUMP_USE_REGSET
-- 
2.20.1

