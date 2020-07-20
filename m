Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43793C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1423E2064B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260087;
	bh=SsaHeLoR+9/H3CXpx889o+cGkyCf/Z5mb0WwxpVf56c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hfLVma9LqcVZAHwL1OLNlEdHRwajIf6ALetHO1lH1jDjNCGdqHvQuGs5uqKZ1SZU2
	 csR12A/BmEQTmDKmq9zTWrGdgP+9dRtcmeYD/HcrVxeq9CcudLa0NBqKxPPvjhsWOL
	 H3rp5mERjbPBasWkM2mUiL3NaUsxK0P8Q/pdAjI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbgGTPsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:48:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729951AbgGTPsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:48:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E111D2064B;
        Mon, 20 Jul 2020 15:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260083;
        bh=SsaHeLoR+9/H3CXpx889o+cGkyCf/Z5mb0WwxpVf56c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f8Q2GfYgkgziVLo8kF8VFW5OVacfneKQV61bFa2iLyqdUTJ6KeoUfQ6LSXKCDSfGt
         OvlnVfNVJVO7lMuVR4JSdHNFFDvKpVPHfLW1Oc5ixP/cKeIENvvGq4sbSgJDtMRmdx
         dzPhorM+yrmIgisBe0rDCJqU5xRCYAqNf1fEZR0I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.14 101/125] USB: serial: iuu_phoenix: fix memory corruption
Date:   Mon, 20 Jul 2020 17:37:20 +0200
Message-Id: <20200720152807.900400249@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152802.929969555@linuxfoundation.org>
References: <20200720152802.929969555@linuxfoundation.org>
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
@@ -704,14 +704,16 @@ static int iuu_uart_write(struct tty_str
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


