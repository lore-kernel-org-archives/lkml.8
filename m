Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7E0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 037C8207FC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s9xx/Duk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgHDUHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgHDUHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 16:07:11 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6419C061757
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 13:07:10 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id i10so10267150ljn.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 13:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u8vVd3eNYQguySxvKcCaV5W8ooNVhtOP1CKm/UC6A7I=;
        b=s9xx/Duk98DAB0+L8vFJMaT7WWygK0TAVyP8WfoNoaFx3f2OxDMsQm34eFo1UqG5Xr
         d9dpxhegHqwtwtW6evsWeDD9utm7jF5dneGl3JlS/3ERywgRsNOPa5o0gke2M+69aSwY
         O9wZPw8E8PiOT0Mo3LmYhFOdJvbUlxHqUTdcU3XwO1/LAH8DVBMbxlw8SIkK30Hdz+Za
         KXs8UGhnHkIcTbM9q/sVxhDjpXK/r1vgmHsLL3AO8VYtuijNNqWECRksnrVnZ4x/i53X
         KoS7hM2sZgmiDw2nxwUeo6qssL0XXACOrQKM150LTEUabBJ/VC+boW6XHPfAwM/xQEZR
         mtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u8vVd3eNYQguySxvKcCaV5W8ooNVhtOP1CKm/UC6A7I=;
        b=b03qLapsImdLysKjEm66lNJw5XthRjsJEPbmBJXkrWt5Z4ro24qcSU/LCycyA+dT9D
         gCdMHvWKk/0YZarbFjPJHcv2eZnHPap9fz4FNddBRy9TRifEyWuDtPrCecJ0xiu9TjxU
         TB/u9svjqUMwlv7WbiwTbnbzubxSaE53d/gFc4pRhDqEDS0DikOOnaTpVmf2fpCCvbCZ
         MlZClC8oWdtYIquUMqiKtxR9u6PDP17NitnuHb6bc4q6UZEmRSeMDBL3mnHizQ5Klau8
         j2szkBlSR09v5+mSbQdx5PZSInV4Kux2B4++U/oSjjaXCzESPmQTGvJHqZD+A6GXgZ7t
         zx3w==
X-Gm-Message-State: AOAM530TPUcxn6feWUPjY5xTEkmfXadOOuG7F+lPul9KTX13ORtQK49x
        K4w8JKoOIZ85cgsdSivc1Ls=
X-Google-Smtp-Source: ABdhPJyBRrbSBhdu9xngj5VBMCOa3dus0RevnDqkrLCpPxaq4pkyHzKmzy8Eur5swB9DFOpFQqCLPg==
X-Received: by 2002:a05:651c:c6:: with SMTP id 6mr10769338ljr.237.1596571629160;
        Tue, 04 Aug 2020 13:07:09 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id g21sm3080020ljh.103.2020.08.04.13.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 13:07:08 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 3/3] drm/amd/display: Constify dcn30_res_pool_funcs
Date:   Tue,  4 Aug 2020 22:06:55 +0200
Message-Id: <20200804200655.30495-4-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200804200655.30495-1-rikard.falkeborn@gmail.com>
References: <20200804200655.30495-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of dcn30_res_pool_funcs is to assign its address to a
const pointer. Make it const to allow the compiler to put it in
read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 653a571e366d..d474a6188445 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2412,7 +2412,7 @@ static void dcn30_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw
 		dml_init_instance(&dc->current_state->bw_ctx.dml, &dcn3_0_soc, &dcn3_0_ip, DML_PROJECT_DCN30);
 }
 
-static struct resource_funcs dcn30_res_pool_funcs = {
+static const struct resource_funcs dcn30_res_pool_funcs = {
 	.destroy = dcn30_destroy_resource_pool,
 	.link_enc_create = dcn30_link_encoder_create,
 	.panel_cntl_create = dcn30_panel_cntl_create,
-- 
2.28.0

