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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2F6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73C05207FC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLpZxQ4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgHDUHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbgHDUHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 16:07:09 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64128C061756
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 13:07:09 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v4so35352326ljd.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 13:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QwuLYaLApEmOVHWHp+Vw1bu5HTkIwR1S8vZ0IWZKqmM=;
        b=FLpZxQ4GTpNyh/1BXqukhZgZoy6iGrA7zQp+owRl9101bQaeprmsdtxy3eVIVuNFCQ
         AQ1Bkycg1e8d/wStglObx5UZLQmRmyAGbwikAijd+WWViYbgFdUnvZf4hWoZeAoG0Lu9
         Hsg1dG1Fno2GINrLJQI/JQiW/LLdUAVRBN5E57dqRbjPFWnUgaRf6Gf9L0FU/VTDOXMo
         Q2xp90uVLmWip7UK3nvWlrgW4d+oFC/d87YsaLPcEcU74EzQi0wa39YUIu/p7HiLXAWp
         hbHBiRjl95a86OgI1DHtLJByW+Tg63iS16OT+gfg6HMyUogie2MaGCLjUziIX0GzanYI
         mFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QwuLYaLApEmOVHWHp+Vw1bu5HTkIwR1S8vZ0IWZKqmM=;
        b=qoqmFDkUT9lpR3eYPvfmjZNMjCslo+T2EpM9hX8bpEHs8EKYZxfjNnBpGVkB2Y5NUT
         8h2/6HSz9EcD2Gwg+jQGY7fZD2/evG6n5nj71fKS888EcNcmZucHQwPh/SN0K8RpPAJ4
         kgo0hy98o/aHAalRci/mXHI1uozlbDnwqfAbaxHrkf9IHBpYjoSojpzAd2BwU4as0xA4
         8TF1vSN+qqtsl2yBuiXjZkCHQQmKxmesgAdzAtjZN80PQz9iBmXAL5yxQkjnFaFO/DxO
         /y5KZ/5n9KpOpTYFbXgEvXduZ7RWxzOJeuAYiFZfR2f4+58zLDQyh+sDxjx3SD15bVut
         0wig==
X-Gm-Message-State: AOAM5300JUKVcNoV2MW549b7PvtJM9N48MsuoCVhHwIMZgKiYPcdCU6X
        XyPCT1ESCTpVkh7hLFjiiadLqcQASu8=
X-Google-Smtp-Source: ABdhPJy10VXgAk8Goc18zm0EgsOvZ6ttd08uapq9UzSlkSY6+d275kuzohjkFRZy0NKuyd896rLEMw==
X-Received: by 2002:a2e:8e96:: with SMTP id z22mr9619710ljk.462.1596571627893;
        Tue, 04 Aug 2020 13:07:07 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id g21sm3080020ljh.103.2020.08.04.13.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 13:07:07 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 2/3] drm/amd/display: Constify dcn21_res_pool_funcs
Date:   Tue,  4 Aug 2020 22:06:54 +0200
Message-Id: <20200804200655.30495-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200804200655.30495-1-rikard.falkeborn@gmail.com>
References: <20200804200655.30495-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of dcn21_res_pool_funcs is to assign its address to a
const pointer. Make it const to allow the compiler to put it in
read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 88d41a385add..a828696668bf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1754,7 +1754,7 @@ enum dc_status dcn21_patch_unknown_plane_state(struct dc_plane_state *plane_stat
 	return result;
 }
 
-static struct resource_funcs dcn21_res_pool_funcs = {
+static const struct resource_funcs dcn21_res_pool_funcs = {
 	.destroy = dcn21_destroy_resource_pool,
 	.link_enc_create = dcn21_link_encoder_create,
 	.panel_cntl_create = dcn21_panel_cntl_create,
-- 
2.28.0

