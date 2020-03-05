Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941E0C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 05:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683592146E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 05:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583387464;
	bh=H6OWK4dVMoL/irrWtX6AMausyAG3bSEayZBwCdqNvnc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=qSSb67hpYsi1/kHj79RNqN+ZdiGYzH3RU+SYDWM/rnzpO4wPx2kqE4gGzUsd9auts
	 xSbZeTJlYWiTUWkCDMB5bXPW4xZ/7ezNaQKSFYnN843qmkWmhJcjeX4QXKhjQJpPfQ
	 r/ITmQVuDsyscAmvHZlr8xKGv69wnbY4Ed3XSy3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgCEFvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 00:51:03 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:43152 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgCEFvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 00:51:02 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 0255olWQ019741;
        Thu, 5 Mar 2020 14:50:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 0255olWQ019741
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1583387448;
        bh=lSt9Fl4a87jd5z1QdbgJFDFK/59k3ohlQI/SOmb9I0U=;
        h=From:To:Cc:Subject:Date:From;
        b=DJef37jmzWlPA1JvWq/ZFJDymTCCEf6RHNFkdJrcN5Vi8Lml3GYJxGVXJQhmNvsSe
         6T92QRPDw9lUzD7G/HuLZlwPUXHy9j+km15ISg8V7kPGvAaxKnf4V3yoW2l6+XXV0x
         JZsw67FsTZw3DOLEcGq06WW1JPj4vXUltI0GhXj7dGsrA721FwK/AaywF0c+Zsj+/G
         LSLarBonUvoC58kHNgNd3x+Ngqh82EDiaikEJYs5dkUdFb+iKw7lfLGJXfF8wOi9ZG
         oRHja4pcz5bnWdDKlr7ir4+HBSl9I2m3pqUd5HUwOyEyIj1ZfEDZ5eg/WMohpCxkhg
         0hR6+00ZUJheQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] efi/libstub: avoid linking libstub/lib-ksyms.o into vmlinux
Date:   Thu,  5 Mar 2020 14:50:47 +0900
Message-Id: <20200305055047.6097-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/firmware/efi/libstub/Makefile is supposed to create a static
library, which is not directly linked to vmlinux.

Since commit 7f2084fa55e6 ("[kbuild] handle exports in lib-y objects
reliably"), any Makefile using lib-y generates lib-ksyms.o which is
linked into vmlinux.

In this case, the following garbage object is linked into vmlinux.

  drivers/firmware/efi/libstub/lib-ksyms.o

We do not want to link anything from libstub/ directly to vmlinux,
so using subdir-y instead of obj-y is the correct way to descend into
this directory.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/firmware/efi/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index 554d795270d9..4fd2fa02f549 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -19,7 +19,7 @@ obj-$(CONFIG_EFI_VARS_PSTORE)		+= efi-pstore.o
 obj-$(CONFIG_UEFI_CPER)			+= cper.o
 obj-$(CONFIG_EFI_RUNTIME_MAP)		+= runtime-map.o
 obj-$(CONFIG_EFI_RUNTIME_WRAPPERS)	+= runtime-wrappers.o
-obj-$(CONFIG_EFI_STUB)			+= libstub/
+subdir-$(CONFIG_EFI_STUB)		+= libstub
 obj-$(CONFIG_EFI_FAKE_MEMMAP)		+= fake_map.o
 obj-$(CONFIG_EFI_BOOTLOADER_CONTROL)	+= efibc.o
 obj-$(CONFIG_EFI_TEST)			+= test/
-- 
2.17.1

