Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE16C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B8020678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996907;
	bh=fU+uoKOXpuBcf++EMnv2Fo9GfhZpAn5vxVCa+VZOIWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JX3EhOq3TA5J1+wMoB0R2DblnUO24tMOPrrh+dsElooaR5O3NC8tfIYIreCYtApsG
	 rd2aG1PIQmpN1lwkEXjSgjWNJRuqZoKsVoYUTfnuJMmxV1BUbfaaY+Ca9fdvwfuLJl
	 Ji9+Y+q2q0HhxcbBbJL5r8E2JZapUZzj2Xfa+76A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbgANKPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:15:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732469AbgANKLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:11:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C706A24682;
        Tue, 14 Jan 2020 10:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996684;
        bh=fU+uoKOXpuBcf++EMnv2Fo9GfhZpAn5vxVCa+VZOIWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SoRf1YikQ6C8SZ5bIbprFJsRZ+36zpNpoL5Y1OVi63h1uSSRjfuBSJxtY3wzsQaEA
         vSqeOQ75RVwtkRf7IiG4r00Wyq6BdM5lb82PlpCLcQAX5uHXA2JwMUey1DtMqRbH3N
         DuXQ4j6W/EaLWCDoMo1Da1AzZkdR/699c2xXCPKs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Bin Liu <b-liu@ti.com>
Subject: [PATCH 4.9 19/31] usb: musb: Disable pullup at init
Date:   Tue, 14 Jan 2020 11:02:11 +0100
Message-Id: <20200114094343.516551634@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094334.725604663@linuxfoundation.org>
References: <20200114094334.725604663@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Cercueil <paul@crapouillou.net>

commit 96a0c12843109e5c4d5eb1e09d915fdd0ce31d25 upstream.

The pullup may be already enabled before the driver is initialized. This
happens for instance on JZ4740.

It has to be disabled at init time, as we cannot guarantee that a gadget
driver will be bound to the UDC.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Suggested-by: Bin Liu <b-liu@ti.com>
Cc: stable@vger.kernel.org
Signed-off-by: Bin Liu <b-liu@ti.com>
Link: https://lore.kernel.org/r/20200107152625.857-3-b-liu@ti.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/musb/musb_core.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2317,6 +2317,9 @@ musb_init_controller(struct device *dev,
 	musb_platform_disable(musb);
 	musb_generic_disable(musb);
 
+	/* MUSB_POWER_SOFTCONN might be already set, JZ4740 does this. */
+	musb_writeb(musb->mregs, MUSB_POWER, 0);
+
 	/* Init IRQ workqueue before request_irq */
 	INIT_DELAYED_WORK(&musb->irq_work, musb_irq_work);
 	INIT_DELAYED_WORK(&musb->deassert_reset_work, musb_deassert_reset);


