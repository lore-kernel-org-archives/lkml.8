Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6404EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 369D0221ED
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592444470;
	bh=jMKMGH9oLq4ZwU2DuxOlSu/A8eXbglr0iWQy84qeamc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JNGMTKEyzPTgTDmiiBja6Y25oBQF0elQUR9P/L4ty5hJ+2YlvLodNEGlIskRFMEDB
	 HIb0ojHqrnni2Mv6/TcDLu8z8d2YmzQvOhyErI7Kq7ONtbr4UR5vGWyXlryWxrxda/
	 tgAm15tc6xMpokPYh23IkclOJV+9MaIybZoSpRVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732380AbgFRB3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:29:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731044AbgFRB0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:26:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B3F82088E;
        Thu, 18 Jun 2020 01:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443593;
        bh=jMKMGH9oLq4ZwU2DuxOlSu/A8eXbglr0iWQy84qeamc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=00CQXpGpTq32Zvca/DOfaYqa8jQ5A3GT3GiqxuweuH2rDfEZtUHpXa3SoaC2T68qo
         pPCscwjpP/SoF81X0Dc/0nqFf98k4MavdHwUArdcWMhGyqMpEO5iY9nguiKRCyR8x1
         7I5VnLR3ne2PtXypo+0F3UpIO42GjLnKvlAbdFP8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alain Volmat <avolmat@me.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 026/108] clk: clk-flexgen: fix clock-critical handling
Date:   Wed, 17 Jun 2020 21:24:38 -0400
Message-Id: <20200618012600.608744-26-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012600.608744-1-sashal@kernel.org>
References: <20200618012600.608744-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alain Volmat <avolmat@me.com>

[ Upstream commit a403bbab1a73d798728d76931cab3ff0399b9560 ]

Fixes an issue leading to having all clocks following a critical
clocks marked as well as criticals.

Fixes: fa6415affe20 ("clk: st: clk-flexgen: Detect critical clocks")
Signed-off-by: Alain Volmat <avolmat@me.com>
Link: https://lkml.kernel.org/r/20200322140740.3970-1-avolmat@me.com
Reviewed-by: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/st/clk-flexgen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/st/clk-flexgen.c b/drivers/clk/st/clk-flexgen.c
index 918ba3164da9..cd856210db58 100644
--- a/drivers/clk/st/clk-flexgen.c
+++ b/drivers/clk/st/clk-flexgen.c
@@ -373,6 +373,7 @@ static void __init st_of_flexgen_setup(struct device_node *np)
 			break;
 		}
 
+		flex_flags &= ~CLK_IS_CRITICAL;
 		of_clk_detect_critical(np, i, &flex_flags);
 
 		/*
-- 
2.25.1

