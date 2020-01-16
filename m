Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21207C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49D62468D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196786;
	bh=MwSgVhG+pTafHyYyuQL3MwKEqFMypOUPahmZrsashQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b0n/QufoJ+gGnPOElNUfO34i5dnbDMdJ+rhz6H5kGVAnZjo0IHtZaSxWTUaQ6dBT2
	 WSlXT52nEu/3vIxHX1NWNB8roi2A6m86L1/jGiuuqLR1mrbv2YWeShQIRHGcZ2Ibg8
	 i9s2uPBa8KMZeI9baf4dVgT9SWXClOj3TatLz27o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406663AbgAPRqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:46:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:39020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406651AbgAPRqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:46:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90F0B246DE;
        Thu, 16 Jan 2020 17:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196781;
        bh=MwSgVhG+pTafHyYyuQL3MwKEqFMypOUPahmZrsashQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uyyuOhmADeFjifvnVXF3/EQS6Ao40c+nnccvT5cWrcGE6sbwTJD2BzAxoBgBaYA5x
         ylPGgRFtSBe/7tJmxE2Zf5yzHzoFwnmf+el0paqdYfvznrSR6kuU082hL0YPfCY41I
         73BGVAUrRddIuE/ojaIkeCHU5MjGGV64w0Kx3zvQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 147/174] USB: usb-skeleton: fix use-after-free after driver unbind
Date:   Thu, 16 Jan 2020 12:42:24 -0500
Message-Id: <20200116174251.24326-147-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116174251.24326-1-sashal@kernel.org>
References: <20200116174251.24326-1-sashal@kernel.org>
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
index 871c366d9229..efc716f26cf5 100644
--- a/drivers/usb/usb-skeleton.c
+++ b/drivers/usb/usb-skeleton.c
@@ -592,6 +592,7 @@ static void skel_disconnect(struct usb_interface *interface)
 	dev->disconnected = 1;
 	mutex_unlock(&dev->io_mutex);
 
+	usb_kill_urb(dev->bulk_in_urb);
 	usb_kill_anchored_urbs(&dev->submitted);
 
 	/* decrement our usage count */
-- 
2.20.1

