Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BB6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4542077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864753;
	bh=2nD3AHmA8rJjgimj4IK7RHcoUgTeaT2e9TwzyW/IHxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mZ5y/LanC85oye1RLlclZfwJaFzsp3Kqtlme54IAY0zuJlg6vOveQKHEKOhRcvTvk
	 npTuZOH3WoFse4SULgCtDWdSBMc52wRKOX3Y6sclHoglTjG0Dw2lXfbrmfIuYwJPXm
	 pqF+wLr7DfDTn1OGhavdDiFBtx6YZwHl6PJTO6hY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390528AbgAXLTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:19:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:56494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390741AbgAXLTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:19:06 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4C222075D;
        Fri, 24 Jan 2020 11:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864745;
        bh=2nD3AHmA8rJjgimj4IK7RHcoUgTeaT2e9TwzyW/IHxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fiGd6bu5dQW8pGZfSuD2Ca6FDrsDwFW/agKilCC2/FY96sVgheTH42h+/1I5zQ2ab
         j0wQpQeSXGaW5u5Fm0cnf8qJJfESflPoYkE9sURwxP8dMaPJj0GrpMT5Wkht4vOK1M
         fbPkJB2H8VMidsAjwkUME9L7Cqbo/G4KkOqN7dCo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 341/639] dwc2: gadget: Fix completed transfer size calculation in DDMA
Date:   Fri, 24 Jan 2020 10:28:31 +0100
Message-Id: <20200124093129.863870628@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 3f68edde0f03a..f64d1cd08fb67 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -2230,6 +2230,7 @@ static unsigned int dwc2_gadget_get_xfersize_ddma(struct dwc2_hsotg_ep *hs_ep)
 		if (status & DEV_DMA_STS_MASK)
 			dev_err(hsotg->dev, "descriptor %d closed with %x\n",
 				i, status & DEV_DMA_STS_MASK);
+		desc++;
 	}
 
 	return bytes_rem;
-- 
2.20.1



