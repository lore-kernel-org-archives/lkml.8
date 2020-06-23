Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610EEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A9F120738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592947543;
	bh=3yRFJU4yntUSPoIbvmL994iY5gdsWWCKciTePj6cKWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LtpwHlHPtDTBQ52+HOaUfYKr8rvNFaxnqLhelWWEfFzIQRoK2RTAMlTVkeTfXt0iI
	 9a5hbORQAtn8Z+E5aRtlEjYJxP80UD/6IRoslBcC+n3PlUoKwRHB7nU0zF2WrWT8i6
	 2sqAn4Dxzv4z2o+8DP0uUHuoAiSbB2dY7Yn7mafI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390430AbgFWVZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:25:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389705AbgFWUSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:18:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93FB72137B;
        Tue, 23 Jun 2020 20:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943521;
        bh=3yRFJU4yntUSPoIbvmL994iY5gdsWWCKciTePj6cKWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pOXHDDZInm4VHtbo6hhdpKI3+5vN6B2po3vkJrRqG6cqogvkhZoIbNzvXYSnnE8n+
         HXpjWqRnnl5G5o1yCk7vfShZqybk77+aJonsGLcvtLng7QYUqX4gCYaqWVP2rlMJFh
         3P657WtnlxRIiZ+ssjIrRuq+8yOiFlDJ3thKVnl0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, nicholas.kazlauskas@amd.com,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.7 424/477] drm/amdgpu/display: use blanked rather than plane state for sync groups
Date:   Tue, 23 Jun 2020 21:57:01 +0200
Message-Id: <20200623195427.571972434@linuxfoundation.org>
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

From: Alex Deucher <alexander.deucher@amd.com>

commit b7f839d292948142eaab77cedd031aad0bfec872 upstream.

We may end up with no planes set yet, depending on the ordering, but we
should have the proper blanking state which is either handled by either
DPG or TG depending on the hardware generation.  Check both to determine
the proper blanked state.

Bug: https://gitlab.freedesktop.org/drm/amd/issues/781
Fixes: 5fc0cbfad45648 ("drm/amd/display: determine if a pipe is synced by plane state")
Cc: nicholas.kazlauskas@amd.com
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/dc/core/dc.c |   24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1011,9 +1011,17 @@ static void program_timing_sync(
 			}
 		}
 
-		/* set first pipe with plane as master */
+		/* set first unblanked pipe as master */
 		for (j = 0; j < group_size; j++) {
-			if (pipe_set[j]->plane_state) {
+			bool is_blanked;
+
+			if (pipe_set[j]->stream_res.opp->funcs->dpg_is_blanked)
+				is_blanked =
+					pipe_set[j]->stream_res.opp->funcs->dpg_is_blanked(pipe_set[j]->stream_res.opp);
+			else
+				is_blanked =
+					pipe_set[j]->stream_res.tg->funcs->is_blanked(pipe_set[j]->stream_res.tg);
+			if (!is_blanked) {
 				if (j == 0)
 					break;
 
@@ -1034,9 +1042,17 @@ static void program_timing_sync(
 				status->timing_sync_info.master = false;
 
 		}
-		/* remove any other pipes with plane as they have already been synced */
+		/* remove any other unblanked pipes as they have already been synced */
 		for (j = j + 1; j < group_size; j++) {
-			if (pipe_set[j]->plane_state) {
+			bool is_blanked;
+
+			if (pipe_set[j]->stream_res.opp->funcs->dpg_is_blanked)
+				is_blanked =
+					pipe_set[j]->stream_res.opp->funcs->dpg_is_blanked(pipe_set[j]->stream_res.opp);
+			else
+				is_blanked =
+					pipe_set[j]->stream_res.tg->funcs->is_blanked(pipe_set[j]->stream_res.tg);
+			if (!is_blanked) {
 				group_size--;
 				pipe_set[j] = pipe_set[group_size];
 				j--;


