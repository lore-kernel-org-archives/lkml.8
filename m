Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FF2C52D53
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA6D21D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812230;
	bh=lAhoGRiy3sDyaLEZ+O2Zwh8Ozc/K/fZFsR8LjI3Nva0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Iyafaa6PHsVNaZqIaPB5RQy15Sh/HA3HH4Vpivqf5paPElOCIdTtlp2gbJdoTuKyO
	 vQYMNzz+5CE7ty5udrnLcxT9h1y/kgvRtnt489iFftpsMFWsosnc8DARi7y1inhWWB
	 0UjxGsl2dwsZADimim5ZG8LodXUPa+MQ1zgsC/Mk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387478AbgB0ODt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:03:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:38914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732716AbgB0ODe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:03:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47DB421D7E;
        Thu, 27 Feb 2020 14:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812213;
        bh=lAhoGRiy3sDyaLEZ+O2Zwh8Ozc/K/fZFsR8LjI3Nva0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LZPB5+UYQnbwfMKdTETBcMsz9nVY1+jnfFV6lzAifnlXeiCX5G0nwt3C/0YG1OeMT
         WnzOcWtVuiE5qNBO8s/Gw/YXHJbHC0xlcmDa+5oeKqzTkWI8QLEmGcFFWkt16h7yZ4
         So3yNrDElTGBzTvzmBMHJDSUOeSkDXeWSzjnsNx4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Minas Harutyunyan <hminas@synopsys.com>,
        Jack Mitchell <ml@embed.me.uk>, Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 4.19 29/97] usb: dwc2: Fix SET/CLEAR_FEATURE and GET_STATUS flows
Date:   Thu, 27 Feb 2020 14:36:37 +0100
Message-Id: <20200227132219.337793533@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132214.553656188@linuxfoundation.org>
References: <20200227132214.553656188@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>

commit 9a0d6f7c0a83844baae1d6d85482863d2bf3b7a7 upstream.

SET/CLEAR_FEATURE for Remote Wakeup allowance not handled correctly.
GET_STATUS handling provided not correct data on DATA Stage.
Issue seen when gadget's dr_mode set to "otg" mode and connected
to MacOS.
Both are fixed and tested using USBCV Ch.9 tests.

Signed-off-by: Minas Harutyunyan <hminas@synopsys.com>
Fixes: fa389a6d7726 ("usb: dwc2: gadget: Add remote_wakeup_allowed flag")
Tested-by: Jack Mitchell <ml@embed.me.uk>
Cc: stable@vger.kernel.org
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc2/gadget.c |   28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -1542,6 +1542,7 @@ static int dwc2_hsotg_process_req_status
 	struct dwc2_hsotg_ep *ep0 = hsotg->eps_out[0];
 	struct dwc2_hsotg_ep *ep;
 	__le16 reply;
+	u16 status;
 	int ret;
 
 	dev_dbg(hsotg->dev, "%s: USB_REQ_GET_STATUS\n", __func__);
@@ -1553,11 +1554,10 @@ static int dwc2_hsotg_process_req_status
 
 	switch (ctrl->bRequestType & USB_RECIP_MASK) {
 	case USB_RECIP_DEVICE:
-		/*
-		 * bit 0 => self powered
-		 * bit 1 => remote wakeup
-		 */
-		reply = cpu_to_le16(0);
+		status = 1 << USB_DEVICE_SELF_POWERED;
+		status |= hsotg->remote_wakeup_allowed <<
+			  USB_DEVICE_REMOTE_WAKEUP;
+		reply = cpu_to_le16(status);
 		break;
 
 	case USB_RECIP_INTERFACE:
@@ -1668,7 +1668,10 @@ static int dwc2_hsotg_process_req_featur
 	case USB_RECIP_DEVICE:
 		switch (wValue) {
 		case USB_DEVICE_REMOTE_WAKEUP:
-			hsotg->remote_wakeup_allowed = 1;
+			if (set)
+				hsotg->remote_wakeup_allowed = 1;
+			else
+				hsotg->remote_wakeup_allowed = 0;
 			break;
 
 		case USB_DEVICE_TEST_MODE:
@@ -1678,16 +1681,17 @@ static int dwc2_hsotg_process_req_featur
 				return -EINVAL;
 
 			hsotg->test_mode = wIndex >> 8;
-			ret = dwc2_hsotg_send_reply(hsotg, ep0, NULL, 0);
-			if (ret) {
-				dev_err(hsotg->dev,
-					"%s: failed to send reply\n", __func__);
-				return ret;
-			}
 			break;
 		default:
 			return -ENOENT;
 		}
+
+		ret = dwc2_hsotg_send_reply(hsotg, ep0, NULL, 0);
+		if (ret) {
+			dev_err(hsotg->dev,
+				"%s: failed to send reply\n", __func__);
+			return ret;
+		}
 		break;
 
 	case USB_RECIP_ENDPOINT:


