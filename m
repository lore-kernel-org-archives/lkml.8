Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FE0C43445
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE3D32083E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859880;
	bh=8CVLljuIEwXs0puMnxHS10FA9u3SjYy216HgOc6fzLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FU9TW8aoMYndBMSZzYxWusTo+t7yyl9UYGALH3azaO0jik0prGMg3FMQx78rIm/8H
	 3ryImsVRvNlMOLENTo4HhWJ3p0KY+Fn980S3FoKtENi7dWw0lWSjyOK9XbKhWwX7Q9
	 SDEqnrj3BZ6FV8O25JGD0xNz9REFJI2RYwPoftfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731687AbgG0OYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:24:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732283AbgG0OYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:24:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7804421775;
        Mon, 27 Jul 2020 14:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859874;
        bh=8CVLljuIEwXs0puMnxHS10FA9u3SjYy216HgOc6fzLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hqDp0WN5S0kRfML2qKB7ZwlCqfa4GYiyOWxf+ja7BOs+1RU8ClmkrfP3PpJTXZgNg
         l4mDKu8dcVp6d81vVhsU8UyPpKcDwqPUfRSOqIRaKM+xPbgUuaecX+qnDT6GCUv6P+
         EcMKCBdiDJ0UDIPfNXeYVDWxV6Eq1QIwujTi8NGk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 138/179] x86/boot: Dont add the EFI stub to targets
Date:   Mon, 27 Jul 2020 16:05:13 +0200
Message-Id: <20200727134939.355856112@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
References: <20200727134932.659499757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 arch/x86/boot/compressed/Makefile |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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


