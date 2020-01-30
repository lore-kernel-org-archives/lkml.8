Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E86BC33CB2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 01:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A36C20661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 01:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmLK3Ae8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgA3BYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 20:24:55 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45040 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgA3BYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 20:24:55 -0500
Received: by mail-ot1-f67.google.com with SMTP id h9so1551055otj.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 17:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m24GYwzOSVWU+XgAxv5NZs3essGtF+Xv5GVsT6y+oQ0=;
        b=SmLK3Ae8l49DBLrp/TyTcGyk46WdEdjUx6FKHNpKRhBw9rTaOz876P6OfK77iim7e1
         MddSYRqGP5ni4xD8KuRd7Of4iUtVDcB928Ak72Fey9l8UnhdViUomoJtetz5CqymXQZx
         cm8bRQqgdyv3W8lUAOyIl1xwy+R2keLecloC+YKhM73fSWIg+vNkHRC9+kmCT95+0VGE
         SklY3eRTKam9mcq1T3MYXaNEg85e44va9QEMcDPt70pZRvf9+aSc+e39nUKouD81ly+O
         kCYuF4Mxkn9szjWp0adK7dEvmbylf2/tdG/vtf/y3aJK+EmhJCyGFzzgCbeBXbQFehyt
         aL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m24GYwzOSVWU+XgAxv5NZs3essGtF+Xv5GVsT6y+oQ0=;
        b=kVcbIzTe7Szvf/DNZzyg28WR+zp+mLXPdllXKU5wFjnOI2DbRSDqVzJLp7B4+0PPkh
         PGwPyuUerQnhK2ygXl/ECQ9apFYMPnfx50jn73bFQdP7DHLZ8ptBLT+VEGbJgCkeafue
         1scd2nuzpnGBFYLGPu18dyuprskWdhbG/536V8KDxU9z37Zo0yyBOOR7V8f7HH5qJ14u
         55ndJtnmN5FzEiIFT2kVH3SlZiI9V1KS6r9VwzHJTTe1XOFuVT8exC2b9rAK/Ib8sJFF
         QDp44W4d89O1PXz3HLkqfX9IphpKw0VIfY7x4xMSNbxZsxf3z8hTOqck7nGr+y2FQM7c
         4hxA==
X-Gm-Message-State: APjAAAVobC/kYLjQIqhJN+YYO4k3mgt8u/VnwZxYtaYDsVRW80rThOBO
        cSEyffLkm5JJVb1WWp++EeI=
X-Google-Smtp-Source: APXvYqxPPGBp3KYwUcU6vqfn1qJZSerBLkruC3uBx8UzrQIyDAYRD458ao+PQYaeLP+w76nr1cOfng==
X-Received: by 2002:a05:6830:15d7:: with SMTP id j23mr1517474otr.357.1580347494042;
        Wed, 29 Jan 2020 17:24:54 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id v10sm930917oic.32.2020.01.29.17.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 17:24:53 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/amdgpu: Fix implicit enum conversion in gfx_v9_4_ras_error_inject
Date:   Wed, 29 Jan 2020 18:24:35 -0700
Message-Id: <20200130012435.49822-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

../drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c:967:35: warning: implicit
conversion from enumeration type 'enum amdgpu_ras_block' to different
enumeration type 'enum ta_ras_block' [-Wenum-conversion]
        block_info.block_id = info->head.block;
                            ~ ~~~~~~~~~~~^~~~~
1 warning generated.

Use the function added in commit 828cfa29093f ("drm/amdgpu: Fix amdgpu
ras to ta enums conversion") that handles this conversion explicitly.

Fixes: 4c461d89db4f ("drm/amdgpu: add RAS support for the gfx block of Arcturus")
Link: https://github.com/ClangBuiltLinux/linux/issues/849
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
index e19d275f3f7d..f099f13d7f1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
@@ -964,7 +964,7 @@ int gfx_v9_4_ras_error_inject(struct amdgpu_device *adev, void *inject_if)
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
 		return -EINVAL;
 
-	block_info.block_id = info->head.block;
+	block_info.block_id = amdgpu_ras_block_to_ta(info->head.block);
 	block_info.sub_block_index = info->head.sub_block_index;
 	block_info.inject_error_type = amdgpu_ras_error_to_ta(info->head.type);
 	block_info.address = info->address;
-- 
2.25.0

