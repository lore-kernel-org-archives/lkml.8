Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354F4C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B2D2078C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586255056;
	bh=mydvpf9JQotGF33zrvwujih4d2LyJw0bPk+qpk20hdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xvruD5dKCNaaPyOGG2SW3jRZO20o0UZ0wzKozUiBB8SwUkvLNvzrwmNcwk6dEaL/p
	 605/FBeGvTrf7virWlfdoHbwtOG+1hjqUQoFlE6S19mBSjUBK3wI1Rib9ofFjmkst0
	 mu+viVoIkO1dvOwxbLnODz5X+zQo56/5b+NHB+WE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgDGKYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:24:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728304AbgDGKYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:24:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 334EC2078A;
        Tue,  7 Apr 2020 10:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586255050;
        bh=mydvpf9JQotGF33zrvwujih4d2LyJw0bPk+qpk20hdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sZmTAfeT9hWp0dfOHp3h9U4lRbv7e66rCDqjp67S70yDtoooWdrK7Cmr4Rb2Ww3q6
         XQ8T3qeQhTRGVrFnFxEdsnY1B6Z8Y/BfHrirC4coHrzxAUIEVh4+TXXa5hMe+HRQfc
         MlsTqgMA2UdQobRRphyrurRNzUS/PtNnVrmApGmg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mario Kleiner <mario.kleiner.de@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 10/46] drm/amd/display: Add link_rate quirk for Apple 15" MBP 2017
Date:   Tue,  7 Apr 2020 12:21:41 +0200
Message-Id: <20200407101500.616555233@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200407101459.502593074@linuxfoundation.org>
References: <20200407101459.502593074@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mario Kleiner <mario.kleiner.de@gmail.com>

[ Upstream commit dec9de2ada523b344eb2428abfedf9d6cd0a0029 ]

This fixes a problem found on the MacBookPro 2017 Retina panel:

The panel reports 10 bpc color depth in its EDID, and the
firmware chooses link settings at boot which support enough
bandwidth for 10 bpc (324000 kbit/sec aka LINK_RATE_RBR2
aka 0xc), but the DP_MAX_LINK_RATE dpcd register only reports
2.7 Gbps (multiplier value 0xa) as possible, in direct
contradiction of what the firmware successfully set up.

This restricts the panel to 8 bpc, not providing the full
color depth of the panel on Linux <= 5.5. Additionally, commit
'4a8ca46bae8a ("drm/amd/display: Default max bpc to 16 for eDP")'
introduced into Linux 5.6-rc1 will unclamp panel depth to
its full 10 bpc, thereby requiring a eDP bandwidth for all
modes that exceeds the bandwidth available and causes all modes
to fail validation -> No modes for the laptop panel -> failure
to set any mode -> Panel goes dark.

This patch adds a quirk specific to the MBP 2017 15" Retina
panel to override reported max link rate to the correct maximum
of 0xc = LINK_RATE_RBR2 to fix the darkness and reduced display
precision.

Please apply for Linux 5.6+ to avoid regressing Apple MBP panel
support.

Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 504055fc70e89..6f2b3ec17e7f0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2909,6 +2909,17 @@ static bool retrieve_link_cap(struct dc_link *link)
 		sink_id.ieee_device_id,
 		sizeof(sink_id.ieee_device_id));
 
+	/* Quirk Apple MBP 2017 15" Retina panel: Wrong DP_MAX_LINK_RATE */
+	{
+		uint8_t str_mbp_2017[] = { 101, 68, 21, 101, 98, 97 };
+
+		if ((link->dpcd_caps.sink_dev_id == 0x0010fa) &&
+		    !memcmp(link->dpcd_caps.sink_dev_id_str, str_mbp_2017,
+			    sizeof(str_mbp_2017))) {
+			link->reported_link_cap.link_rate = 0x0c;
+		}
+	}
+
 	core_link_read_dpcd(
 		link,
 		DP_SINK_HW_REVISION_START,
-- 
2.20.1



