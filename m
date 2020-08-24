Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFA0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC97D2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598289208;
	bh=S7ECAN+qn/s+wnh0kJhI7SdCw/kXvFwD8mdYQzpRZbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EelnTgmR6FM5N0Aq3S6sAwdm70it1w9BefqUrz1rlbww3KPwSih4o6VcmRsDDqPD9
	 ygySoGX/Lht+SgRxamVjNnaTk1D17gxyQnkvo47e5b7lIAigIzk1go1HRLFnO24hNE
	 TaYJBMqi+xSPREAolle8fyjGDb/VhSzhtPF6I+BU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgHXRN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:13:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728380AbgHXQhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:37:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BF7622C9F;
        Mon, 24 Aug 2020 16:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598287020;
        bh=S7ECAN+qn/s+wnh0kJhI7SdCw/kXvFwD8mdYQzpRZbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mgtUfMt3PnTYGw20EiVSz0yF1a0leKujTyIgz05XAagFXp9vVWNQsgWhHZrVX3Yt7
         y7iJIJsFvUvpjDhc1rbXSJJG5mNqNrGaxhPYv3qDZksE/1MQD/BJYz/COn0gouPwTT
         d/oGO8YXv0OMaDxmvHf2v3MEuHmEYxCfVcUc42ME=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anthony Koo <Anthony.Koo@amd.com>,
        Ashley Thomas <Ashley.Thomas2@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.7 19/54] drm/amd/display: Switch to immediate mode for updating infopackets
Date:   Mon, 24 Aug 2020 12:35:58 -0400
Message-Id: <20200824163634.606093-19-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163634.606093-1-sashal@kernel.org>
References: <20200824163634.606093-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anthony Koo <Anthony.Koo@amd.com>

[ Upstream commit abba907c7a20032c2d504fd5afe3af7d440a09d0 ]

[Why]
Using FRAME_UPDATE will result in infopacket to be potentially updated
one frame late.
In commit stream scenarios for previously active stream, some stale
infopacket data from previous config might be erroneously sent out on
initial frame after stream is re-enabled.

