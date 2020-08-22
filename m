Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FB5C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 13:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FCA22078D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 13:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pxI+h9q3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9617Df2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgHVNjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 09:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbgHVNjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 09:39:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0373C061574;
        Sat, 22 Aug 2020 06:39:00 -0700 (PDT)
Date:   Sat, 22 Aug 2020 13:38:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598103538;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AB39r1CmG85FAxZK4JH68Qkhw+TaVVWNegRqmRDPq1Q=;
        b=pxI+h9q3bpdeEAIwlpNEW+IkQPr9/s5ljQIfeesh9/6i8sUW27/Rw62aSCXk4vyShJafay
        wg14uuQKQW2AHb1bmw95wmjyDMDcxaXTYY65DnMqf/gAFVhQh6OZKqXevxr2dalbvDEC27
        og29cc79MvxvZklfD7IIdUGFGrj7pWKaMgbcS+WcAmL9KApkBLYliQqLuEd9pZARsrjLoy
        bENo/6uwTV5EKJsZwZ/wxsXwLuma+7EG1tW33jTfnvlCyEpFtplw44X94i2hjZzWcppPDb
        6pyLdSeLqpdZdUEToTPAqAIU7RdCEYZpYvUmmqm3pnLsJ6E44CVVKte4xKcHoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598103538;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AB39r1CmG85FAxZK4JH68Qkhw+TaVVWNegRqmRDPq1Q=;
        b=9617Df2f/VSIEJYoVloniMFgNOj8tS57Oi81F/Wqy7Da0f9zzpNGkeHKY2EcSuojO7kwKy
        hi495ocNYe6OZ0AQ==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] Documentation: efi: remove description of efi=old_map
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159810353738.3192.1106749969218812060.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     fb1201aececc59990b75ef59fca93ae4aa1e1444
Gitweb:        https://git.kernel.org/tip/fb1201aececc59990b75ef59fca93ae4aa1e1444
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Mon, 17 Aug 2020 12:00:17 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Thu, 20 Aug 2020 11:18:36 +02:00

Documentation: efi: remove description of efi=old_map

The old EFI runtime region mapping logic that was kept around for some
time has finally been removed entirely, along with the SGI UV1 support
code that was its last remaining user. So remove any mention of the
efi=old_map command line parameter from the docs.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bdc1f33..a106874 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1233,8 +1233,7 @@
 	efi=		[EFI]
 			Format: { "debug", "disable_early_pci_dma",
 				  "nochunk", "noruntime", "nosoftreserve",
-				  "novamap", "no_disable_early_pci_dma",
-				  "old_map" }
+				  "novamap", "no_disable_early_pci_dma" }
 			debug: enable misc debug output.
 			disable_early_pci_dma: disable the busmaster bit on all
 			PCI bridges while in the EFI boot stub.
@@ -1251,8 +1250,6 @@
 			novamap: do not call SetVirtualAddressMap().
 			no_disable_early_pci_dma: Leave the busmaster bit set
 			on all PCI bridges while in the EFI boot stub
-			old_map [X86-64]: switch to the old ioremap-based EFI
-			runtime services mapping. [Needs CONFIG_X86_UV=y]
 
 	efi_no_storage_paranoia [EFI; X86]
 			Using this parameter you can use more than 50% of
