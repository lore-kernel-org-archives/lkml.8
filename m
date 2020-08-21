Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63443C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29B23207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="sHQPk2hV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgHUPwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 11:52:06 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:13446 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbgHUPv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 11:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598025118; x=1629561118;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eH58IyTxq1bGrzWsPvkVg+srdd+BLp80k+swpu7gV3M=;
  b=sHQPk2hVkKMprmi/6bnklZfqXvkeneV81jidkCAd5dHP0Q/DxBBaDa3e
   6VTZo3p+AUMsOyFhjv0x3ZtnNMTevAE3cW8EFw+J1jS9rdO0GJjYxGbOt
   FRHWQFzLknn59Euuc9ClECAGlKyDMawLyyjSlElDSDV21dJkRDOoSIGYs
   I=;
X-IronPort-AV: E=Sophos;i="5.76,337,1592870400"; 
   d="scan'208";a="49153842"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-c6afef2e.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 21 Aug 2020 15:51:55 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-c6afef2e.us-west-2.amazon.com (Postfix) with ESMTPS id D4EA0A23A8;
        Fri, 21 Aug 2020 15:51:54 +0000 (UTC)
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 21 Aug 2020 15:51:54 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13d01UWB002.ant.amazon.com (10.43.161.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 21 Aug 2020 15:51:54 +0000
Received: from dev-dsk-csbisa-2a-37939146.us-west-2.amazon.com (172.19.34.216)
 by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 21 Aug 2020 15:51:54 +0000
Received: by dev-dsk-csbisa-2a-37939146.us-west-2.amazon.com (Postfix, from userid 800212)
        id 688F2E622; Fri, 21 Aug 2020 15:51:54 +0000 (UTC)
Date:   Fri, 21 Aug 2020 15:51:54 +0000
From:   Clint Sbisa <csbisa@amazon.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Clint Sbisa <csbisa@amazon.com>,
        Benjamin Herrenschmidt <benh@amazon.com>,
        Ali Saidi <alisaidi@amazon.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Guy Tzalik" <gtzalik@amazon.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200821155154.umharcbew46hkhuq@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using write-combine is crucial for performance of PCI devices where
significant amounts of transactions go over PCI BARs.

arm64 supports write-combine PCI mappings, so the appropriate define
has been added which will expose write-combine mappings under sysfs
for prefetchable PCI resources.

Signed-off-by: Clint Sbisa <csbisa@amazon.com>
---
 arch/arm64/include/asm/pci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
index 70b323cf8300..b33ca260e3c9 100644
--- a/arch/arm64/include/asm/pci.h
+++ b/arch/arm64/include/asm/pci.h
@@ -17,6 +17,7 @@
 #define pcibios_assign_all_busses() \
 	(pci_has_flag(PCI_REASSIGN_ALL_BUS))
 
+#define arch_can_pci_mmap_wc() 1
 #define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
 
 extern int isa_dma_bridge_buggy;
-- 
2.23.3

