Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85124C433F1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 16:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61C532176B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 16:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mvQ2D74Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731338AbgGVQpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 12:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731204AbgGVQpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 12:45:13 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1345C0619E0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 09:45:12 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r12so2524651wrj.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 09:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bcTngC2Bes9sF1CupaxPgWX3tAw0UoRfYaGJIdlmeeQ=;
        b=mvQ2D74QyUwCzSPTgbT4sWDjrm7UJoVfL3cHenKVZM4lEyQ4kiJMrsWap47ViZ/Wvr
         rZDWLr9NFPdHynImP8k+kUbehz7sK/izWI9taaixH28DDyAQxLDE2IVjI4JHth6sqvMd
         Bm3MyxL4Ev2MPQ719BJsT1suvEsdnYD9LiwdooMdWfuceghQTEMxSuCUAzFCiQNkszgr
         776DU9p9GQmi0hKDgGS6X4PrAU7F1kaKRpoHIctLA3l3w5RGa68JqwP9mYrDKItjiXEp
         YdYfHynQXX5o0Cs0P73flkaXSX7R5VWhnBQrZk7Ew+typZtMNI/jv6YpF1C6khkBO0C0
         nNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bcTngC2Bes9sF1CupaxPgWX3tAw0UoRfYaGJIdlmeeQ=;
        b=S6cAsl2iwMhqrGhBs5OzHPDImYfc15l0PJbJZ21ulQXDWnHd/t7AWW+UP5F5o4jSox
         s+YllJwa3LrrsGieGGJt1DWtxs88JcpZ1kdV5kv+wjePQWNjGuG445xHp+FPzJa2+nEK
         u6ckVmdZ5l/hTZD+uxBG3fY44U/bEZA+CKU8+ECbXsAG13aky9uWtsldXIjaopntgR/6
         6MF5VOHUqz6EnpLlRBiveQqzl13exQyk2k3rHsEwyEmqQSuWPe6MojNemU+JYLLzg7LX
         bGo7cBSpugHbeW8p6hKtGAANd+0At70nnjRYvxMFZ9xVGpF4ae6lhu1pJZHxY69qPW7m
         9BbA==
X-Gm-Message-State: AOAM531qaf8/QoXpkT73VvSbLdDLCvq+jN4mxdPG0xUhFf92j3dQYPUG
        VqD/ZF8fsF6uZl8VOgxdblLxzQ==
X-Google-Smtp-Source: ABdhPJx2hxeObfvv1sweoqi7kI9BIJM5pRi6WnEDs4mkAmQ3drosmvpJW+pWqVpWlbJoNaizyRi9hA==
X-Received: by 2002:a5d:558a:: with SMTP id i10mr388087wrv.146.1595436311404;
        Wed, 22 Jul 2020 09:45:11 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:b0ee:900a:e004:b9d0])
        by smtp.gmail.com with ESMTPSA id e5sm631557wrc.37.2020.07.22.09.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 09:45:10 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        kernel-team@google.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH 7/9] kvm: arm64: Mark hyp stack pages reserved
Date:   Wed, 22 Jul 2020 17:44:22 +0100
Message-Id: <20200722164424.42225-8-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722164424.42225-1-dbrazdil@google.com>
References: <20200722164424.42225-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for unmapping hyp pages from host stage-2, allocate/free hyp
stack using new helpers which automatically mark the pages reserved.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/arm.c | 49 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 0700c3d21b23..dc557b380c87 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1451,13 +1451,58 @@ static int init_subsystems(void)
 	return err;
 }
 
+/*
+ * Alloc pages and mark them reserved so the kernel never tries to
+ * take them away from the hypervisor.
+ */
+static unsigned long alloc_hyp_pages(gfp_t flags, unsigned int order)
+{
+	struct page *page;
+	unsigned long i;
+
+	page = alloc_pages(flags, order);
+	if (!page)
+		return 0;
+
+	for (i = 0; i < (1ul << order); ++i)
+		mark_page_reserved(page + i);
+
+	return (unsigned long)page_address(page);
+}
+
+static unsigned long alloc_hyp_page(gfp_t flags)
+{
+	return alloc_hyp_pages(flags, 0);
+}
+
+/*
+ * Free pages which were previously marked reserved for the hypervisor.
+ */
+static void free_hyp_pages(unsigned long addr, unsigned int order)
+{
+	unsigned long i;
+	struct page *page;
+
+	if (!addr)
+		return;
+
+	page = virt_to_page(addr);
+	for (i = 0; i < (1ul << order); ++i)
+		free_reserved_page(page + i);
+}
+
+static void free_hyp_page(unsigned long addr)
+{
+	return free_hyp_pages(addr, 0);
+}
+
 static void teardown_hyp_mode(void)
 {
 	int cpu;
 
 	free_hyp_pgds();
 	for_each_possible_cpu(cpu)
-		free_page(per_cpu(kvm_arm_hyp_stack_page, cpu));
+		free_hyp_page(per_cpu(kvm_arm_hyp_stack_page, cpu));
 }
 
 /**
@@ -1481,7 +1526,7 @@ static int init_hyp_mode(void)
 	for_each_possible_cpu(cpu) {
 		unsigned long stack_page;
 
-		stack_page = __get_free_page(GFP_KERNEL);
+		stack_page = alloc_hyp_page(GFP_KERNEL);
 		if (!stack_page) {
 			err = -ENOMEM;
 			goto out_err;
-- 
2.27.0

