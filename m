Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC93CC35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C476920836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgBXLhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 06:37:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49584 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgBXLhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 06:37:06 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j6C2n-0000qe-AV; Mon, 24 Feb 2020 12:37:01 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id ED6F21C2134;
        Mon, 24 Feb 2020 12:37:00 +0100 (CET)
Date:   Mon, 24 Feb 2020 11:37:00 -0000
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/compressed: Remove .eh_frame section from bzImage
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200109150218.16544-2-nivedita@alum.mit.edu>
References: <20200109150218.16544-2-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <158254422067.28353.10866888120950973607.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     0eea39a234dc52063d14541fabcb2c64516a2328
Gitweb:        https://git.kernel.org/tip/0eea39a234dc52063d14541fabcb2c64516a2328
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Thu, 09 Jan 2020 10:02:18 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 24 Feb 2020 12:30:28 +01:00

x86/boot/compressed: Remove .eh_frame section from bzImage

Discarding unnecessary sections with "*(*)" (see thread at Link: below)
works fine with the bfd linker but fails with lld:

  $ make -j$(nproc) -s CC=clang LD=ld.lld O=out.x86_64 distclean defconfig bzImage
  ld.lld: error: discarding .shstrtab section is not allowed

lld tries to also discard essential sections like .shstrtab, .symtab and
.strtab, which results in the link failing since .shstrtab is required
by the ELF specification: the e_shstrndx field in the ELF header is the
index of .shstrtab, and each section in the section table is required to
have an sh_name that points into the .shstrtab.

.symtab and .strtab are also necessary to generate the zoffset.h file
for the bzImage header.

Since the only sizeable section that can be discarded is .eh_frame,
restrict the discard to only .eh_frame to be safe.

 [ bp: Flesh out commit message and replace offending commit with this one. ]

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Link: https://lkml.kernel.org/r/20200109150218.16544-2-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/vmlinux.lds.S | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 508cfa6..469dcf8 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -73,4 +73,9 @@ SECTIONS
 #endif
 	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
 	_end = .;
+
+	/* Discard .eh_frame to save some space */
+	/DISCARD/ : {
+		*(.eh_frame)
+	}
 }
