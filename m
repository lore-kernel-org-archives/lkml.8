Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14939C433EC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3E5120734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oTG89801";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gjmy4gNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgGQOvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbgGQOvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:51:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591DAC0619D3;
        Fri, 17 Jul 2020 07:51:11 -0700 (PDT)
Date:   Fri, 17 Jul 2020 14:51:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594997468;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GJsMPyh/Aby7qDbkuThyZTG+iITkW2gT99ZUJztWGzQ=;
        b=oTG89801CPbglnHqYt4STPjHjgHsC4ARUB0oyRo9NBN+uvMVO8T5t1TTba6xTCPTc3Y+2+
        b3Ck4T59cqNgEJzg5goDi9OWlE7TsLXYGkwut0uWAj/bxoybX7wA7QvleXUtCEDpGrlZ87
        ikd4MAAAjC+HyGlVrs2UWTyaZ/V7eoLHyxpZaO6DjAJr7mewM6byfhRMGpnfsv+enfYmPy
        pP1u3rRGry3L1nSTnLxlyatnGUBA1/QuNCIHTcec5Pb//JvOmclEK6OVU3a46Zgf08Cxfj
        H8E7quW2MPimmIGXpEc2pwSD6L/7nfmziNLqcyoLRs+91Cmvh0Oob3LS9lP3rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594997468;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GJsMPyh/Aby7qDbkuThyZTG+iITkW2gT99ZUJztWGzQ=;
        b=Gjmy4gNkL9PKxQkmxyeU3qWp6H+rSYjuXWVgABKvMQb0Pkcrnyw8aAPFZgaGsLYPXumnyR
        I06s5PGpe15kK0AA==
From:   "tip-bot2 for steve.wahl@hpe.com" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/efi: Delete SGI UV1 detection.
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200713212955.667726896@hpe.com>
References: <20200713212955.667726896@hpe.com>
MIME-Version: 1.0
Message-ID: <159499746829.4006.2590649991808612730.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     cadde2379f0c64f00bb17834c7095a90595255b0
Gitweb:        https://git.kernel.org/tip/cadde2379f0c64f00bb17834c7095a90595255b0
Author:        steve.wahl@hpe.com <steve.wahl@hpe.com>
AuthorDate:    Mon, 13 Jul 2020 16:30:04 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Jul 2020 16:47:47 +02:00

x86/efi: Delete SGI UV1 detection.

As a part of UV1 platform removal, don't try to recognize the platform
through DMI to set the EFI_UV1_MEMMAP bit.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lkml.kernel.org/r/20200713212955.667726896@hpe.com

---
 arch/x86/platform/efi/quirks.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index a5a469c..d627f55 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -558,16 +558,6 @@ out:
 	return ret;
 }
 
-static const struct dmi_system_id sgi_uv1_dmi[] __initconst = {
-	{ NULL, "SGI UV1",
-		{	DMI_MATCH(DMI_PRODUCT_NAME,	"Stoutland Platform"),
-			DMI_MATCH(DMI_PRODUCT_VERSION,	"1.0"),
-			DMI_MATCH(DMI_BIOS_VENDOR,	"SGI.COM"),
-		}
-	},
-	{ } /* NULL entry stops DMI scanning */
-};
-
 void __init efi_apply_memmap_quirks(void)
 {
 	/*
@@ -579,17 +569,6 @@ void __init efi_apply_memmap_quirks(void)
 		pr_info("Setup done, disabling due to 32/64-bit mismatch\n");
 		efi_memmap_unmap();
 	}
-
-	/* UV2+ BIOS has a fix for this issue.  UV1 still needs the quirk. */
-	if (dmi_check_system(sgi_uv1_dmi)) {
-		if (IS_ENABLED(CONFIG_X86_UV)) {
-			set_bit(EFI_UV1_MEMMAP, &efi.flags);
-		} else {
-			pr_warn("EFI runtime disabled, needs CONFIG_X86_UV=y on UV1\n");
-			clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
-			efi_memmap_unmap();
-		}
-	}
 }
 
 /*
@@ -723,8 +702,6 @@ void efi_recover_from_page_fault(unsigned long phys_addr)
 
 	/*
 	 * Make sure that an efi runtime service caused the page fault.
-	 * "efi_mm" cannot be used to check if the page fault had occurred
-	 * in the firmware context because the UV1 memmap doesn't use efi_pgd.
 	 */
 	if (efi_rts_work.efi_rts_id == EFI_NONE)
 		return;
