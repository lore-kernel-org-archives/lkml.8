Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA805C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5CFF20776
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592448416;
	bh=OhuwWR1pHKkKg0JA0TgwM8GDNArAPfNmbW5ZA4DO098=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ydycUOSRJXWjGvDnHtXXijYgZ5HgB0QKpX0tWCjtr6ydK36fMj6nVs0YfkmC1XfWG
	 DL7M4Y548tQrkXb29VYMk0bc3XeH5tpsFlkxBjrRGgT5JDBVzSK2pJlZK1Ss93qHtJ
	 6Sh+9P7ai+laok1XPraklRLpfQVJEEwTvdAt+Jm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730748AbgFRCqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:46:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbgFRBKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:10:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BF9320CC7;
        Thu, 18 Jun 2020 01:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442632;
        bh=OhuwWR1pHKkKg0JA0TgwM8GDNArAPfNmbW5ZA4DO098=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Fyu65O0yPxm1z8XBQ6qO1s0hvFoU2WT43c3qNFawxAO16XPmp+QotEB1TwVMUFGX
         /0lX+Bqy+sU8Zvnlvd5THQEH45zclicLcle607KZETvNrBV6L6OKPcANlhJJaGSkZF
         Tz56NMcz2fw3KVK0lM6juhOxy2kmmEKur2rl/sm8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jonas Karlman <jonas@kwiboo.se>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 109/388] media: v4l2-ctrls: Unset correct HEVC loop filter flag
Date:   Wed, 17 Jun 2020 21:03:26 -0400
Message-Id: <20200618010805.600873-109-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonas Karlman <jonas@kwiboo.se>

[ Upstream commit 88441917dc6cd995cb993df603e264f5b88be50c ]

Wrong loop filter flag is unset when tiles enabled flag is not set,
this cause HEVC decoding issues with Rockchip Video Decoder.

Fix this by unsetting the loop filter across tiles enabled flag instead of
the pps loop filter across slices enabled flag when tiles are disabled.

Fixes: 256fa3920874 ("media: v4l: Add definitions for HEVC stateless decoding")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/v4l2-core/v4l2-ctrls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index 93d33d1db4e8..07d9ae7a929c 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -1825,7 +1825,7 @@ static int std_validate_compound(const struct v4l2_ctrl *ctrl, u32 idx,
 			       sizeof(p_hevc_pps->row_height_minus1));
 
 			p_hevc_pps->flags &=
-				~V4L2_HEVC_PPS_FLAG_PPS_LOOP_FILTER_ACROSS_SLICES_ENABLED;
+				~V4L2_HEVC_PPS_FLAG_LOOP_FILTER_ACROSS_TILES_ENABLED;
 		}
 
 		if (p_hevc_pps->flags &
-- 
2.25.1

