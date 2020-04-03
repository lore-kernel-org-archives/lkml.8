Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A6DC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 09:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B25F206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 09:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="x21dt5c2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390616AbgDCJYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 05:24:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37180 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390538AbgDCJYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 05:24:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id j19so6899506wmi.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 02:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z4X9CztVv9fuiwGgU0m8a6G5JZzhVQteYALGdpAp1X0=;
        b=x21dt5c2oqbttSzIm/GZIb7/QsS3KtZXZgyAyN2Xse45a99hSr5eVgqq8spcF/SQVZ
         qgUF+VQ2qONzOO5CUInCWe31mzt1Pv6h2KZuLurNrhWbwpy6uX01/UbRSdVBblHnX7cA
         r/iiLD1ddJETbqB2QE056DrI7zCE/qV9RKnbcw90CmmICoXI8uvPks8pYHxIz+O0m/sX
         OfdeiUcVZGhPXh8CuLTDR204+4VnRHn5enAMclLlGS/7udW/kt1i8VTyEDNzRi3o0e3U
         4aQsJIlGVSHkMH99GVa84vSMxbqoyFMOuGJWX/TsCY4AIYBhF33LEjC0DrF969HuKROL
         JP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Z4X9CztVv9fuiwGgU0m8a6G5JZzhVQteYALGdpAp1X0=;
        b=kofs/VHNHCh2PUmwM7nkfuArAwgYFvmxxdOWpqpy0Ql/8X3Dul8vkSdBJiBaO5PAN0
         D3HF4iZF0PrXTohSIjEX3alLR+C9h1MBrqPXD8YDhgMGAx/+m9AmS4LFXH3SHdsXPMHX
         oSJIvLDrbxP+e0txkkpxN8XTpKF3/4uZP06Ti2OKpNsMIlV9wTCLMNIuomH2K9KVISxh
         9ZZgdryLzm5gOd92gUtOuUxA00rXPr7/V2LlOaKKnR76AVsK+Ok52B7zwn22pmgPcHm9
         qJiYOHOy06r7/fa5bZDkMdXREn/AXWzNe5Ppl4G4W/mjy6rZV/trD0gh4k8LZhqu1NQo
         Rsgw==
X-Gm-Message-State: AGi0PualNNfotA9xPHZ4Ot4whL2I9ttQ1L8fX6kLHMk2EIIZg84gPhnY
        LhxWniq48MSrQF8W4U4aPpnhbQ==
X-Google-Smtp-Source: APiQypLXsFB4Nhp1P6wz0oWS1uTO4dCw50x90jze73F6lCQ9haNDHgdotGFAdwgjiq807zSRUQZjiA==
X-Received: by 2002:a7b:c452:: with SMTP id l18mr8086444wmi.140.1585905888590;
        Fri, 03 Apr 2020 02:24:48 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id q4sm14554079wmj.1.2020.04.03.02.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Apr 2020 02:24:48 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 4/7] Revert "serial: uartps: Do not allow use aliases >= MAX_UART_INSTANCES"
Date:   Fri,  3 Apr 2020 11:24:33 +0200
Message-Id: <dac3898e3e32d963f357fb436ac9a7ac3cbcf933.1585905873.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1585905873.git.michal.simek@xilinx.com>
References: <cover.1585905873.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 2088cfd882d0403609bdf426e9b24372fe1b8337.

As Johan says, this driver needs a lot more work and these changes are
only going in the wrong direction:
  https://lkml.kernel.org/r/20190523091839.GC568@localhost

Reported-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 412bfc51f546..9db3cd120057 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1712,8 +1712,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
 err_out_id:
 	mutex_lock(&bitmap_lock);
-	if (cdns_uart_data->id < MAX_UART_INSTANCES)
-		clear_bit(cdns_uart_data->id, bitmap);
+	clear_bit(cdns_uart_data->id, bitmap);
 	mutex_unlock(&bitmap_lock);
 	return rc;
 }
@@ -1738,8 +1737,7 @@ static int cdns_uart_remove(struct platform_device *pdev)
 	rc = uart_remove_one_port(cdns_uart_data->cdns_uart_driver, port);
 	port->mapbase = 0;
 	mutex_lock(&bitmap_lock);
-	if (cdns_uart_data->id < MAX_UART_INSTANCES)
-		clear_bit(cdns_uart_data->id, bitmap);
+	clear_bit(cdns_uart_data->id, bitmap);
 	mutex_unlock(&bitmap_lock);
 	clk_disable_unprepare(cdns_uart_data->uartclk);
 	clk_disable_unprepare(cdns_uart_data->pclk);
-- 
2.26.0

