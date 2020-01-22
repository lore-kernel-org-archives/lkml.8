Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC86C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40EA22467E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579685869;
	bh=+2FjCr9YaSsUpap2iFDUqs8WIMpwcmCcbVjOTTroLZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SJJgJDgzb5V8m7fQ23VXHmzvcrX2EoafVJtVc8LKSw83mnfueJ+AQbRhUwUuwAHox
	 9ehbx6vMfeLDzyz28DDPMrzNXdqQqeZKyeCAk2yitTGmC0mz+zymx8ioZGaMwVXoQD
	 /x/AOsAkv//r5ubGq8wSNh2i1YurqBDStJ8pk0ZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732698AbgAVJhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:37:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:53940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732662AbgAVJhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:37:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C28F82467E;
        Wed, 22 Jan 2020 09:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685865;
        bh=+2FjCr9YaSsUpap2iFDUqs8WIMpwcmCcbVjOTTroLZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MCLtMw1xZmwpsyNem6cg2LMKTbUwWW+38LYQwJGUhHgdfq9WCx8JcfkBQyKhUIOIb
         Ppme+5i6JlPrCUMc4NZf9yiNS/G77Y1c4UOK8tSdYmkIqJ7j4E53vndvoqclDCfCHB
         SI0r27fE+ETdMFawPNh8t7EY5NgXREqFX8UCi+ec=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.14 14/65] USB: serial: ch341: handle unbound port at reset_resume
Date:   Wed, 22 Jan 2020 10:28:59 +0100
Message-Id: <20200122092753.130397269@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092750.976732974@linuxfoundation.org>
References: <20200122092750.976732974@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 4d5ef53f75c22d28f490bcc5c771fcc610a9afa4 upstream.

Check for NULL port data in reset_resume() to avoid dereferencing a NULL
pointer in case the port device isn't bound to a driver (e.g. after a
failed control request at port probe).

Fixes: 1ded7ea47b88 ("USB: ch341 serial: fix port number changed after resume")
Cc: stable <stable@vger.kernel.org>     # 2.6.30
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/ch341.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/usb/serial/ch341.c
+++ b/drivers/usb/serial/ch341.c
@@ -592,9 +592,13 @@ static int ch341_tiocmget(struct tty_str
 static int ch341_reset_resume(struct usb_serial *serial)
 {
 	struct usb_serial_port *port = serial->port[0];
-	struct ch341_private *priv = usb_get_serial_port_data(port);
+	struct ch341_private *priv;
 	int ret;
 
+	priv = usb_get_serial_port_data(port);
+	if (!priv)
+		return 0;
+
 	/* reconfigure ch341 serial port after bus-reset */
 	ch341_configure(serial->dev, priv);
 


