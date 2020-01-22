Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A066C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446CF24685
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579685750;
	bh=54W6OgmCDqeTuJsLiKooVfT40af7XsuLNWDViJLgAhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DwWvAozO//hwtst7EGHPz0dTKMgdzcmEfTdXIUhw+v8ib/fYBJYCCKiN5wAaWVAP8
	 7tEItQ9uVpiof33npen54wPz4iy0A6y1YewGvZerzWEw2p5hqZwsZ52ECmXPZ7w63H
	 hR0X419XCcwsYeGXxZWzjWGlpV5nmYDNLcrbSI00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgAVJft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:35:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:50942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731455AbgAVJfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:35:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E179124672;
        Wed, 22 Jan 2020 09:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685743;
        bh=54W6OgmCDqeTuJsLiKooVfT40af7XsuLNWDViJLgAhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MPPKv8ycwGGg8g33GKvc4Xpj+Ktgdx/mgD/P0jLx7932JNXrlCXPlXtKl9wPHCZiU
         l9jrlSFBHik2w/YV8BpleFNLTjOOxrq4g7aJK+dBFOvrSLFuhA/aIqFHjJk7ZgmE+A
         iS+Oru96fJlQ/txfti1uiAM5erG0XD/mahV2130I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.9 62/97] USB: serial: quatech2: handle unbound ports
Date:   Wed, 22 Jan 2020 10:29:06 +0100
Message-Id: <20200122092806.372918821@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092755.678349497@linuxfoundation.org>
References: <20200122092755.678349497@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 9715a43eea77e42678a1002623f2d9a78f5b81a1 upstream.

Check for NULL port data in the modem- and line-status handlers to avoid
dereferencing a NULL pointer in the unlikely case where a port device
isn't bound to a driver (e.g. after an allocation failure on port
probe).

Note that the other (stubbed) event handlers qt2_process_xmit_empty()
and qt2_process_flush() would need similar sanity checks in case they
are ever implemented.

Fixes: f7a33e608d9a ("USB: serial: add quatech2 usb to serial driver")
Cc: stable <stable@vger.kernel.org>     # 3.5
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/quatech2.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/usb/serial/quatech2.c
+++ b/drivers/usb/serial/quatech2.c
@@ -872,7 +872,10 @@ static void qt2_update_msr(struct usb_se
 	u8 newMSR = (u8) *ch;
 	unsigned long flags;
 
+	/* May be called from qt2_process_read_urb() for an unbound port. */
 	port_priv = usb_get_serial_port_data(port);
+	if (!port_priv)
+		return;
 
 	spin_lock_irqsave(&port_priv->lock, flags);
 	port_priv->shadowMSR = newMSR;
@@ -900,7 +903,10 @@ static void qt2_update_lsr(struct usb_se
 	unsigned long flags;
 	u8 newLSR = (u8) *ch;
 
+	/* May be called from qt2_process_read_urb() for an unbound port. */
 	port_priv = usb_get_serial_port_data(port);
+	if (!port_priv)
+		return;
 
 	if (newLSR & UART_LSR_BI)
 		newLSR &= (u8) (UART_LSR_OE | UART_LSR_BI);


