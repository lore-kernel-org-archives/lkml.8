Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD520C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 03:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB13420738
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 03:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="U2lpAylM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgHDDCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 23:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgHDDCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 23:02:13 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0D7C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 20:02:12 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id i92so897357pje.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 20:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZTAatZWZ0GlXiEm9GiJYu4NMJeGV2u8v2fu1nTAIzio=;
        b=U2lpAylM/0OnEjFRijGhvgd7ONcjlUmJbYh5pUB+FDETfYHPB8eimJYKMUKD+Lsqss
         ix+CXbFa6SfmC9EveDxMv681ft3f5TLU2GkaZpvt0BBfHck3GY6NdW0wlhEmE09o+eOc
         4RXSAPG5oB/jVZnHiiXPM2IrEnMozx43zdc0q5Wz2zmKj8EYMltIY29U/mzxACvtqoRr
         CXQGHcyZB8a0SBIZfzuEQ92TwFlo4SgQgzjiPINYN/0HIw1LPMpfbVZx2eNPh+YLEFpB
         tngNAO8tbcvxNgmxiUpxaOgFX+y+HByISIOYZx4P+vsRYj9vTcObM2mJTM584VGnd162
         rpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZTAatZWZ0GlXiEm9GiJYu4NMJeGV2u8v2fu1nTAIzio=;
        b=PS0pZI5zo4T6BtV0T9oL4yOToZeOR7DLvzIGrYMV5WOelisO7R5ZKeHSmmBNpoS8ej
         Nnn/P2Np6DMGiFhdnyuQmNoKmR0AwCKifkbf1v6Ie1qTvi5i59Bsab0ZjfMp1j9u9sV3
         TH/qn3QAucf5UlshROO9cUELy7dz7Yvdc98t0cvgm/M+WTdalBMAMcxdOKijDfpUrdS8
         tRpk853QewBPTLrKOfitb/RSPJCaPV4EMUPIXGj+Qiabd6s2MdLU3trGAZLbXlxZsG3l
         nz0NuF56OMdYHx7CU8Bhi3y1QDCEddBi7TU7mdDcM1cm/97wAbPRDd3gYr/NCVyfsF4C
         8JHQ==
X-Gm-Message-State: AOAM5332Jhj5TdUAYZTTJw3DmWBn1VFBz4/8+3TBVzXmhwptRQVpXsiB
        /kLjFc3Ahx1RwHOJn67j+VKjlw==
X-Google-Smtp-Source: ABdhPJw7mixIQ1U1MltIEHSHX8Kz3GsNmNG6C8BEexFvbJ/XQ+lPmZYZ3/wP/fjYNU1s8cIbpcgtMQ==
X-Received: by 2002:a17:90a:ff07:: with SMTP id ce7mr2303816pjb.192.1596510132416;
        Mon, 03 Aug 2020 20:02:12 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id x15sm20396240pfr.208.2020.08.03.20.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 20:02:11 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com, syven.wang@sifive.com
Subject: [PATCH] riscv: Add sfence.vma after page table changed
Date:   Tue,  4 Aug 2020 11:02:05 +0800
Message-Id: <20200804030205.91656-1-greentime.hu@sifive.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch addes local_flush_tlb_page(addr) to use sfence.vma after the
page table changed. That address will be used immediately in
memset(nextp, 0, PAGE_SIZE) to cause this issue so we should add the
sfence.vma before we use it.

Fixes: f2c17aabc917 ("RISC-V: Implement compile-time fixed mappings")

Reported-by: Syven Wang <syven.wang@sifive.com>
Signed-off-by: Syven Wang <syven.wang@sifive.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/mm/init.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index f4adb3684f3d..29b0f7108054 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -202,12 +202,11 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
 
 	ptep = &fixmap_pte[pte_index(addr)];
 
-	if (pgprot_val(prot)) {
+	if (pgprot_val(prot))
 		set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, prot));
-	} else {
+	else
 		pte_clear(&init_mm, addr, ptep);
-		local_flush_tlb_page(addr);
-	}
+	local_flush_tlb_page(addr);
 }
 
 static pte_t *__init get_pte_virt(phys_addr_t pa)
-- 
2.28.0

