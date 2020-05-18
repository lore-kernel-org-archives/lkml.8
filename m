Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C902C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4621C20756
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s37biS52"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgERPDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 11:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgERPDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 11:03:53 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E39C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 08:03:51 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id z15so78915pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 08:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WgmxNih5o7lZXHfbWl9I3AtHRbIULLMSDkl7rFCTknE=;
        b=s37biS52LBSY4wjTk2uU75fo73grJe1Bprmn0WzYTdY+9jDKJUKnntDV2RhFYAu/Sw
         IYtmt4gYUF7Wc2sC3ZWKv8Qjq7ij33/F0YhqVmq2J24OAEZ3GnVJ/PNVvwCUzyvGSnQE
         6h4tj2fhO7alMmc/2bNlGXAyKFeUmFtYmltJOhp3qJ/yfcQUKXASbXIYGGzwCwGPqTva
         7DemjyYkUBCQJwHxoy7eVVIGcG9Xbi4aA0tUc+raEElr8dprKQLZ092YUuAXWckSMf+h
         r82jJexcn2WUIz4Q7f63qmWoeU8VMFzVgrG+QmJCLRpI4J42vjz6jzmFmDLDbkOrINZd
         DiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WgmxNih5o7lZXHfbWl9I3AtHRbIULLMSDkl7rFCTknE=;
        b=o9LjCywsxKWU+T7EQ8GNoTg+zVknc2h7xPFa8Zt/dEaymsfTjaOyzvG7p6XP0gbGol
         +Zbbld1byyDiG9uuRyal93pulwmxXhXlE7FGIU0b50ja1DEEazLhSMoU5VPXp2ldWyws
         PELzvKnVLOjSZGYgeJqQaGH7uL6i1mWyWAwA0p3SOQsXBgteZC9s4qB1NQs8fbj+aG8v
         hV4DXXmc5dfkGMq4Se5IX07bJqzGLdha0HDTLW7d+xdgawm3DdRpWwEfQRbyFuJsEFk7
         zNqUzzNzscQa7yNnYUdnOOJt6P2JqiTZOR5F0OBdocP6NLZejQkj1uLtIwdSIN40hUqC
         RN7g==
X-Gm-Message-State: AOAM533yz3fhgCr7tdcECt4nVRs9NstLnXQfYvz+i5g8S/lUA/DEhAMx
        kVbDURo0++1HE9LGmm+2SnM=
X-Google-Smtp-Source: ABdhPJy1il1HPxFZ4CMIw6qSCNCAYzwkanG2+QXgzJ9xj6UUukyerk2v7SMZyIwnlULbjAtJNpz1Vg==
X-Received: by 2002:a17:902:7682:: with SMTP id m2mr10535509pll.281.1589814230632;
        Mon, 18 May 2020 08:03:50 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:418:e389:dd54:a815:71b4:fdc])
        by smtp.gmail.com with ESMTPSA id 7sm6329586pfc.203.2020.05.18.08.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 08:03:49 -0700 (PDT)
From:   Aishwarya Ramakrishnan <aishwaryarj100@gmail.com>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     aishwaryarj100@gmail.com
Subject: [PATCH] drm/i915/gvt: Use ARRAY_SIZE for vgpu_types
Date:   Mon, 18 May 2020 20:33:36 +0530
Message-Id: <20200518150336.15265-1-aishwaryarj100@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefer ARRAY_SIZE instead of using sizeof

Fixes coccicheck warning: Use ARRAY_SIZE

Signed-off-by: Aishwarya Ramakrishnan <aishwaryarj100@gmail.com>
---
 drivers/gpu/drm/i915/gvt/vgpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/vgpu.c b/drivers/gpu/drm/i915/gvt/vgpu.c
index 1d5ff88078bd..7d361623ff67 100644
--- a/drivers/gpu/drm/i915/gvt/vgpu.c
+++ b/drivers/gpu/drm/i915/gvt/vgpu.c
@@ -124,7 +124,7 @@ int intel_gvt_init_vgpu_types(struct intel_gvt *gvt)
 	 */
 	low_avail = gvt_aperture_sz(gvt) - HOST_LOW_GM_SIZE;
 	high_avail = gvt_hidden_sz(gvt) - HOST_HIGH_GM_SIZE;
-	num_types = sizeof(vgpu_types) / sizeof(vgpu_types[0]);
+	num_types = ARRAY_SIZE(vgpu_types);
 
 	gvt->types = kcalloc(num_types, sizeof(struct intel_vgpu_type),
 			     GFP_KERNEL);
-- 
2.17.1

