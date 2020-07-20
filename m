Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32E8C47423
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 992AF207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595281434;
	bh=dmG1vRszsew8fuxCEiEbsKPFY4DbbQrHRnX76AhEDwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lDHbWmK2x9d8efaLh3JfCNUiK1mRvv243MWV5J+Tj50I2uHO2s4w/GMKjje/fOh+x
	 WUKFbW0fkdEwS0ng7CDBfIqxnr4G5JWAowiY/zsKXTvDM7R+81iEigzNXR4siE5jDR
	 iJ6cLfx88kf48SU+SravsRQOSNoIbR4KUh1Jx88E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgGTViU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 17:38:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbgGTViG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 17:38:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46F2322D01;
        Mon, 20 Jul 2020 21:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595281086;
        bh=dmG1vRszsew8fuxCEiEbsKPFY4DbbQrHRnX76AhEDwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EqhMC9nDv8OUL8cu33QZ7ybp3/hOL/sfLyYKM3+2AuhACNFZAtyNRx0rAJ0q+0v3A
         +hDRooui14fgStzVUgugt273fz2tFnqP9ix5KjGVMj+5fcX25Xt9o02TrHoK6u5PVC
         pADrmkWS9z4tuvoulyYbMj3FtUDD/RVImUWsUyOA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.7 40/40] x86/boot: Don't add the EFI stub to targets
Date:   Mon, 20 Jul 2020 17:37:15 -0400
Message-Id: <20200720213715.406997-40-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200720213715.406997-1-sashal@kernel.org>
References: <20200720213715.406997-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

[ Upstream commit da05b143a308bd6a7a444401f9732678ae63fc70 ]

vmlinux-objs-y is added to targets, which currently means that the EFI
stub gets added to the targets as well. It shouldn't be added since it
is built elsewhere.

This confuses Makefile.build which interprets the EFI stub as a target
	$(obj)/$(objtree)/drivers/firmware/efi/libstub/lib.a
and will create drivers/firmware/efi/libstub/ underneath
arch/x86/boot/compressed, to hold this supposed target, if building
out-of-tree. [0]

Fix this by pulling the stub out of vmlinux-objs-y into efi-obj-y.

[0] See scripts/Makefile.build near the end:
    # Create directories for object files if they do not exist

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lkml.kernel.org/r/20200715032631.1562882-1-nivedita@alum.mit.edu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/boot/compressed/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 5f7c262bcc99a..20aac99683156 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -88,8 +88,8 @@ endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 
-vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
+efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
 
 # The compressed kernel is built with -fPIC/-fPIE so that a boot loader
 # can place it anywhere in memory and it will still run. However, since
@@ -113,7 +113,7 @@ endef
 quiet_cmd_check-and-link-vmlinux = LD      $@
       cmd_check-and-link-vmlinux = $(cmd_check_data_rel); $(cmd_ld)
 
-$(obj)/vmlinux: $(vmlinux-objs-y) FORCE
+$(obj)/vmlinux: $(vmlinux-objs-y) $(efi-obj-y) FORCE
 	$(call if_changed,check-and-link-vmlinux)
 
 OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
-- 
2.25.1

