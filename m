Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A60C35DF2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 05:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F9924684
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 05:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="avzQkIzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgBYFNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 00:13:35 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46736 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgBYFNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 00:13:15 -0500
Received: by mail-pl1-f194.google.com with SMTP id y8so4983466pll.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 21:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YYkEUMiwoqC9g5twl30uamAlKq3Tsh5NtF9u9M+qrn4=;
        b=avzQkIzWP11XHI9dfw+sintU7jSdYyOmCfUcrZbVfI3neNkexyxVoipAlC0aEClJyH
         aCOUDg37itfNNyo5WKHg3hVZ3VCLg6AxDzjoOQ4lSK1OaOhtw93wixoun6PIjwoxoYId
         BANd3swsVOiMeZkStF0wE5AKrSqy5u7EzvUzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YYkEUMiwoqC9g5twl30uamAlKq3Tsh5NtF9u9M+qrn4=;
        b=l4bAZpoPC2Fzrm0VgN2mjlhEhe4s1399ZSzB+I9u2MLJ7xGo8SOb1n74wvjES7Humc
         ShwxBtVYl9wpi7kslLNqZe8QhHn/+irKrsWkFqIeD+Tyr9ePbnMjwJiRtOA/N3HUCD6K
         3SRYLhfEUa3xyQZabTCh5RRYqnXmiFRv96PaWbMQD9vHdeIzUNkadF4avQn8LfuOHN6N
         WUA/pC18cyS0OILQq5dItRwxMu6gxYgzSaYPcnjo4SY+jnClHFL1ApeXIlYcgzxT7xAv
         yH36DAyKVzzfc4Dhp9sO4SE1PRSyPVi0d06aB0AdlV2Igb/+XuSDNEYLsn72Taozj450
         5Pzg==
X-Gm-Message-State: APjAAAV2JFzqvR3w73oY2pZGwui6QHM8KQz6BrS7OgR5gy8xXR0xdQYn
        ixpYSxWl4otnhgmSSiH8HzTmvA==
X-Google-Smtp-Source: APXvYqzBUEzonruL33z1bqgvonSPWOcLoIk/bYLtdQnry1U+j3ClgjvqG2nmE0zuEw4fCLKGWa37Yw==
X-Received: by 2002:a17:902:b617:: with SMTP id b23mr54721739pls.285.1582607594502;
        Mon, 24 Feb 2020 21:13:14 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l69sm14547852pgd.1.2020.02.24.21.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 21:13:11 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Jann Horn <jannh@google.com>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/6] x86/elf: Add table to document READ_IMPLIES_EXEC
Date:   Mon, 24 Feb 2020 21:13:02 -0800
Message-Id: <20200225051307.6401-2-keescook@chromium.org>
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

Add a table to document the current behavior of READ_IMPLIES_EXEC in
preparation for changing the behavior.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
---
 arch/x86/include/asm/elf.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 69c0f892e310..733f69c2b053 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -281,6 +281,25 @@ extern u32 elf_hwcap2;
 /*
  * An executable for which elf_read_implies_exec() returns TRUE will
  * have the READ_IMPLIES_EXEC personality flag set automatically.
+ *
+ * The decision process for determining the results are:
+ *
+ *              CPU: | lacks NX*  | has NX, ia32     | has NX, x86_64 |
+ * ELF:              |            |                  |                |
+ * -------------------------------|------------------|----------------|
+ * missing GNU_STACK | exec-all   | exec-all         | exec-all       |
+ * GNU_STACK == RWX  | exec-all   | exec-all         | exec-all       |
+ * GNU_STACK == RW   | exec-none  | exec-none        | exec-none      |
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
 #define elf_read_implies_exec(ex, executable_stack)	\
 	(executable_stack != EXSTACK_DISABLE_X)
-- 
2.20.1

