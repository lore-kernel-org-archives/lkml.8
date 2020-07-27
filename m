Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEC0C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AD5521775
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859075;
	bh=/n45QYFcbxAEw47FM3WmH2IEHFCAqBv9oDcfilT76/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hGANpxgnc13Z4xFhdQt50VY/LpwNFGmG11bC73eEzQNPIW/gveR5EzR4qkFpytNB+
	 oUsms+4Cg4qs0U4KoMXR3ONeIDUTykr8H8W3M0u70OnLHPP8fXtARZotOTSXXxroDC
	 ELnLD9C3oR1tFMIGgA9roEmda6l1+gLUeIaM+kMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgG0OLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:11:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729299AbgG0OLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:11:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D88C2173E;
        Mon, 27 Jul 2020 14:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859071;
        bh=/n45QYFcbxAEw47FM3WmH2IEHFCAqBv9oDcfilT76/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lLPa6eMvEHOe6SDHO9VlLcYzPq6z2tVadmbOhnkieoEyV9yYbmnsXlUZ/uCLg1Pq5
         OJgzBPByXlc19bLjQMnilO9BPPYpjVJ/BeRMvql0pJu7Kf1yEMbfsxitSr7NKo5OQ4
         Zc4Oty02nPvCU1M7GpU3ebFVIq1BSQ64lFhpitn8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evgeny Novikov <novikov@ispras.ru>,
        Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 55/86] usb: gadget: udc: gr_udc: fix memleak on error handling path in gr_ep_init()
Date:   Mon, 27 Jul 2020 16:04:29 +0200
Message-Id: <20200727134917.173467637@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134914.312934924@linuxfoundation.org>
References: <20200727134914.312934924@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeny Novikov <novikov@ispras.ru>

[ Upstream commit c8f8529e2c4141afa2ebb487ad48e8a6ec3e8c99 ]

gr_ep_init() does not assign the allocated request anywhere if allocation
of memory for the buffer fails. This is a memory leak fixed by the given
patch.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/gr_udc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/gr_udc.c b/drivers/usb/gadget/udc/gr_udc.c
index e50108f9a374e..e0b2fb33ed0d8 100644
--- a/drivers/usb/gadget/udc/gr_udc.c
+++ b/drivers/usb/gadget/udc/gr_udc.c
@@ -1980,9 +1980,12 @@ static int gr_ep_init(struct gr_udc *dev, int num, int is_in, u32 maxplimit)
 
 	if (num == 0) {
 		_req = gr_alloc_request(&ep->ep, GFP_ATOMIC);
+		if (!_req)
+			return -ENOMEM;
+
 		buf = devm_kzalloc(dev->dev, PAGE_SIZE, GFP_DMA | GFP_ATOMIC);
-		if (!_req || !buf) {
-			/* possible _req freed by gr_probe via gr_remove */
+		if (!buf) {
+			gr_free_request(&ep->ep, _req);
 			return -ENOMEM;
 		}
 
-- 
2.25.1



