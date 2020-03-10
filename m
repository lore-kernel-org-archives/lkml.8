Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBD8C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBE12253D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845178;
	bh=7+LMZXNi4MoY4tezDeyJYcxJUKRx7xxqRt+myaI/E10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z2ZA8Un9h2rZnNy9Qgn/WsjGGJo/85qSSkWJW9yiQRv+Baq2qylpJqk0t+4xfw5cv
	 p91awD6QKfa8LwVB2ITQApnRayLREvfuYlQuHw7NXwpye7Tu1ptjIUc6krCN9aeI1y
	 oVD91ZbJyvWJMWk2eAX5BnzhcWL8gIA7xLYFaZVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgCJM7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:59:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729871AbgCJM7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:59:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DC7524698;
        Tue, 10 Mar 2020 12:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845172;
        bh=7+LMZXNi4MoY4tezDeyJYcxJUKRx7xxqRt+myaI/E10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f8RQ8Ikeuiu9jeiAL8bC/8kXYNv5xpATkMY+P56nuXMkqeNMx/U+BiR/YtY9aofhX
         Ww1Nmqtr8n/WjJBRIt/fsUBWzxoUMGnlPq6Rz/Uir+kEEeenLOPXyAukP079DJzHfL
         VK/MA0RX3gW5zryhgL6E7DDSWFZ1Nm4+Os3wokRA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH 5.5 089/189] tty: serial: fsl_lpuart: free IDs allocated by IDA
Date:   Tue, 10 Mar 2020 13:38:46 +0100
Message-Id: <20200310123648.719610467@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

commit 2b2e71fe657510a6f71aa16ef0309fa6bc20ab3d upstream.

Since commit 3bc3206e1c0f ("serial: fsl_lpuart: Remove the alias node
dependence") the port line number can also be allocated by IDA, but in
case of an error the ID will no be removed again. More importantly, any
ID will be freed in remove(), even if it wasn't allocated but instead
fetched by of_alias_get_id(). If it was not allocated by IDA there will
be a warning:
  WARN(1, "ida_free called for id=%d which is not allocated.\n", id);

Move the ID allocation more to the end of the probe() so that we still
can use plain return in the first error cases.

Fixes: 3bc3206e1c0f ("serial: fsl_lpuart: Remove the alias node dependence")
Signed-off-by: Michael Walle <michael@walle.cc>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200303174306.6015-3-michael@walle.cc
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/fsl_lpuart.c |   39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -268,6 +268,7 @@ struct lpuart_port {
 	int			rx_dma_rng_buf_len;
 	unsigned int		dma_tx_nents;
 	wait_queue_head_t	dma_wait;
+	bool			id_allocated;
 };
 
 struct lpuart_soc_data {
@@ -2429,19 +2430,6 @@ static int lpuart_probe(struct platform_
 	if (!sport)
 		return -ENOMEM;
 
-	ret = of_alias_get_id(np, "serial");
-	if (ret < 0) {
-		ret = ida_simple_get(&fsl_lpuart_ida, 0, UART_NR, GFP_KERNEL);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "port line is full, add device failed\n");
-			return ret;
-		}
-	}
-	if (ret >= ARRAY_SIZE(lpuart_ports)) {
-		dev_err(&pdev->dev, "serial%d out of range\n", ret);
-		return -EINVAL;
-	}
-	sport->port.line = ret;
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	sport->port.membase = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(sport->port.membase))
@@ -2485,9 +2473,25 @@ static int lpuart_probe(struct platform_
 		}
 	}
 
+	ret = of_alias_get_id(np, "serial");
+	if (ret < 0) {
+		ret = ida_simple_get(&fsl_lpuart_ida, 0, UART_NR, GFP_KERNEL);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "port line is full, add device failed\n");
+			return ret;
+		}
+		sport->id_allocated = true;
+	}
+	if (ret >= ARRAY_SIZE(lpuart_ports)) {
+		dev_err(&pdev->dev, "serial%d out of range\n", ret);
+		ret = -EINVAL;
+		goto failed_out_of_range;
+	}
+	sport->port.line = ret;
+
 	ret = lpuart_enable_clks(sport);
 	if (ret)
-		return ret;
+		goto failed_clock_enable;
 	sport->port.uartclk = lpuart_get_baud_clk_rate(sport);
 
 	lpuart_ports[sport->port.line] = sport;
@@ -2537,6 +2541,10 @@ static int lpuart_probe(struct platform_
 failed_attach_port:
 failed_irq_request:
 	lpuart_disable_clks(sport);
+failed_clock_enable:
+failed_out_of_range:
+	if (sport->id_allocated)
+		ida_simple_remove(&fsl_lpuart_ida, sport->port.line);
 	return ret;
 }
 
@@ -2546,7 +2554,8 @@ static int lpuart_remove(struct platform
 
 	uart_remove_one_port(&lpuart_reg, &sport->port);
 
-	ida_simple_remove(&fsl_lpuart_ida, sport->port.line);
+	if (sport->id_allocated)
+		ida_simple_remove(&fsl_lpuart_ida, sport->port.line);
 
 	lpuart_disable_clks(sport);
 


