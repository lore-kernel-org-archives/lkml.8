Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75594C7619D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431F720725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IUirukFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgBQIc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:32:59 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41421 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgBQIce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:32:34 -0500
Received: by mail-pf1-f194.google.com with SMTP id j9so8431016pfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 00:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fmRXlNLWA66QEXzOsB4SiGAg688bm55gcoXcA+osGcg=;
        b=IUirukFwdTH2JYN3UHnCoo0xSkpYjWzQiS46cwG+hnudFzmLHkzzCo69fQwm020L7I
         YPsBdfIUfOfK15SP3frTDbrkoT0zSf6OORP+Rc+AX/dvOj0bn39D6xK6hNXTuNE1eu5U
         0BvCTNuD7Dfde9cqHOdhUn5Jf4f6O/9iUEClIMnfDDBmYy+CRhllzS8JaWsyklDfFDfr
         8ZVfNmkCz08xs8qBsuz/d592ISch4tfyoN1Vm2kuEty36Dj5UIPSYkA2iiV0VI0EuJ+Q
         xXuN6aDYQbFtOe0/wjvuIJg1DZ7K8mTC+6ZAlDzw1iGhfhs/lXxI6lWrENRcM1oUsyJO
         8hyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fmRXlNLWA66QEXzOsB4SiGAg688bm55gcoXcA+osGcg=;
        b=E82pI6rsX8iVMR75I82Fz/FzghEyhJrAUdLdbQ/Xa4Yjmr3FxlJTZtKJFO/RE2SG8M
         KU7lkypRr/JItmfEuN8TqoxdOh42shIf4XlzlE6tkaRW7P3O21E054+vgUfmTIjoZbFk
         RoGc67jKvelauxMtCkCzs6L0Ive8gR7/qzgGy1/HsaxolQM5meY20ZnY15j+ZTk+kflw
         v0ohjO5JFTT+BF3ZS384xGaacl7rDLAULIS+r7+LpvejnDqL5HYkOfD56T5gZ3TwvSPo
         TPPvh/+OaWLS/utv3QKddlON/vlgszULMXUzZ70/ZW6PS54SzgMLNKD3OZhgTCMDpmkg
         Ve+Q==
X-Gm-Message-State: APjAAAXK3bgRL6zkZIVz171RzIXQA7Qj8/fqVAD4rnomQYCyWRNH2+Ao
        zVagZ4yjniISayXoeBsAt38OQQ==
X-Google-Smtp-Source: APXvYqxORVll252z49WHmr/1Nnbpt/aAf5+1H1wpQBuznOWydoJWlnyYNnl4gawppsH4adiK7zMQHQ==
X-Received: by 2002:a63:c341:: with SMTP id e1mr17315588pgd.334.1581928354167;
        Mon, 17 Feb 2020 00:32:34 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id z10sm16989319pgz.88.2020.02.17.00.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 00:32:33 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 3/8] riscv: add ARCH_SUPPORTS_DEBUG_PAGEALLOC support
Date:   Mon, 17 Feb 2020 16:32:18 +0800
Message-Id: <20200217083223.2011-4-zong.li@sifive.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217083223.2011-1-zong.li@sifive.com>
References: <20200217083223.2011-1-zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARCH_SUPPORTS_DEBUG_PAGEALLOC provides a hook to map and unmap
pages for debugging purposes. Implement the __kernel_map_pages
functions to fill the poison pattern.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/Kconfig       |  3 +++
 arch/riscv/mm/pageattr.c | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 07bf1a7c0dd2..f524d7e60648 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -132,6 +132,9 @@ config ARCH_SELECT_MEMORY_MODEL
 config ARCH_WANT_GENERAL_HUGETLB
 	def_bool y
 
+config ARCH_SUPPORTS_DEBUG_PAGEALLOC
+	def_bool y
+
 config SYS_SUPPORTS_HUGETLBFS
 	def_bool y
 
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 7be6cd67e2ef..728759eb530a 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -172,3 +172,16 @@ int set_direct_map_default_noflush(struct page *page)
 
 	return walk_page_range(&init_mm, start, end, &pageattr_ops, &masks);
 }
+
+void __kernel_map_pages(struct page *page, int numpages, int enable)
+{
+	if (!debug_pagealloc_enabled())
+		return;
+
+	if (enable)
+		__set_memory((unsigned long)page_address(page), numpages,
+			     __pgprot(_PAGE_PRESENT), __pgprot(0));
+	else
+		__set_memory((unsigned long)page_address(page), numpages,
+			     __pgprot(0), __pgprot(_PAGE_PRESENT));
+}
-- 
2.25.0

