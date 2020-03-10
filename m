Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2401AC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D5F2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="aTNZraKl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgCJRrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:47:31 -0400
Received: from mail.skyhub.de ([5.9.137.197]:32878 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727079AbgCJRr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:47:29 -0400
Received: from zn.tnic (p200300EC2F09B400F44F66F0FEFB445E.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:b400:f44f:66f0:fefb:445e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DBED91EC0CD0;
        Tue, 10 Mar 2020 18:47:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1583862448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LHHw8SvQLS8LrY22tN1VpVYSWUCSNCJABBfe04z8uek=;
        b=aTNZraKlGrxqLs2xDh15nwKRAoSWbbOynS0n3w4m+bhdLqFiIy4i+wTQRHivBY3JnM4FW+
        qUIKT2BcYjETwndKfgbh3PFupcCF+ayaNJlNL6S+A4w7ycOzWadIVVg+fFxNbe224db3YF
        vZMlOkssyV9Zx8Xz3fFoUU0YUxeS9RI=
Date:   Tue, 10 Mar 2020 18:47:31 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Bruce Rogers <brogers@suse.com>
Subject: Re: [PATCH] x86/ioremap: Map EFI runtime services data as encrypted
 for SEV
Message-ID: <20200310174712.GG29372@zn.tnic>
References: <2d9e16eb5b53dc82665c95c6764b7407719df7a0.1582645327.git.thomas.lendacky@amd.com>
 <20200310124003.GE29372@zn.tnic>
 <20200310130321.GH7028@suse.de>
 <20200310163738.GF29372@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200310163738.GF29372@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 05:37:38PM +0100, Borislav Petkov wrote:
> Let's wrap this in a new function which is called at the end of
> __ioremap_check_mem() instead of trying to map EFI_RUNTIME_SERVICES_DATA
> to IORES_DESC types and match the flags just so that we can preserve the
> flow. And add a comment above it why we're doing this.
> 
> As you said on IRC, none of the IO resource ranges covers the
> EFI_RUNTIME_SERVICES_DATA.

Ok, here's what I have. @joro, I know it is trivially different from the
version you tested but I'd appreciate it if you ran it again, just to be
sure.

Thx.

---
From 244b62ca142c6296361bde953488fc64db31f1bd Mon Sep 17 00:00:00 2001
From: Tom Lendacky <thomas.lendacky@amd.com>
Date: Tue, 10 Mar 2020 18:35:57 +0100
Subject: [PATCH] x86/ioremap: Map EFI runtime services data as encrypted for
 SEV

The dmidecode program fails to properly decode the SMBIOS data supplied
by OVMF/UEFI when running in an SEV guest. The SMBIOS area, under SEV, is
encrypted and resides in reserved memory that is marked as EFI runtime
services data.

As a result, when memremap() is attempted for the SMBIOS data, it
can't be mapped as regular RAM (through try_ram_remap()) and, since
the address isn't part of the iomem resources list, it isn't mapped
encrypted through the fallback ioremap().

Add a new __ioremap_check_other() to deal with memory types like
EFI_RUNTIME_SERVICES_DATA which are not covered by the resource ranges.

This allows any runtime services data, which has been created encrypted,
to be mapped encrypted.

 [ bp: Move functionality to a separate function. ]

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: <stable@vger.kernel.org> # 5.3
Link: https://lkml.kernel.org/r/2d9e16eb5b53dc82665c95c6764b7407719df7a0.1582645327.git.thomas.lendacky@amd.com
---
 arch/x86/mm/ioremap.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 44e4beb4239f..935a91e1fd77 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -106,6 +106,19 @@ static unsigned int __ioremap_check_encrypted(struct resource *res)
 	return 0;
 }
 
+/*
+ * The EFI runtime services data area is not covered by walk_mem_res(), but must
+ * be mapped encrypted when SEV is active.
+ */
+static void __ioremap_check_other(resource_size_t addr, struct ioremap_desc *desc)
+{
+	if (!sev_active())
+		return;
+
+	if (efi_mem_type(addr) == EFI_RUNTIME_SERVICES_DATA)
+		desc->flags |= IORES_MAP_ENCRYPTED;
+}
+
 static int __ioremap_collect_map_flags(struct resource *res, void *arg)
 {
 	struct ioremap_desc *desc = arg;
@@ -124,6 +137,9 @@ static int __ioremap_collect_map_flags(struct resource *res, void *arg)
  * To avoid multiple resource walks, this function walks resources marked as
  * IORESOURCE_MEM and IORESOURCE_BUSY and looking for system RAM and/or a
  * resource described not as IORES_DESC_NONE (e.g. IORES_DESC_ACPI_TABLES).
+ *
+ * After that, deal with misc other ranges in __ioremap_check_other() which do
+ * not fall into the above category.
  */
 static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
 				struct ioremap_desc *desc)
@@ -135,6 +151,8 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
 	memset(desc, 0, sizeof(struct ioremap_desc));
 
 	walk_mem_res(start, end, desc, __ioremap_collect_map_flags);
+
+	__ioremap_check_other(addr, desc);
 }
 
 /*
-- 
2.21.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
