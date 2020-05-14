Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BD0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60EB220675
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589483370;
	bh=nx23dqVpWnjfhGPHJ3dCs8uLrVRnY0WPQ+tFW7+VuqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k2+zaX3OiiGJBkoGly6ZttrLLPoh5uLlQSVVju6GA/ltlJWs6MWipcJN9fO1Wb3eM
	 QEYVqBRJIUzseSVF78eouD/A5zL4n96973E0ZmS+Fbd6byPWwUr0t0VulnNU1USqHp
	 cGK8TYrC5QQ3I3VTIiI+20BdbCP7ic1YnS1unr9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgENSwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 14:52:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728398AbgENSwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:52:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29C4E20727;
        Thu, 14 May 2020 18:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482357;
        bh=nx23dqVpWnjfhGPHJ3dCs8uLrVRnY0WPQ+tFW7+VuqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MNrhG7YtabLcEzkB+ziSxGBuaiNDXEPeHN9wvOZzcj3T21wpVQhqp0c3oCaadPmgk
         RaxT71cykMQu0sXYDisTyOeMFB1+J5uXSeM3QI0gZ5IM76L+DtJ8SdKLKV9YCo2Mfh
         iLJxz1Kb4vQcVLonMMqxWAn6j5bujIOhm/7N8tp0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        syzbot+db339689b2101f6f6071@syzkaller.appspotmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 38/62] USB: core: Fix misleading driver bug report
Date:   Thu, 14 May 2020 14:51:23 -0400
Message-Id: <20200514185147.19716-38-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514185147.19716-1-sashal@kernel.org>
References: <20200514185147.19716-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 02eaac7e1e34e..a1ac2f0723b0b 100644
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
2.20.1

