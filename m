Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338F4C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E36820B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099048;
	bh=gdIJgW2cE+uHwuHq/5VHo8bLoulqcGUa+lwpn8Ssa74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wcfzcj5fnSNShJ/aLVTELrNfc528S/vpJW0DRmwx4m5ydh+Eewk+31mm2ypybnb7E
	 FyJOBwmEMiuGYdzKQO3CCmc2Q/MjTEZ5qfY0SZIiy9EuN5mDJEcFgaQ2XPXFvWBysg
	 ntVT5MEBkae3wmEz89dmRkeGYCvD4Jr1nw2ILroQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbgD1Sh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:37:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730465AbgD1ShT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:37:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAE1B20575;
        Tue, 28 Apr 2020 18:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099038;
        bh=gdIJgW2cE+uHwuHq/5VHo8bLoulqcGUa+lwpn8Ssa74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ear2nL2FoOPTiqgC3G1/EcsBVmbFaiNeTfWN75RuCbLns6Rog2/Vlo2ZZ51qfKMUk
         NhlPYT0WTvYD5IOefDtUO4TzMxh6eCWK94LeCiT2qeB/KKMBRF3jxI0V6qOkaBCseE
         qxMR9Q7/4GSMnLfqAA9dcccsbLaD4hFG4TYgB1eU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Paul Zimmerman <pauldzim@gmail.com>,
        Peter Chen <peter.chen@nxp.com>
Subject: [PATCH 4.19 089/131] USB: hub: Fix handling of connect changes during sleep
Date:   Tue, 28 Apr 2020 20:25:01 +0200
Message-Id: <20200428182236.149372067@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182224.822179290@linuxfoundation.org>
References: <20200428182224.822179290@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

commit 9f952e26295d977dbfc6fedeaf8c4f112c818d37 upstream.

Commit 8099f58f1ecd ("USB: hub: Don't record a connect-change event
during reset-resume") wasn't very well conceived.  The problem it
tried to fix was that if a connect-change event occurred while the
system was asleep (such as a device disconnecting itself from the bus
when it is suspended and then reconnecting when it resumes)
requiring a reset-resume during the system wakeup transition, the hub
port's change_bit entry would remain set afterward.  This would cause
the hub driver to believe another connect-change event had occurred
after the reset-resume, which was wrong and would lead the driver to
send unnecessary requests to the device (which could interfere with a
firmware update).

The commit tried to fix this by not setting the change_bit during the
wakeup.  But this was the wrong thing to do; it means that when a
device is unplugged while the system is asleep, the hub driver doesn't
realize anything has happened: The change_bit flag which would tell it
to handle the disconnect event is clear.

The commit needs to be reverted and the problem fixed in a different
way.  Fortunately an alternative solution was noted in the commit's
Changelog: We can continue to set the change_bit entry in
hub_activate() but then clear it when a reset-resume occurs.  That way
the the hub driver will see the change_bit when a device is
disconnected but won't see it when the device is still present.

That's what this patch does.

Reported-and-tested-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Fixes: 8099f58f1ecd ("USB: hub: Don't record a connect-change event during reset-resume")
Tested-by: Paul Zimmerman <pauldzim@gmail.com>
CC: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/Pine.LNX.4.44L0.2004221602480.11262-100000@iolanthe.rowland.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/hub.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1196,6 +1196,11 @@ static void hub_activate(struct usb_hub
 #ifdef CONFIG_PM
 			udev->reset_resume = 1;
 #endif
+			/* Don't set the change_bits when the device
+			 * was powered off.
+			 */
+			if (test_bit(port1, hub->power_bits))
+				set_bit(port1, hub->change_bits);
 
 		} else {
 			/* The power session is gone; tell hub_wq */
@@ -3051,6 +3056,15 @@ static int check_port_resume_type(struct
 		if (portchange & USB_PORT_STAT_C_ENABLE)
 			usb_clear_port_feature(hub->hdev, port1,
 					USB_PORT_FEAT_C_ENABLE);
+
+		/*
+		 * Whatever made this reset-resume necessary may have
+		 * turned on the port1 bit in hub->change_bits.  But after
+		 * a successful reset-resume we want the bit to be clear;
+		 * if it was on it would indicate that something happened
+		 * following the reset-resume.
+		 */
+		clear_bit(port1, hub->change_bits);
 	}
 
 	return status;


