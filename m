Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE75C352B6
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74CDF215A4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586646662;
	bh=j7Y74wBYzbYdiPB2ZGWXKhrRT4g6qM8+fdvfvY24KyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A+PA/9Q3LdDP6E8RiL0N66uV3e+7Vp16IpC3oEdfsbVoN1wgUKYwx5RucOVk25TRx
	 LwN3paj7kipm5cOOw3ekcY+svkSfZMIaOZ4p56cFhQkm3jZK8LondFjYbA4kDSdmX7
	 U/+bDxUYshtuvUwX9wGWAIsW4fyiMxA3JNoAUncQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbgDKXLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:11:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729246AbgDKXK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:10:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9865C21924;
        Sat, 11 Apr 2020 23:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646659;
        bh=j7Y74wBYzbYdiPB2ZGWXKhrRT4g6qM8+fdvfvY24KyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FpHkorfBhPekSm7u3Q+MfDd0de3mqe4TGrWDc/YFrfU544OQ4oM9wI09Xv1R0FaFV
         eR9adCzpyDMsbZA1duYl4qH9B019lxNXdpAsF5L/NXXbpMaBp8uo2CNmSWkITjs34N
         C19K7zTzd8kRNipG2yytdEuvNtIWsTWPbfvCr8wY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aric Cyr <aric.cyr@amd.com>,
        Joshua Aberback <Joshua.Aberback@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 061/108] drm/amd/display: dal_ddc_i2c_payloads_create can fail causing panic
Date:   Sat, 11 Apr 2020 19:08:56 -0400
Message-Id: <20200411230943.24951-61-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230943.24951-1-sashal@kernel.org>
References: <20200411230943.24951-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aric Cyr <aric.cyr@amd.com>

[ Upstream commit 6a6c4a4d459ecacc9013c45dcbf2bc9747fdbdbd ]

[Why]
Since the i2c payload allocation can fail need to check return codes

[How]
Clean up i2c payload allocations and check for errors

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Joshua Aberback <Joshua.Aberback@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c | 52 +++++++++----------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
index 51991bf26a93c..4c90d68db2307 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
@@ -126,22 +126,16 @@ struct aux_payloads {
 	struct vector payloads;
 };
 
-static struct i2c_payloads *dal_ddc_i2c_payloads_create(struct dc_context *ctx, uint32_t count)
+static bool dal_ddc_i2c_payloads_create(
+		struct dc_context *ctx,
+		struct i2c_payloads *payloads,
+		uint32_t count)
 {
-	struct i2c_payloads *payloads;
-
-	payloads = kzalloc(sizeof(struct i2c_payloads), GFP_KERNEL);
-
-	if (!payloads)
-		return NULL;
-
 	if (dal_vector_construct(
 		&payloads->payloads, ctx, count, sizeof(struct i2c_payload)))
-		return payloads;
-
-	kfree(payloads);
-	return NULL;
+		return true;
 
+	return false;
 }
 
 static struct i2c_payload *dal_ddc_i2c_payloads_get(struct i2c_payloads *p)
@@ -154,14 +148,12 @@ static uint32_t dal_ddc_i2c_payloads_get_count(struct i2c_payloads *p)
 	return p->payloads.count;
 }
 
-static void dal_ddc_i2c_payloads_destroy(struct i2c_payloads **p)
+static void dal_ddc_i2c_payloads_destroy(struct i2c_payloads *p)
 {
-	if (!p || !*p)
+	if (!p)
 		return;
-	dal_vector_destruct(&(*p)->payloads);
-	kfree(*p);
-	*p = NULL;
 
+	dal_vector_destruct(&p->payloads);
 }
 
 #define DDC_MIN(a, b) (((a) < (b)) ? (a) : (b))
@@ -521,9 +513,13 @@ bool dal_ddc_service_query_ddc_data(
 
 	uint32_t payloads_num = write_payloads + read_payloads;
 
+
 	if (write_size > EDID_SEGMENT_SIZE || read_size > EDID_SEGMENT_SIZE)
 		return false;
 
+	if (!payloads_num)
+		return false;
+
 	/*TODO: len of payload data for i2c and aux is uint8!!!!,
 	 *  but we want to read 256 over i2c!!!!*/
 	if (dal_ddc_service_is_in_aux_transaction_mode(ddc)) {
@@ -556,23 +552,25 @@ bool dal_ddc_service_query_ddc_data(
 
 		ret = dc_link_aux_transfer_with_retries(ddc, &read_payload);
 	} else {
-		struct i2c_payloads *payloads =
-			dal_ddc_i2c_payloads_create(ddc->ctx, payloads_num);
+		struct i2c_command command = {0};
+		struct i2c_payloads payloads;
+
+		if (!dal_ddc_i2c_payloads_create(ddc->ctx, &payloads, payloads_num))
+			return false;
 
-		struct i2c_command command = {
-			.payloads = dal_ddc_i2c_payloads_get(payloads),
-			.number_of_payloads = 0,
-			.engine = DDC_I2C_COMMAND_ENGINE,
-			.speed = ddc->ctx->dc->caps.i2c_speed_in_khz };
+		command.payloads = dal_ddc_i2c_payloads_get(&payloads);
+		command.number_of_payloads = 0;
+		command.engine = DDC_I2C_COMMAND_ENGINE;
+		command.speed = ddc->ctx->dc->caps.i2c_speed_in_khz;
 
 		dal_ddc_i2c_payloads_add(
-			payloads, address, write_size, write_buf, true);
+			&payloads, address, write_size, write_buf, true);
 
 		dal_ddc_i2c_payloads_add(
-			payloads, address, read_size, read_buf, false);
+			&payloads, address, read_size, read_buf, false);
 
 		command.number_of_payloads =
-			dal_ddc_i2c_payloads_get_count(payloads);
+			dal_ddc_i2c_payloads_get_count(&payloads);
 
 		ret = dm_helpers_submit_i2c(
 				ddc->ctx,
-- 
2.20.1

