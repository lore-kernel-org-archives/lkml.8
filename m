Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76957C54FF1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436F321D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813838;
	bh=eNP2wRueIYsQ0UuZX2jQ1NACVIbo0uRrJkyDM2F6qGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=heS6izD+XT4rC9OrNP6sMxCUfT1Y0JAUhjqMQmfWdr+IfxEX1V2AQhlfcdyT6tdxl
	 +5ihiNey3vsEfhOeT3cnLIEqOrbywOR01luwKEFeBUDbMKDCzl5Ic1CKURLNbnEGI5
	 IHrRL4K8X6+NYClS3v9oaypFZGhBcPsp1q7M+Ra4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733298AbgB0OE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:04:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:41150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387626AbgB0OEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:04:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45DAC20578;
        Thu, 27 Feb 2020 14:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812283;
        bh=eNP2wRueIYsQ0UuZX2jQ1NACVIbo0uRrJkyDM2F6qGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YXsm6SybD1lZsswtbLk88m8p2ssq9/FQdxfKBJcXvVYZk3Jd+XRCH8fbfvxBXRbdc
         JSffJ/UTmxu4o6+nvwwu5OIODKTkA7llbbBBD+FsxvWnmfOOJvu7RXKoezbKS1Lz4c
         cW54XX2q5DQicvPXE7zIrE+v93AfYanH12SuqHak=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ryan Case <ryandcase@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 54/97] tty: serial: qcom_geni_serial: Fix UART hang
Date:   Thu, 27 Feb 2020 14:37:02 +0100
Message-Id: <20200227132223.401435581@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132214.553656188@linuxfoundation.org>
References: <20200227132214.553656188@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Case <ryandcase@chromium.org>

[ Upstream commit 663abb1a7a7ff8fea9ab0145463de7fcff823755 ]

If a serial console write occured while a UART transmit command was
waiting for a done signal then no further data would be sent until
something new kicked the system into gear. If there is already data
waiting in the circular buffer we must re-enable the tx watermark so we
receive the expected interrupts.

Signed-off-by: Ryan Case <ryandcase@chromium.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index b3f7d1a1e97f8..2003dfcace5d8 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -438,6 +438,7 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
 	bool locked = true;
 	unsigned long flags;
 	u32 geni_status;
+	u32 irq_en;
 
 	WARN_ON(co->index < 0 || co->index >= GENI_UART_CONS_PORTS);
 
@@ -472,6 +473,13 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
 		 * has been sent, in which case we need to look for done first.
 		 */
 		qcom_geni_serial_poll_tx_done(uport);
+
+		if (uart_circ_chars_pending(&uport->state->xmit)) {
+			irq_en = readl_relaxed(uport->membase +
+					SE_GENI_M_IRQ_EN);
+			writel_relaxed(irq_en | M_TX_FIFO_WATERMARK_EN,
+					uport->membase + SE_GENI_M_IRQ_EN);
+		}
 	}
 
 	__qcom_geni_serial_console_write(uport, s, count);
-- 
2.20.1



