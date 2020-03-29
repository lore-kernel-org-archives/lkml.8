Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D22C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 16:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C638A2073B
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 16:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgC2QD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 12:03:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56668 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbgC2QD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 12:03:56 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jIaPh-0007ur-UE; Sun, 29 Mar 2020 18:03:54 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 58CB71040BC;
        Sun, 29 Mar 2020 18:03:53 +0200 (CEST)
Date:   Sun, 29 Mar 2020 16:03:25 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for v5.6
References: <158549780513.2870.9873806112977909523.tglx@nanos.tec.linutronix.de>
Message-ID: <158549780514.2870.1236107824707197925.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-03-29

up to:  870b4333a62e: x86/ioremap: Fix CONFIG_EFI=n build

A single fix to unbreak the build for CONFIG_EFI=n by adding a missing
IS_ENABLED() check.

Thanks,

	tglx

------------------>
Borislav Petkov (1):
      x86/ioremap: Fix CONFIG_EFI=n build


 arch/x86/mm/ioremap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 935a91e1fd77..18c637c0dc6f 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -115,6 +115,9 @@ static void __ioremap_check_other(resource_size_t addr, struct ioremap_desc *des
 	if (!sev_active())
 		return;
 
+	if (!IS_ENABLED(CONFIG_EFI))
+		return;
+
 	if (efi_mem_type(addr) == EFI_RUNTIME_SERVICES_DATA)
 		desc->flags |= IORES_MAP_ENCRYPTED;
 }

