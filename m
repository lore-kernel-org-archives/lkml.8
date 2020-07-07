Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED98FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA955206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594135664;
	bh=qBg1OYO70NoWHYQ+EuSTu2RZv+PrX4Fl+JXFgjuN96Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IgDOj2Kk9W8GwYnpXZG/Yc3M6543IH9O77uHXoq5fxZAR/6C+lmVuyQyLfm6Emdhq
	 CxmdGwamK7Eedkc7FCGrNjWefVD01cJ4AGCsN7c+MfCnyVoNGR9WNftnBV1kBSSXvg
	 OAc5BJ9k0UY81T6PgS1zGU+p+UK76thDYb5y222Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbgGGP1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:27:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730331AbgGGP1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:27:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BD7D2078D;
        Tue,  7 Jul 2020 15:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594135620;
        bh=qBg1OYO70NoWHYQ+EuSTu2RZv+PrX4Fl+JXFgjuN96Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1JK5nV2ilnyX8UKXkF0zFEFzxdBNJwe2IlCWewOewCpPgx0+lRSIDggv2yLo+mTpb
         JT5lT0fvR5U00Bhhb1yKHgn2Ti52k9smxtC/42RSOcv4SrghF5A/y502D59ArhdP9Z
         yFMu0EoEUn6Hf2MKzQsedfM3ngSOCWoH4aiYU+zY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Jones <pjones@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 5.7 112/112] efi: Make it possible to disable efivar_ssdt entirely
Date:   Tue,  7 Jul 2020 17:17:57 +0200
Message-Id: <20200707145806.296852863@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145800.925304888@linuxfoundation.org>
References: <20200707145800.925304888@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Jones <pjones@redhat.com>

commit 435d1a471598752446a72ad1201b3c980526d869 upstream.

In most cases, such as CONFIG_ACPI_CUSTOM_DSDT and
CONFIG_ACPI_TABLE_UPGRADE, boot-time modifications to firmware tables
are tied to specific Kconfig options.  Currently this is not the case
for modifying the ACPI SSDT via the efivar_ssdt kernel command line
option and associated EFI variable.

This patch adds CONFIG_EFI_CUSTOM_SSDT_OVERLAYS, which defaults
disabled, in order to allow enabling or disabling that feature during
the build.

Cc: <stable@vger.kernel.org>
Signed-off-by: Peter Jones <pjones@redhat.com>
Link: https://lore.kernel.org/r/20200615202408.2242614-1-pjones@redhat.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/firmware/efi/Kconfig |   11 +++++++++++
 drivers/firmware/efi/efi.c   |    2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -267,3 +267,14 @@ config EFI_EARLYCON
 	depends on SERIAL_EARLYCON && !ARM && !IA64
 	select FONT_SUPPORT
 	select ARCH_USE_MEMREMAP_PROT
+
+config EFI_CUSTOM_SSDT_OVERLAYS
+	bool "Load custom ACPI SSDT overlay from an EFI variable"
+	depends on EFI_VARS && ACPI
+	default ACPI_TABLE_UPGRADE
+	help
+	  Allow loading of an ACPI SSDT overlay from an EFI variable specified
+	  by a kernel command line option.
+
+	  See Documentation/admin-guide/acpi/ssdt-overlays.rst for more
+	  information.
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -189,7 +189,7 @@ static void generic_ops_unregister(void)
 	efivars_unregister(&generic_efivars);
 }
 
-#if IS_ENABLED(CONFIG_ACPI)
+#ifdef CONFIG_EFI_CUSTOM_SSDT_OVERLAYS
 #define EFIVAR_SSDT_NAME_MAX	16
 static char efivar_ssdt[EFIVAR_SSDT_NAME_MAX] __initdata;
 static int __init efivar_ssdt_setup(char *str)


