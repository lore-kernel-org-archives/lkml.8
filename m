Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B1BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F2B5208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592323842;
	bh=UDMldpiL3ZcmkG02DJ17tLmEDkvzlsbIxX8TylRM4vM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e/Sqlb2N35Q6UwWuw4IvWey3Iv/35UBHRlnXtWEU2Bm5APlUaQd23Ac11DxXpXpp2
	 31EAOwZTgPCjCQrynDNF7dnCT08cpOhwJCZIvR1htdMC2b2jjEYEvuFBwQZB3xAh/U
	 bOgUbM2uYr7UdaltnHZ0dXwFC5A+yyoIVHjLZopg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbgFPQKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:10:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731961AbgFPPoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:44:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B199208E4;
        Tue, 16 Jun 2020 15:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322256;
        bh=UDMldpiL3ZcmkG02DJ17tLmEDkvzlsbIxX8TylRM4vM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pfsq6++u44RoPeIWUo74OqST3yanWlqenaWm8MhC0OdNk+LbvcKJ8uF8ceeELEgvb
         JjUQd2p2yIo+Uy2t8MeVFRlkECcu5SpvI/nlN9Vkr7Q3rEeqs3vIFeg+ANzvsJo1MD
         6sidcfTLAt1FgsRSohENqTI+sFOg2A4col5fO7As=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 021/163] powerpc/xive: Clear the page tables for the ESB IO mapping
Date:   Tue, 16 Jun 2020 17:33:15 +0200
Message-Id: <20200616153107.897579747@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.849127260@linuxfoundation.org>
References: <20200616153106.849127260@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cédric Le Goater <clg@kaod.org>

[ Upstream commit a101950fcb78b0ba20cd487be6627dea58d55c2b ]

Commit 1ca3dec2b2df ("powerpc/xive: Prevent page fault issues in the
machine crash handler") fixed an issue in the FW assisted dump of
machines using hash MMU and the XIVE interrupt mode under the POWER
hypervisor. It forced the mapping of the ESB page of interrupts being
mapped in the Linux IRQ number space to make sure the 'crash kexec'
sequence worked during such an event. But it didn't handle the
un-mapping.

This mapping is now blocking the removal of a passthrough IO adapter
under the POWER hypervisor because it expects the guest OS to have
cleared all page table entries related to the adapter. If some are
still present, the RTAS call which isolates the PCI slot returns error
9001 "valid outstanding translations".

Remove these mapping in the IRQ data cleanup routine.

Under KVM, this cleanup is not required because the ESB pages for the
adapter interrupts are un-mapped from the guest by the hypervisor in
the KVM XIVE native device. This is now redundant but it's harmless.

Fixes: 1ca3dec2b2df ("powerpc/xive: Prevent page fault issues in the machine crash handler")
Cc: stable@vger.kernel.org # v5.5+
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200429075122.1216388-2-clg@kaod.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/sysdev/xive/common.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index b294f70f1a67..261cff60df14 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/msi.h>
+#include <linux/vmalloc.h>
 
 #include <asm/debugfs.h>
 #include <asm/prom.h>
@@ -1017,12 +1018,16 @@ EXPORT_SYMBOL_GPL(is_xive_irq);
 void xive_cleanup_irq_data(struct xive_irq_data *xd)
 {
 	if (xd->eoi_mmio) {
+		unmap_kernel_range((unsigned long)xd->eoi_mmio,
+				   1u << xd->esb_shift);
 		iounmap(xd->eoi_mmio);
 		if (xd->eoi_mmio == xd->trig_mmio)
 			xd->trig_mmio = NULL;
 		xd->eoi_mmio = NULL;
 	}
 	if (xd->trig_mmio) {
+		unmap_kernel_range((unsigned long)xd->trig_mmio,
+				   1u << xd->esb_shift);
 		iounmap(xd->trig_mmio);
 		xd->trig_mmio = NULL;
 	}
-- 
2.25.1



