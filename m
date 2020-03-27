Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D87C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 14:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58812072F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 14:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgC0Oyh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 10:54:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53598 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbgC0Oyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 10:54:36 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jHqNS-0008WC-ER; Fri, 27 Mar 2020 15:54:30 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 111401C0470;
        Fri, 27 Mar 2020 15:54:30 +0100 (CET)
Date:   Fri, 27 Mar 2020 14:54:29 -0000
From:   "tip-bot2 for Benjamin Thiel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/efi: Add a prototype for efi_arch_mem_reserve()
Cc:     Benjamin Thiel <b.thiel@posteo.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200326135041.3264-1-b.thiel@posteo.de>
References: <20200326135041.3264-1-b.thiel@posteo.de>
MIME-Version: 1.0
Message-ID: <158532086972.28353.17246569541666507215.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     860f89e6182479149bb6c27f5f44989b0628a176
Gitweb:        https://git.kernel.org/tip/860f89e6182479149bb6c27f5f44989b0628a176
Author:        Benjamin Thiel <b.thiel@posteo.de>
AuthorDate:    Thu, 26 Mar 2020 14:50:41 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 27 Mar 2020 11:21:21 +01:00

x86/efi: Add a prototype for efi_arch_mem_reserve()

... in order to fix a -Wmissing-ptototypes warning:

  arch/x86/platform/efi/quirks.c:245:13: warning:
  no previous prototype for ‘efi_arch_mem_reserve’ [-Wmissing-prototypes] \
	  void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)

Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200326135041.3264-1-b.thiel@posteo.de
---
 include/linux/efi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 7efd707..e4b28ae 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1703,4 +1703,6 @@ struct linux_efi_memreserve {
 
 void efi_pci_disable_bridge_busmaster(void);
 
+void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size);
+
 #endif /* _LINUX_EFI_H */
