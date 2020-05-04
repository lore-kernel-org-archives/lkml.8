Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA97C47254
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 04:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8270520705
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 04:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rJXWtuco"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgEDEEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 00:04:00 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:21313 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgEDED7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 00:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588565039; x=1620101039;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kpRqgt1e2NQdJbBQkpUaOUuP+qP9IBaNNw7Ep6/63JA=;
  b=rJXWtucoZb/iBc+dVWGg4Jd16eHEBKHeVDJwkX5u/wwPk8rckTV+Wqep
   cnpoHv8Pr5Qpfmx9/7lpWJFNLlm8rT+4v8LUyi1VErlJ/tA+n5lbyKYSq
   MRAMmmL2EIkZtkLI7sk0CjGK512FEcxpytjS9UQQ+G4iTcoS4QfJVdsn9
   zb3j0OFDzG3ZivIB/7kRFFu1JKkJhfNEltrm+/y8dewhGfTak8AzmfjI+
   tqH/bRlCd004yZNO85QTY1xA1DguXgz+bnbY8W/h+hyX7MIA1IDJMCod2
   yXQJNOBQ4xv0BoIOk80ubP+W+wBNOJP0GfLjpOzKut80ZGEA3QCX70CcT
   w==;
IronPort-SDR: mdmXmoSWgc8QW51urZtDeUsWkyxu9uacLpibWMFpk1jo46h2CDdRtt/nAqyq4Zy/89NSoNHiZk
 +loOTR4EOGxFGUjpnjTim6RSFmciSOx+37p/BqfHdXUEaK+YTl7EW0jYYKFlmfBg0P16T36kRt
 W/1XVp42zvTj4dLkMeliiG8f5QC3DTotbFhYV5paSZpNnzNd9/sr4+wxPJCACAUlDx03dr3UIJ
 W7Od1fOcLHX9Cap1OT4HfihPuiEsmF7PCmqFGaiwGvKIxWKF8NEkKdmq3wzpHRrcebGfud7FIT
 tjk=
X-IronPort-AV: E=Sophos;i="5.73,350,1583164800"; 
   d="scan'208";a="138270233"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2020 12:03:59 +0800
IronPort-SDR: RAybAAyIveZSAubymx4wLM0d2HJC8sXRBPLQTzCfVeF6H6+PCe1lC9FsG11oMFOOy2Jy8jfA6k
 pxoKxAFARItD+W5etOQIoLgzaRp84jHUg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2020 20:54:29 -0700
IronPort-SDR: F/dysIwzax7M/PVnAc/1t2dyxkVmHgmQ2FEEAYlqSkikeYC9HEIhTFEDAylSwnF9nadTq0c4Bz
 sVZqMF0peN7w==
WDCIronportException: Internal
Received: from unknown (HELO yoda.hgst.com) ([10.86.56.169])
  by uls-op-cesaip01.wdc.com with ESMTP; 03 May 2020 21:03:58 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <Anup.Patel@wdc.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH] RISC-V: Remove unused code from STRICT_KERNEL_RWX
Date:   Sun,  3 May 2020 21:03:19 -0700
Message-Id: <20200504040319.31423-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the unused functions set_kernel_text_rw/ro.
Currently, it is not being invoked from anywhere and no other architecture
(except arm) uses this code. Even in ARM, these functions are not invoked
from anywhere currently.

Fixes: d27c3c90817e ("riscv: add STRICT_KERNEL_RWX support")

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/mm/init.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index b55be44ff9bd..ba60a581e9b6 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -501,22 +501,6 @@ static inline void setup_vm_final(void)
 #endif /* CONFIG_MMU */
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
-void set_kernel_text_rw(void)
-{
-	unsigned long text_start = (unsigned long)_text;
-	unsigned long text_end = (unsigned long)_etext;
-
-	set_memory_rw(text_start, (text_end - text_start) >> PAGE_SHIFT);
-}
-
-void set_kernel_text_ro(void)
-{
-	unsigned long text_start = (unsigned long)_text;
-	unsigned long text_end = (unsigned long)_etext;
-
-	set_memory_ro(text_start, (text_end - text_start) >> PAGE_SHIFT);
-}
-
 void mark_rodata_ro(void)
 {
 	unsigned long text_start = (unsigned long)_text;
-- 
2.26.2

