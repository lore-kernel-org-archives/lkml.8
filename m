Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB12C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A023D20835
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591366594;
	bh=G61HIjVZvMgRo7LlxxL+AVvu+MxFpRf/gwQh5Wz4BXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bZ22GU9mpQMSNi4vSMxvt7ZiyUKbSsjuHRWF8AqZe/WnLVCmdr6gNePfIuli+r7tZ
	 +TdHrcWrcxdFwrIpfHao69dDhJNLQJrq+jHTSnk8VMJAaOHvDDmoG2l4veaKN1KOZf
	 T1A12WYwgGzHUjxpyxj1XKUDu5OKoDImOo1Hssww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgFEOQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:16:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728212AbgFEOQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:16:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF8FB208A9;
        Fri,  5 Jun 2020 14:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591366578;
        bh=G61HIjVZvMgRo7LlxxL+AVvu+MxFpRf/gwQh5Wz4BXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dVCLnCrUuJKAt2cQ4Hpyn34E4nQgqPNYQBqFDLHTIf47hS/2LlC42oifsA1qUbQ5f
         6EHhtOUbjf7cmI8kOuPkIa1ZwQGyit4KYAI/bIzSpNqhwh3PexX3OvbH1bSiNkmSPH
         hLKRkWUyY5tZb/t/0CIenWMw18MaF3dAzfCl+A6g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thorsten Glaser <t.glaser@tarent.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>, stable@kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 01/43] x86/syscalls: Revert "x86/syscalls: Make __X32_SYSCALL_BIT be unsigned long"
Date:   Fri,  5 Jun 2020 16:14:31 +0200
Message-Id: <20200605140152.573595118@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200605140152.493743366@linuxfoundation.org>
References: <20200605140152.493743366@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

[ Upstream commit 700d3a5a664df267f01ec8887fd2d8ff98f67e7f ]

Revert

  45e29d119e99 ("x86/syscalls: Make __X32_SYSCALL_BIT be unsigned long")

and add a comment to discourage someone else from making the same
mistake again.

It turns out that some user code fails to compile if __X32_SYSCALL_BIT
is unsigned long. See, for example [1] below.

 [ bp: Massage and do the same thing in the respective tools/ header. ]

Fixes: 45e29d119e99 ("x86/syscalls: Make __X32_SYSCALL_BIT be unsigned long")
Reported-by: Thorsten Glaser <t.glaser@tarent.de>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: stable@kernel.org
Link: [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=954294
Link: https://lkml.kernel.org/r/92e55442b744a5951fdc9cfee10badd0a5f7f828.1588983892.git.luto@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/uapi/asm/unistd.h       | 11 +++++++++--
 tools/arch/x86/include/uapi/asm/unistd.h |  2 +-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/uapi/asm/unistd.h b/arch/x86/include/uapi/asm/unistd.h
index 196fdd02b8b1..be5e2e747f50 100644
--- a/arch/x86/include/uapi/asm/unistd.h
+++ b/arch/x86/include/uapi/asm/unistd.h
@@ -2,8 +2,15 @@
 #ifndef _UAPI_ASM_X86_UNISTD_H
 #define _UAPI_ASM_X86_UNISTD_H
 
-/* x32 syscall flag bit */
-#define __X32_SYSCALL_BIT	0x40000000UL
+/*
+ * x32 syscall flag bit.  Some user programs expect syscall NR macros
+ * and __X32_SYSCALL_BIT to have type int, even though syscall numbers
+ * are, for practical purposes, unsigned long.
+ *
+ * Fortunately, expressions like (nr & ~__X32_SYSCALL_BIT) do the right
+ * thing regardless.
+ */
+#define __X32_SYSCALL_BIT	0x40000000
 
 #ifndef __KERNEL__
 # ifdef __i386__
diff --git a/tools/arch/x86/include/uapi/asm/unistd.h b/tools/arch/x86/include/uapi/asm/unistd.h
index 196fdd02b8b1..30d7d04d72d6 100644
--- a/tools/arch/x86/include/uapi/asm/unistd.h
+++ b/tools/arch/x86/include/uapi/asm/unistd.h
@@ -3,7 +3,7 @@
 #define _UAPI_ASM_X86_UNISTD_H
 
 /* x32 syscall flag bit */
-#define __X32_SYSCALL_BIT	0x40000000UL
+#define __X32_SYSCALL_BIT	0x40000000
 
 #ifndef __KERNEL__
 # ifdef __i386__
-- 
2.25.1



