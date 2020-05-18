Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4FCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C689220829
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824619;
	bh=ouyLlWBbNH0FtRmGq8YsQpE51svtNoNQQcK8Lbax6W8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1FHrjEY4t9pDIYftNhDPD7M/yTke+oESJ94QpjjLU+en8RlZ0sAWpf+eTsRraMeA8
	 zIBbgVPuRavX8/fSj6Zy5kKobh4SiDk96iNB0IP+7CdZ/zwKW0Tz1Ys1YdhgvfXExW
	 1qMUw1UX0/b7DViaCFjOR3ItIi1fRlPs9jUd12+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbgERR46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:56:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731715AbgERR4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:56:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89C4520674;
        Mon, 18 May 2020 17:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824615;
        bh=ouyLlWBbNH0FtRmGq8YsQpE51svtNoNQQcK8Lbax6W8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VpKgxSD6/IMtsUM3W5n2HCTAuznocXpbm3q8q3Jg0CovIXCj8kHB9NQKlABVmxgOI
         UuwytBEMjcmBFjMs2NF0PdElITfsaecg/ObQX+uoeILgILvvy9DxHby+K3Iqt7K3dW
         /qi7M5IGRKNsAuUC2z9Qr7vWgUegFmTqs9Mo09U4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Eric Bernstein <Eric.Bernstein@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 045/147] drm/amd/display: check if REFCLK_CNTL register is present
Date:   Mon, 18 May 2020 19:36:08 +0200
Message-Id: <20200518173519.654388255@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173513.009514388@linuxfoundation.org>
References: <20200518173513.009514388@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

[ Upstream commit 3159d41db3a04330c31ece32f8b29752fc114848 ]

Check before programming the register since it isn't present on
all IPs using this code.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Eric Bernstein <Eric.Bernstein@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index e933f6a369f92..083c42e521f5c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2015,7 +2015,8 @@ static void dcn20_fpga_init_hw(struct dc *dc)
 
 	REG_UPDATE(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_REFDIV, 2);
 	REG_UPDATE(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_ENABLE, 1);
-	REG_WRITE(REFCLK_CNTL, 0);
+	if (REG(REFCLK_CNTL))
+		REG_WRITE(REFCLK_CNTL, 0);
 	//
 
 
-- 
2.20.1



