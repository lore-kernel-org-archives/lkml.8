Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A59BC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08015206B9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587048266;
	bh=bA8K2AOso87BeqHclySCW19T72yEic4780pqkF97yGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J7Bnr7q+qOYUZ5aKDNxCEpm/IShxNvc6RJjKpiJUTCDmA1U0ngn8UoUWLNI2EJsz9
	 x03yXSnYnDZWXLKx7Ef/XSxZpYPGuQaJvs9ni1sb8nZQpZeWoYjNXjs+ZKqJI0T1y3
	 4bo2aVLNyQ13TMtDeR+2pISti+zyv9xh+dV3yXRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387860AbgDPOoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:44:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405710AbgDPOAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:00:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4CA220786;
        Thu, 16 Apr 2020 14:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045608;
        bh=bA8K2AOso87BeqHclySCW19T72yEic4780pqkF97yGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CW+uO9cpkFpYwZ1GHvcjHGwYsTfX7u4aPyW6t1tRkFsoQWKZd0jm55bgU9choGI33
         X2ziJWAAK19KYIu1RYapiMMdj7YAX4Q8PLVaF6oPihe/w77vn/08eYSkOccoGebVDs
         nZvQ6BvShcztEpQ2kaIoKMx3pN3pk4X5FnV9BW0Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuxian Dai <Yuxian.Dai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Huang Rui <ray.huang@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>
Subject: [PATCH 5.6 204/254] drm/amdgpu/powerplay: using the FCLK DPM table to set the MCLK
Date:   Thu, 16 Apr 2020 15:24:53 +0200
Message-Id: <20200416131351.585936261@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuxian Dai <Yuxian.Dai@amd.com>

commit 022ac4c9c55be35a2d1f71019a931324c51b0dab upstream.

1.Using the FCLK DPM table to set the MCLK for DPM states consist of
three entities:
 FCLK
 UCLK
 MEMCLK
All these three clk change together, MEMCLK from FCLK, so use the fclk
frequency.
2.we should show the current working clock freqency from clock table metric

Signed-off-by: Yuxian Dai <Yuxian.Dai@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Kevin Wang <Kevin1.Wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c |    6 ++++++
 drivers/gpu/drm/amd/powerplay/renoir_ppt.h |    2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -240,6 +240,7 @@ static int renoir_print_clk_levels(struc
 	uint32_t cur_value = 0, value = 0, count = 0, min = 0, max = 0;
 	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
 	SmuMetrics_t metrics;
+	bool cur_value_match_level = false;
 
 	if (!clk_table || clk_type >= SMU_CLK_COUNT)
 		return -EINVAL;
@@ -298,8 +299,13 @@ static int renoir_print_clk_levels(struc
 		GET_DPM_CUR_FREQ(clk_table, clk_type, i, value);
 		size += sprintf(buf + size, "%d: %uMhz %s\n", i, value,
 				cur_value == value ? "*" : "");
+		if (cur_value == value)
+			cur_value_match_level = true;
 	}
 
+	if (!cur_value_match_level)
+		size += sprintf(buf + size, "   %uMhz *\n", cur_value);
+
 	return size;
 }
 
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
@@ -37,7 +37,7 @@ extern void renoir_set_ppt_funcs(struct
 			freq = table->SocClocks[dpm_level].Freq;	\
 			break;						\
 		case SMU_MCLK:						\
-			freq = table->MemClocks[dpm_level].Freq;	\
+			freq = table->FClocks[dpm_level].Freq;	\
 			break;						\
 		case SMU_DCEFCLK:					\
 			freq = table->DcfClocks[dpm_level].Freq;	\


