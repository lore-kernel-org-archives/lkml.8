Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE820C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C327320736
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587386937;
	bh=Td6phF6OipQfRwHy9dH1WczrdeUDuqNXLRmhK2Nm+34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NTaLUYoZM3F+ewfbUO1RxE2e0+ioPjNYklrEhZwAbl3WCwgcBokqidP+CVzM8VOvZ
	 Laz1cQbhCd5miW3s8UTeqs1c6LyKwFWLa5weTDaVCUpG0Qg049l/0hZOibnU2/zxNn
	 zsg5YOAc5LO0DuCMqzxXePtrXBxLgt1kTrMFk5CY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgDTMs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:48:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729327AbgDTMsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:48:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1DE320735;
        Mon, 20 Apr 2020 12:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386933;
        bh=Td6phF6OipQfRwHy9dH1WczrdeUDuqNXLRmhK2Nm+34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=St83J7M57uUAz4vkN92neg2uX2A3o5BZF/q7HE3VjmBwAA2USNoldlgh9DfUUjX6g
         hsgQss+jLk0GWdLeneNrZnmEer3Y7xD47NCXK91KuW3K1g36HBkth2jBB941w11syR
         tJ6u5wLu76zU6Ck/f94BKqh5gqSuLn0+qEd2tWvc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thinh Nguyen <thinhn@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 26/40] usb: dwc3: gadget: Dont clear flags before transfer ended
Date:   Mon, 20 Apr 2020 14:39:36 +0200
Message-Id: <20200420121502.311210933@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121444.178150063@linuxfoundation.org>
References: <20200420121444.178150063@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

[ Upstream commit a114c4ca64bd522aec1790c7e5c60c882f699d8f ]

We track END_TRANSFER command completion. Don't clear transfer
started/ended flag prematurely. Otherwise, we'd run into the problem
with restarting transfer before END_TRANSFER command finishes.

Fixes: 6d8a019614f3 ("usb: dwc3: gadget: check for Missed Isoc from event status")
Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 019aee3a79568..8a4455d0af8b9 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2366,10 +2366,8 @@ static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
 
 	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
 
-	if (stop) {
+	if (stop)
 		dwc3_stop_active_transfer(dep, true, true);
-		dep->flags = DWC3_EP_ENABLED;
-	}
 
 	/*
 	 * WORKAROUND: This is the 2nd half of U1/U2 -> U0 workaround.
-- 
2.20.1



