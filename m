Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CC0C83002
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 04:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1C3E2073E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 04:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cznpSpEi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgD3EFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 00:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725280AbgD3EFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 00:05:11 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A9AC035494
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 21:05:11 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z1so2266509pfn.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 21:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nL5VdHGdHlO2IhatVlz8X2CvG6piY9r4GDUrKsxm6ic=;
        b=cznpSpEiKH0hWKnAx7uiNiDeEwX7JlHVKlluiqHNX33+HHWfFn62Kn29274rvc+uVz
         rOUdG86CoRen4CZvqcq7OquI9A+E8ZRXuOVo4wISjUibG2vYtwHg9jsZRr+K+CdptyTK
         iKgFksouKlj3d3tKpgTMh79uoJdEyvWRBi0nYwP+4HxbWZMs+nlTO8KNFzlf6hvExW8+
         JRwRL4u5q6M/bkLb472L+0o/NQP04ijfzV32DZB2FEY75+NH0dyFclfXnJAE6WT3/GGt
         A+pUe4z4jsbl4btUNziBt6+091qGMRA95ardgp/E9w3NVA+cFH4llUfRrwJ1fq37qdEs
         JiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nL5VdHGdHlO2IhatVlz8X2CvG6piY9r4GDUrKsxm6ic=;
        b=VSbiGp2wJx1WBtC/XsvR+sZ8e4vRTRqGzvzNvF1wl3ZyO7D0VYUGaVRMTZY059gWhC
         5Z7lq0XxLwgv+JdJ9EvCupxrPwJAjIagyaB2E25qgHzyGythEyk8q4L8cBT1PoW5KYHR
         4lhFqIoBeItNTfJO4WNBtGemlIQfjM6RisBV0f72fTV8x/aFQmuyn6sCTinuviFvkwBm
         SSLguupzqoP6MDeZgGX668QNKuAWT2f5FEVeWQoFNzPFadW1S87nn7UmtkLVWYWYyxtE
         SJ0VfEX8VTmhxntAWDuTI3+DbpgYW+kF5nHZOpvqGADgmPs8fmDzWEOu5Pt0GbVOdqfu
         fBgA==
X-Gm-Message-State: AGi0PuaVHmmUMpQflurfu15Y/s38+seGN4yl0xxlbU9oByT1jyhdhV7j
        Qvs8sF7HN+tf5etHfTB05Vg=
X-Google-Smtp-Source: APiQypLLwNEhk4G5v1VTt7A03T6ulKhnelKdVSLFjdGL9WidJAeO6lU/Q524Qb58XKgf+UuQhNy3iA==
X-Received: by 2002:a62:3c5:: with SMTP id 188mr1524979pfd.41.1588219510852;
        Wed, 29 Apr 2020 21:05:10 -0700 (PDT)
Received: from ubuntu.localdomain ([223.104.63.3])
        by smtp.gmail.com with ESMTPSA id 185sm2358836pfv.9.2020.04.29.21.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 21:05:10 -0700 (PDT)
From:   Guixiong Wei <guixiongwei@gmail.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     nsaenzjulienne@suse.de, steve.capper@arm.com,
        akpm@linux-foundation.org, guro@fb.com, tglx@linutronix.de,
        rppt@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guixiong Wei <guixiongwei@gmail.com>
Subject: [PATCH] arm: mm: use __pfn_to_section() to get mem_section
Date:   Thu, 30 Apr 2020 18:04:37 +1400
Message-Id: <20200430040437.119591-1-guixiongwei@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use __pfn_to_section() to get mem_section, instead of open-coding it.
No semantic changes.

Signed-off-by: Guixiong Wei <guixiongwei@gmail.com>
---
 arch/arm64/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index e42727e3568e..d2df416b840e 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -272,7 +272,7 @@ int pfn_valid(unsigned long pfn)
 	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
 		return 0;
 
-	if (!valid_section(__nr_to_section(pfn_to_section_nr(pfn))))
+	if (!valid_section(__pfn_to_section(pfn)))
 		return 0;
 #endif
 	return memblock_is_map_memory(addr);
-- 
2.17.1

