Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88690C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B74B2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592942877;
	bh=4j1JP4plDK8RFUqLRz601YOa8jIR0m3WIxNF4zfQGLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tiBoVlqWfV0EiHmXyqGBOzK550e+72+ueOAKamLf+w42fcBLFfnkgdjOURTQHdYf5
	 0t85GWC1JKlk/j2oSVshsI1677at576iJUHRlsX3F8I3wS/UzSdWDU+GpmBTOXu012
	 voErUY/AOVkzWMWmTxBV2ibafznvZo6sLyejRnfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388680AbgFWUHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:07:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388098AbgFWUHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:07:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 765F32064B;
        Tue, 23 Jun 2020 20:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942869;
        bh=4j1JP4plDK8RFUqLRz601YOa8jIR0m3WIxNF4zfQGLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aSpZY0Xiab8SeTlqQMFVHjuSHCr8XzOgSjxJYpWkLr8aPZCaIiRj7ApOK1azZVk0I
         YShvd7jXTJ24isiVx0shdfzTQPociy6JlQvKjTv+ujUFI2HCD7JprToitktOYf8B+9
         hp7tUbJ0a7o5OVwFzrhRn5RzWf0GF7+Xd7ThG0xo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thinh Nguyen <thinhn@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 166/477] usb: dwc3: gadget: Properly handle failed kick_transfer
Date:   Tue, 23 Jun 2020 21:52:43 +0200
Message-Id: <20200623195415.432186897@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

[ Upstream commit 8d99087c2db863c5fa3a4a1f3cb82b3a493705ca ]

If dwc3 fails to issue START_TRANSFER/UPDATE_TRANSFER command, then we
should properly end an active transfer and give back all the started
requests. However if it's for an isoc endpoint, the failure maybe due to
bus-expiry status. In this case, don't give back the requests and wait
for the next retry.

Fixes: 72246da40f37 ("usb: Introduce DesignWare USB3 DRD Driver")
Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index ab6562c5b9279..de3b92680935a 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1220,6 +1220,8 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep)
 	}
 }
 
+static void dwc3_gadget_ep_cleanup_cancelled_requests(struct dwc3_ep *dep);
+
 static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 {
 	struct dwc3_gadget_ep_cmd_params params;
@@ -1259,14 +1261,20 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 
 	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
 	if (ret < 0) {
-		/*
-		 * FIXME we need to iterate over the list of requests
-		 * here and stop, unmap, free and del each of the linked
-		 * requests instead of what we do now.
-		 */
-		if (req->trb)
-			memset(req->trb, 0, sizeof(struct dwc3_trb));
-		dwc3_gadget_del_and_unmap_request(dep, req, ret);
+		struct dwc3_request *tmp;
+
+		if (ret == -EAGAIN)
+			return ret;
+
+		dwc3_stop_active_transfer(dep, true, true);
+
+		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
+			dwc3_gadget_move_cancelled_request(req);
+
+		/* If ep isn't started, then there's no end transfer pending */
+		if (!(dep->flags & DWC3_EP_END_TRANSFER_PENDING))
+			dwc3_gadget_ep_cleanup_cancelled_requests(dep);
+
 		return ret;
 	}
 
-- 
2.25.1



