Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A265CC3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E3020732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgBXKvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 05:51:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49463 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgBXKvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 05:51:15 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j6BKP-0008RK-V6; Mon, 24 Feb 2020 11:51:10 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6EF3D1C1A0F;
        Mon, 24 Feb 2020 11:51:09 +0100 (CET)
Date:   Mon, 24 Feb 2020 10:51:08 -0000
From:   "tip-bot2 for Dave Young" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kdump] x86/kexec: Do not reserve EFI setup_data in the
 kexec e820 table
Cc:     Dave Young <dyoung@redhat.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200212110424.GA2938@dhcp-128-65.nay.redhat.com>
References: <20200212110424.GA2938@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Message-ID: <158254146897.28353.4247096498069522547.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/kdump branch of tip:

Commit-ID:     8efbc518b884e1db2dd6a6fce62d0112ab871dcf
Gitweb:        https://git.kernel.org/tip/8efbc518b884e1db2dd6a6fce62d0112ab871dcf
Author:        Dave Young <dyoung@redhat.com>
AuthorDate:    Wed, 12 Feb 2020 19:04:24 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 24 Feb 2020 11:41:57 +01:00

x86/kexec: Do not reserve EFI setup_data in the kexec e820 table

The e820 table for the kexec kernel unconditionally marks setup_data as
reserved because the second kernel can reuse setup_data passed by the
1st kernel's boot loader, for example SETUP_PCI marked regions like PCI
BIOS, etc.

SETUP_EFI types, however, are used by kexec itself to enable EFI in the
2nd kernel. Thus, it is pointless to add this type of setup_data to the
kexec e820 table as reserved.

IOW, what happens is this:

  -  1st physical boot: no SETUP_EFI.

  - kexec loads a new kernel and prepares a SETUP_EFI setup_data blob, then
  reboots the machine.

  - 2nd kernel sees SETUP_EFI, reserves it both in the e820 and in the
  kexec e820 table.

  - If another kexec load is executed, it prepares a new SETUP_EFI blob and
  then reboots the machine into the new kernel.

  5. The 3rd kexec-ed kernel has two SETUP_EFI ranges reserved. And so on...

Thus skip SETUP_EFI while reserving setup_data in the e820_table_kexec
table because it is not needed.

 [ bp: Heavily massage commit message, shorten line and improve comment. ]

Signed-off-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200212110424.GA2938@dhcp-128-65.nay.redhat.com
---
 arch/x86/kernel/e820.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index c5399e8..c920296 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -999,7 +999,15 @@ void __init e820__reserve_setup_data(void)
 	while (pa_data) {
 		data = early_memremap(pa_data, sizeof(*data));
 		e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
-		e820__range_update_kexec(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
+
+		/*
+		 * SETUP_EFI is supplied by kexec and does not need to be
+		 * reserved.
+		 */
+		if (data->type != SETUP_EFI)
+			e820__range_update_kexec(pa_data,
+						 sizeof(*data) + data->len,
+						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
 
 		if (data->type == SETUP_INDIRECT &&
 		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
