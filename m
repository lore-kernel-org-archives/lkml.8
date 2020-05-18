Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD15C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BAE320826
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824527;
	bh=MZoJruzevu0Mqm1XG+YDSEIaVLGDBxikzdKGaPu4uuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JQnlloDrULzkrKA3IKhai2QSXs+R3wd/cVahjZR2GieqZmvYzt0Dd3FEIPdJr4sLU
	 YLL1NWG1IoHjhjZ4pejyYPqWQPi2bL8QH2JqC3wrKDKLTa3DIHaBiFVn1/bgStbITO
	 Xt1GcCenhcwp7N7T6oGD5ZNjVn53cs0cKiiwB/k8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbgERRz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:55:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731438AbgERRzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:55:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77191207C4;
        Mon, 18 May 2020 17:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824522;
        bh=MZoJruzevu0Mqm1XG+YDSEIaVLGDBxikzdKGaPu4uuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qkr0xF7uBcLN5F7jc2/YCfwHZ30muI7QUBgPNvxi/xH+nPu4BeROUdI+FIoyA44cK
         BkTHBKbOoUJ4AsiX64mjcwEqkU/RAXvrdNIb2GySV9aqADw9g95R7CXrsKw80rXaO3
         lHonIA3D+KWRy1MU33XbS1lzv4xS/fSelEbxrp2I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sung Lee <sung.lee@amd.com>,
        Yongqiang Sun <yongqiang.sun@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 046/147] drm/amd/display: Update downspread percent to match spreadsheet for DCN2.1
Date:   Mon, 18 May 2020 19:36:09 +0200
Message-Id: <20200518173519.759606237@linuxfoundation.org>
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

From: Sung Lee <sung.lee@amd.com>

[ Upstream commit 668a6741f809f2d15d125cfe2b39661e8f1655ea ]

[WHY]
The downspread percentage was copied over from a previous version
of the display_mode_lib spreadsheet. This value has been updated,
and the previous value is too high to allow for such modes as
4K120hz. The new value is sufficient for such modes.

[HOW]
Update the value in dcn21_resource to match the spreadsheet.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 161bf7caf3ae0..bb7add5ea2273 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -247,7 +247,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn2_1_soc = {
 	.dram_channel_width_bytes = 4,
 	.fabric_datapath_to_dcn_data_return_bytes = 32,
 	.dcn_downspread_percent = 0.5,
-	.downspread_percent = 0.5,
+	.downspread_percent = 0.38,
 	.dram_page_open_time_ns = 50.0,
 	.dram_rw_turnaround_time_ns = 17.5,
 	.dram_return_buffer_per_channel_bytes = 8192,
-- 
2.20.1



