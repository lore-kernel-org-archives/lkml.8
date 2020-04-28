Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFD5C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D639206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099473;
	bh=aS0hFVpQWhXW7VFuiT/Y6uJtqHdrHx0vSSqNIPj78N4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZNCFSOwum7R0dJm4Kw9CYxLQKEAFmHBysXMbtvXGk9xl2gslqQcwplVPXLJhyeReF
	 jo0gZ5PPXve/z8IW47sM4K7TlfhJloxzokSfbQXc7LZFo36ZmFL1Zqu8pGilae9N/P
	 kmrd0TZ2G10utqWes0+tDIvvNMT0EGG2f3BvDZfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbgD1Sob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:44:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731490AbgD1SoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:44:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04F2920575;
        Tue, 28 Apr 2020 18:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099464;
        bh=aS0hFVpQWhXW7VFuiT/Y6uJtqHdrHx0vSSqNIPj78N4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oXx6tfOizS48q8olYvhrOV+0xM/wpt+H1htxQbeg8rGs7b9h+r6Cr+naVxt8k4i1b
         /hS/AjUjGI3xt896WCiGwAHgvYyNz/ys9lTyOz+zXJPyLCdUWdQssXIPLsnF94eLzK
         nlhTg0OeSk9M+pbLOYMHz1uZLXaXE1zbyczxcfD8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 5.4 161/168] Revert "serial: uartps: Do not allow use aliases >= MAX_UART_INSTANCES"
Date:   Tue, 28 Apr 2020 20:25:35 +0200
Message-Id: <20200428182251.316191194@linuxfoundation.org>
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

commit 91c9dfa25c7f95b543c280e0edf1fd8de6e90985 upstream.

This reverts commit 2088cfd882d0403609bdf426e9b24372fe1b8337.

As Johan says, this driver needs a lot more work and these changes are
only going in the wrong direction:
  https://lkml.kernel.org/r/20190523091839.GC568@localhost

Reported-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/dac3898e3e32d963f357fb436ac9a7ac3cbcf933.1585905873.git.michal.simek@xilinx.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/xilinx_uartps.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1697,8 +1697,7 @@ err_out_unregister_driver:
 	uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
 err_out_id:
 	mutex_lock(&bitmap_lock);
-	if (cdns_uart_data->id < MAX_UART_INSTANCES)
-		clear_bit(cdns_uart_data->id, bitmap);
+	clear_bit(cdns_uart_data->id, bitmap);
 	mutex_unlock(&bitmap_lock);
 	return rc;
 }
@@ -1723,8 +1722,7 @@ static int cdns_uart_remove(struct platf
 	rc = uart_remove_one_port(cdns_uart_data->cdns_uart_driver, port);
 	port->mapbase = 0;
 	mutex_lock(&bitmap_lock);
-	if (cdns_uart_data->id < MAX_UART_INSTANCES)
-		clear_bit(cdns_uart_data->id, bitmap);
+	clear_bit(cdns_uart_data->id, bitmap);
 	mutex_unlock(&bitmap_lock);
 	clk_disable_unprepare(cdns_uart_data->uartclk);
 	clk_disable_unprepare(cdns_uart_data->pclk);


