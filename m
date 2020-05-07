Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DCAC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 389DA215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588861697;
	bh=dp7iFnJlTuXJo6yAkAJuyAMkJxYlx6hfOyDpFHMYqbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LP56CRbZFYt4PIDU9HqqDZrOQEdRyO/DQCXzFhipe7gaW36HmpVb6lKYcD9h1Qg66
	 z05E+AD+9DnsumM/nh6dFya4DVEEuitUkpLcGU2r8NUY3Q7CG3g+rVOVcyxRmTH3R5
	 eD5wRMSU6MW9A2MnYlhVI01v9txsKqK1oy5xm7no=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgEGO2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:28:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbgEGO2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:28:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09E43208D6;
        Thu,  7 May 2020 14:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588861691;
        bh=dp7iFnJlTuXJo6yAkAJuyAMkJxYlx6hfOyDpFHMYqbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CQKuv4f/hJucKK16lVxMRhjz+Gtl9JWwD6HPK89uizrgHIoBYx9pmoT2b3xb32dlB
         pI0PCi/hpAbDgS5REhd9g9HA7vRlBASTyS70rlfdNGEJQfDLRAYx5SstaeuxJiUhqJ
         6hV0OiKIGud8fRdkUVT9iOd1nNLbervxZwTBUoT8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Eric Bernstein <Eric.Bernstein@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.6 35/50] drm/amd/display: check if REFCLK_CNTL register is present
Date:   Thu,  7 May 2020 10:27:11 -0400
Message-Id: <20200507142726.25751-35-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200507142726.25751-1-sashal@kernel.org>
References: <20200507142726.25751-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index a444fed941849..ad422e00f9fec 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2306,7 +2306,8 @@ void dcn20_fpga_init_hw(struct dc *dc)
 
 	REG_UPDATE(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_REFDIV, 2);
 	REG_UPDATE(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_ENABLE, 1);
-	REG_WRITE(REFCLK_CNTL, 0);
+	if (REG(REFCLK_CNTL))
+		REG_WRITE(REFCLK_CNTL, 0);
 	//
 
 
-- 
2.20.1

