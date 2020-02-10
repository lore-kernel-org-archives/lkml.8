Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75410C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453E72085B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T33oewBV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgBJTbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 14:31:09 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40370 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbgBJTbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 14:31:03 -0500
Received: by mail-ot1-f65.google.com with SMTP id i6so7553890otr.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 11:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SoMlqkPW6d6t+DyvhcmYwhC/CLbcIQw6Iq6GyurXq7I=;
        b=T33oewBV6LwB0gLY4Y/wgyTFEjrMO+tsNjLjNsIx462NvY6k878hEut+t0Dxl2+T2m
         qFIdoyfwpqsSACJuHqubYuHgW9i9yCone4feFBOegL9ifmir/GKpPSzwOTAIQnR0UiIU
         XYJjaM8SHWaBn2q9MVLaVWC/Ev/hNh/61qVfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SoMlqkPW6d6t+DyvhcmYwhC/CLbcIQw6Iq6GyurXq7I=;
        b=SZeXKnU1CAXHSS4l5XkyS58Kj/ClF0dE2P5cDYp4TkZIoAqMCB3Q0lvARWon1K+QSe
         B96AKgnLnkv5h8anUpRExXhfYao2IqX77nZj/gD8/a6dVE1PRS4Y7b6W0dOcYb/gSpdx
         sjhlPJ5QMq8T0ZCZULajTq+PBIbf0Kdrm83j+zyRGXkJ2psWMQKn5N2uW/NoBXXj7seR
         4l00/12avm9MCHZVVukm/x5AJmU0NgBXNixJx31nnf/ISv5vgxgDPrytyh8s270GNAt9
         vEF+kswgM3oV5XvUPuTJ5Dax9AvAuDxB6HBoUZB5Ifz9JSAnuPPFbPM8+ZNSu+pH/kPZ
         H7VQ==
X-Gm-Message-State: APjAAAWFhPM6eRjAdmCZyr5cp795WD6csP4lOtT7bZ+S460vgpTnYKNP
        IsqJHllG/+yYuiETs7IhSUDYUQ==
X-Google-Smtp-Source: APXvYqzYj09UqOIqVmchmtjHU0/10JBletVlAeKEV0PL33eea4MKTG5zvEVavNY7MuTpo2yAvLV8pg==
X-Received: by 2002:a05:6830:1353:: with SMTP id r19mr2298000otq.288.1581363061874;
        Mon, 10 Feb 2020 11:31:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m19sm362991otn.47.2020.02.10.11.30.58
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
Subject: [PATCH v3 2/7] x86/elf: Split READ_IMPLIES_EXEC from executable GNU_STACK
Date:   Mon, 10 Feb 2020 11:30:44 -0800
Message-Id: <20200210193049.64362-3-keescook@chromium.org>
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

The READ_IMPLIES_EXEC work-around was designed for old toolchains that
lacked the ELF PT_GNU_STACK marking under the assumption that toolchains
that couldn't specify executable permission flags for the stack may not
know how to do it correctly for any memory region.

This logic is sensible for having ancient binaries coexist in a system
with possibly NX memory, but was implemented in a way that equated having
a PT_GNU_STACK marked executable as being as "broken" as lacking the
PT_GNU_STACK marking entirely. Things like unmarked assembly and stack
trampolines may cause PT_GNU_STACK to need an executable bit, but they
do not imply all mappings must be executable.

This confusion has led to situations where modern programs with explicitly
marked executable stack are forced into the READ_IMPLIES_EXEC state when
no such thing is needed. (And leads to unexpected failures when mmap()ing
regions of device driver memory that wish to disallow VM_EXEC[1].)

In looking for other reasons for the READ_IMPLIES_EXEC behavior, Jann
Horn noted that glibc thread stacks have always been marked RWX (until
2003 when they started tracking the PT_GNU_STACK flag instead[2]). And
musl doesn't support executable stacks at all[3]. As such, no breakage
for multithreaded applications is expected from this change.

[1] https://lkml.kernel.org/r/20190418055759.GA3155@mellanox.com
[2] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=54ee14b3882
[3] https://lkml.kernel.org/r/20190423192534.GN23599@brightrain.aerifal.cx

Suggested-by: Hector Marco-Gisbert <hecmargi@upv.es>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/elf.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 733f69c2b053..a7035065377c 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -288,12 +288,13 @@ extern u32 elf_hwcap2;
  * ELF:              |            |                  |                |
  * -------------------------------|------------------|----------------|
  * missing GNU_STACK | exec-all   | exec-all         | exec-all       |
- * GNU_STACK == RWX  | exec-all   | exec-all         | exec-all       |
+ * GNU_STACK == RWX  | exec-stack | exec-stack       | exec-stack     |
  * GNU_STACK == RW   | exec-none  | exec-none        | exec-none      |
  *
  *  exec-all  : all PROT_READ user mappings are executable, except when
  *              backed by files on a noexec-filesystem.
  *  exec-none : only PROT_EXEC user mappings are executable.
+ *  exec-stack: only the stack and PROT_EXEC user mappings are executable.
  *
  *  *this column has no architectural effect: NX markings are ignored by
  *   hardware, but may have behavioral effects when "wants X" collides with
@@ -302,7 +303,7 @@ extern u32 elf_hwcap2;
  *
  */
 #define elf_read_implies_exec(ex, executable_stack)	\
-	(executable_stack != EXSTACK_DISABLE_X)
+	(executable_stack == EXSTACK_DEFAULT)
 
 struct task_struct;
 
-- 
2.20.1

