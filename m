Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0CFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7751121556
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864246;
	bh=IEF1OaN19hiJyhy0Lp/4TiusDtysAMWihnmd/fmyvlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0SU6WxQDWWlLx0IYALXQuMdg7pvnpN3N4LMxmwWn8RZGlV3ju1rhfiV3FGeggH1Ta
	 mO5sTliQEIGyukK5DC9vqyCTlA9jvUbBR+DHR34zmQETWaHsWxCv86aV7LA6PTb0IH
	 Va3PJxviWJB/t4qCuTgKaFncBJybSQrKdIGW9iW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733138AbgAXLKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:10:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:46508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388348AbgAXLKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:10:41 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D585920708;
        Fri, 24 Jan 2020 11:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864240;
        bh=IEF1OaN19hiJyhy0Lp/4TiusDtysAMWihnmd/fmyvlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JzUEgM4idIHHa+I7WOKqiOYNdtdEbEUAXJEXy7DRbllGH7q6fV8bg0s0paC13RXkA
         oC9Z6NgzY+jq7DEcBeZsMySrSwDbPOWofafB7+7Pnv761MBRFQnyqqdjNwQlThXCFE
         0QNodyzG/5l+K7LesnZyFQsAkd698lSe2129M8Yk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Selles <paul.selles@microchip.com>,
        Wesley Sheng <wesley.sheng@microchip.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jon Mason <jdmason@kudzu.us>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 188/639] ntb_hw_switchtec: debug print 64bit aligned crosslink BAR Numbers
Date:   Fri, 24 Jan 2020 10:25:58 +0100
Message-Id: <20200124093110.666436454@linuxfoundation.org>
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

From: Paul Selles <paul.selles@microchip.com>

[ Upstream commit cce8e04cf79e47809455215744685e8eb56f94bb ]

Switchtec NTB crosslink BARs are 64bit addressed but they are printed as
32bit addressed BARs. Fix debug log to increment the BAR numbers by 2 to
reflect the 64bit address alignment.

Fixes: 017525018202 ("ntb_hw_switchtec: Add initialization code for crosslink")
Signed-off-by: Paul Selles <paul.selles@microchip.com>
Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 5ee5f40b4dfc3..9916bc5b6759a 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -1120,7 +1120,7 @@ static int crosslink_enum_partition(struct switchtec_ntb *sndev,
 
 		dev_dbg(&sndev->stdev->dev,
 			"Crosslink BAR%d addr: %llx\n",
-			i, bar_addr);
+			i*2, bar_addr);
 
 		if (bar_addr != bar_space * i)
 			continue;
-- 
2.20.1



