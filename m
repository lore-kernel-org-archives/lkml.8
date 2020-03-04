Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCCDC3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 20:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B690F24658
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 20:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583354192;
	bh=jIaDVMgNDAojAdth6JddZsvPCm/9yhXe9ZoXPpkkiXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ybf7e8mFTAYAGRXuamd2P66HvUu1G8073krjeREXq71YZ8/Kt1dQlBHXk6s7w0o2m
	 caA5ESclbTGWncwEzzUTPirp4Dny6ctncnhXbnufqJgfHI0znO396n2VwKhCjgRJAM
	 EFr4QIfvMAcQV/b+q5h/ej6wvgZDpxoXjXB6X1Z4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388385AbgCDUgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 15:36:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:36306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388328AbgCDUga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 15:36:30 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AD7721775;
        Wed,  4 Mar 2020 20:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583354189;
        bh=jIaDVMgNDAojAdth6JddZsvPCm/9yhXe9ZoXPpkkiXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KBrFBmZMnU6th+KyvGB6vi0fv+RN1kGbLj/ljvPLgOxKiEiab14eVbvQdFjZTRELB
         KwLOOl70rlLXY7X9ydLYIt+OeGYFlP8GufgvQtoKLB9ukuVJd99Vx4JcneHjtDQJ6s
         my82YXb2aA/0ptwsc14rmDw/KhE/74jEcxHxN5Cg=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1j9aj9-00A59R-9H; Wed, 04 Mar 2020 20:34:47 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Robert Richter <rrichter@marvell.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v5 12/23] irqchip/gic-v4.1: Plumb set_vcpu_affinity SGI callbacks
Date:   Wed,  4 Mar 2020 20:33:19 +0000
Message-Id: <20200304203330.4967-13-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304203330.4967-1-maz@kernel.org>
References: <20200304203330.4967-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, jason@lakedaemon.net, rrichter@marvell.com, tglx@linutronix.de, yuzenghui@huawei.com, eric.auger@redhat.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like for vLPIs, there is some configuration information that cannot
be directly communicated through the normal irqchip API, and we have to
use our good old friend set_vcpu_affinity as a side-band communication
mechanism.

This is used to configure group and priority for a given vSGI.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c   | 18 ++++++++++++++++++
 include/linux/irqchip/arm-gic-v4.h |  5 +++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index fb2b836c31ff..effb0e0b0c9d 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4033,6 +4033,23 @@ static int its_sgi_get_irqchip_state(struct irq_data *d,
 	return 0;
 }
 
+static int its_sgi_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
+{
+	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
+	struct its_cmd_info *info = vcpu_info;
+
+	switch (info->cmd_type) {
+	case PROP_UPDATE_SGI:
+		vpe->sgi_config[d->hwirq].priority = info->priority;
+		vpe->sgi_config[d->hwirq].group = info->group;
+		its_configure_sgi(d, false);
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static struct irq_chip its_sgi_irq_chip = {
 	.name			= "GICv4.1-sgi",
 	.irq_mask		= its_sgi_mask_irq,
@@ -4040,6 +4057,7 @@ static struct irq_chip its_sgi_irq_chip = {
 	.irq_set_affinity	= its_sgi_set_affinity,
 	.irq_set_irqchip_state	= its_sgi_set_irqchip_state,
 	.irq_get_irqchip_state	= its_sgi_get_irqchip_state,
+	.irq_set_vcpu_affinity	= its_sgi_set_vcpu_affinity,
 };
 
 static int its_sgi_irq_domain_alloc(struct irq_domain *domain,
diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqchip/arm-gic-v4.h
index 44e8c19e3d56..b4dbf899460b 100644
--- a/include/linux/irqchip/arm-gic-v4.h
+++ b/include/linux/irqchip/arm-gic-v4.h
@@ -103,6 +103,7 @@ enum its_vcpu_info_cmd_type {
 	SCHEDULE_VPE,
 	DESCHEDULE_VPE,
 	INVALL_VPE,
+	PROP_UPDATE_SGI,
 };
 
 struct its_cmd_info {
@@ -115,6 +116,10 @@ struct its_cmd_info {
 			bool		g0en;
 			bool		g1en;
 		};
+		struct {
+			u8		priority;
+			bool		group;
+		};
 	};
 };
 
-- 
2.20.1

