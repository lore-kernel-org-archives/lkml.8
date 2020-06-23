Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AAFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3BF820707
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592947861;
	bh=iEny6mrRqtcOg3jHBhUFOqhX0wJAG3lvG7YpYwL63H4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mEc9Gcm0+l7FPS7BzKX/E2MjJ9NO+slBDn8bcH2weFap09AgAUEs7n5z7jKHadckr
	 HlU2iRTWHFhW9wx54kUmR0HcwGvAMJAvPlYhZiYyX0wgFujVdGAvSNXXGUNNkRtcM1
	 9ujEeCaDq/2yljjGyZCHs+8Rog8tBL85zPYcfclQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393635AbgFWVbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:31:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389188AbgFWUOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:14:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6984F20E65;
        Tue, 23 Jun 2020 20:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943257;
        bh=iEny6mrRqtcOg3jHBhUFOqhX0wJAG3lvG7YpYwL63H4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qVmhhk0eIgO9gW0mioaTGcYayt3LiTQar6Cv8RdQ9Keid8Zn5r9VMbBnEzKc+e4MW
         OhjSKOtgnbA6WFbDRYTF+DcacmnXET7KwrzTncMeLULFAZQdsIxx3mQJ7HGKl41S8M
         Sw+SLF7YbbrcL5Xx0HtOp/NtnZwPG0ufexjrE48M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 321/477] drm/amd/display: Revalidate bandwidth before commiting DC updates
Date:   Tue, 23 Jun 2020 21:55:18 +0200
Message-Id: <20200623195422.707100245@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit a24eaa5c51255b344d5a321f1eeb3205f2775498 ]

[Why]
Whenever we switch between tiled formats without also switching pixel
formats or doing anything else that recreates the DC plane state we
can run into underflow or hangs since we're not updating the
DML parameters before committing to the hardware.

[How]
If the update type is FULL then call validate_bandwidth again to update
the DML parmeters before committing the state.

This is basically just a workaround and protective measure against
update types being added DC where we could run into this issue in
the future.

We can only fully validate the state in advance before applying it to
the hardware if we recreate all the plane and stream states since
we can't modify what's currently in use.

The next step is to update DM to ensure that we're creating the plane
and stream states for whatever could potentially be a full update in
DC to pre-emptively recreate the state for DC global validation.

The workaround can stay until this has been fixed in DM.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 47431ca6986db..4a619328101ce 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2517,6 +2517,12 @@ void dc_commit_updates_for_stream(struct dc *dc,
 
 	copy_stream_update_to_stream(dc, context, stream, stream_update);
 
+	if (!dc->res_pool->funcs->validate_bandwidth(dc, context, false)) {
+		DC_ERROR("Mode validation failed for stream update!\n");
+		dc_release_state(context);
+		return;
+	}
+
 	commit_planes_for_stream(
 				dc,
 				srf_updates,
-- 
2.25.1



