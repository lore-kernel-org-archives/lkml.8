Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304C1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE9D4205CB
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598288457;
	bh=48KcJnFUretPa9m4eu33BwX5UY/CjfVBLnIuqyBnw9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e8jw82dw0+vvf6AykyuuquZQ0wq7HD//xtctsLQk/brZQEFe13aoNuXKsgsj7a6ml
	 0Jb1Yn1Wkp83tatEYJhVciVnje95pH1G4iWjFKov4Wv3LhXMOchY7C4/LNq/h9j3GM
	 RU2mPthR0LDagMgHz5oVUiShpYW6Ep/3tH9KwFhc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgHXRAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:00:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728498AbgHXQin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:38:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABA4022D07;
        Mon, 24 Aug 2020 16:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598287118;
        bh=48KcJnFUretPa9m4eu33BwX5UY/CjfVBLnIuqyBnw9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1ch8e5SgEdAZhEi0f5tnU80AXTThlfC5s7Pz7Ht1HvEudL8pdWasKvCrRU0mBTwBp
         PsQAePW0i7CIj8i2aXbVcVBbRPgJUz9jT+s4FsdbntEpd9VG8kLOzyiwnHocRzncpr
         lN+pDOE1CFeZMgotdDwf8qIWdrwmt7i4fwJquQM0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiansong Chen <Jiansong.Chen@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 34/38] drm/amdgpu: disable gfxoff for navy_flounder
Date:   Mon, 24 Aug 2020 12:37:46 -0400
Message-Id: <20200824163751.606577-34-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163751.606577-1-sashal@kernel.org>
References: <20200824163751.606577-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiansong Chen <Jiansong.Chen@amd.com>

[ Upstream commit 9c9b17a7d19a8e21db2e378784fff1128b46c9d3 ]

gfxoff is temporarily disabled for navy_flounder,
since at present the feature has broken some basic
amdgpu test.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 64d96eb0a2337..3a5b4efa7a5e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -617,6 +617,9 @@ static void gfx_v10_0_check_gfxoff_flag(struct amdgpu_device *adev)
 	case CHIP_NAVI10:
 		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
 		break;
+	case CHIP_NAVY_FLOUNDER:
+		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
+		break;
 	default:
 		break;
 	}
-- 
2.25.1

