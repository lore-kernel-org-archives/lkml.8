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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932FEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BF20207FC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ouoh3vaN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgHDUHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgHDUHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 16:07:09 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B9CC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 13:07:09 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 185so34804587ljj.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 13:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8X1vD9iMjbD58TZPHKwb4ye5PBWIjmiaZvRTOJ3otNU=;
        b=Ouoh3vaNcVVGD7H1kVwnvrVgU+wwepgvDoAEKRlV+AQ4Tf2O+YsRYKYjqgvyFNQB2o
         eROYCzwN/1rJZ+FMCt2vFYPMrt4X0Rmk9LoreTDEZAGNnFKT6V2YRSqWNc14awRYiFn7
         jEUkw6GM3xGAEjf3AXKOIgEMI3vjKawi3ItOG4+6Jl80xw80/Alin70MWgu/wjlM7d94
         c3jshDgkCYxxIq7vcFA18eAH30zhEryIJTkQW4bINYC9f/+SEEdxx8P4ZJ1UiSuqHgJU
         gVywg7cQU1OOxLn4t8RJCuKJx36zrpwywX8nIm3XL/Rs3oOwMK2kM33iP3Lm8D1toPPn
         YBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8X1vD9iMjbD58TZPHKwb4ye5PBWIjmiaZvRTOJ3otNU=;
        b=ZLFZ6c+NjRJlwzyXFK41Ar4FYp/q2yfJuRxaA7jZ5nLqJAe4oUrC8qsHizAAl0dT2k
         /5Ap3E+xB/DubGFwtJksGtRw3rBXv0ytkRt65g/tdY75B8aHWJPsUawqRAYb0ysNYNXf
         1PcbIWoI42UC7Th7WIJ8qYZWComivGYimbst9GorhiCfKlc8oUMBq44C2fsJ0DL6ulG3
         FnZvSRu8Ib9njFD5KepIgjoEgJe/qToOnWO2ThFeSZn7cZIK1rWLxsmH9VI+2SBd85Y3
         xubomYsKVsd9d5pEbQQil3jepoQVKQlinADd8GVKOvlRMxmauS5vFw2JEJ7qiib06OHB
         sdAw==
X-Gm-Message-State: AOAM533zqP/pRemIqkze87ELqkoF1FxtP1yoSLlR5wmVfAyhYGjzWgSn
        Y606EOMAhScyqax+JIMH34k=
X-Google-Smtp-Source: ABdhPJx1Y3+zg8EQVx5eowP9zlLeEH4mmso+i3MTOfkpYRGj2nf76AZey+5T5A6YD2go2MiFTnmiCg==
X-Received: by 2002:a2e:a179:: with SMTP id u25mr11596380ljl.101.1596571626718;
        Tue, 04 Aug 2020 13:07:06 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id g21sm3080020ljh.103.2020.08.04.13.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 13:07:06 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 1/3] drm/amd/display: Constify dcn20_res_pool_funcs
Date:   Tue,  4 Aug 2020 22:06:53 +0200
Message-Id: <20200804200655.30495-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200804200655.30495-1-rikard.falkeborn@gmail.com>
References: <20200804200655.30495-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of dcn20_res_pool_funcs is to assign its address to a
const pointer. Make it const to allow the compiler to put it in
read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 2a5e7175926a..d7ce984a2ce3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3320,7 +3320,7 @@ enum dc_status dcn20_patch_unknown_plane_state(struct dc_plane_state *plane_stat
 	return DC_OK;
 }
 
-static struct resource_funcs dcn20_res_pool_funcs = {
+static const struct resource_funcs dcn20_res_pool_funcs = {
 	.destroy = dcn20_destroy_resource_pool,
 	.link_enc_create = dcn20_link_encoder_create,
 	.panel_cntl_create = dcn20_panel_cntl_create,
-- 
2.28.0

