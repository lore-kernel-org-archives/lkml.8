Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B83C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17BD3206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597932007;
	bh=4TN8b/w1O6wpn+41nQXj3b70jxrH9CAppsWwXRewTgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mez18iFF/4FVcUu3CmKi38ZMDIMz1PHsZEMql15QsdrJ8LNLKE2PVQ2Z6wPlFNKG/
	 ODYtN2dMjo+xtYUDTeoBqBor4W8Ij0ahS3S8hvFyUFMBQZ4BKqNFvspuYalDRmcaK7
	 YoSBIrq88z3toyQn7D6hxtY4+lgrJ7o8a4FRvv2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgHTOAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:00:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727895AbgHTJ0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:26:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7252122B4B;
        Thu, 20 Aug 2020 09:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915592;
        bh=4TN8b/w1O6wpn+41nQXj3b70jxrH9CAppsWwXRewTgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V84LmdLo+jFUDcKecDrODRGUTrynLJgP/FxCSdanQrYg/D1x+ifhadlnjuFuByCCM
         91YuUd4NF9yrBN+P+L+7muTiqc5td+AuMwbrRZ4JO+wMzeQTFGWfAfeEK0V+8/Y7Dk
         lfp/18Ngoykfv9stSRcp3xQkF6h9wlufmLAenN5s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zenghui Yu <yuzenghui@huawei.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 5.8 060/232] irqchip/gic-v4.1: Ensure accessing the correct RD when writing INVALLR
Date:   Thu, 20 Aug 2020 11:18:31 +0200
Message-Id: <20200820091615.701346985@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zenghui Yu <yuzenghui@huawei.com>

commit 3af9571cd585efafc2facbd8dbd407317ff898cf upstream.

The GICv4.1 spec tells us that it's CONSTRAINED UNPREDICTABLE to issue a
register-based invalidation operation for a vPEID not mapped to that RD,
or another RD within the same CommonLPIAff group.

To follow this rule, commit f3a059219bc7 ("irqchip/gic-v4.1: Ensure mutual
exclusion between vPE affinity change and RD access") tried to address the
race between the RD accesses and the vPE affinity change, but somehow
forgot to take GICR_INVALLR into account. Let's take the vpe_lock before
evaluating vpe->col_idx to fix it.

Fixes: f3a059219bc7 ("irqchip/gic-v4.1: Ensure mutual exclusion between vPE affinity change and RD access")
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200720092328.708-1-yuzenghui@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-gic-v3-its.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4090,18 +4090,22 @@ static void its_vpe_4_1_deschedule(struc
 static void its_vpe_4_1_invall(struct its_vpe *vpe)
 {
 	void __iomem *rdbase;
+	unsigned long flags;
 	u64 val;
+	int cpu;
 
 	val  = GICR_INVALLR_V;
 	val |= FIELD_PREP(GICR_INVALLR_VPEID, vpe->vpe_id);
 
 	/* Target the redistributor this vPE is currently known on */
-	raw_spin_lock(&gic_data_rdist_cpu(vpe->col_idx)->rd_lock);
-	rdbase = per_cpu_ptr(gic_rdists->rdist, vpe->col_idx)->rd_base;
+	cpu = vpe_to_cpuid_lock(vpe, &flags);
+	raw_spin_lock(&gic_data_rdist_cpu(cpu)->rd_lock);
+	rdbase = per_cpu_ptr(gic_rdists->rdist, cpu)->rd_base;
 	gic_write_lpir(val, rdbase + GICR_INVALLR);
 
 	wait_for_syncr(rdbase);
-	raw_spin_unlock(&gic_data_rdist_cpu(vpe->col_idx)->rd_lock);
+	raw_spin_unlock(&gic_data_rdist_cpu(cpu)->rd_lock);
+	vpe_to_cpuid_unlock(vpe, flags);
 }
 
 static int its_vpe_4_1_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)


