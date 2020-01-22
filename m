Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793DBC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4124724680
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686032;
	bh=YntkyKDy5KI2DCgvhufavTpqfWURh67IqaGLyQej8mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yzz0dmG+vq80dSzzmeKLTZ4GPt7l2c68XqHU+OA5mcCO99gqeTU9YrkOGqlPvpshB
	 Y3JazyZTUk7TQ1Obx67pgsrYZCTHuGndgpzlPmhEbt0ZUj6gw2OtMciU+imMbl6uAc
	 U0EfpLiV//oKH6MMCi7gaWp3DEsLXfuGiIraQyt0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387461AbgAVJkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:40:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:59204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732848AbgAVJkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:40:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10BDB24699;
        Wed, 22 Jan 2020 09:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579686021;
        bh=YntkyKDy5KI2DCgvhufavTpqfWURh67IqaGLyQej8mw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M7Yk7OYp7d6xE7Z5dLevssNvn0AFNrG+Z3by/6yegTP+7Eh7xufyBkunbi53NFNYn
         dowhEp3OTibWluu3FHPVOQMu54B45Ql2DPrrf7sSayLAbET6gFGAdoMxf4uEwTkV00
         MHjh/1nKiPgO1UxV0LcfOro+P+8QcYspOoQv6kLw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.19 012/103] USB: serial: suppress driver bind attributes
Date:   Wed, 22 Jan 2020 10:28:28 +0100
Message-Id: <20200122092805.511916199@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092803.587683021@linuxfoundation.org>
References: <20200122092803.587683021@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit fdb838efa31e1ed9a13ae6ad0b64e30fdbd00570 upstream.

USB-serial drivers must not be unbound from their ports before the
corresponding USB driver is unbound from the parent interface so
suppress the bind and unbind attributes.

Unbinding a serial driver while it's port is open is a sure way to
trigger a crash as any driver state is released on unbind while port
hangup is handled on the parent USB interface level. Drivers for
multiport devices where ports share a resource such as an interrupt
endpoint also generally cannot handle individual ports going away.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable <stable@vger.kernel.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/usb-serial.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -1294,6 +1294,9 @@ static int usb_serial_register(struct us
 		return -EINVAL;
 	}
 
+	/* Prevent individual ports from being unbound. */
+	driver->driver.suppress_bind_attrs = true;
+
 	usb_serial_operations_init(driver);
 
 	/* Add this device to our list of devices */


