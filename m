Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E35CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 02:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE3EC2078C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 02:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="pAQ/XTym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgFICZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 22:25:41 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:43099 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgFICZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 22:25:40 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E3A7E8066C;
        Tue,  9 Jun 2020 14:25:36 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1591669536;
        bh=586lz6bmU2bKx27WMCmywupzvB0ytIUGBkce0NdqGvk=;
        h=From:To:Cc:Subject:Date;
        b=pAQ/XTymihiR6wXAERENzPXGZ+sNZEr9mxaoYqQigv/EnKcF6N98vqQROM0ZDvQMT
         vkmf8PsEaafxzuGjIenZ0S4cgwYWOkaI3058KuPAlYNY1v/DRYFrxakJoyiOZXDCEH
         00uU2YvX5nJZoqNs0lhbjul/urd3Q5LhJgXvDVNV5PP51TfKwTo2a6NuM3E76BrpCJ
         FHO4t4uMIvhSL7JGpUFL2Qe17+feElAWf4EZ9iJmLl+ueIvYl2FefAY1r2m+dFIZHn
         6XN9g5uOPDI4JR7Bg/+IYIhnBkVuJnXUmtcaG0CdIK26n+UZ61uumjcRfniqQUzi2c
         v91vwl3HK0T8g==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5edef31f0000>; Tue, 09 Jun 2020 14:25:35 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id EDF9513EDE4;
        Tue,  9 Jun 2020 14:25:35 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id A2C5B28006C; Tue,  9 Jun 2020 14:25:36 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@armlinux.org.uk, arnd@arndb.de, akpm@linux-foundation.org,
        rppt@linux.ibm.com, mchehab+samsung@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] ARM: Kconfig: set default ZBOOT_ROM_TEXT/BSS value to 0x0
Date:   Tue,  9 Jun 2020 14:25:17 +1200
Message-Id: <20200609022517.15137-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
KernelVersion: next
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZBOOT_ROM_TEXT and ZBOOT_ROM_BSS are defined as 'hex' but had a default
of "0". Kconfig will helpfully expand a text entry of 0 to 0x0 but
because this is not the same as the default value it was treated as
being explicitly set when running 'make savedefconfig' so most arm
defconfigs have CONFIG_ZBOOT_ROM_TEXT=3D0x0 and CONFIG_ZBOOT_ROM_BSS=3D0x=
0.

Change the default to 0x0 which will mean next time the defconfigs are
re-generated the spurious config entries will be removed.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
I'm assuming there's some semi-automated regular process that syncs up th=
e
defconfigs so I've not created a patch with the result of regenerating th=
e
defconfigs.

 arch/arm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fb6c85c5d344..38c0cab598bf 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1750,7 +1750,7 @@ config DEPRECATED_PARAM_STRUCT
 # TEXT and BSS so we preserve their values in the config files.
 config ZBOOT_ROM_TEXT
 	hex "Compressed ROM boot loader base address"
-	default "0"
+	default 0x0
 	help
 	  The physical address at which the ROM-able zImage is to be
 	  placed in the target.  Platforms which normally make use of
@@ -1761,7 +1761,7 @@ config ZBOOT_ROM_TEXT
=20
 config ZBOOT_ROM_BSS
 	hex "Compressed ROM boot loader BSS address"
-	default "0"
+	default 0x0
 	help
 	  The base address of an area of read/write memory in the target
 	  for the ROM-able zImage which must be available while the
--=20
2.25.1

