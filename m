Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1265AC352A3
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 06:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F4620726
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 06:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581748819;
	bh=Ijc+KvcGzi0K3J/mliVXKKjIvnk5BeyOTx9T/0ERAIw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Dp2qgy0U3qY4lo+AMJc0jVGB56ILa0J5fzBRS9QzAS327eQIJP1W618ByAykuZrMA
	 nePsIkzCpjQNYzikJWh83beuQGIXtIFEc1Be0fV5/FOXvX6LbyytvQeWLPc6Upzdfl
	 wxDlw4zCqRL5FyFuZs06mgvFG8qU6I65fWUK5XaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgBOGkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 01:40:19 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:29844 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgBOGkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 01:40:18 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 01F6ctNQ021710;
        Sat, 15 Feb 2020 15:38:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 01F6ctNQ021710
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1581748736;
        bh=hzaKWqxyRGWZmKOPz+/9Ece4nMKAJWa8v/9LdCo1hAk=;
        h=From:To:Cc:Subject:Date:From;
        b=DCP+eLrHhElbihH56lE/bNyCsQRzsncUw4cMVKMx8G+PRI4AdSOJiGcxb58Uft2eV
         ruDPXjNNKciJBKQaQQDcMXH3LrKscvZqInQd1guoA0xfBeuZbERHhUsJm9REK0Mq3/
         HVcUdo7y42kW3M8LcHt/mWpQJTs/UrPZ/e/yHlTiBzmdZEF69lJMXY4Mcjy6R4lOc/
         TiV1Gl+8buyBSM9XiUeb9sVzniPRp/qp4CuZQoon8SxRBm1C3nU5OXARIeyPOhkouB
         jGDl7VzT6EIjjePhdq+oDK1FM2l4LDYLhwlQEIbnoeIxC6MmFqmjekdCI2U11+JJMY
         kIy6haapFtnLQ==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] x86/boot/build: make 'make bzlilo' not depend on vmlinux or $(obj)/bzImage
Date:   Sat, 15 Feb 2020 15:38:51 +0900
Message-Id: <20200215063852.8298-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bzlilo is an installation target because it copies files to
$(INSTALL_PATH)/, then runs 'lilo'.

However, arch/x86/Makefile and arch/x86/boot/Makefile have it depend on
vmlinux, $(obj)/bzImage, respectively.

'make bzlilo' may update some build artifacts in the source tree.

As commit 19514fc665ff ("arm, kbuild: make "make install" not depend
on vmlinux") explained, it should not happen.

Make 'bzlilo' not depend on any build artifact.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/Makefile      | 6 +++---
 arch/x86/boot/Makefile | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 94df0868804b..a034d7787b7e 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -267,7 +267,7 @@ drivers-$(CONFIG_FB) += arch/x86/video/
 
 boot := arch/x86/boot
 
-BOOT_TARGETS = bzlilo bzdisk fdimage fdimage144 fdimage288 isoimage
+BOOT_TARGETS = bzdisk fdimage fdimage144 fdimage288 isoimage
 
 PHONY += bzImage $(BOOT_TARGETS)
 
@@ -288,8 +288,8 @@ endif
 $(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $@
 
-PHONY += install
-install:
+PHONY += install bzlilo
+install bzlilo:
 	$(Q)$(MAKE) $(build)=$(boot) $@
 
 PHONY += vdso_install
diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 050164ba3def..1b37746aab82 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -144,7 +144,7 @@ isoimage: $(obj)/bzImage
 	$(call cmd,genimage,isoimage,$(obj)/image.iso)
 	@$(kecho) 'Kernel: $(obj)/image.iso is ready'
 
-bzlilo: $(obj)/bzImage
+bzlilo:
 	if [ -f $(INSTALL_PATH)/vmlinuz ]; then mv $(INSTALL_PATH)/vmlinuz $(INSTALL_PATH)/vmlinuz.old; fi
 	if [ -f $(INSTALL_PATH)/System.map ]; then mv $(INSTALL_PATH)/System.map $(INSTALL_PATH)/System.old; fi
 	cat $(obj)/bzImage > $(INSTALL_PATH)/vmlinuz
-- 
2.17.1

