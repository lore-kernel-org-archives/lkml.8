Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A39C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD5F02064A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586857902;
	bh=lLjOdJNzfTg1XA/Y4GH1+dUhMNXmzn/l6kUU1xx7rgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gjb8MXZPXs5TRUq5CfG3l2+7V4K6ChqcwgM2y135JlB7RwDMPmbIl2Z96RBbeW8dy
	 mGJ2s/kxzFOAmmkDzJBnh+JpswDSr6Y6QjP2g/JusmJUJKX2IX71uxm5XPu1XQpOjh
	 hXSzOTXaS2UeNeUD08MufN+mcFbwfVwmbFHMGuw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437986AbgDNJvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 05:51:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437933AbgDNJuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 05:50:20 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D7612076A;
        Tue, 14 Apr 2020 09:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586857820;
        bh=lLjOdJNzfTg1XA/Y4GH1+dUhMNXmzn/l6kUU1xx7rgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GL3qZlL7APH1maPT8McqIJ0pjVP4KEMK/Q2PsPzMTqhkdz6Vlz4A66fn6R89WkUyA
         X412SftxXGI9kXlSj6Dl3hboeFeiWLM6IdcLPPSrPbqrkHMeIrI6gvqdzepcT7Pq0A
         Wg/sEGb1MQMjLH//ZNUmiEfavTrr/Eax2pj8TMME=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jOICw-0036Cw-Lw; Tue, 14 Apr 2020 10:50:18 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Zenghui Yu <yuzenghui@huawei.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 2/2] irqchip/gic-v4.1: Update effective affinity of virtual SGIs
Date:   Tue, 14 Apr 2020 10:50:13 +0100
Message-Id: <20200414095013.2821418-3-maz@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414095013.2821418-1-maz@kernel.org>
References: <20200414095013.2821418-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, yuzenghui@huawei.com, eric.auger@redhat.com, jason@lakedaemon.net, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although the vSGIs are not directly visible to the host, they still
get moved around by the CPU hotplug, for example. This results in
the kernel moaning on the console, such as:

  genirq: irq_chip GICv4.1-sgi did not update eff. affinity mask of irq 38

Updating the effective affinity on set_affinity() fixes it.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index e24a145f17f6..84366cc1c14f 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4054,6 +4054,7 @@ static int its_sgi_set_affinity(struct irq_data *d,
 	 * not on the host (since they can only be targetting a vPE).
 	 * Tell the kernel we've done whatever it asked for.
 	 */
+	irq_data_update_effective_affinity(d, mask_val);
 	return IRQ_SET_MASK_OK;
 }
 
-- 
2.25.1

