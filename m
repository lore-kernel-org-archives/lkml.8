Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89A2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A759720776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590521079;
	bh=L9dEFwmMPW+AV5IScBr/9bkG1sG4655gjTPtCJQfpNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mjmiTVZfgBmIshHM6F+DoQskmMZ2/dDiPD8XdL5wYOCoGznjf/7QZjnjkUIWXkO7l
	 la9sX60A3ZJRIy8MRTQJPZ5Y3+HCQL9UvuUB59WDPSht6xboxa1WFlbw9VN7vG8hKy
	 hd9H9+GzTyEIZSuPf2YEsUIqORbS2SR5H/PJsab4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392473AbgEZTYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:24:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391289AbgEZTHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:07:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E36820873;
        Tue, 26 May 2020 19:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520053;
        bh=L9dEFwmMPW+AV5IScBr/9bkG1sG4655gjTPtCJQfpNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GewzSnvm4cWRP71bYyVWcDUhco1aFKoVtA4sHwX1yGL9Mkc+nzUyl4p51IbNL11MM
         upCKfEL7N3+zWg3TDHtWOjlsRAzd7gyCkOxy4IyKOsfadA9m2C45d3txAPlcECkbS5
         YgC76gqtxs/J50bOq6FVVeKvRmoyk3aKkzo4kwc4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Sasha Levin <sashal@kernel.org>,
        syzbot+db339689b2101f6f6071@syzkaller.appspotmail.com
Subject: [PATCH 5.4 041/111] USB: core: Fix misleading driver bug report
Date:   Tue, 26 May 2020 20:52:59 +0200
Message-Id: <20200526183936.834497087@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183932.245016380@linuxfoundation.org>
References: <20200526183932.245016380@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

[ Upstream commit ac854131d9844f79e2fdcef67a7707227538d78a ]

The syzbot fuzzer found a race between URB submission to endpoint 0
and device reset.  Namely, during the reset we call usb_ep0_reinit()
because the characteristics of ep0 may have changed (if the reset
follows a firmware update, for example).  While usb_ep0_reinit() is
running there is a brief period during which the pointers stored in
udev->ep_in[0] and udev->ep_out[0] are set to NULL, and if an URB is
submitted to ep0 during that period, usb_urb_ep_type_check() will
report it as a driver bug.  In the absence of those pointers, the
routine thinks that the endpoint doesn't exist.  The log message looks
like this:

------------[ cut here ]------------
usb 2-1: BOGUS urb xfer, pipe 2 != type 2
WARNING: CPU: 0 PID: 9241 at drivers/usb/core/urb.c:478
usb_submit_urb+0x1188/0x1460 drivers/usb/core/urb.c:478

Now, although submitting an URB while the device is being reset is a
questionable thing to do, it shouldn't count as a driver bug as severe
as submitting an URB for an endpoint that doesn't exist.  Indeed,
endpoint 0 always exists, even while the device is in its unconfigured
state.

To prevent these misleading driver bug reports, this patch updates
usb_disable_endpoint() to avoid clearing the ep_in[] and ep_out[]
pointers when the endpoint being disabled is ep0.  There's no danger
of leaving a stale pointer in place, because the usb_host_endpoint
structure being pointed to is stored permanently in udev->ep0; it
doesn't get deallocated until the entire usb_device structure does.

Reported-and-tested-by: syzbot+db339689b2101f6f6071@syzkaller.appspotmail.com
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Link: https://lore.kernel.org/r/Pine.LNX.4.44L0.2005011558590.903-100000@netrider.rowland.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/core/message.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 02eaac7e1e34..a1ac2f0723b0 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1143,11 +1143,11 @@ void usb_disable_endpoint(struct usb_device *dev, unsigned int epaddr,
 
 	if (usb_endpoint_out(epaddr)) {
 		ep = dev->ep_out[epnum];
-		if (reset_hardware)
+		if (reset_hardware && epnum != 0)
 			dev->ep_out[epnum] = NULL;
 	} else {
 		ep = dev->ep_in[epnum];
-		if (reset_hardware)
+		if (reset_hardware && epnum != 0)
 			dev->ep_in[epnum] = NULL;
 	}
 	if (ep) {
-- 
2.25.1



