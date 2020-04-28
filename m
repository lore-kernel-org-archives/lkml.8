Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6DBC83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D317420575
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099149;
	bh=70en2y8im9i9iX0DhYhp+taRYiWl+DOFa6w+T0EF4Fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B3jhP9TgS4BiPBpn8eut83RhC2c1Z+hkzVSP0gT7a0M41fu2XsMxy0AuEQ8Gw04U3
	 Uo420LN/4MYiXAyPjax0O3Ad/3hYkzDtNj0zGcSx9mX/mmncibsIkFlEOU9IDjMJ3h
	 NrwGi9Xny2VFIPjFxJLmjD65X3d8Y00ZwsBDUVW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbgD1SjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:39:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730706AbgD1SjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:39:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C042A20575;
        Tue, 28 Apr 2020 18:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099141;
        bh=70en2y8im9i9iX0DhYhp+taRYiWl+DOFa6w+T0EF4Fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=swUtieol8CW3igpXn2eOqsvHVaSv7xkE12QjVMZqdhcV2TUTvugeFTsJe46L7JvPU
         eNUnyuONfjxl+lyFIc0FTCg7yOdIUJTrR6G5o+V12r26HA09qLLix15H+QDtizSAob
         u4ilBs2uEEg6UfglyikVRf7R/LRFj6pcf63H0Li4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 5.6 160/167] Revert "serial: uartps: Do not allow use aliases >= MAX_UART_INSTANCES"
Date:   Tue, 28 Apr 2020 20:25:36 +0200
Message-Id: <20200428182245.820415415@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182225.451225420@linuxfoundation.org>
References: <20200428182225.451225420@linuxfoundation.org>
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
@@ -1724,8 +1724,7 @@ err_out_unregister_driver:
 	uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
 err_out_id:
 	mutex_lock(&bitmap_lock);
-	if (cdns_uart_data->id < MAX_UART_INSTANCES)
-		clear_bit(cdns_uart_data->id, bitmap);
+	clear_bit(cdns_uart_data->id, bitmap);
 	mutex_unlock(&bitmap_lock);
 	return rc;
 }
@@ -1750,8 +1749,7 @@ static int cdns_uart_remove(struct platf
 	rc = uart_remove_one_port(cdns_uart_data->cdns_uart_driver, port);
 	port->mapbase = 0;
 	mutex_lock(&bitmap_lock);
-	if (cdns_uart_data->id < MAX_UART_INSTANCES)
-		clear_bit(cdns_uart_data->id, bitmap);
+	clear_bit(cdns_uart_data->id, bitmap);
 	mutex_unlock(&bitmap_lock);
 	clk_disable_unprepare(cdns_uart_data->uartclk);
 	clk_disable_unprepare(cdns_uart_data->pclk);


