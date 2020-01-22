Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CF2C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B11205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699130;
	bh=l7BJIh0IT3H57HylY1Uzj1ztmKPjNKu1y6WNTJQsjvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ghpJtU1gEyo+yGcRiXPK2ucZZp2qRjGgAwWk041k6aI0vrk0rE/y9lKFpb4BT0zbp
	 Vmb1d3eQf2Bem/FcRhwPGL4/cTYp1WQkiusHT0Dczm4mon7i9nYVfcvmfbhSZz+1tI
	 jwgDjGbZzgk6+7goOktaH9G2J0je79Rfi7qzjMxA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgAVNSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:18:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:34472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbgAVNSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:18:43 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7743A205F4;
        Wed, 22 Jan 2020 13:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699123;
        bh=l7BJIh0IT3H57HylY1Uzj1ztmKPjNKu1y6WNTJQsjvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lt+9srySG5p6+XgW/9Jf3Z6fokPygBdjE2MB/6fFOYqI6glGKIGzgm2PXe+qZh7i2
         WMU8tJaZxq2fAYY5XaGqSGO2cZqahifjmMEIkPwwUANcAp21UhYrtcMq62SzohJy8t
         stuAxFaRpdGSx4i4/nxrfzh9j24tj+LksEFGEsxw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.4 048/222] USB: serial: ch341: handle unbound port at reset_resume
Date:   Wed, 22 Jan 2020 10:27:14 +0100
Message-Id: <20200122092837.028566412@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
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
@@ -589,9 +589,13 @@ static int ch341_tiocmget(struct tty_str
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
 


