Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F240BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDDD020684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgATKOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 05:14:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:32831 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgATKOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 05:14:18 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1itU4O-0005BH-Qg; Mon, 20 Jan 2020 11:14:09 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D3FD11C1A3F;
        Mon, 20 Jan 2020 11:14:07 +0100 (CET)
Date:   Mon, 20 Jan 2020 10:14:07 -0000
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/sysfb: Fix check for bad VRAM size
Cc:     Christopher Head <chead@chead.ca>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200107230410.2291947-1-nivedita@alum.mit.edu>
References: <20200107230410.2291947-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <157951524757.396.6875449897563073243.tip-bot2@tip-bot2>
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

Commit-ID:     dacc9092336be20b01642afe1a51720b31f60369
Gitweb:        https://git.kernel.org/tip/dacc9092336be20b01642afe1a51720b31f60369
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Tue, 07 Jan 2020 18:04:10 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 20 Jan 2020 10:57:53 +01:00

x86/sysfb: Fix check for bad VRAM size

When checking whether the reported lfb_size makes sense, the height
* stride result is page-aligned before seeing whether it exceeds the
reported size.

This doesn't work if height * stride is not an exact number of pages.
For example, as reported in the kernel bugzilla below, an 800x600x32 EFI
framebuffer gets skipped because of this.

Move the PAGE_ALIGN to after the check vs size.

Reported-by: Christopher Head <chead@chead.ca>
Tested-by: Christopher Head <chead@chead.ca>
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206051
Link: https://lkml.kernel.org/r/20200107230410.2291947-1-nivedita@alum.mit.edu
---
 arch/x86/kernel/sysfb_simplefb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/sysfb_simplefb.c b/arch/x86/kernel/sysfb_simplefb.c
index 01f0e22..298fc1e 100644
--- a/arch/x86/kernel/sysfb_simplefb.c
+++ b/arch/x86/kernel/sysfb_simplefb.c
@@ -90,11 +90,11 @@ __init int create_simplefb(const struct screen_info *si,
 	if (si->orig_video_isVGA == VIDEO_TYPE_VLFB)
 		size <<= 16;
 	length = mode->height * mode->stride;
-	length = PAGE_ALIGN(length);
 	if (length > size) {
 		printk(KERN_WARNING "sysfb: VRAM smaller than advertised\n");
 		return -EINVAL;
 	}
+	length = PAGE_ALIGN(length);
 
 	/* setup IORESOURCE_MEM as framebuffer memory */
 	memset(&res, 0, sizeof(res));
