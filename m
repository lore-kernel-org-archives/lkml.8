Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54B7C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E2B2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579199180;
	bh=Ex7beX8B0uBCb6owvoU+lXPoJuQfKrE4JeXVwBoIk1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PNUBdUEyy7mBUDpIP3B5+x7eL6DwKatcIVEKo5gLq7TWqVgBmKksx9a8aHISolrhn
	 andeDsR3IwdBN9cOZNUFFZWimlRNsQicXT3dPSlNZD1zuZgmJPPfFHsQopswWfIhW2
	 JOw1SqeWD7Jygr25LNapqk3pFypfFP0CrgP9TGWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391180AbgAPS0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:26:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:35814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404027AbgAPR0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:26:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 883A7246BC;
        Thu, 16 Jan 2020 17:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195604;
        bh=Ex7beX8B0uBCb6owvoU+lXPoJuQfKrE4JeXVwBoIk1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yTwjEZPrmd2oylq4F6TyxGwTwloMYKJXCF1lRS9Kz+ZraOgNXSC6igz5lWc7rx8/I
         LhlI9YbW7STXZaLJ/wFNHYHvN5fV/UdcFyJHmQCHqEgh0nGJrno7IoMhIyVU7Mf3pJ
         tGHvaGKS2rqTspARFVcSTJLW9YoBWaTTM0k2q6rs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Minas Harutyunyan <minas.harutyunyan@synopsys.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 179/371] dwc2: gadget: Fix completed transfer size calculation in DDMA
Date:   Thu, 16 Jan 2020 12:20:51 -0500
Message-Id: <20200116172403.18149-122-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minas Harutyunyan <minas.harutyunyan@synopsys.com>

[ Upstream commit 5acb4b970184d189d901192d075997c933b82260 ]

Fix calculation of transfer size on completion in function
dwc2_gadget_get_xfersize_ddma().

Added increment of descriptor pointer to move to next descriptor in
the loop.

Fixes: aa3e8bc81311 ("usb: dwc2: gadget: DDMA transfer start and complete")

Signed-off-by: Minas Harutyunyan <hminas@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc2/gadget.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index e164439b2154..4af9a1c652ed 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -2276,6 +2276,7 @@ static unsigned int dwc2_gadget_get_xfersize_ddma(struct dwc2_hsotg_ep *hs_ep)
 		if (status & DEV_DMA_STS_MASK)
 			dev_err(hsotg->dev, "descriptor %d closed with %x\n",
 				i, status & DEV_DMA_STS_MASK);
+		desc++;
 	}
 
 	return bytes_rem;
-- 
2.20.1

