Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FE8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199092468F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220653;
	bh=5Z6EN6VJq3DfDOLKKD91wpew8hlqtMfujy9PSyL+YbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U6GvmhQ1Q2bUCMYBUi/7h07CrGNycjwMvBR93V+zjUXCwtLnlm2QffY5iyn51iddg
	 uASbBwECPK/CV0wMfxAzWmzSQTUsiy4Mx39Wq1jfda8G6Dgogka4OzRtUk6sDALgi9
	 B+qTw7sm8jQrRGofPxOtaX17gtqNE6+AfV0+zd2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgA1OKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:10:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:59762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726797AbgA1OKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:10:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C02A2468F;
        Tue, 28 Jan 2020 14:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220649;
        bh=5Z6EN6VJq3DfDOLKKD91wpew8hlqtMfujy9PSyL+YbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IpGAUMlTnpMYV9/tdBCh+nytvQY2OtZeJLbMs8Hjz3pehQOCRPzma8bqeVOeG6t2H
         Q02uSrqeBIe/Aaa1BSNHQlOa4+HeFrIqw+2rayp271Oo7xGnG8PW66iiIK790XBYz8
         oyHy3PptaouQN3aq48lbX0ubBZ6iGRpKb65tk5Ag=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 091/183] ARM: riscpc: fix lack of keyboard interrupts after irq conversion
Date:   Tue, 28 Jan 2020 15:05:10 +0100
Message-Id: <20200128135839.199485314@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135829.486060649@linuxfoundation.org>
References: <20200128135829.486060649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit 63a0666bca9311f35017be454587f3ba903644b8 ]

Fix lack of keyboard interrupts for RiscPC due to incorrect conversion.

Fixes: e8d36d5dbb6a ("ARM: kill off set_irq_flags usage")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-rpc/irq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rpc/irq.c b/arch/arm/mach-rpc/irq.c
index 66502e6207fea..fce7fecbd8fa4 100644
--- a/arch/arm/mach-rpc/irq.c
+++ b/arch/arm/mach-rpc/irq.c
@@ -117,7 +117,7 @@ extern unsigned char rpc_default_fiq_start, rpc_default_fiq_end;
 
 void __init rpc_init_irq(void)
 {
-	unsigned int irq, clr, set = 0;
+	unsigned int irq, clr, set;
 
 	iomd_writeb(0, IOMD_IRQMASKA);
 	iomd_writeb(0, IOMD_IRQMASKB);
@@ -129,6 +129,7 @@ void __init rpc_init_irq(void)
 
 	for (irq = 0; irq < NR_IRQS; irq++) {
 		clr = IRQ_NOREQUEST;
+		set = 0;
 
 		if (irq <= 6 || (irq >= 9 && irq <= 15))
 			clr |= IRQ_NOPROBE;
-- 
2.20.1