[How]
Switch to using IMMEDIATE_UPDATE mode

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Ashley Thomas <Ashley.Thomas2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../amd/display/dc/dcn10/dcn10_stream_encoder.c  | 16 ++++++++--------
 .../amd/display/dc/dcn10/dcn10_stream_encoder.h  | 14 ++++++++++++++
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
index 7eba9333c3285..66ce9092e9950 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
@@ -121,35 +121,35 @@ void enc1_update_generic_info_packet(
 	switch (packet_index) {
 	case 0:
 		REG_UPDATE(AFMT_VBI_PACKET_CONTROL1,
-				AFMT_GENERIC0_FRAME_UPDATE, 1);
+				AFMT_GENERIC0_IMMEDIATE_UPDATE, 1);
 		break;
 	case 1:
 		REG_UPDATE(AFMT_VBI_PACKET_CONTROL1,
-				AFMT_GENERIC1_FRAME_UPDATE, 1);
+				AFMT_GENERIC1_IMMEDIATE_UPDATE, 1);
 		break;
 	case 2:
 		REG_UPDATE(AFMT_VBI_PACKET_CONTROL1,
-				AFMT_GENERIC2_FRAME_UPDATE, 1);
+				AFMT_GENERIC2_IMMEDIATE_UPDATE, 1);
 		break;
 	case 3:
 		REG_UPDATE(AFMT_VBI_PACKET_CONTROL1,
-				AFMT_GENERIC3_FRAME_UPDATE, 1);
+				AFMT_GENERIC3_IMMEDIATE_UPDATE, 1);
 		break;
 	case 4:
 		REG_UPDATE(AFMT_VBI_PACKET_CONTROL1,
-				AFMT_GENERIC4_FRAME_UPDATE, 1);
+				AFMT_GENERIC4_IMMEDIATE_UPDATE, 1);
 		break;
 	case 5:
 		REG_UPDATE(AFMT_VBI_PACKET_CONTROL1,
-				AFMT_GENERIC5_FRAME_UPDATE, 1);
+				AFMT_GENERIC5_IMMEDIATE_UPDATE, 1);
 		break;
 	case 6:
 		REG_UPDATE(AFMT_VBI_PACKET_CONTROL1,
-				AFMT_GENERIC6_FRAME_UPDATE, 1);
+				AFMT_GENERIC6_IMMEDIATE_UPDATE, 1);
 		break;
 	case 7:
 		REG_UPDATE(AFMT_VBI_PACKET_CONTROL1,
-				AFMT_GENERIC7_FRAME_UPDATE, 1);
+				AFMT_GENERIC7_IMMEDIATE_UPDATE, 1);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
index f9b9e221c698b..7507000a99ac4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
@@ -273,7 +273,14 @@ struct dcn10_stream_enc_registers {
 	SE_SF(DIG0_AFMT_VBI_PACKET_CONTROL1, AFMT_GENERIC2_FRAME_UPDATE, mask_sh),\
 	SE_SF(DIG0_AFMT_VBI_PACKET_CONTROL1, AFMT_GENERIC3_FRAME_UPDATE, mask_sh),\
 	SE_SF(DIG0_AFMT_VBI_PACKET_CONTROL1, AFMT_GENERIC4_FRAME_UPDATE, mask_sh),\
+	SE_SF(DIG0_AFMT_VBI_PACKET_CONTROL1, AFMT_GENERIC0_IMMEDIATE_UPDATE, mask_sh),\
+	SE_SF(DIG0_AFMT_VBI_PACKET_CONTROL1, AFMT_GENERIC1_IMMEDIATE_UPDATE, mask_sh),\
+	SE_SF(DIG0_AFMT_VBI_PACKET_CONTROL1, AFMT_GENERIC2_IMMEDIATE_UPDATE, mask_sh),\
+	SE_SF(DIG0_AFMT_VBI_PACKET_CONTROL1, AFMT_GENERIC3_IMMEDIATE_UPDATE, mask_sh),\
 	SE_SF(DIG0_AFMT_VBI_PACKET_CONTROL1, AFMT_GENERIC4_IMMEDIATE_UPDATE, mask_sh),\
+	SE_SF(DIG0_AFMT_VBI_PACKET_CONTROL1, AFMT_GENERIC5_IMMEDIATE_UPDATE, mask_sh),\
+	SE_SF(DIG0_AFMT_VBI_PACKET_CONTROL1, AFMT_GENERIC6_IMMEDIATE_UPDATE, mask_sh),\
+	SE_SF(DIG0_AFMT_VBI_PACKET_CONTROL1, AFMT_GENERIC7_IMMEDIATE_UPDATE, mask_sh),\
 	SE_SF(DIG0_AFMT_VBI_PACKET_CONTROL1, AFMT_GENERIC5_FRAME_UPDATE, mask_sh),\
 	SE_SF(DIG0_AFMT_VBI_PACKET_CONTROL1, AFMT_GENERIC6_FRAME_UPDATE, mask_sh),\
 	SE_SF(DIG0_AFMT_VBI_PACKET_CONTROL1, AFMT_GENERIC7_FRAME_UPDATE, mask_sh),\
@@ -337,7 +344,14 @@ struct dcn10_stream_enc_registers {
 	type AFMT_GENERIC2_FRAME_UPDATE;\
 	type AFMT_GENERIC3_FRAME_UPDATE;\
 	type AFMT_GENERIC4_FRAME_UPDATE;\
+	type AFMT_GENERIC0_IMMEDIATE_UPDATE;\
+	type AFMT_GENERIC1_IMMEDIATE_UPDATE;\
+	type AFMT_GENERIC2_IMMEDIATE_UPDATE;\
+	type AFMT_GENERIC3_IMMEDIATE_UPDATE;\
 	type AFMT_GENERIC4_IMMEDIATE_UPDATE;\
+	type AFMT_GENERIC5_IMMEDIATE_UPDATE;\
+	type AFMT_GENERIC6_IMMEDIATE_UPDATE;\
+	type AFMT_GENERIC7_IMMEDIATE_UPDATE;\
 	type AFMT_GENERIC5_FRAME_UPDATE;\
 	type AFMT_GENERIC6_FRAME_UPDATE;\
 	type AFMT_GENERIC7_FRAME_UPDATE;\
-- 
2.25.1

