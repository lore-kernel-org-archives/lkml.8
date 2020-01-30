Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08277C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 22:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB7220708
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 22:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCivQUGP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbgA3Wpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 17:45:34 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43718 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbgA3Wpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 17:45:34 -0500
Received: by mail-pg1-f194.google.com with SMTP id u131so2388857pgc.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 14:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pJLzxzkNtbblZiMU2t1sW8XMMhW2XUAhXW1NL4oiL6A=;
        b=TCivQUGPIKZ6fn8CFevCtyXI2st0TrHeS9cJtB0B8/ug8HYuiqyEAl3K088O9m+r1g
         dBGNPaHvW8OE/srGEBul10rYXoAdoQyI8ZjH0LodoRKm7rxBaovCdZTLTsB9R5+RZiNq
         dWMtcynOgnwwksu1Rq6c/1SkQPQrEr2WpD/J5tgwZ6iahBGyjVouLLNjdFzbVptvQEqG
         tnBBct1KfQoMlIHFZwah/JeQusmjk32pwMqAtMFiwcFwrTyaSGSoSODKvFUIW8GkmkPn
         c4BNUVJCzRFqXN78ZNqyHREaTFn+aafnkJEnE94lD9H9oSd9E7zPWqTCBpJBzjY5cuqx
         uUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pJLzxzkNtbblZiMU2t1sW8XMMhW2XUAhXW1NL4oiL6A=;
        b=c6E3Ek5vTNWJrfD6TjP2Ae/9PPq/cMU1FdkTeO7Mi09Oe9GdfTVitCnE2fVQ/lbVo/
         XsUhT1NDGMduJa9kbZfWBjXCAUOozES73rydvtFko5K5X5ppcUK8mfbRQIlHSuvVl2Nc
         6PfPUum7CX4uCglkhqAOMx2dmMg2YL+fVOUBSc59OiIdmkgnmZXgFfkWduwTxzoztmK1
         XzeTjGSVJ7J7VRLfd77uuXyFTStK9sIfCRFhc8ErsRTvJEWPq0w59ePWkQw00xOScusq
         upMpnxn5fdv7thWnt6iL1kmapR+afIiS0p6ANGdcD+eoYL68MSU91aqB//DEwu5evftd
         rzuQ==
X-Gm-Message-State: APjAAAWOOSz8eymX5GUQSvfF++tvXtgT3LofYjnuhPkpBR6llFeerS/9
        cGqHPMkBZQ6EevR4IF3ey8o=
X-Google-Smtp-Source: APXvYqzhpw0o69yvYtAggWnTZVCmYRGNK7iqOwqj+WK+bRhuQmDKbfkd8VYIL6TEUYZgvTM26Ogz+Q==
X-Received: by 2002:a62:4e42:: with SMTP id c63mr7278166pfb.86.1580424333344;
        Thu, 30 Jan 2020 14:45:33 -0800 (PST)
Received: from gnu-efi-2.localdomain ([172.58.38.183])
        by smtp.gmail.com with ESMTPSA id u18sm7580429pgi.44.2020.01.30.14.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 14:45:32 -0800 (PST)
Received: from gnu-efi-2.localdomain (localhost [127.0.0.1])
        by gnu-efi-2.localdomain (Postfix) with ESMTP id D6A5F100800;
        Thu, 30 Jan 2020 14:43:37 -0800 (PST)
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
Subject: [PATCH] Discard .note.gnu.property sections in generic NOTES
Date:   Thu, 30 Jan 2020 14:43:37 -0800
Message-Id: <20200130224337.4150-2-hjl.tools@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200130224337.4150-1-hjl.tools@gmail.com>
References: <20200130224337.4150-1-hjl.tools@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the command-line option, -mx86-used-note=yes, the x86 assembler
in binutils 2.32 and above generates a program property note in a note
section, .note.gnu.property, to encode used x86 ISAs and features.  But
kernel linker script only contains a single NOTE segment:

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

The NOTE segment generated by kernel linker script is aligned to 4 bytes.
But .note.gnu.property section must be aligned to 8 bytes on x86-64 and
we get

[hjl@gnu-skx-1 linux]$ readelf -n vmlinux

Displaying notes found in: .notes
  Owner                Data size Description
  Xen                  0x00000006 Unknown note type: (0x00000006)
   description data: 6c 69 6e 75 78 00
  Xen                  0x00000004 Unknown note type: (0x00000007)
   description data: 32 2e 36 00
  xen-3.0              0x00000005 Unknown note type: (0x006e6558)
   description data: 08 00 00 00 03
readelf: Warning: note with invalid namesz and/or descsz found at offset 0x50
readelf: Warning:  type: 0xffffffff, namesize: 0x006e6558, descsize:
0x80000000, alignment: 8
[hjl@gnu-skx-1 linux]$

Since note.gnu.property section in kernel image is never used, this patch
discards .note.gnu.property sections in kernel linker script by adding

/DISCARD/ : {
  *(.note.gnu.property)
}

before kernel NOTE segment in generic NOTES.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
---
 include/asm-generic/vmlinux.lds.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 6b943fb8c5fd..6659a7c07c84 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -818,7 +818,14 @@
 #define TRACEDATA
 #endif
 
+/*
+ * Discard .note.gnu.property sections which are unused and have
+ * different alignment requirement from kernel note sections.
+ */
 #define NOTES								\
+	/DISCARD/ : {							\
+		*(.note.gnu.property)					\
+	}								\
 	.notes : AT(ADDR(.notes) - LOAD_OFFSET) {			\
 		__start_notes = .;					\
 		KEEP(*(.note.*))					\
-- 
2.24.1

