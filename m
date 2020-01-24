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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C88C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E692075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnidnUDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403979AbgAXSSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 13:18:31 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36864 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403923AbgAXSS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 13:18:29 -0500
Received: by mail-pg1-f195.google.com with SMTP id q127so1533821pga.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 10:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x8M6NR2IDJvctZW2oGSylFYVo5vGhU8Q9xmNFw68Rlg=;
        b=cnidnUDd6rqt4TPPCJJpG4h/eSl83a7HHYFYrannnEiNShwYKfQm3snAziCX6cJ6Fh
         yNEm+9HnsiqxnCwenUGc9091BBOA17Glov30gOn3QS+roaoZbLUc9u0RPT5cQsPlTqzm
         5XNictarVRGMhnnjyPmKndjTjwGcsyRy4k9QdD/on0qx2x2VcuEcOCLwWE6d2Q+07bpP
         2k28lT2uH9uTqgbFc8cw2oRJRRzULjfo0OApRBmuzsOMdiyFDOqmdBF4s5hMPvFISJhE
         D65TQalOrzhsklmQhLb3Xr6YBOvQd9wtgQljsFhUx3jSgVIauyfoQR8KBb+al3hB3Poy
         0Kog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x8M6NR2IDJvctZW2oGSylFYVo5vGhU8Q9xmNFw68Rlg=;
        b=qvQMGfP2Vin+Ecwk3//HcEXeZ6nj4g+pg4/A2jPtvdl8QjdwawUkeEm0DMmxDbX2/6
         kNCPHJ+7IJdvbbMA93bkSMoPYgx9Dcjrie1iY6ZrvHeIK+EIHOHMJxSXuie4a/djoKJ7
         VwnFSDaHz1LhsRiJYXRitQvD0CssSHhocPOZc708AkFDThSQg0qpjMl8m/+yB6WD4Dkv
         bRN30psCVNZcLkocVaIhD3wkouleun64YFCR76kSvmcCgteiyA7kUJ25n40yrttsePRN
         yKfrNdDVMVTwUmHw69YvCfzi5x/COndglcwqvgWAaN9HXJaRlgdgz/nGlie8Q40KxQl1
         6Q4Q==
X-Gm-Message-State: APjAAAUDPQUQzrlis9izlJldwmAgxmjW8TVcWV2NOGazw2hekBvmYyzD
        9UzrhMBgW96FTF54YvAj/qs=
X-Google-Smtp-Source: APXvYqx26EDtDpFnY8TW2wg75PX3J4gluUmT+S4VzGbLl96a2icHJn8aHIFQ2t3JRGmnNPYksZKrDA==
X-Received: by 2002:a63:181:: with SMTP id 123mr5369141pgb.36.1579889908650;
        Fri, 24 Jan 2020 10:18:28 -0800 (PST)
Received: from gnu-efi-2.localdomain ([2607:fb90:276d:92e7:da4f:90b0:c395:2435])
        by smtp.gmail.com with ESMTPSA id r66sm7453775pfc.74.2020.01.24.10.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 10:18:28 -0800 (PST)
Received: from gnu-efi-2.localdomain (localhost [IPv6:::1])
        by gnu-efi-2.localdomain (Postfix) with ESMTP id A5BBB100AC3;
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
Subject: [PATCH 1/2] x86: Discard .note.gnu.property sections in vDSO
Date:   Fri, 24 Jan 2020 10:18:18 -0800
Message-Id: <20200124181819.4840-2-hjl.tools@gmail.com>
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
section, .note.gnu.property, to encode used x86 ISAs and features.  X86
kernel vDSO linker script only contains a signle NOTE segment:

PHDRS
{
 text PT_LOAD FLAGS(5) FILEHDR PHDRS; /* PF_R|PF_X */
 dynamic PT_DYNAMIC FLAGS(4); /* PF_R */
 note PT_NOTE FLAGS(4); /* PF_R */
 eh_frame_hdr 0x6474e550;
}

which may not be incompatible with note.gnu.property sections.  Since
note.gnu.property section in vDSO is not used by dynamic linker, this
patch discards .note.gnu.property sections in vDSO by adding

/DISCARD/ : {
 *(.note.gnu.property)
}

before .notes sections.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/entry/vdso/vdso-layout.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
index 93c6dc7812d0..b604da6cc024 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -52,6 +52,10 @@ SECTIONS
 		*(.gnu.linkonce.b.*)
 	}						:text
 
+	/* .note.gnu.property sections should be discarded */
+	/DISCARD/ : {
+		*(.note.gnu.property)
+	}
 	.note		: { *(.note.*) }		:text	:note
 
 	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
-- 
2.24.1

