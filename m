Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229E6C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E388320882
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578737975;
	bh=RjKyGyHDjMtfKLgwT6hxJC6iWMeiB35CNzj+g9jOmzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TvTg+vqhzYT3hNnpdzJNgwHxaFmlJryOIRTwsThNVhKowK2aLRKIn14lP6PFy8MQa
	 S5OZNdPDpcsLbu5J3/EnxLRDYfdtBff9Orj+NO8S7f3cwvnFcO1Xv6EApw5LlPhHP5
	 V9zg3jVunxp9tfFnHJ7wyYXe47V4HY1GDIypo2y8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbgAKKTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:19:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:39174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728998AbgAKKTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:19:31 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE2B520848;
        Sat, 11 Jan 2020 10:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578737970;
        bh=RjKyGyHDjMtfKLgwT6hxJC6iWMeiB35CNzj+g9jOmzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hv+qoPhMTsY+2KyqFo/BeNBzlQ65GKzLSLkZUAplIrUJ+13ZpBYFPSC/6HpE3pxjf
         V6rVAfi1RXHpq5r5G3nMzGc1tYpuPQj1QLZCJwCMpGFABnw+T/qHatUU6o2MDRWhkE
         AGFCycip40ySkmy/EXoaqwBAzVLPJogrHd/eFTZc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thinh Nguyen <thinhn@synopsys.com>
Subject: [PATCH 4.19 81/84] usb: dwc3: gadget: Fix request complete check
Date:   Sat, 11 Jan 2020 10:50:58 +0100
Message-Id: <20200111094912.700962986@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094845.328046411@linuxfoundation.org>
References: <20200111094845.328046411@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

commit ea0d762775e20aaff7909a3f0866ff1688b1c618 upstream.

We can only check for IN direction if the request had completed. For OUT
direction, it's perfectly fine that the host can send less than the
setup length. Let's return true fall all cases of OUT direction.

Fixes: e0c42ce590fe ("usb: dwc3: gadget: simplify IOC handling")
Cc: stable@vger.kernel.org
Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
Link: https://lore.kernel.org/r/ac5a3593a94fdaa3d92e6352356b5f7a01ccdc7c.1576291140.git.thinhn@synopsys.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/gadget.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2271,6 +2271,13 @@ static int dwc3_gadget_ep_reclaim_trb_li
 
 static bool dwc3_gadget_ep_request_completed(struct dwc3_request *req)
 {
+	/*
+	 * For OUT direction, host may send less than the setup
+	 * length. Return true for all OUT requests.
+	 */
+	if (!req->direction)
+		return true;
+
 	return req->request.actual == req->request.length;
 }
 


