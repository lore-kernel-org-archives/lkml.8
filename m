Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A85CC2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 00:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29AD2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 00:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYKHpY6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgCRAZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 20:25:13 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36544 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgCRAZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 20:25:13 -0400
Received: by mail-ot1-f65.google.com with SMTP id 39so8355092otu.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 17:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RthWSSAwfQ1m/fIyaMgHoqmV5M148uMDMgR2Z75pZn8=;
        b=nYKHpY6nByhG0uRCsowUHUQJDn8lvAmj1r6pTXxO+446VW4lMe+YgRICjtX4GAia1C
         niVY8FgXbE31dNwHG5RfG1MjyEthgGJTIdiuHqLgzLyfjtmtr8WqehWj1A/7hbst7MvT
         TxuNCCpWqcMTj3ehMffTAne8xCq1PVAGU3OpM/AuUmCRblWQHrtl+9BLgz8VdKDHSMeS
         GTnKkvg+dZHvUevq3Bv8Rsx5l7r4PDB5ZKT8kO72UvOF3UhK+DkJF5nH+C4ffxUeimVt
         2iAkONfQ+6AmNmy3q0v1aR2mp+UJyCK3F2P/Ey32/jCril3wDx3aMfDdNeaRcfwgipZ4
         qYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RthWSSAwfQ1m/fIyaMgHoqmV5M148uMDMgR2Z75pZn8=;
        b=k3QxzQ82QGBxKmPPb7B08k1iE6ZqSSbQWUPGqcZd65NjkloWo0NJoNU1rghXlKgHTR
         +1DngBEGrEXiq4dN+23Lt3wbQd2W7rCyS3DtAZ3MgBLNq2YLZVIoLmkcHecSQV0ze12q
         Vpi7qi2TMlP/f6hdqgOjPquJns0p7hqzMVbj24/y6j3uXzEvdUQCpsClsQN6oHIRwYYu
         j2UiQ7Yb5IxS+V0DVTZNF8X891nDI4ohqrpRQtwNydn1bleVHzO0wWfvsd72a2wZJ8nG
         IQwWL8nI4M9rtu5yggv3QnMOWL1x2OaZuIT90MIW/JgpS5J1NJyK5bL59KPEMwoW/fw0
         vrFg==
X-Gm-Message-State: ANhLgQ20PAxVnTIRHVYaRpyw+e8Ndrj8i5twBWwdfKB+QrUcoz9+cncs
        lESMHYJow6cwjB/i/Y7+Kcw=
X-Google-Smtp-Source: ADFU+vtt2GDTqaDqobRqfbJiRXx+3kKCoi5fhOgvoNclVJWr5EiPhuO5Az9mcy0rzvDzM8NfX7xUGA==
X-Received: by 2002:a9d:53c2:: with SMTP id i2mr1714115oth.11.1584491112227;
        Tue, 17 Mar 2020 17:25:12 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id b26sm1569129oti.3.2020.03.17.17.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 17:25:11 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/amdgpu: Initialize shadow to false in gfx_v9_0_rlcg_wreg
Date:   Tue, 17 Mar 2020 17:25:00 -0700
Message-Id: <20200318002500.52471-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.26.0.rc1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang warns:

drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:754:6: warning: variable 'shadow'
is used uninitialized whenever 'if' condition is
false [-Wsometimes-uninitialized]
        if (offset == grbm_cntl || offset == grbm_idx)
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:757:6: note: uninitialized use
occurs here
        if (shadow) {
            ^~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:754:2: note: remove the 'if' if
its condition is always true
        if (offset == grbm_cntl || offset == grbm_idx)
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:738:13: note: initialize the
variable 'shadow' to silence this warning
        bool shadow;
                   ^
                    = 0
1 warning generated.

It is not wrong so initialize shadow to false to ensure shadow is always
used initialized.

Fixes: 2e0cc4d48b91 ("drm/amdgpu: revise RLCG access path")
Link: https://github.com/ClangBuiltLinux/linux/issues/936
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 7bc2486167e7..affbff76758c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -735,7 +735,7 @@ void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v)
 	static void *spare_int;
 	static uint32_t grbm_cntl;
 	static uint32_t grbm_idx;
-	bool shadow;
+	bool shadow = false;
 
 	scratch_reg0 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] + mmSCRATCH_REG0)*4;
 	scratch_reg1 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG1)*4;
-- 
2.26.0.rc1

