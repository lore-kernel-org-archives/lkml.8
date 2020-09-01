Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7FAC433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2591F2168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598974555;
	bh=lMCz7shUEGYmhFpPBbA9bvISxtpCW3iyb3Uv1DC/0k0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oqZV33xeCqPNHLE7Tw2c0RK6TmW9O06UQpqNTbfJ3NlzAlNVoLjr1AyXfnUa6GeKG
	 uH1ASG906VR+2qR9h80jsfP4ryi3A/5LJdDtFc2fdSRfXjK3r/Pz0fFpbGlTXvL3PF
	 AeHle1wlM2FyUeV4BIpPqV7sM2HUN4s2RvQ+5PRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731177AbgIAPfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:35:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728058AbgIAPeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:34:46 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16B7D21548;
        Tue,  1 Sep 2020 15:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974485;
        bh=lMCz7shUEGYmhFpPBbA9bvISxtpCW3iyb3Uv1DC/0k0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qr9bBI6hHe4rxk4wEpt0pWr+WRdzb+dIWlBBPlZyktbquO2Kytl9KlsqQHCjM16Lp
         +lnMtC6YmaoTjMTfnCdadfcwk7XciaMBkCSGCSItWvlZe4g11iEnJ79US66chW+iTP
         iBWH1E8aHj36IPdwFvTRGf8+j+bWGJi+pcwFBmCI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Holger Assmann <h.assmann@pengutronix.de>
Subject: [PATCH 5.4 164/214] serial: stm32: avoid kernel warning on absence of optional IRQ
Date:   Tue,  1 Sep 2020 17:10:44 +0200
Message-Id: <20200901151000.835096270@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150952.963606936@linuxfoundation.org>
References: <20200901150952.963606936@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Holger Assmann <h.assmann@pengutronix.de>

commit fdf16d78941b4f380753053d229955baddd00712 upstream.

stm32_init_port() of the stm32-usart may trigger a warning in
platform_get_irq() when the device tree specifies no wakeup interrupt.

The wakeup interrupt is usually a board-specific GPIO and the driver
functions correctly in its absence. The mainline stm32mp151.dtsi does
not specify it, so all mainline device trees trigger an unnecessary
kernel warning. Use of platform_get_irq_optional() avoids this.

Fixes: 2c58e56096dd ("serial: stm32: fix the get_irq error case")
Signed-off-by: Holger Assmann <h.assmann@pengutronix.de>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200813152757.32751-1-h.assmann@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/stm32-usart.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -937,7 +937,7 @@ static int stm32_init_port(struct stm32_
 	stm32_init_rs485(port, pdev);
 
 	if (stm32port->info->cfg.has_wakeup) {
-		stm32port->wakeirq = platform_get_irq(pdev, 1);
+		stm32port->wakeirq = platform_get_irq_optional(pdev, 1);
 		if (stm32port->wakeirq <= 0 && stm32port->wakeirq != -ENXIO)
 			return stm32port->wakeirq ? : -ENODEV;
 	}


