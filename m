Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22619C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB842087E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="MuUkpOAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbgBCSTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:19:20 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:39261 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728822AbgBCSTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:19:20 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 669badf1;
        Mon, 3 Feb 2020 18:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=mail; bh=n5zCiu7k9uKnwtw56v5H4Q+meWY=; b=MuUkpOAx/cFBE2zIGr+6
        sA+jA4PgJ+zP3AVVn50Iw4vmW6IhPZhZDzPJAcRtYJNc43AiHvTnyCoGrbb9TOMG
        S53mZvzR7j/tCAnqzI4tqL+dHB6nlLo6mL546+zs20+1tJpQhV4cJHRYaLxXt64/
        +UYUhF0EHgh3TlaT4EJc6ZjRLJ4h2kTDIGsGPaqe9F+eYdSlqk7GCt6UfBIHpdjg
        3Hs95SxC6a8Oi5ZLriDwsERgxHjpydMnDo/p/KuzY1C5ltFiX3/5YrqhTr07wuaq
        6H869d7AB8Jk3u7xMvtVkcKGAEnK00kBC75PbIzIoPrqixzd5kUJ7iEfE3E3+O4r
        kA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d7f99f18 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Mon, 3 Feb 2020 18:18:35 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, bhelgaas@google.com, x86@kernel.org,
        hch@lst.de
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] x86/PCI: ensure to_pci_sysdata usage is guarded by CONFIG_PCI
Date:   Mon,  3 Feb 2020 19:19:06 +0100
Message-Id: <20200203181906.78264-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, the helper to_pci_sysdata was added inside of the CONFIG_PCI
guard, but it is used from inside of a CONFIG_PCI_MSI_IRQ_DOMAIN guard,
which does not require CONFIG_PCI. This breaks builds on !CONFIG_PCI
machines. This commit fixes the ifdef to require CONFIG_PCI.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Fixes: aad6aa0cd674 ("x86/PCI: Add to_pci_sysdata() helper")
Cc: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index 40ac1330adb2..d8772b75236d 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -119,7 +119,7 @@ void native_restore_msi_irqs(struct pci_dev *dev);
 /* generic pci stuff */
 #include <asm-generic/pci.h>
 
-#ifdef CONFIG_NUMA
+#if defined(CONFIG_NUMA) && defined(CONFIG_PCI)
 /* Returns the node based on pci bus */
 static inline int __pcibus_to_node(const struct pci_bus *bus)
 {
-- 
2.25.0

