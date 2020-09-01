Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83E4C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A33682064B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598975365;
	bh=Y5zoPBOA/xMCtTOnx3pSck5cOG0QFwVJ7NuEgCZTuPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dCEtrB1nrzBe77B7poHyCRciGiEDn2ufQFt4BE7vY6f139dF21IyDPDZx1wWnB9uh
	 RMB8MALexQE/J1+F3IdsoieHrIo/LCPBxE2xuj/0GCnmeXZMCO80rr7bQbR4Nl0k6X
	 hvv1y6V4qOxIHYBordV0kS2yfYlpWk9GvwMH5pMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732111AbgIAPtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:49:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731911AbgIAPp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:45:58 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B86A2078B;
        Tue,  1 Sep 2020 15:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598975157;
        bh=Y5zoPBOA/xMCtTOnx3pSck5cOG0QFwVJ7NuEgCZTuPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BrlkUVC6HglgmO1iwM0EX+9MM8hjJdIrmEpCMUkAXALyzzkorvi1RUzChaRAkuMvL
         r18fm/vLxaA4czYaRRJpudfvSWGS1QYcxtdfJvaoTTVLw4WOtT1WmgJSFfRrAPWIE9
         dUcOZjgu27xadF5cTdH+mk8+g9iNkpen/SCiOAfY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thinh Nguyen <thinhn@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 5.8 232/255] usb: dwc3: gadget: Fix handling ZLP
Date:   Tue,  1 Sep 2020 17:11:28 +0200
Message-Id: <20200901151011.866295207@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

commit d2ee3ff79e6a3d4105e684021017d100524dc560 upstream.

The usb_request->zero doesn't apply for isoc. Also, if we prepare a
0-length (ZLP) TRB for the OUT direction, we need to prepare an extra
TRB to pad up to the MPS alignment. Use the same bounce buffer for the
ZLP TRB and the extra pad TRB.

Cc: <stable@vger.kernel.org> # v4.5+
Fixes: d6e5a549cc4d ("usb: dwc3: simplify ZLP handling")
Fixes: 04c03d10e507 ("usb: dwc3: gadget: handle request->zero")
Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/gadget.c |   25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1199,6 +1199,7 @@ static void dwc3_prepare_one_trb_linear(
 				req->request.no_interrupt,
 				req->request.is_last);
 	} else if (req->request.zero && req->request.length &&
+		   !usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
 		   (IS_ALIGNED(req->request.length, maxp))) {
 		struct dwc3	*dwc = dep->dwc;
 		struct dwc3_trb	*trb;
@@ -1208,14 +1209,25 @@ static void dwc3_prepare_one_trb_linear(
 		/* prepare normal TRB */
 		dwc3_prepare_one_trb(dep, req, length, true, 0);
 
-		/* Now prepare one extra TRB to handle ZLP */
+		/* Prepare one extra TRB to handle ZLP */
 		trb = &dep->trb_pool[dep->trb_enqueue];
 		req->num_trbs++;
 		__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr, 0,
-				false, 1, req->request.stream_id,
+				!req->direction, 1, req->request.stream_id,
 				req->request.short_not_ok,
 				req->request.no_interrupt,
 				req->request.is_last);
+
+		/* Prepare one more TRB to handle MPS alignment for OUT */
+		if (!req->direction) {
+			trb = &dep->trb_pool[dep->trb_enqueue];
+			req->num_trbs++;
+			__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr, maxp,
+					       false, 1, req->request.stream_id,
+					       req->request.short_not_ok,
+					       req->request.no_interrupt,
+					       req->request.is_last);
+		}
 	} else {
 		dwc3_prepare_one_trb(dep, req, length, false, 0);
 	}
@@ -2668,8 +2680,17 @@ static int dwc3_gadget_ep_cleanup_comple
 				status);
 
 	if (req->needs_extra_trb) {
+		unsigned int maxp = usb_endpoint_maxp(dep->endpoint.desc);
+
 		ret = dwc3_gadget_ep_reclaim_trb_linear(dep, req, event,
 				status);
+
+		/* Reclaim MPS padding TRB for ZLP */
+		if (!req->direction && req->request.zero && req->request.length &&
+		    !usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
+		    (IS_ALIGNED(req->request.length, maxp)))
+			ret = dwc3_gadget_ep_reclaim_trb_linear(dep, req, event, status);
+
 		req->needs_extra_trb = false;
 	}
 


