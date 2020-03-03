Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A37C3F2D2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76643217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583204177;
	bh=F4Lhoeop5jyc/HLHpAGZSESF9WLzwH4clZlIidY28eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZTbr4UWjJYjPin9WwLWMTZ6Cxfi3blyYpo9yCH1TdyP6F3L7AU3qYciw6bMhYtRn2
	 o/lgIm0LCk1kZPMHNAlGsKo9tqYhoLxagH+Sz1CtwAbYlxf6ieRXrVVyRzgPQ/rxF2
	 v70suOBJIJ8Jqq1FM1qMnOb4H7JJfk7tGDI1czm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgCCC4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:56:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:44638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728536AbgCCCsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:48:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C553246D6;
        Tue,  3 Mar 2020 02:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583203725;
        bh=F4Lhoeop5jyc/HLHpAGZSESF9WLzwH4clZlIidY28eo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oza0F+JPD3jlvzy5ALAeQwmjAuXZWGfpOSIWeC/XKRoNF2j9YOD4hj8r8FyLHgz6A
         qcEMRfDFi9SzdN4zz8QdmO/NwHMuwyVbnqIOBhj4YuDG7J2O3JwLvRnBrICr3+4ieB
         tQHVys4cbcjEzAKK4aSx3TV7O1U9EippV9r4/eso=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guo Ren <guoren@linux.alibaba.com>,
        Sasha Levin <sashal@kernel.org>, linux-csky@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 54/58] csky/smp: Fixup boot failed when CONFIG_SMP
Date:   Mon,  2 Mar 2020 21:47:36 -0500
Message-Id: <20200303024740.9511-54-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303024740.9511-1-sashal@kernel.org>
References: <20200303024740.9511-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

[ Upstream commit c9492737b25ca32679ba3163609d938c9abfd508 ]

If we use a non-ipi-support interrupt controller, it will cause panic here.
We should let cpu up and work with CONFIG_SMP, when we use a non-ipi intc.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/csky/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index b753d382e4cef..0bb0954d55709 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -120,7 +120,7 @@ void __init setup_smp_ipi(void)
 	int rc;
 
 	if (ipi_irq == 0)
-		panic("%s IRQ mapping failed\n", __func__);
+		return;
 
 	rc = request_percpu_irq(ipi_irq, handle_ipi, "IPI Interrupt",
 				&ipi_dummy_dev);
-- 
2.20.1

