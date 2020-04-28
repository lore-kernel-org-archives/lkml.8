Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64395C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41EB5206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588100201;
	bh=uXlG7zY2R4nQkPMFSwhbfOPelFo9eV73KDF2pnAMz+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ydzy/jr2W+0WJLM0R4l7dc6Wt29mPzuQiwgcy630hiO0+VYoHnGwh1TGYdNDV7NbR
	 fs33LS91UQqIZ+5J76Z2wKbk5bZ5f/2ZMW+OQyNsx1z2RdBjagrgU5lzS3zIbcPp2g
	 1qtzVt25+nkf+g0ccOsQZWKQ7L33qR1yV4F4fGWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbgD1S4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:56:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:46502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729623AbgD1SbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:31:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ACA720B80;
        Tue, 28 Apr 2020 18:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098670;
        bh=uXlG7zY2R4nQkPMFSwhbfOPelFo9eV73KDF2pnAMz+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BRtPWbqsTTaxYAlSgB10cxR/HMRA327LPqvkTlxjWSPf42QOeH5X7MxiQrtkiudn2
         P6WWtNtsw1iz3AkqUugkEAO/J1wxFROqapSskfTs3JgTJmglGz7Z52Yraabg8FUX/5
         0LPAP2py4EfJMeJIHxWi96/mpc4zi7dd1zW6uBZQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amit Singh Tomar <amittomer25@gmail.com>
Subject: [PATCH 5.6 096/167] tty: serial: owl: add "much needed" clk_prepare_enable()
Date:   Tue, 28 Apr 2020 20:24:32 +0200
Message-Id: <20200428182237.275211321@linuxfoundation.org>
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

From: Amit Singh Tomar <amittomer25@gmail.com>

commit abf42d2f333b21bf8d33b2fbb8a85fa62037ac01 upstream.

commit 8ba92cf59335 ("arm64: dts: actions: s700: Add Clock Management Unit")
breaks the UART on Cubieboard7-lite (based on S700 SoC), This is due to the
fact that generic clk routine clk_disable_unused() disables the gate clks,
and that in turns disables OWL UART (but UART driver never enables it). To
prove this theory, Andre suggested to use "clk_ignore_unused" in kernel
commnd line and it worked (Kernel happily lands into RAMFS world :)).

This commit fix this up by adding clk_prepare_enable().

Fixes: 8ba92cf59335 ("arm64: dts: actions: s700: Add Clock Management Unit")
Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/1587067917-1400-1-git-send-email-amittomer25@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/owl-uart.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -680,6 +680,12 @@ static int owl_uart_probe(struct platfor
 		return PTR_ERR(owl_port->clk);
 	}
 
+	ret = clk_prepare_enable(owl_port->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "could not enable clk\n");
+		return ret;
+	}
+
 	owl_port->port.dev = &pdev->dev;
 	owl_port->port.line = pdev->id;
 	owl_port->port.type = PORT_OWL;
@@ -712,6 +718,7 @@ static int owl_uart_remove(struct platfo
 
 	uart_remove_one_port(&owl_uart_driver, &owl_port->port);
 	owl_uart_ports[pdev->id] = NULL;
+	clk_disable_unprepare(owl_port->clk);
 
 	return 0;
 }


