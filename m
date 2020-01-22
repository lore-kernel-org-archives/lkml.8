Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C824C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55DF205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699404;
	bh=OD7n9DR/CXM0JoRPTTOVsnhzA1oG56OYYXNu0yJCmnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O9Ho4XQPxoBDWBCU0d/H2LyWLVtZQk9+u/qMXGC8on2rAKUo9E9WsR1y2qthaSo9T
	 CujjZ6TWiEhztin3ErJlAWnKkxjIp731h4y4ewNC4ildbooJOhF+5B7reA+avXHmQp
	 miUO3SpoT8C4xd9HC/rp1yp7HrWS/HWbG9Y0xDxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbgAVNXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:23:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:41464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729100AbgAVNXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:23:19 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FFEE205F4;
        Wed, 22 Jan 2020 13:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699398;
        bh=OD7n9DR/CXM0JoRPTTOVsnhzA1oG56OYYXNu0yJCmnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uOXH29gbWDZFtCHHXAkNhCWgG7JspqeMM5cMrEugaimCvA4oZ/JIV2jQDxExpPnaV
         caNPTCaNr79z15GxrGHsiS90U3CXuziww7LXD0KQCMTGkXxLpe6cRkLiuFMjdXRJU2
         7cEAUqX3AK+xgaq29eNj0sX2XFtx1NW+VQOJSvwY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.4 132/222] NFC: pn533: fix bulk-message timeout
Date:   Wed, 22 Jan 2020 10:28:38 +0100
Message-Id: <20200122092843.197411658@linuxfoundation.org>
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

commit a112adafcb47760feff959ee1ecd10b74d2c5467 upstream.

The driver was doing a synchronous uninterruptible bulk-transfer without
using a timeout. This could lead to the driver hanging on probe due to a
malfunctioning (or malicious) device until the device is physically
disconnected. While sleeping in probe the driver prevents other devices
connected to the same hub from being added to (or removed from) the bus.

An arbitrary limit of five seconds should be more than enough.

Fixes: dbafc28955fa ("NFC: pn533: don't send USB data off of the stack")
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nfc/pn533/usb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/nfc/pn533/usb.c
+++ b/drivers/nfc/pn533/usb.c
@@ -391,7 +391,7 @@ static int pn533_acr122_poweron_rdr(stru
 		       cmd, sizeof(cmd), false);
 
 	rc = usb_bulk_msg(phy->udev, phy->out_urb->pipe, buffer, sizeof(cmd),
-			  &transferred, 0);
+			  &transferred, 5000);
 	kfree(buffer);
 	if (rc || (transferred != sizeof(cmd))) {
 		nfc_err(&phy->udev->dev,


