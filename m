Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14CFC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B34AA206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099470;
	bh=+G9A+d2urEBIekAyzOxxilb6lylUKvI/JDvwZcFpwQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SMENhskRaJ9IUg4+sD9PFTN/QjTbvCYr8EOceKApQKbJtesTvdzHHC6+OEYeUQpWV
	 xEvN57JFIEAp6wYSJSq1IcERM6hdVSicHqPcwiDVwYbhJPWYGtq5hlqlocW5p/u6c6
	 PBENqq7ZgzERxLdEMWxwXietU98xTtv4U6Nhca+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgD1Soa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:44:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731417AbgD1SoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:44:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C73720575;
        Tue, 28 Apr 2020 18:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099462;
        bh=+G9A+d2urEBIekAyzOxxilb6lylUKvI/JDvwZcFpwQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cbWFwUnOipgcaNmPOQcNnoDBjwpGtPmTMVPfRs1xMW0hX4tsHwGrH4IecaCgVUQWi
         YhBimoMleNSIQtWeCmF8/ghkJ5/rQZ8/QZoLAar5bCPX2+CQ2qz9zDJVpQIpYs5v0/
         ARUiwTG1zj/Fw38l8AjCpbUAA4QGP5tbLQ5mHD/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 5.4 160/168] Revert "serial: uartps: Fix error path when alloc failed"
Date:   Tue, 28 Apr 2020 20:25:34 +0200
Message-Id: <20200428182251.244690387@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182231.704304409@linuxfoundation.org>
References: <20200428182231.704304409@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Simek <michal.simek@xilinx.com>

commit b6fd2dbbd649b89a3998528994665ded1e3fbf7f upstream.

This reverts commit 32cf21ac4edd6c0d5b9614368a83bcdc68acb031.

As Johan says, this driver needs a lot more work and these changes are
only going in the wrong direction:
  https://lkml.kernel.org/r/20190523091839.GC568@localhost

Reported-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/46cd7f039db847c08baa6508edd7854f7c8ff80f.1585905873.git.michal.simek@xilinx.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/xilinx_uartps.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1528,10 +1528,8 @@ static int cdns_uart_probe(struct platfo
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 	cdns_uart_console = devm_kzalloc(&pdev->dev, sizeof(*cdns_uart_console),
 					 GFP_KERNEL);
-	if (!cdns_uart_console) {
-		rc = -ENOMEM;
-		goto err_out_id;
-	}
+	if (!cdns_uart_console)
+		return -ENOMEM;
 
 	strncpy(cdns_uart_console->name, CDNS_UART_TTY_NAME,
 		sizeof(cdns_uart_console->name));


