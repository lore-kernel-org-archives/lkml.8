Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A505EC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8275D206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbgDUSbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 14:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgDUSbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 14:31:02 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA0BC0610D6;
        Tue, 21 Apr 2020 11:31:02 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jQxff-0000RR-5J; Tue, 21 Apr 2020 20:30:59 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 65F3C1C0315;
        Tue, 21 Apr 2020 20:30:58 +0200 (CEST)
Date:   Tue, 21 Apr 2020 18:30:58 -0000
From:   "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/boot/build: Add phony targets in
 arch/x86/boot/Makefile to PHONY
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200215063852.8298-2-masahiroy@kernel.org>
References: <20200215063852.8298-2-masahiroy@kernel.org>
MIME-Version: 1.0
Message-ID: <158749385800.28353.13640320845323735874.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     675a59b7dec6e03c5fb060f18fc25b2e56be3c7a
Gitweb:        https://git.kernel.org/tip/675a59b7dec6e03c5fb060f18fc25b2e56be3c7a
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Sat, 15 Feb 2020 15:38:52 +09:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 21 Apr 2020 18:30:58 +02:00

x86/boot/build: Add phony targets in arch/x86/boot/Makefile to PHONY

These targets are correctly added to PHONY in arch/x86/Makefile, but
not in arch/x86/boot/Makefile. Thus, with a file 'install' in the top
directory, 'make install' does nothing:

  $ touch install
  $ make install
  make[1]: 'install' is up to date.

Add them to the PHONY targets in the boot Makefile too.

 [ bp: Massage. ]

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200215063852.8298-2-masahiroy@kernel.org
---
 arch/x86/boot/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index f1bf4a7..4c53556 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -128,6 +128,8 @@ quiet_cmd_genimage = GENIMAGE $3
 cmd_genimage = sh $(srctree)/$(src)/genimage.sh $2 $3 $(obj)/bzImage \
 			$(obj)/mtools.conf '$(image_cmdline)' $(FDINITRD)
 
+PHONY += bzdisk fdimage fdimage144 fdimage288 isoimage bzlilo install
+
 # This requires write access to /dev/fd0
 bzdisk: $(obj)/bzImage $(obj)/mtools.conf
 	$(call cmd,genimage,bzdisk,/dev/fd0)
