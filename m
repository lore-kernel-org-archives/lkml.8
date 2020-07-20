Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F5CC433ED
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85CAC22CB2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595259591;
	bh=R0FwqxG8ES+ytRK/W3QTjkRyesWmEBLa/Mw0OsP60e0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HhhVlgkEai5JWdZPRjCzWQ8TdZDJuRAVkM8fD3g0spkj3A/GsvvTkOZsqlX/Ak8kA
	 BV8Tw9B8SnvoCbPiUYW9f8VD86u54t4X0JkJ4BINMwww5puo3wf9lpjlzvf0MnWSre
	 M/iAvhFm8U5yavc6sUoqwR2+Qi9YVnj+cwd0+Z2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbgGTPju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:39:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729593AbgGTPjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:39:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECA3022D04;
        Mon, 20 Jul 2020 15:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259586;
        bh=R0FwqxG8ES+ytRK/W3QTjkRyesWmEBLa/Mw0OsP60e0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UM2cZ707APNbN9T7ms5x+u8jSrZ0w1I2jnMa4nCqewe2tCkq0IGgWxksXyrq/XBSq
         FG1bmXu+sjJRyOMBEDX44neMY12p/tssRChpoCXXwme9eTjEpH5c11CqjbOgYgHIHi
         QNk++H+WTHYkmpXcBzVExjNb+/dBKQ6rzHyOc0VI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.4 44/58] USB: serial: iuu_phoenix: fix memory corruption
Date:   Mon, 20 Jul 2020 17:37:00 +0200
Message-Id: <20200720152749.444649755@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152747.127988571@linuxfoundation.org>
References: <20200720152747.127988571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit e7b931bee739e8a77ae216e613d3b99342b6dec0 upstream.

The driver would happily overwrite its write buffer with user data in
256 byte increments due to a removed buffer-space sanity check.

Fixes: 5fcf62b0f1f2 ("tty: iuu_phoenix: fix locking.")
Cc: stable <stable@vger.kernel.org>     # 2.6.31
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/iuu_phoenix.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/usb/serial/iuu_phoenix.c
+++ b/drivers/usb/serial/iuu_phoenix.c
@@ -717,14 +717,16 @@ static int iuu_uart_write(struct tty_str
 	struct iuu_private *priv = usb_get_serial_port_data(port);
 	unsigned long flags;
 
-	if (count > 256)
-		return -ENOMEM;
-
 	spin_lock_irqsave(&priv->lock, flags);
 
+	count = min(count, 256 - priv->writelen);
+	if (count == 0)
+		goto out;
+
 	/* fill the buffer */
 	memcpy(priv->writebuf + priv->writelen, buf, count);
 	priv->writelen += count;
+out:
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return count;


