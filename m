Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9522C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D1B2467B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686705;
	bh=VduW93Y0Qt9OjW9JLQTSDDgaDytptO9GJJ+sjcxCw08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gmF/d7+6ZtrZwIvOS6mLLYJIBD1QcQYQLZxWMO4eP5/mfa6jl/IvoOVeDUn/vtMIZ
	 3pKF5gOdw6ib7Dfocr/5ve4X/XvRyV9WukO1dMYQO2XfowhZWq31NUkxzN/VEEoXJK
	 leYMcaKpS4LinmjBGjAYWNexH2g/Stj+MtxTjWrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732814AbgAVJvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:51:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:52970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732387AbgAVJhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:37:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A46052467E;
        Wed, 22 Jan 2020 09:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685826;
        bh=VduW93Y0Qt9OjW9JLQTSDDgaDytptO9GJJ+sjcxCw08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2JTWW9wEv2YediYJURlmiN+Of+57kcB0nIi/uvy8zZvfIJA55I7GABMh9vM5EiO+p
         uWuCGnCBRM+UERqt+4pNzelUixONhP9iBHrTMhm3uTNxkk7+Y6BwFWLsrBjLaiQxIX
         COVugq82lNx/dXD7GlV3eL+BxV3P1YVBc6IiJHVc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.9 59/97] USB: serial: suppress driver bind attributes
Date:   Wed, 22 Jan 2020 10:29:03 +0100
Message-Id: <20200122092805.915683644@linuxfoundation.org>
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
@@ -1351,6 +1351,9 @@ static int usb_serial_register(struct us
 		return -EINVAL;
 	}
 
+	/* Prevent individual ports from being unbound. */
+	driver->driver.suppress_bind_attrs = true;
+
 	usb_serial_operations_init(driver);
 
 	/* Add this device to our list of devices */


