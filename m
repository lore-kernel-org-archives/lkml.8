Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB2DC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEBF3206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgDUSbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 14:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgDUSbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 14:31:02 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D87C0610D5;
        Tue, 21 Apr 2020 11:31:02 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jQxff-0000RT-9R; Tue, 21 Apr 2020 20:30:59 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DBC1F1C0451;
        Tue, 21 Apr 2020 20:30:58 +0200 (CEST)
Date:   Tue, 21 Apr 2020 18:30:58 -0000
From:   "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/boot/build: Make 'make bzlilo' not depend on
 vmlinux or $(obj)/bzImage
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200215063852.8298-1-masahiroy@kernel.org>
References: <20200215063852.8298-1-masahiroy@kernel.org>
MIME-Version: 1.0
Message-ID: <158749385852.28353.11598390166275769235.tip-bot2@tip-bot2>
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

Commit-ID:     30ce434e44d7e142e7a36c6b3eb2545adf692c67
Gitweb:        https://git.kernel.org/tip/30ce434e44d7e142e7a36c6b3eb2545adf692c67
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Sat, 15 Feb 2020 15:38:51 +09:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 21 Apr 2020 18:10:28 +02:00

x86/boot/build: Make 'make bzlilo' not depend on vmlinux or $(obj)/bzImage

bzlilo is an installation target because it copies files to
$(INSTALL_PATH)/, then runs 'lilo'. However, arch/x86/Makefile and
arch/x86/boot/Makefile have it depend on vmlinux and $(obj)/bzImage,
respectively.

'make bzlilo' may update some build artifacts in the source tree.

As commit

  19514fc665ff ("arm, kbuild: make "make install" not depend on vmlinux")

explained, this should not happen.

Make 'bzlilo' not depend on any build artifact.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200215063852.8298-1-masahiroy@kernel.org
---
 arch/x86/Makefile      | 6 +++---
 arch/x86/boot/Makefile | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index b65ec63..00e378d 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -246,7 +246,7 @@ drivers-$(CONFIG_FB) += arch/x86/video/
 
 boot := arch/x86/boot
 
-BOOT_TARGETS = bzlilo bzdisk fdimage fdimage144 fdimage288 isoimage
+BOOT_TARGETS = bzdisk fdimage fdimage144 fdimage288 isoimage
 
 PHONY += bzImage $(BOOT_TARGETS)
 
@@ -267,8 +267,8 @@ endif
 $(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $@
 
-PHONY += install
-install:
+PHONY += install bzlilo
+install bzlilo:
 	$(Q)$(MAKE) $(build)=$(boot) $@
 
 PHONY += vdso_install
diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 02c8d1c..f1bf4a7 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -145,7 +145,7 @@ isoimage: $(obj)/bzImage
 	$(call cmd,genimage,isoimage,$(obj)/image.iso)
 	@$(kecho) 'Kernel: $(obj)/image.iso is ready'
 
-bzlilo: $(obj)/bzImage
+bzlilo:
 	if [ -f $(INSTALL_PATH)/vmlinuz ]; then mv $(INSTALL_PATH)/vmlinuz $(INSTALL_PATH)/vmlinuz.old; fi
 	if [ -f $(INSTALL_PATH)/System.map ]; then mv $(INSTALL_PATH)/System.map $(INSTALL_PATH)/System.old; fi
 	cat $(obj)/bzImage > $(INSTALL_PATH)/vmlinuz
