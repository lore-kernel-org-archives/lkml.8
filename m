Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416DDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1461F22CBB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595262889;
	bh=6WnrSP/9H0aEpK01S5lqzV1JZMdQzzmjrml1TORPtL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X/ELIp6HJ9spB0EQ0e/3/is+WztO6mjctnwSA2bBQLTEZH+R/ArH9soKX7wIv4NUO
	 tgDVQRZDzLVEW7QU1ef1QSaMxfolZ0XkFdE0bVg53AZHXdHt9lkljfu5V/ncoYa/AO
	 ZYso39hgDayvLcXJGmQzbDjp2L66oArtYqBauPEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732526AbgGTQer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:34:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731452AbgGTPzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:55:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14FFA20734;
        Mon, 20 Jul 2020 15:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260521;
        bh=6WnrSP/9H0aEpK01S5lqzV1JZMdQzzmjrml1TORPtL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cVFKNIkvTsatsl7qjal3KaO+fJt8Khp0sqa0oltDFgjPdyAVZiTTVaT3GzZlBtj81
         6kcsVPc1hl96Ld/Qq6QnDk3R9sOyRklhcaYbifP5Np2eDlxG7ejxXWGmAG1d5Lu42p
         GTuCuSENqfa3EREkMzeINiO3jZ4SUqDiOKDERq8E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 4.19 102/133] serial: mxs-auart: add missed iounmap() in probe failure and remove
Date:   Mon, 20 Jul 2020 17:37:29 +0200
Message-Id: <20200720152808.664519354@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152803.732195882@linuxfoundation.org>
References: <20200720152803.732195882@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

commit d8edf8eb5f6e921fe6389f96d2cd05862730a6ff upstream.

This driver calls ioremap() in probe, but it misses calling iounmap() in
probe's error handler and remove.
Add the missed calls to fix it.

Fixes: 47d37d6f94cc ("serial: Add auart driver for i.MX23/28")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200709135608.68290-1-hslester96@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/mxs-auart.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1703,21 +1703,21 @@ static int mxs_auart_probe(struct platfo
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = irq;
-		goto out_disable_clks;
+		goto out_iounmap;
 	}
 
 	s->port.irq = irq;
 	ret = devm_request_irq(&pdev->dev, irq, mxs_auart_irq_handle, 0,
 			       dev_name(&pdev->dev), s);
 	if (ret)
-		goto out_disable_clks;
+		goto out_iounmap;
 
 	platform_set_drvdata(pdev, s);
 
 	ret = mxs_auart_init_gpios(s, &pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialize GPIOs.\n");
-		goto out_disable_clks;
+		goto out_iounmap;
 	}
 
 	/*
@@ -1725,7 +1725,7 @@ static int mxs_auart_probe(struct platfo
 	 */
 	ret = mxs_auart_request_gpio_irq(s);
 	if (ret)
-		goto out_disable_clks;
+		goto out_iounmap;
 
 	auart_port[s->port.line] = s;
 
@@ -1751,6 +1751,9 @@ out_free_qpio_irq:
 	mxs_auart_free_gpio_irq(s);
 	auart_port[pdev->id] = NULL;
 
+out_iounmap:
+	iounmap(s->port.membase);
+
 out_disable_clks:
 	if (is_asm9260_auart(s)) {
 		clk_disable_unprepare(s->clk);
@@ -1766,6 +1769,7 @@ static int mxs_auart_remove(struct platf
 	uart_remove_one_port(&auart_driver, &s->port);
 	auart_port[pdev->id] = NULL;
 	mxs_auart_free_gpio_irq(s);
+	iounmap(s->port.membase);
 	if (is_asm9260_auart(s)) {
 		clk_disable_unprepare(s->clk);
 		clk_disable_unprepare(s->clk_ahb);


