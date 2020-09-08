Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A67C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A407F20578
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599594044;
	bh=sC/pvJDDeet3Ha/GqvpnS3F62bLdQE5Ay7fgjWIf91E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W/HV4FVPQntoRrf/BeYKiXhoWzLFAl8LT6G4zFarwL67tivxkdAuhhIDwPHXgCOFH
	 tca6X9BgmS+58aJ9UyOYsUWqI4ltarzAAfisuxNTaf48FecpHquoV15I35mk7A4rzf
	 uSqkvDwooKmVEoG7dXZyokwV6jvaEXnau00CU5Go=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731869AbgIHTkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:40:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730791AbgIHPyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:54:44 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1498820738;
        Tue,  8 Sep 2020 15:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579339;
        bh=sC/pvJDDeet3Ha/GqvpnS3F62bLdQE5Ay7fgjWIf91E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZKOznwzqffhxGKLFhChVDSWNQn8Z7Mh2muymlFrbEspNKDgh6e2MDQ2EocsLGXtn1
         IVcGFlNRsPjhTzggZOOh6dVDmfaXJQIxZy7hrr6GLZl2nyHi8VfmOf5LJzcAbVXlQx
         tB8DLl7AjAmi55Jv2y0PFp5tlLySC4czEKO+2hac=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 036/186] drm/amd/display: Fix memleak in amdgpu_dm_mode_config_init
Date:   Tue,  8 Sep 2020 17:22:58 +0200
Message-Id: <20200908152243.426255581@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit b67a468a4ccef593cd8df6a02ba3d167b77f0c81 ]

When amdgpu_display_modeset_create_props() fails, state and
state->context should be freed to prevent memleak. It's the
same when amdgpu_dm_audio_init() fails.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7ec810ebf4ce4..3f7eced92c0c8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2822,12 +2822,18 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
 				    &dm_atomic_state_funcs);
 
 	r = amdgpu_display_modeset_create_props(adev);
-	if (r)
+	if (r) {
+		dc_release_state(state->context);
+		kfree(state);
 		return r;
+	}
 
 	r = amdgpu_dm_audio_init(adev);
-	if (r)
+	if (r) {
+		dc_release_state(state->context);
+		kfree(state);
 		return r;
+	}
 
 	return 0;
 }
-- 
2.25.1



