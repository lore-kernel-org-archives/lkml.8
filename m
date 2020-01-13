Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141F0C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 19:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5FDE222C4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 19:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgAMTMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 14:12:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39852 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgAMTJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 14:09:32 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ir55d-0000wo-Pn; Mon, 13 Jan 2020 20:09:29 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 593191C18DB;
        Mon, 13 Jan 2020 20:09:26 +0100 (CET)
Date:   Mon, 13 Jan 2020 19:09:26 -0000
From:   "tip-bot2 for Dmitry Safonov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] x86/vdso: On timens page fault prefault also VVAR page
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191112012724.250792-26-dima@arista.com>
References: <20191112012724.250792-26-dima@arista.com>
MIME-Version: 1.0
Message-ID: <157894256621.19145.18395342446986358759.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     4970dc4c31da81447c51a375a906616bf6618f7b
Gitweb:        https://git.kernel.org/tip/4970dc4c31da81447c51a375a906616bf6618f7b
Author:        Dmitry Safonov <dima@arista.com>
AuthorDate:    Tue, 12 Nov 2019 01:27:14 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 13 Jan 2020 08:10:57 +01:00

x86/vdso: On timens page fault prefault also VVAR page

As timens page has offsets to data on VVAR page VVAR is going
to be accessed shortly. Set it up with timens in one page fault
as optimization.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Co-developed-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20191112012724.250792-26-dima@arista.com

---
 arch/x86/entry/vdso/vma.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index e5f3361..d2fd8a5 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -170,8 +170,23 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 		 * offset.
 		 * See also the comment near timens_setup_vdso_data().
 		 */
-		if (timens_page)
+		if (timens_page) {
+			unsigned long addr;
+			vm_fault_t err;
+
+			/*
+			 * Optimization: inside time namespace pre-fault
+			 * VVAR page too. As on timens page there are only
+			 * offsets for clocks on VVAR, it'll be faulted
+			 * shortly by VDSO code.
+			 */
+			addr = vmf->address + (image->sym_timens_page - sym_offset);
+			err = vmf_insert_pfn(vma, addr, pfn);
+			if (unlikely(err & VM_FAULT_ERROR))
+				return err;
+
 			pfn = page_to_pfn(timens_page);
+		}
 
 		return vmf_insert_pfn(vma, vmf->address, pfn);
 	} else if (sym_offset == image->sym_pvclock_page) {
