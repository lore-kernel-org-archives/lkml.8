Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8853CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69662204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597689890;
	bh=4sgduH5P5O73KnNHItFH0MRZIlGcnmkccmJ2zfLYU+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=al5NATbwNYEYNwSHMs2L//0QmujB00AoqivIo8BWXfgNKR7KTJMYO1Z5WoUU7LDxS
	 XDAkGslLH28V8fs954MaodxdySqymDUOqliSQIwf1y7JvpZ5U6DjpW9rTmvRL+UycU
	 UBRZ1FQJG/HQET7YviIyAF1isAqQM+SGnmHoq1ik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403788AbgHQSot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:44:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730486AbgHQP4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:56:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B089020760;
        Mon, 17 Aug 2020 15:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679774;
        bh=4sgduH5P5O73KnNHItFH0MRZIlGcnmkccmJ2zfLYU+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aYwUOC0HVJORTFzdDceQLsj12FAIgDoWUOTXIr70ctQPyil5zf5AWng+Kv4K6Ucxp
         G4z6tSfjbOHmJFtoqNA6fwc5TlEHLiT/4z8D8yB7KEYkNoHvzlgIKQWryrSm29rk2D
         GK5uIxK82ummuy4QN7VoYvnffVeciHOYyXqQyU0Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brant Merryman <brant.merryman@silabs.com>,
        Phu Luu <phu.luu@silabs.com>, Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.7 330/393] USB: serial: cp210x: re-enable auto-RTS on open
Date:   Mon, 17 Aug 2020 17:16:20 +0200
Message-Id: <20200817143835.602916226@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brant Merryman <brant.merryman@silabs.com>

commit c7614ff9b73a1e6fb2b1b51396da132ed22fecdb upstream.

CP210x hardware disables auto-RTS but leaves auto-CTS when in hardware
flow control mode and UART on cp210x hardware is disabled. When
re-opening the port, if auto-CTS is enabled on the cp210x, then auto-RTS
must be re-enabled in the driver.

Signed-off-by: Brant Merryman <brant.merryman@silabs.com>
Co-developed-by: Phu Luu <phu.luu@silabs.com>
Signed-off-by: Phu Luu <phu.luu@silabs.com>
Link: https://lore.kernel.org/r/ECCF8E73-91F3-4080-BE17-1714BC8818FB@silabs.com
[ johan: fix up tags and problem description ]
Fixes: 39a66b8d22a3 ("[PATCH] USB: CP2101 Add support for flow control")
Cc: stable <stable@vger.kernel.org>     # 2.6.12
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/cp210x.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -915,6 +915,7 @@ static void cp210x_get_termios_port(stru
 	u32 baud;
 	u16 bits;
 	u32 ctl_hs;
+	u32 flow_repl;
 
 	cp210x_read_u32_reg(port, CP210X_GET_BAUDRATE, &baud);
 
@@ -1015,6 +1016,22 @@ static void cp210x_get_termios_port(stru
 	ctl_hs = le32_to_cpu(flow_ctl.ulControlHandshake);
 	if (ctl_hs & CP210X_SERIAL_CTS_HANDSHAKE) {
 		dev_dbg(dev, "%s - flow control = CRTSCTS\n", __func__);
+		/*
+		 * When the port is closed, the CP210x hardware disables
+		 * auto-RTS and RTS is deasserted but it leaves auto-CTS when
+		 * in hardware flow control mode. When re-opening the port, if
+		 * auto-CTS is enabled on the cp210x, then auto-RTS must be
+		 * re-enabled in the driver.
+		 */
+		flow_repl = le32_to_cpu(flow_ctl.ulFlowReplace);
+		flow_repl &= ~CP210X_SERIAL_RTS_MASK;
+		flow_repl |= CP210X_SERIAL_RTS_SHIFT(CP210X_SERIAL_RTS_FLOW_CTL);
+		flow_ctl.ulFlowReplace = cpu_to_le32(flow_repl);
+		cp210x_write_reg_block(port,
+				CP210X_SET_FLOW,
+				&flow_ctl,
+				sizeof(flow_ctl));
+
 		cflag |= CRTSCTS;
 	} else {
 		dev_dbg(dev, "%s - flow control = NONE\n", __func__);


