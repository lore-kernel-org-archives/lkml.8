Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5EBC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08CF024683
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196070;
	bh=r567kJllO7l6ZFL/EKiqPTZlPdMaYe+6YV6/jG8CsyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f2eBGSkDlDI8SBJI9NMevuxbGBPrTWsMlmSMVbT93JQtO8AkV5eTdvfbR0ZXz2V5w
	 sbywE8/56RvackP/0T2q/NdWy6ym9NxnjrbRWIOX2IAafL9hdb4Yw/TKH/9tAXAwqs
	 V7G+Az1PUwMel1ivo7fOqBwNDOuFyKQ/d2xNBXjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404876AbgAPRe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:34:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:42474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392971AbgAPRaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:30:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 465342471F;
        Thu, 16 Jan 2020 17:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195808;
        bh=r567kJllO7l6ZFL/EKiqPTZlPdMaYe+6YV6/jG8CsyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uJ1NQ45UDW5irQ+lErE4/MYaShlyUGvwgUILbH5nnU5wOSch43wxT+6UBW5qnrUzz
         3ESRU3okGhJkZ46+R8+BsYHM73zLajqJgM7oNT4tRRLYlB8Jq/99aw1OJ0rYA4G2no
         5SQOqggWeT+6g3a14BqVgJ99Dksf1je2ffDZTAqU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 321/371] USB: usb-skeleton: fix use-after-free after driver unbind
Date:   Thu, 16 Jan 2020 12:23:13 -0500
Message-Id: <20200116172403.18149-264-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 6353001852776e7eeaab4da78922d4c6f2b076af ]

The driver failed to stop its read URB on disconnect, something which
could lead to a use-after-free in the completion handler after driver
unbind in case the character device has been closed.

Fixes: e7389cc9a7ff ("USB: skel_read really sucks royally")
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20191009170944.30057-3-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/usb-skeleton.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/usb-skeleton.c b/drivers/usb/usb-skeleton.c
index 7140d06ae04f..baf047c0be6c 100644
--- a/drivers/usb/usb-skeleton.c
+++ b/drivers/usb/usb-skeleton.c
@@ -575,6 +575,7 @@ static void skel_disconnect(struct usb_interface *interface)
 	dev->disconnected = 1;
 	mutex_unlock(&dev->io_mutex);
 
+	usb_kill_urb(dev->bulk_in_urb);
 	usb_kill_anchored_urbs(&dev->submitted);
 
 	/* decrement our usage count */
-- 
2.20.1

