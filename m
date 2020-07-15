Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615C9C433E8
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 23:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42251206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 23:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e8cqtuVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgGOXag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 19:30:36 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49845 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgGOXad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 19:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594855833; x=1626391833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5kQrWwHrAj/YyBZ09Df67BPo3nptH7Z6t1IAIOeIJ0Q=;
  b=e8cqtuVAjexuflWwLObcn+APMsqjtoOl5wCLSaf7wN7Lh9y5fpW/mZZ1
   R/Q6PcT9Et5bCIEtXGLiwoDYS8fEJ1bLJWK7U4XhHyNnAazkkQgEA1Ljw
   RxvimJSwlUP+qQF/NonfaJkhJdQH7zOnQ/q/lmlBGRlmrBqs/YP9Q6WnM
   SfbBRXvNpfTTuCVnTTRyWYw8QXuKe3DPk0lqHKKIrN63vZ7qnAhhuqtsm
   fhaPIdq81RVKMHOKBBI/UOmO4ADFRYrGzuxnq1/tw9kA9faQWLuQ1Xc7w
   l3BgGCCVa4vjjZlu/6jnpSKHWX+i+aI/EKbs1kMzlEwXuQAYwrPDYC+2w
   Q==;
IronPort-SDR: MBqbzWLwu3+0tOVvw/gbAjFxBQ7WkHMitFCxHQrObE8Vlos/qhyihg3+4k/g5J0uq+13gkMpV2
 hbT/EIS12qAQfglQZKkpJxjeyTXUyVEBDeXupu2uArcTxFO57KttwM1z8IDASYMTFZqAFEuaDj
 6PhEOD9//NQtHM5EPs9LkUzITMONckybIAX0frzUpZ6pUp6ZGWXM/EbP8iNu9L2uiqYrpUqCib
 Qiz09PUYE6+8mqGK2LEns22wWt7AQQkzHjnfthfXEZ+Qmd++Ustliw0v9BdGDf7mzYLqtKXu+u
 AJI=
X-IronPort-AV: E=Sophos;i="5.75,357,1589212800"; 
   d="scan'208";a="146868541"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2020 07:30:19 +0800
IronPort-SDR: B5mmnYotYoHoJWTllCVoF3OCWyZuHY+PMTjhxeL3Kt6GCqwppWMdnzwMNf2mGcIyI6BjNtfPUC
 FYQBApjTU+hA+NLVM5ZwDspGj5ydywl1U=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 16:18:43 -0700
IronPort-SDR: E0hQIX7CydO5HGsevPgVvucJmOwMETCcCXqbbTiK7oZt6znBE0XEHaqeqCDlPrG9tXKWpG8heY
 QC3A6nrTbKlQ==
WDCIronportException: Internal
Received: from cnf009656.ad.shared (HELO jedi-01.hgst.com) ([10.86.58.5])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Jul 2020 16:30:18 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH 2/4] RISC-V: Set maximum number of mapped pages correctly
Date:   Wed, 15 Jul 2020 16:30:07 -0700
Message-Id: <20200715233009.27183-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200715233009.27183-1-atish.patra@wdc.com>
References: <20200715233009.27183-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, maximum number of mapper pages are set to the pfn calculated
from the memblock size of the memblock containing kernel. This will work
until that memblock spans the entire memory. However, it will be set to
a wrong value if there are multiple memblocks defined in kernel
(e.g. with efi runtime services).

Set the the maximum value to the pfn calculated from dram size.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index f4adb3684f3d..8d22973bde40 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -150,9 +150,9 @@ void __init setup_bootmem(void)
 	/* Reserve from the start of the kernel to the end of the kernel */
 	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
 
-	set_max_mapnr(PFN_DOWN(mem_size));
 	max_pfn = PFN_DOWN(memblock_end_of_DRAM());
 	max_low_pfn = max_pfn;
+	set_max_mapnr(max_low_pfn);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	setup_initrd();
-- 
2.24.0

