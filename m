Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D66EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B63F20738
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QN2LdlzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgHSISm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgHSISU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:18:20 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0C4C061343
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 01:18:20 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id o18so25226631eje.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 01:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Dy+2OELhVDdm1DxklsrmDDS8Lu3aUtSBuyTN0DczS8k=;
        b=QN2LdlzXC/iWoVnvzjtShkG79VByoSWMJ0PGEvfCBxDt/cOl/FifqXc3Z4DxDI+jbO
         U0EX7DHcdDsmZeTj9BLD1GCuPT1hGS5ySxbAauEkzX0omK0Y7DixjnR3ygpB61Kl5Hu/
         nHr1pohz2HJda1AJ2cK2eofrpnPvxF+LJKzTcRz+dKyZpCsCNM/6sypYNpCInJzNCwgq
         MIxlUAKRGypbjbxTBHdOBNaJPSlD0AYXuXqWjxJoD84Ci8vJzTSlt9O5Cq85Ul1oOqpU
         tbLFZnKvcBmTfsPf0Cju7d5CgFX3pwkbtLsVzi7tfkhO25POEwMGsKACLh9R6939Az00
         iHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Dy+2OELhVDdm1DxklsrmDDS8Lu3aUtSBuyTN0DczS8k=;
        b=Dq6Ykmn4WrDPsFcljeJB+df9wjYSJiT7c186S4AmRU/xgbfdp0y4wjWWpNwIvNa51Y
         1PAMlG3mhuHa6JJvuDpxQtYsOCo8i2an9/TSf2dIuXttKV+3SkeBRPyahUO7+JyCiaZP
         4tYErw4TUo0uPPW8G5Jp4XPy5W5N5PcxXjq16FVC6otBmwYEz/ZKrKT8m87mc/BpHG7g
         153OiAC4AqKlpubx2erWZsc4pEUiFE8PmQHW2KgN8UF/w8WMMjxFPzeRfSHBDH7w7gNi
         EoMpGzxNDFy32BHTL/MEzjACtoESlEc1ZylOVIRpeNKVvu3/HhfNAv5UCnKB6hffsLZv
         UpRw==
X-Gm-Message-State: AOAM532+oA0g+vafN0z1mVtvXU28URDmJbZzvDa/Fa3I7KkyK/zDZo7Q
        wEeUshXwhIQ4Wik3F3ijpwnWixTsghq+p+eF
X-Google-Smtp-Source: ABdhPJxbTmCq+bnKTWd+oh5WAn5yWBTYt4w7rCTNOjbtzeU/xdueaFs38zLAtFWMKtPdqRf3d+UzGg==
X-Received: by 2002:a17:906:4f0f:: with SMTP id t15mr23482886eju.337.1597825098654;
        Wed, 19 Aug 2020 01:18:18 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d1b:6b00:888f:331b:5459:5921])
        by smtp.gmail.com with ESMTPSA id g27sm18312043edf.57.2020.08.19.01.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 01:18:17 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dennis Li <Dennis.Li@amd.com>, Jerry Zuo <Jerry.Zuo@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Guchun Chen <guchun.chen@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] drm/amd/display: remove unintended executable mode
Date:   Wed, 19 Aug 2020 10:18:08 +0200
Message-Id: <20200819081808.26796-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Besides the intended change, commit 4cc1178e166a ("drm/amdgpu: replace DRM
prefix with PCI device info for gfx/mmhub") also set the source files
mmhub_v1_0.c and gfx_v9_4.c to be executable, i.e., changed fromold mode
644 to new mode 755.

Commit 241b2ec9317e ("drm/amd/display: Add dcn30 Headers (v2)") added the
four header files {dpcs,dcn}_3_0_0_{offset,sh_mask}.h as executable, i.e.,
mode 755.

Set to the usual modes for source and headers files and clean up those
mistakes. No functional change.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master and next-20200819

Alex, Christian, please pick this minor non-urgent cleanup patch.

Dennis, Jerry, please ack.

Dennis, Jerry, you might want to check your development environment
introducing those executable modes on files.

 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c                         | 0
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c                       | 0
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h   | 0
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h  | 0
 drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_offset.h  | 0
 drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_sh_mask.h | 0
 6 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
 mode change 100755 => 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
 mode change 100755 => 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h
 mode change 100755 => 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
 mode change 100755 => 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_offset.h
 mode change 100755 => 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_sh_mask.h

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
old mode 100755
new mode 100644
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
old mode 100755
new mode 100644
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h
old mode 100755
new mode 100644
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
old mode 100755
new mode 100644
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_offset.h
old mode 100755
new mode 100644
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_sh_mask.h
old mode 100755
new mode 100644
-- 
2.17.1

