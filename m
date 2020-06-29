Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FDBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 766ED206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593467690;
	bh=/l6JkuWvLUtTwpeDbonIISTFolylKnipK93m1Q9AQwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bDk7adaFdEOM9qtSH61vL5FF0I3+cHOmOt62GsXjW+n7u7PTybUnEfp1fcOi+y9P7
	 nWm5bdU9QlSfHdX6j/uB6NT/AA1tu6wCy+wlv7jsVOkvprAoKLga1cInsx7+A3EGhH
	 eTc2MRlGAmGMV/Kpea67sgT/gXx8Tj0gIl2sno6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404399AbgF2Vys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:54:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbgF2Sfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:35:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55F11247CF;
        Mon, 29 Jun 2020 15:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444138;
        bh=/l6JkuWvLUtTwpeDbonIISTFolylKnipK93m1Q9AQwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1i5uvF8LxP21fAW113A18Db1qC31YhWHvfT6JtCck3tetZ8qh2wdQ9yXcSa22piwL
         JhAWf1khwzchrHi1AAVGbMO6Yy0qQ443608O58fSczPfpQjPCnShlmZoCUqbO4atLV
         DDCD1LtFFfQQBdQilbsQvnG8XlzC074H6Q8Jj/pY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stylon Wang <stylon.wang@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.7 244/265] drm/amd/display: Enable output_bpc property on all outputs
Date:   Mon, 29 Jun 2020 11:17:57 -0400
Message-Id: <20200629151818.2493727-245-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629151818.2493727-1-sashal@kernel.org>
References: <20200629151818.2493727-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.7.7-rc1
X-KernelTest-Deadline: 2020-07-01T15:14+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stylon Wang <stylon.wang@amd.com>

commit 5ae9c378c3d88b40af72f8e8f961808e29f3e70b upstream.

[Why]
Connector property output_bpc is available on DP/eDP only. New IGT tests
would benifit if this property works on HDMI.

[How]
Enable this read-only property on all types of connectors.

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 0461fecd68db3..11491ae1effc2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1017,7 +1017,6 @@ static const struct {
 		{"link_settings", &dp_link_settings_debugfs_fops},
 		{"phy_settings", &dp_phy_settings_debugfs_fop},
 		{"test_pattern", &dp_phy_test_pattern_fops},
-		{"output_bpc", &output_bpc_fops},
 		{"vrr_range", &vrr_range_fops},
 		{"sdp_message", &sdp_message_fops},
 		{"aux_dpcd_address", &dp_dpcd_address_debugfs_fops},
@@ -1090,6 +1089,9 @@ void connector_debugfs_init(struct amdgpu_dm_connector *connector)
 	debugfs_create_file_unsafe("force_yuv420_output", 0644, dir, connector,
 				   &force_yuv420_output_fops);
 
+	debugfs_create_file("output_bpc", 0644, dir, connector,
+			    &output_bpc_fops);
+
 	connector->debugfs_dpcd_address = 0;
 	connector->debugfs_dpcd_size = 0;
 
-- 
2.25.1

