Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397D4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05D30204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597927840;
	bh=EIgqOuqjx6hxxb++cuTMR5Swu+gKbpESkR9jw59FFbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=evGipJTw8A7ulzFJmpS22AHlGlLu1AzeCNCtIfPCT8NvlZV7vPqYvLJaAdYICb7Cz
	 miBnUr+IdxYstDh5HqY4yFK9iRZrX88DiSLT0eIZJw9edEBpjslWONjeuhYyRZHasO
	 ZgK3P+4OyA5AMhQy91JlO8jjdax2l+7KXZf4G4/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbgHTMuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:50:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728644AbgHTJpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:45:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E78C420724;
        Thu, 20 Aug 2020 09:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916648;
        bh=EIgqOuqjx6hxxb++cuTMR5Swu+gKbpESkR9jw59FFbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Da55pZk7YSvcEsGoFl/CDl8LzyXmbr07/0wPspsR/iQrhF/BjkR57MBibII2zDxJt
         9//UT+BXVXJkwpOENtNde8FfMAL7DZWrn5WUrZVm3THMIsZ7K+TWwlIp4LbLMMSYlX
         AVIG8gYhBv4oKiKF+jgTS8L6T54ZllJahI09Xn88=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stylon Wang <stylon.wang@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        Eryk Brol <eryk.brol@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.7 203/204] drm/amd/display: Fix dmesg warning from setting abm level
Date:   Thu, 20 Aug 2020 11:21:40 +0200
Message-Id: <20200820091616.320085317@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stylon Wang <stylon.wang@amd.com>

commit c5892a10218214d729699ab61bad6fc109baf0ce upstream.

[Why]
Setting abm level does not correctly update CRTC state. As a result
no surface update is added to dc stream state and triggers warning.

[How]
Correctly update CRTC state when setting abm level property.

CC: Stable <stable@vger.kernel.org>
Signed-off-by: Stylon Wang <stylon.wang@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8458,6 +8458,29 @@ static int amdgpu_dm_atomic_check(struct
 		if (ret)
 			goto fail;
 
+	/* Check connector changes */
+	for_each_oldnew_connector_in_state(state, connector, old_con_state, new_con_state, i) {
+		struct dm_connector_state *dm_old_con_state = to_dm_connector_state(old_con_state);
+		struct dm_connector_state *dm_new_con_state = to_dm_connector_state(new_con_state);
+
+		/* Skip connectors that are disabled or part of modeset already. */
+		if (!old_con_state->crtc && !new_con_state->crtc)
+			continue;
+
+		if (!new_con_state->crtc)
+			continue;
+
+		new_crtc_state = drm_atomic_get_crtc_state(state, new_con_state->crtc);
+		if (IS_ERR(new_crtc_state)) {
+			ret = PTR_ERR(new_crtc_state);
+			goto fail;
+		}
+
+		if (dm_old_con_state->abm_level !=
+		    dm_new_con_state->abm_level)
+			new_crtc_state->connectors_changed = true;
+	}
+
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 		if (!compute_mst_dsc_configs_for_state(state, dm_state->context))
 			goto fail;


