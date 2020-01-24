Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DBAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC022071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+W6XxPn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403919AbgAXSSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 13:18:25 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45323 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391038AbgAXSSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 13:18:25 -0500
Received: by mail-pg1-f193.google.com with SMTP id b9so1508120pgk.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 10:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7xMkbnPA4MrYjyLEKHxSVx8wqcOftv8ZwmhCz9kSnxU=;
        b=i+W6XxPnH5LndDhCYBac50EwO149wBn/cF9EJOYRSaoKKMT4gK66GPLJr31fDEH9qJ
         5xvSMs7ypkwqgUenf71xniNJCWFz8xwl7VKYFxikURW1UzoL0gH3zXjkB16BAJAlyPwR
         Mo1KndwX6YsUulb2RiwlCDPEmJrLaq4aZPgv3POE92hijfhHO8Mqb808afyJrj0Q8AJO
         9ppuErzsu61QRXcCaet2PCa48HH/jj9+ya661BaJw4D/l2Qc03MvfQQw0x4NXnnquFJO
         s7HMLgdj5++7kpnfozuGxCGTfRm7ObluB6Y9Dm2mXOqWYI7g8XW91OB5Ti0JzHxZjHaO
         HpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7xMkbnPA4MrYjyLEKHxSVx8wqcOftv8ZwmhCz9kSnxU=;
        b=Uo5GiHNZSffKXG2g5vvFjg2rcJuL6bS40y1Ut19EHizxUL/42BG7yu4uHhu88zo4pm
         ZEKDVfTxUM0/TOGQwGj+Wro12UCDlYqH8DyWhigDi8c8iT0N/knXY7jDzX9K5+OwXCrN
         6tTruzyKgZLNRqtpOuWuo0biXyBTY/NXO/SzfjymAP+vK1N9MdG49h5gMeWLu7ADV2Gx
         NjAVcGX98tcedRfBksRRiv3iH+Y472hi+Ba4FLfahSiAkAFxkhySZ26+JsVSFEwbnQ9e
         v9pLaTjZvwemGc/1qQZfFyB7Uro2Xxk5tCMjwvvFe1fL8NYR5CEZrOYD0wkGy+o97N12
         +/8A==
X-Gm-Message-State: APjAAAWGv2rjkAI7SA2pZVBmHHDSXKyzVDgPDUrqi5OQpPK0iHUQx/Lv
        0kp2rK5G/DYpkVGV2CSlgB4=
X-Google-Smtp-Source: APXvYqycMEpRCR4lrq81bb3eTel7biBnD2Q/9bf364rX2qDkU7t2IyPIuso7qd246MZl1oRrE3HmTw==
X-Received: by 2002:a65:5242:: with SMTP id q2mr5314449pgp.74.1579889903647;
        Fri, 24 Jan 2020 10:18:23 -0800 (PST)
Received: from gnu-efi-2.localdomain ([2607:fb90:276d:92e7:da4f:90b0:c395:2435])
        by smtp.gmail.com with ESMTPSA id e2sm6849178pfh.84.2020.01.24.10.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 10:18:22 -0800 (PST)
Received: from gnu-efi-2.localdomain (localhost [IPv6:::1])
        by gnu-efi-2.localdomain (Postfix) with ESMTP id B7712100B14;
        Fri, 24 Jan 2020 10:18:21 -0800 (PST)
From:   "H.J. Lu" <hjl.tools@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH 2/2] x86: Discard .note.gnu.property sections in vmlinux
Date:   Fri, 24 Jan 2020 10:18:19 -0800
Message-Id: <20200124181819.4840-3-hjl.tools@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124181819.4840-1-hjl.tools@gmail.com>
References: <20200124181819.4840-1-hjl.tools@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the command-line option, -mx86-used-note=yes, the x86 assembler
in binutils 2.32 and above generates a program property note in a note
section, .note.gnu.property, to encode used x86 ISAs and features.
But x86 kernel linker script only contains a signle NOTE segment:

PHDRS {
 text PT_LOAD FLAGS(5);
 data PT_LOAD FLAGS(6);
 percpu PT_LOAD FLAGS(6);
 init PT_LOAD FLAGS(7);
 note PT_NOTE FLAGS(0);
}
SECTIONS
{
...
 .notes : AT(ADDR(.notes) - 0xffffffff80000000) { __start_notes = .; KEEP(*(.not
e.*)) __stop_notes = .; } :text :note
...
}

which may not be incompatible with note.gnu.property sections.  Since
note.gnu.property section in kernel image is unused, this patch discards
.note.gnu.property sections in kernel linker script by adding

 /DISCARD/ : {
  *(.note.gnu.property)
 }

before .notes sections.  Since .exit.text and .exit.data sections are
discarded at runtime, it undefines EXIT_TEXT and EXIT_DATA to exclude
.exit.text and .exit.data sections from default discarded sections.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/kernel/vmlinux.lds.S | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 3a1a819da137..6c6cc26b0177 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -150,6 +150,11 @@ SECTIONS
 	_etext = .;
 	. = ALIGN(PAGE_SIZE);
 
+	/* .note.gnu.property sections should be discarded */
+	/DISCARD/ : {
+		*(.note.gnu.property)
+	}
+
 	X86_ALIGN_RODATA_BEGIN
 	RO_DATA(PAGE_SIZE)
 	X86_ALIGN_RODATA_END
@@ -413,6 +418,12 @@ SECTIONS
 	STABS_DEBUG
 	DWARF_DEBUG
 
+	/* Sections to be discarded.  EXIT_TEXT and EXIT_DATA discard at runtime.
+	 * not link time.  */
+#undef EXIT_TEXT
+#define EXIT_TEXT
+#undef EXIT_DATA
+#define EXIT_DATA
 	DISCARDS
 	/DISCARD/ : {
 		*(.eh_frame)
-- 
2.24.1

