Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8FCC8300A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33B7C206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099873;
	bh=cx53Q1txw0OXP9jC5QKoWUgPkLNbKKpXi65526FejRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zg/ySYTQX8t6RNw/DPiZ+ZWknRJemzqxILsW2JpWKBwIXs1BGKFVcVYmIjJjzToyA
	 hm3FLBMCft1rIp683q/ZKppnF8sGFIltOPVUr5i7bGrZhrKeWH08aX/GF231GIOF+J
	 fxb9hMBuqT5uMKPB0Y8pGcj28ESX2i1GWeMrXBVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbgD1Shh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:37:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730483AbgD1She (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:37:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4B3720B1F;
        Tue, 28 Apr 2020 18:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099053;
        bh=cx53Q1txw0OXP9jC5QKoWUgPkLNbKKpXi65526FejRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LbolyCEYc2QKGN40zfz4qG/mER2K8vFIX9QhcIhrRum3CCvGCf+uqcJC5yLh3prAg
         sAjlb92NheinsR19Kbga4vBx3Y3r49MeSBUDSwvw8Rj2V4kpIi/Vp9sP1VSnRLPOVi
         uRS3BmK9vQPosK2Y9UTFbUBRkQ2w3qtUN6LzEQFQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thinh Nguyen <thinhn@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 5.6 149/167] usb: dwc3: gadget: Fix request completion check
Date:   Tue, 28 Apr 2020 20:25:25 +0200
Message-Id: <20200428182244.412333708@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182225.451225420@linuxfoundation.org>
References: <20200428182225.451225420@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

commit 49e0590e3a60e75b493e5df879e216e5073c7663 upstream.

A request may not be completed because not all the TRBs are prepared for
it. This happens when we run out of available TRBs. When some TRBs are
completed, the driver needs to prepare the rest of the TRBs for the
request. The check dwc3_gadget_ep_request_completed() shouldn't be
checking the amount of data received but rather the number of pending
TRBs. Revise this request completion check.

Cc: stable@vger.kernel.org
Fixes: e0c42ce590fe ("usb: dwc3: gadget: simplify IOC handling")
Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/gadget.c |   12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2484,14 +2484,7 @@ static int dwc3_gadget_ep_reclaim_trb_li
 
 static bool dwc3_gadget_ep_request_completed(struct dwc3_request *req)
 {
-	/*
-	 * For OUT direction, host may send less than the setup
-	 * length. Return true for all OUT requests.
-	 */
-	if (!req->direction)
-		return true;
-
-	return req->request.actual == req->request.length;
+	return req->num_pending_sgs == 0;
 }
 
 static int dwc3_gadget_ep_cleanup_completed_request(struct dwc3_ep *dep,
@@ -2515,8 +2508,7 @@ static int dwc3_gadget_ep_cleanup_comple
 
 	req->request.actual = req->request.length - req->remaining;
 
-	if (!dwc3_gadget_ep_request_completed(req) ||
-			req->num_pending_sgs) {
+	if (!dwc3_gadget_ep_request_completed(req)) {
 		__dwc3_gadget_kick_transfer(dep);
 		goto out;
 	}


