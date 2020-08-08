Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E107AC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B53AB20672
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596930537;
	bh=y8wyplqEAIId6P46I1z8VaebrOgSc2gTi2rbPckwy9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=khXe8nTW5DtSZITwCkT3YmVlJOl+jtV9h5s0zudDQ/o05Hgas1PV7ipb3JyywXXUW
	 pwuA9nhmuoz02QDKOJtUqZaNJaU2egANBBlymEDDD7Rs6sUplFywQ+JZnPtaE8pMFW
	 J2RtEvoF1qNeibNug8baP+wvYUEs1JvbbbzLN86M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgHHXhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:37:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727849AbgHHXhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:37:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7ADF20723;
        Sat,  8 Aug 2020 23:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596929829;
        bh=y8wyplqEAIId6P46I1z8VaebrOgSc2gTi2rbPckwy9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JA32O9AFfcWvRV9Fq2lXj3q2o+gO0NDJqo/YdAZ6OhNMLfSVxoxRJ0/M6nWQUaFIJ
         9COODGEMWw/X4OCor6pYld8ywc7iVXjJxA6zxoCwvsk/vJLSq+IFZrbv6JETKJMPEN
         n5J0M+6TpIbqMBZglpEd1PwwpRqzr8IzH4IiSUOY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 61/72] irqchip/loongson-pch-pic: Check return value of irq_domain_translate_twocell()
Date:   Sat,  8 Aug 2020 19:35:30 -0400
Message-Id: <20200808233542.3617339-61-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808233542.3617339-1-sashal@kernel.org>
References: <20200808233542.3617339-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit 66a535c495f72e1deacc37dfa34acca2a06e3578 ]

Check the return value of irq_domain_translate_twocell() due to
it may returns -EINVAL if failed and use variable fwspec for it,
and then use a new variable parent_fwspec which is proper for
irq_domain_alloc_irqs_parent().

Fixes: ef8c01eb64ca ("irqchip: Add Loongson PCH PIC controller")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1594087972-21715-6-git-send-email-yangtiezhu@loongson.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-loongson-pch-pic.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
index 2a05b9305012b..016f32c4cbe18 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -135,16 +135,19 @@ static int pch_pic_alloc(struct irq_domain *domain, unsigned int virq,
 	int err;
 	unsigned int type;
 	unsigned long hwirq;
-	struct irq_fwspec fwspec;
+	struct irq_fwspec *fwspec = arg;
+	struct irq_fwspec parent_fwspec;
 	struct pch_pic *priv = domain->host_data;
 
-	irq_domain_translate_twocell(domain, arg, &hwirq, &type);
+	err = irq_domain_translate_twocell(domain, fwspec, &hwirq, &type);
+	if (err)
+		return err;
 
-	fwspec.fwnode = domain->parent->fwnode;
-	fwspec.param_count = 1;
-	fwspec.param[0] = hwirq + priv->ht_vec_base;
+	parent_fwspec.fwnode = domain->parent->fwnode;
+	parent_fwspec.param_count = 1;
+	parent_fwspec.param[0] = hwirq + priv->ht_vec_base;
 
-	err = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
+	err = irq_domain_alloc_irqs_parent(domain, virq, 1, &parent_fwspec);
 	if (err)
 		return err;
 
-- 
2.25.1

