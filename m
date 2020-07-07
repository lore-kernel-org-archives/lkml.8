Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D3EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7FD42067D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594151544;
	bh=BCg2O5jFZBlDRc+MF49DFW22EwGVWh89T01WR1/QAyk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=wuoR29L2t1OnpHCN6D6aPPTGl59r9nO8z2zy9EUfX1peRj2enEzn2cSA/OLgJN1wX
	 QgzcKbgubpDXLosb7q56NHpFW15VaXq1amrALLFvgzCXHhKCU77MoqU/+GWxGv6eaX
	 PxKKvDa2nDLLBecKSiGIJ7gNvFjDzRzWMOICjW6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgGGTwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:52:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbgGGTwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:52:22 -0400
Received: from embeddedor (unknown [200.39.26.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A36C92067D;
        Tue,  7 Jul 2020 19:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594151541;
        bh=BCg2O5jFZBlDRc+MF49DFW22EwGVWh89T01WR1/QAyk=;
        h=Date:From:To:Cc:Subject:From;
        b=P0+GOtA5+XNYmpksFCVRBIEVNBW3/ffnM5bFqEXHW3Db77YWs0JiCtPjul3JHKXa/
         9pNhzwj5h9xARmb4DA5JAN96erzS3jTHF5vKWuofCOxAcU48XacsCAMBEWD+a1v25G
         +ytUhAhKlzTaodKBZM5p4euorN0Ow1ZgQHcp6v6I=
Date:   Tue, 7 Jul 2020 14:57:47 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH] USB: serial: Use fallthrough pseudo-keyword
Message-ID: <20200707195747.GA4354@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the existing /* fall through */ comments and its variants with
the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
fall-through markings when it is the case.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/usb/serial/cypress_m8.c  |    4 ++--
 drivers/usb/serial/io_edgeport.c |    4 ++--
 drivers/usb/serial/kobil_sct.c   |    2 +-
 drivers/usb/serial/upd78f0730.c  |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m8.c
index 216edd5826ca..53e3051b0a71 100644
--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -1046,7 +1046,7 @@ static void cypress_read_int_callback(struct urb *urb)
 		return;
 	case -EPIPE:
 		/* Can't call usb_clear_halt while in_interrupt */
-		/* FALLS THROUGH */
+		fallthrough;
 	default:
 		/* something ugly is going on... */
 		dev_err(dev, "%s - unexpected nonzero read status received: %d\n",
@@ -1195,7 +1195,7 @@ static void cypress_write_int_callback(struct urb *urb)
 		return;
 	case -EPIPE:
 		/* Cannot call usb_clear_halt while in_interrupt */
-		/* FALLTHROUGH */
+		fallthrough;
 	default:
 		dev_err(dev, "%s - unexpected nonzero write status received: %d\n",
 			__func__, status);
diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index 4cca0b836f43..ba5d8df69518 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -1752,7 +1752,7 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
 				edge_serial->rxState = EXPECT_HDR2;
 				break;
 			}
-			/* Fall through */
+			fallthrough;
 		case EXPECT_HDR2:
 			edge_serial->rxHeader2 = *buffer;
 			++buffer;
@@ -1804,7 +1804,7 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
 				edge_serial->rxState = EXPECT_DATA;
 				break;
 			}
-			/* Fall through */
+			fallthrough;
 		case EXPECT_DATA: /* Expect data */
 			if (bufferLength < edge_serial->rxBytesRemaining) {
 				rxLen = bufferLength;
diff --git a/drivers/usb/serial/kobil_sct.c b/drivers/usb/serial/kobil_sct.c
index e9882ba20933..9660c16be56a 100644
--- a/drivers/usb/serial/kobil_sct.c
+++ b/drivers/usb/serial/kobil_sct.c
@@ -499,7 +499,7 @@ static void kobil_set_termios(struct tty_struct *tty,
 		break;
 	default:
 		speed = 9600;
-		/* fall through */
+		fallthrough;
 	case 9600:
 		urb_val = SUSBCR_SBR_9600;
 		break;
diff --git a/drivers/usb/serial/upd78f0730.c b/drivers/usb/serial/upd78f0730.c
index 1ba1401d27d7..0a2268c479af 100644
--- a/drivers/usb/serial/upd78f0730.c
+++ b/drivers/usb/serial/upd78f0730.c
@@ -332,7 +332,7 @@ static void upd78f0730_set_termios(struct tty_struct *tty,
 		tty->termios.c_cflag &= ~CSIZE;
 		tty->termios.c_cflag |= CS8;
 		dev_warn(dev, "data size is not supported, using 8 bits\n");
-		/* fall through */
+		fallthrough;
 	case CS8:
 		request.params |= UPD78F0730_DATA_SIZE_8_BITS;
 		dev_dbg(dev, "%s - 8 data bits\n", __func__);

