Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE1DC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22C9620674
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597693320;
	bh=qpYVExMYuXlY8Y4VITqpkEQO2JIAQnnXvNxeNv4FaKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mjeTnuL3czYpHmKfZZS2YeyL1uAoz4cylyg94N3Vg+CS9BcHLVEp35CO9+hxdKk6q
	 2FVXZg9TJfG4zv0M9TXPpjKJ0jMS1sbOKRsqJPHUny9PRNa7q6pnLJnoC5JolcBt5N
	 hHrP0CGO0FEi0CoZ6GVpzGwKylUPCiw8VsHji0GA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404328AbgHQTl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:41:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729400AbgHQPYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:24:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE2A322D6F;
        Mon, 17 Aug 2020 15:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597677882;
        bh=qpYVExMYuXlY8Y4VITqpkEQO2JIAQnnXvNxeNv4FaKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ieAMNuryKDZkl+Fnjy6eW12P040wS2XvG1zrIcQT9pRH1cZcZLOHCYzPvqOUl9ra4
         B5d5SyScf+KIWd/kf9N1vRr+tNqP7R3znLxEl2HN70f6UKJ687v1nN1WxYdYJja0U4
         xsM5+ytcGArve0Z1WUQLqyAy+m03FgXrlnh/jFr0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 142/464] drm/bridge: ti-sn65dsi86: Fix off-by-one error in clock choice
Date:   Mon, 17 Aug 2020 17:11:35 +0200
Message-Id: <20200817143840.616640797@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit fe3d7a35497c807d0dad0642afd87d6ba5b6fc86 ]

If the rate in our table is _equal_ to the rate we want then it's OK
to pick it.  It doesn't need to be greater than the one we want.

Fixes: a095f15c00e2 ("drm/bridge: add support for sn65dsi86 bridge driver")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20200504213225.1.I21646c7c37ff63f52ae6cdccc9bc829fbc3d9424@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index d865cc2565bc0..8a0e34f2160af 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -475,7 +475,7 @@ static int ti_sn_bridge_calc_min_dp_rate_idx(struct ti_sn_bridge *pdata)
 				   1000 * pdata->dp_lanes * DP_CLK_FUDGE_DEN);
 
 	for (i = 1; i < ARRAY_SIZE(ti_sn_bridge_dp_rate_lut) - 1; i++)
-		if (ti_sn_bridge_dp_rate_lut[i] > dp_rate_mhz)
+		if (ti_sn_bridge_dp_rate_lut[i] >= dp_rate_mhz)
 			break;
 
 	return i;
-- 
2.25.1



