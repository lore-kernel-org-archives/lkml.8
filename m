Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E285C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 19:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0909C2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 19:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgAMTxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 14:53:40 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35497 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgAMTxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 14:53:40 -0500
Received: by mail-qt1-f195.google.com with SMTP id e12so10235470qto.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 11:53:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wd1hJquGKgYdmDaXrPuAYp9ToVegaqbS9TWk8AmSoxE=;
        b=Vc01JmiT33IexTz9bPOqKw3MkwVHYmJ1aL2tWpRphP5fSmtnambJ89SmsrHlXPkNPN
         IOal7H6Liz8pBlvsFb92Q/4KD11VbFHGy0Z4HvcmkEGa2dzFqfPT135vj2xsK5muMDqM
         4uoSOZsnH41Oje+ITGJSVlCrF1pbvSa5Ccu+uXw/hj0xecI14aiByHsCG7R3oAHA/Em0
         BBxYvxnv58F5gZfYJfhR+U0YWT9OqZa2ZxS9zXA/3UJeCPSM6dzbGlhr0rwL90obMmRw
         nCpSA75oIOWNBUYIz4JiItV7SwZwPD+gpnf/POu4aBcueDKnAna+s0HH43/c/hhPn0Ad
         F+Pg==
X-Gm-Message-State: APjAAAWx8vkITIdiFaYPB26yHk6oIecp6eQvsk18OHQex/ldz/1oUwO1
        p9WD4+fpiwH27QoPuSE02wI=
X-Google-Smtp-Source: APXvYqxIfy76HMH+7bIHqbfMW+gCDY4fIlWCd0QVTWAlVza8sBs17o/GIu3Nq5Ua1lRTcrciudAi0Q==
X-Received: by 2002:ac8:602:: with SMTP id d2mr215552qth.245.1578945218992;
        Mon, 13 Jan 2020 11:53:38 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id j194sm5458569qke.83.2020.01.13.11.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 11:53:38 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Michael Matz <matz@suse.de>
Subject: [PATCH v3] x86/vmlinux: Fix vmlinux.lds.S with pre-2.23 binutils
Date:   Mon, 13 Jan 2020 14:53:37 -0500
Message-Id: <20200113195337.604646-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200113161310.GA191743@rani.riverdale.lan>
References: <20200113161310.GA191743@rani.riverdale.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to binutils-2.23, ld treats the location counter as absolute if
used outside an output section definition. From version 2.23 onwards,
the location counter is treated as relative to an adjacent output
section (usually the previous one, unless there isn't one or the
location counter has been assigned to previously, in which case the next
one).

The result is that a symbol definition in the linker script, such as
	_etext = .;
that appears outside an output section definition makes _etext an
absolute symbol prior to binutils-2.23 and a relative symbol from
version 2.23 onwards. So when using a 2.21 or 2.22 vintage linker, the
build fails with
	Invalid absolute R_X86_64_32S relocation: _etext
for x86-64, and a similar message with R_386_32 for x86-32.

This can be reproduced with the official 2.21.1 and 2.22 binutils
releases.

Commit b907693883fd ("x86/vmlinux: Actually use _etext for the end of
the text segment") moved _etext out of the .text section to place it
after the exception table, however since commit f0d7ee17d57c
("x86/vmlinux: Move EXCEPTION_TABLE to RO_DATA segment") this is no
longer needed. Move _etext back inside .text to make it relative even
with older linkers.

Commit c603a309cc75 ("x86/mm: Identify the end of the kernel area to be
reserved") defines __end_of_kernel_reserve using the location counter
outside an output section definition. Use __bss_stop instead of the
location counter for the definition to make it relative with older
linkers.

Fixes: b907693883fd ("x86/vmlinux: Actually use _etext for the end of the text segment")
Fixes: c603a309cc75 ("x86/mm: Identify the end of the kernel area to be reserved")
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
v3: Modify vmlinux.lds.S instead of adding more workarounds to tools/relocs.c

 arch/x86/kernel/vmlinux.lds.S | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 3a1a819da137..bad4e22384dc 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -144,10 +144,12 @@ SECTIONS
 		*(.text.__x86.indirect_thunk)
 		__indirect_thunk_end = .;
 #endif
+
+		/* End of text section */
+		_etext = .;
 	} :text =0xcccc
 
-	/* End of text section, which should occupy whole number of pages */
-	_etext = .;
+	/* .text should occupy whole number of pages */
 	. = ALIGN(PAGE_SIZE);
 
 	X86_ALIGN_RODATA_BEGIN
@@ -372,7 +374,7 @@ SECTIONS
 	 * explicitly reserved using memblock_reserve() or it will be discarded
 	 * and treated as available memory.
 	 */
-	__end_of_kernel_reserve = .;
+	__end_of_kernel_reserve = __bss_stop;
 
 	. = ALIGN(PAGE_SIZE);
 	.brk : AT(ADDR(.brk) - LOAD_OFFSET) {
-- 
2.24.1

