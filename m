Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23239C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3A3E2064B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598975518;
	bh=yDLS4GpALiS50MdUjX1h3o8hJC1zdRP3oJyAoFAveEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FtBq63k3K6skuj2Cm7hTKHN286CDgurFaP1FqpjEYkxCa7EZ6JD3Q7LtQb7XC1Pwc
	 AJEQAL/V5UkFhEsAPFk4UcaGyvp2lnqebFs8TGo5C0MEF2Weg7Q4XfaLtAp/FELjIW
	 GoSnVfxJ5U7fPykpAnbYShJupWns/cNAPXlJ4GTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbgIAPsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:48:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:32996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731856AbgIAPpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:45:03 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F877206EB;
        Tue,  1 Sep 2020 15:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598975102;
        bh=yDLS4GpALiS50MdUjX1h3o8hJC1zdRP3oJyAoFAveEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WyEvA2xNy60OhA/IFxl9vn9YcO5vYvTaABC8gYSD2ofHrydmnfP/EF71Guhh1evWH
         ZSNEu1uVqnc1KU5PpNJs/n+zQkn/u3jHxJBxczrh62Jiq4GRqc5cSKT9jF7oeEcW0o
         hajRe4dIH36dbqNM3IDBrj90dX4cVhB3CL0NrPOI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Holger Assmann <h.assmann@pengutronix.de>
Subject: [PATCH 5.8 183/255] serial: stm32: avoid kernel warning on absence of optional IRQ
Date:   Tue,  1 Sep 2020 17:10:39 +0200
Message-Id: <20200901151009.455296070@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
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
@@ -962,7 +962,7 @@ static int stm32_init_port(struct stm32_
 		return ret;
 
 	if (stm32port->info->cfg.has_wakeup) {
-		stm32port->wakeirq = platform_get_irq(pdev, 1);
+		stm32port->wakeirq = platform_get_irq_optional(pdev, 1);
 		if (stm32port->wakeirq <= 0 && stm32port->wakeirq != -ENXIO)
 			return stm32port->wakeirq ? : -ENODEV;
 	}


