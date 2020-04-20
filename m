Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6215EC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34271206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587387199;
	bh=bCDq43JudMUVyE16zfPz7jVRgValKuqje5YUNUC1vdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bZUXJjkO+Kra5l5SRB+XBHvofG43W9JGOqidUse8E6pWUeeKYkr7p1sEWs+Qs0uQG
	 sPDVz9TdX9VrE0uZu8BtIR8SJXqqYQzXBGrN+SbftYZ51OPZ5JvPI4CazkX1nIDVHr
	 fnOiwn4Dqg5wlxH1CB9hKsT8EVKJZvgm5LZSW74M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgDTMxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:53:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728207AbgDTMqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:46:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A639206DD;
        Mon, 20 Apr 2020 12:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386807;
        bh=bCDq43JudMUVyE16zfPz7jVRgValKuqje5YUNUC1vdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WJS66V0vzphSMuy+gEKC/I60WjwNaOOsusuLhaneAaOY9sdR5PZKms4J5lLZTMMo8
         bPBu14eLwIPasr6dgupUNal1KT+aKTi0NEMEPmAahmmOk5ZP5g0ARQGKq9A3+w1b9Z
         vbrsf+jUZ3KlJDV6alS0Q29TEDfmGhOBqQPlKJos=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thinh Nguyen <thinhn@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 5.4 33/60] usb: dwc3: gadget: Dont clear flags before transfer ended
Date:   Mon, 20 Apr 2020 14:39:11 +0200
Message-Id: <20200420121510.387048885@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121500.490651540@linuxfoundation.org>
References: <20200420121500.490651540@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

commit a114c4ca64bd522aec1790c7e5c60c882f699d8f upstream.

We track END_TRANSFER command completion. Don't clear transfer
started/ended flag prematurely. Otherwise, we'd run into the problem
with restarting transfer before END_TRANSFER command finishes.

Fixes: 6d8a019614f3 ("usb: dwc3: gadget: check for Missed Isoc from event status")
Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/gadget.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2567,10 +2567,8 @@ static void dwc3_gadget_endpoint_transfe
 
 	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
 
-	if (stop) {
+	if (stop)
 		dwc3_stop_active_transfer(dep, true, true);
-		dep->flags = DWC3_EP_ENABLED;
-	}
 
 	/*
 	 * WORKAROUND: This is the 2nd half of U1/U2 -> U0 workaround.


