Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3965AC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C94B2468D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkgKXpMV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgB1Qn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:43:29 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41923 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgB1Qn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:43:28 -0500
Received: by mail-ed1-f65.google.com with SMTP id c26so4054515eds.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 08:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=10ldW0StfDF5LQn5px5zjojzk7W9mvvMvbddw+jgFsA=;
        b=XkgKXpMVRw195GbFLaoE1Lus3mosOPFgls1V02Wvy1Vj5vnwWa/HRfYURh8n8PZpaJ
         GkkkX3RdNYcvyJtM4AnWGWxiNk9HM4LBrUL9G2/xBYaUn4nNhl0jhV83HNR6fI2ajKQK
         /ETtlOkksDL/o5pz0bHC7Wi+BlJ3qRQlsiTOta/ifPscYgV+XNiDtrl/yZPGF4t75ctM
         hTdDnCOg8YNAMiVoC8iwHNfW0zk4ML4bSbxMwJV4BwBXuY7sdgvNCYaZG6l6vkc81t78
         6/ZYVosISVmDrBi4WrIDONYZVhLbUBgjnMstgqn+Q1pUDlwXXRVCti9+m6gKW29nAtsd
         wgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=10ldW0StfDF5LQn5px5zjojzk7W9mvvMvbddw+jgFsA=;
        b=PKMV24c6TMyRtqsaFhePHyIVEZFe8D1BKQXcg94tm5ddwVLlIziuJgt+oxRP2P0pnt
         UkUtdc2phh63sfIPlKXjByNQNgLvhUl5h7wwA19yt7waBCQ38ee6TvIMfWZZAm8P3qUd
         5fbD0LhfYavB0nn5TmkXVM8iJAVUAbLRQzBT41LyLwj6ug5m1x5GDLxLmZV/ybc+XPMZ
         Hg+ZOZH/XfVFjPu9IyPhEXH7G+9ZHlmNQPkPIG2PRfhrH6OHCFJqWdFcCagwCiLNFJor
         apY9r9r11K2ul+5KSt2F2P7k6WjmPYPt9Zg9xqkwPOupLcjbJhdEb/sIUE5u70A8e+7F
         D93A==
X-Gm-Message-State: APjAAAURxHHOmMxbymMhomTidVzW+CuRgYsO9raB1b7KRq6+Jo9a4BUV
        xv96zf/hLockCd4RlBpQgls=
X-Google-Smtp-Source: APXvYqxq6JyAJsx/ABxv5xVgyd+/eUW8LdQVVIyzQs61/8UwUjygLRJ5olX/k0a0wg+uYk8PR3GkRQ==
X-Received: by 2002:a50:eb04:: with SMTP id y4mr4879876edp.170.1582908207050;
        Fri, 28 Feb 2020 08:43:27 -0800 (PST)
Received: from smtp.gmail.com (1.77.115.89.rev.vodafone.pt. [89.115.77.1])
        by smtp.gmail.com with ESMTPSA id g6sm318212edm.29.2020.02.28.08.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 08:43:26 -0800 (PST)
Date:   Fri, 28 Feb 2020 13:43:19 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Konig <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] drm/amd/display: dc_link: code clean up on detect_dp
 function
Message-ID: <60bc9ed29e4136eedd3b92c9fd536310b6b9c00d.1582907436.git.melissa.srw@gmail.com>
References: <cover.1582907436.git.melissa.srw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1582907436.git.melissa.srw@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes codestyle issues on detect_dp function as suggested by
checkpatch.pl.

CHECK: Lines should not end with a '('
WARNING: Missing a blank line after declarations
WARNING: line over 80 characters
CHECK: Alignment should match open parenthesis

Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 35 +++++++++----------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index eb9894e416ed..549bea1d725c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -585,14 +585,14 @@ static void read_current_link_settings_on_detect(struct dc_link *link)
 		LINK_SPREAD_05_DOWNSPREAD_30KHZ : LINK_SPREAD_DISABLED;
 }
 
-static bool detect_dp(
-	struct dc_link *link,
-	struct display_sink_capability *sink_caps,
-	bool *converter_disable_audio,
-	struct audio_support *audio_support,
-	enum dc_detect_reason reason)
+static bool detect_dp(struct dc_link *link,
+		      struct display_sink_capability *sink_caps,
+		      bool *converter_disable_audio,
+		      struct audio_support *audio_support,
+		      enum dc_detect_reason reason)
 {
 	bool boot = false;
+
 	sink_caps->signal = link_detect_sink(link, reason);
 	sink_caps->transaction_type =
 		get_ddc_transaction_type(sink_caps->signal);
@@ -609,9 +609,8 @@ static bool detect_dp(
 			sink_caps->signal = SIGNAL_TYPE_DISPLAY_PORT_MST;
 			link->type = dc_connection_mst_branch;
 
-			dal_ddc_service_set_transaction_type(
-							link->ddc,
-							sink_caps->transaction_type);
+			dal_ddc_service_set_transaction_type(link->ddc,
+							     sink_caps->transaction_type);
 
 			/*
 			 * This call will initiate MST topology discovery. Which
@@ -640,13 +639,10 @@ static bool detect_dp(
 			if (reason == DETECT_REASON_BOOT)
 				boot = true;
 
-			dm_helpers_dp_update_branch_info(
-				link->ctx,
-				link);
+			dm_helpers_dp_update_branch_info(link->ctx, link);
 
-			if (!dm_helpers_dp_mst_start_top_mgr(
-				link->ctx,
-				link, boot)) {
+			if (!dm_helpers_dp_mst_start_top_mgr(link->ctx,
+							     link, boot)) {
 				/* MST not supported */
 				link->type = dc_connection_single;
 				sink_caps->signal = SIGNAL_TYPE_DISPLAY_PORT;
@@ -654,7 +650,7 @@ static bool detect_dp(
 		}
 
 		if (link->type != dc_connection_mst_branch &&
-			is_dp_active_dongle(link)) {
+		    is_dp_active_dongle(link)) {
 			/* DP active dongles */
 			link->type = dc_connection_active_dongle;
 			if (!link->dpcd_caps.sink_count.bits.SINK_COUNT) {
@@ -665,14 +661,15 @@ static bool detect_dp(
 				return true;
 			}
 
-			if (link->dpcd_caps.dongle_type != DISPLAY_DONGLE_DP_HDMI_CONVERTER)
+			if (link->dpcd_caps.dongle_type !=
+			    DISPLAY_DONGLE_DP_HDMI_CONVERTER)
 				*converter_disable_audio = true;
 		}
 	} else {
 		/* DP passive dongles */
 		sink_caps->signal = dp_passive_dongle_detection(link->ddc,
-				sink_caps,
-				audio_support);
+								sink_caps,
+								audio_support);
 	}
 
 	return true;
-- 
2.25.0

