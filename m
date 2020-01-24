Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9A6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DFC2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864797;
	bh=Be775YfMZRAshdeiSYxip5rPo/rAYt/NxuZ4l4lI9vU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NwAj3Llq0IY3ijERerVXLQyHakZEbEBagt27MEWfbBCGnKU5SbvKFLM2RJBPPJXXf
	 sMvxNP/q13TBOzIYNXQmwMqhIEllkBTioll3FVm6eT6mkBML+6ngJ0FN3UH6+Lsqkg
	 lUQ2umbNlBNJww1MtUGbWBV2DacF/okHrBaGi6nE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390853AbgAXLT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:19:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:57310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390640AbgAXLTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:19:53 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B10BF20708;
        Fri, 24 Jan 2020 11:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864793;
        bh=Be775YfMZRAshdeiSYxip5rPo/rAYt/NxuZ4l4lI9vU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A2bkoojeT508YB92KSEhmPyQHXdVfRZbWnDClvsMMNhv6g2k4dO/EGL0nlKpLwnms
         /NtQm3IOB7FkOLlWXTFKxnOy7K5q9YK/8SmojYVUkC+6oQhkogsvtm8PNfY58AlCFY
         hPcfBM3peIrAH58U8bIN/EVnnYVjLYEiosi3lQ5o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 367/639] ARM: riscpc: fix lack of keyboard interrupts after irq conversion
Date:   Fri, 24 Jan 2020 10:28:57 +0100
Message-Id: <20200124093133.052050889@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
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
index b8a61cb112073..7f0f401786344 100644
--- a/arch/arm/mach-rpc/irq.c
+++ b/arch/arm/mach-rpc/irq.c
@@ -118,7 +118,7 @@ extern unsigned char rpc_default_fiq_start, rpc_default_fiq_end;
 
 void __init rpc_init_irq(void)
 {
-	unsigned int irq, clr, set = 0;
+	unsigned int irq, clr, set;
 
 	iomd_writeb(0, IOMD_IRQMASKA);
 	iomd_writeb(0, IOMD_IRQMASKB);
@@ -130,6 +130,7 @@ void __init rpc_init_irq(void)
 
 	for (irq = 0; irq < NR_IRQS; irq++) {
 		clr = IRQ_NOREQUEST;
+		set = 0;
 
 		if (irq <= 6 || (irq >= 9 && irq <= 15))
 			clr |= IRQ_NOPROBE;
-- 
2.20.1



