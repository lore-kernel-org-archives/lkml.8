Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7E4C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2EF1246D9
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583203933;
	bh=lmH1utyMKQlbkWRrt5YcFzcKcYbLr9xfF/JCSANbeOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hnmyuvL51aD4CwkzFqPjZIlZ0VmsfkQxTw/oEytYJ2+L/wTNQYh0GPsa277Ih43w6
	 nCDtCf9PicEx2YceMKxZiExCrRyfrdpatnJv7qG1rBsYVCbii0w5/XUvGX4Nq24nw1
	 5ktjzDkrqDawS7CJ5JeNhjaZNswXHtRVyfTHE6n8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgCCCwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:52:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:46702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729066AbgCCCuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:50:06 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8ED7246E6;
        Tue,  3 Mar 2020 02:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583203805;
        bh=lmH1utyMKQlbkWRrt5YcFzcKcYbLr9xfF/JCSANbeOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C8eZAkT52FSSzAHCMeUY6+YQ1wDsjG+ik/GroZjNIjyuao9zqJRIJY3KNVGzWaswF
         t9sTZiEqCV1cxEcOnUFK7tQqsnW2Q/D+ozjhS+wT+VZiZtwoB/pynpJT+RHcBn6La1
         Kji+dNG+Ij/zFrF1tu3qPGuEVItN4TvAxOB8HEPA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jack Pham <jackp@codeaurora.org>, Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 02/13] usb: gadget: composite: Support more than 500mA MaxPower
Date:   Mon,  2 Mar 2020 21:49:51 -0500
Message-Id: <20200303025002.10600-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303025002.10600-1-sashal@kernel.org>
References: <20200303025002.10600-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jack Pham <jackp@codeaurora.org>

[ Upstream commit a2035411fa1d1206cea7d5dfe833e78481844a76 ]

USB 3.x SuperSpeed peripherals can draw up to 900mA of VBUS power
when in configured state. However, if a configuration wanting to
take advantage of this is added with MaxPower greater than 500
(currently possible if using a ConfigFS gadget) the composite
driver fails to accommodate this for a couple reasons:

 - usb_gadget_vbus_draw() when called from set_config() and
   composite_resume() will be passed the MaxPower value without
   regard for the current connection speed, resulting in a
   violation for USB 2.0 since the max is 500mA.

 - the bMaxPower of the configuration descriptor would be
   incorrectly encoded, again if the connection speed is only
   at USB 2.0 or below, likely wrapping around U8_MAX since
   the 2mA multiplier corresponds to a maximum of 510mA.

Fix these by adding checks against the current gadget->speed
when the c->MaxPower value is used (set_config() and
composite_resume()) and appropriately limit based on whether
it is currently at a low-/full-/high- or super-speed connection.

Because 900 is not divisible by 8, with the round-up division
currently used in encode_bMaxPower() a MaxPower of 900mA will
result in an encoded value of 0x71. When a host stack (including
Linux and Windows) enumerates this on a single port root hub, it
reads this value back and decodes (multiplies by 8) to get 904mA
which is strictly greater than 900mA that is typically budgeted
for that port, causing it to reject the configuration. Instead,
we should be using the round-down behavior of normal integral
division so that 900 / 8 -> 0x70 or 896mA to stay within range.
And we might as well change it for the high/full/low case as well
for consistency.

N.B. USB 3.2 Gen N x 2 allows for up to 1500mA but there doesn't
seem to be any any peripheral controller supported by Linux that
does two lane operation, so for now keeping the clamp at 900
should be fine.

Signed-off-by: Jack Pham <jackp@codeaurora.org>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/composite.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 4d7df2f6caf5b..3a0452ff1a565 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -438,9 +438,13 @@ static u8 encode_bMaxPower(enum usb_device_speed speed,
 	if (!val)
 		return 0;
 	if (speed < USB_SPEED_SUPER)
-		return DIV_ROUND_UP(val, 2);
+		return min(val, 500U) / 2;
 	else
-		return DIV_ROUND_UP(val, 8);
+		/*
+		 * USB 3.x supports up to 900mA, but since 900 isn't divisible
+		 * by 8 the integral division will effectively cap to 896mA.
+		 */
+		return min(val, 900U) / 8;
 }
 
 static int config_buf(struct usb_configuration *config,
@@ -833,6 +837,10 @@ static int set_config(struct usb_composite_dev *cdev,
 
 	/* when we return, be sure our power usage is valid */
 	power = c->MaxPower ? c->MaxPower : CONFIG_USB_GADGET_VBUS_DRAW;
+	if (gadget->speed < USB_SPEED_SUPER)
+		power = min(power, 500U);
+	else
+		power = min(power, 900U);
 done:
 	usb_gadget_vbus_draw(gadget, power);
 	if (result >= 0 && cdev->delayed_status)
@@ -2272,7 +2280,7 @@ void composite_resume(struct usb_gadget *gadget)
 {
 	struct usb_composite_dev	*cdev = get_gadget_data(gadget);
 	struct usb_function		*f;
-	u16				maxpower;
+	unsigned			maxpower;
 
 	/* REVISIT:  should we have config level
 	 * suspend/resume callbacks?
@@ -2286,10 +2294,14 @@ void composite_resume(struct usb_gadget *gadget)
 				f->resume(f);
 		}
 
-		maxpower = cdev->config->MaxPower;
+		maxpower = cdev->config->MaxPower ?
+			cdev->config->MaxPower : CONFIG_USB_GADGET_VBUS_DRAW;
+		if (gadget->speed < USB_SPEED_SUPER)
+			maxpower = min(maxpower, 500U);
+		else
+			maxpower = min(maxpower, 900U);
 
-		usb_gadget_vbus_draw(gadget, maxpower ?
-			maxpower : CONFIG_USB_GADGET_VBUS_DRAW);
+		usb_gadget_vbus_draw(gadget, maxpower);
 	}
 
 	cdev->suspended = 0;
-- 
2.20.1

