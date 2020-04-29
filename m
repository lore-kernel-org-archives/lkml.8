Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A477BC83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 810F220731
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXsmR3gG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgD2DCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 23:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726522AbgD2DCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 23:02:16 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7224C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 20:02:15 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id r66so525332oie.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 20:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vat/A+5wAq17/5/tk88DCdniaj1GWzYrag6w3vBmDBk=;
        b=MXsmR3gGPgc/++kp1hntr5cCxudY82uhEJERwYydQonzsULfllXVQPX6adl0wfHxCR
         hN6XVdnbVjjxXY2qQZMkskbIdxMo0H0h1Vdo0c8HFek4FtH+stf1cTeAGtt1XayCTVNS
         ymmyBQaT50MAq2bWzATfqIlepoWQDKOQp5XpiaFvtzaIaeNw5AcFve7Heu0cL/JSsInO
         bzcbGgJDT2SChMtGsLWO3JK8QxWlImqiVnHx4o5mHnWuBZiBXVBxy4TJ9JEXWSXwKzPr
         +xrDm+pvPlYWWfdzamcZHFa1yGp89tCY6y86l7biE2VA4VAE+/znnWga31lPSHWhQQcf
         PI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vat/A+5wAq17/5/tk88DCdniaj1GWzYrag6w3vBmDBk=;
        b=oWMzUr8aJV2uYk+JUnJ/ww/uJOZFb7d1QQqZlgk13QmvIcA72pkt5uRkYRk1VecP/j
         fYpMzYyvjUQXGGn0Mk4lx9fP1j6hSNUpbHNI4IGaHYQKP0H1mtacBEYS1BIdd2ifp7QK
         7U7TqxWygadLrGeCdAHOrgYRz0O1Fe1iqmf3fGsyz87R75+yRqfNZl+61Uydfbx5ZvCD
         u4qx84nWHgSrHBeCn5fN9wICUbqbfwyQeOVfx5xov9iS6r54v8h5sj8Svq/O7fHrfRKY
         5RK3z7tSpFvGwuisHYcA7+a/mSvjPPlgGdN6+2XWflNOPvPnRPAtJjy4aP5RemcJ4YuZ
         sP3w==
X-Gm-Message-State: AGi0PubxfsR03xBUxzsrO4cl6qWAh9BJgMOwer0+B5d2VpLyLvHy9aVI
        7thPcN+koTTsDRqRpxijgYo=
X-Google-Smtp-Source: APiQypK+U07j9oOnyToDeRg0xLGngsqomu6PGJKgQyDCGupw7N9RnvAMb2gAndIHHsn3o5VFfOujVg==
X-Received: by 2002:aca:fc0a:: with SMTP id a10mr323869oii.77.1588129335074;
        Tue, 28 Apr 2020 20:02:15 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id m189sm4262046oig.12.2020.04.28.20.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 20:02:14 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/i915/gt: Avoid uninitialized use of rpcurupei in frequency_show
Date:   Tue, 28 Apr 2020 20:00:52 -0700
Message-Id: <20200429030051.920203-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with clang + -Wuninitialized:

drivers/gpu/drm/i915/gt/debugfs_gt_pm.c:407:7: warning: variable
'rpcurupei' is uninitialized when used here [-Wuninitialized]
                           rpcurupei,
                           ^~~~~~~~~
drivers/gpu/drm/i915/gt/debugfs_gt_pm.c:304:16: note: initialize the
variable 'rpcurupei' to silence this warning
                u32 rpcurupei, rpcurup, rpprevup;
                             ^
                              = 0
1 warning generated.

rpupei is assigned twice; based on the second argument to
intel_uncore_read, it seems this one should have been assigned to
rpcurupei.

Fixes: 9c878557b1eb ("drm/i915/gt: Use the RPM config register to determine clk frequencies")
Link: https://github.com/ClangBuiltLinux/linux/issues/1016
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/i915/gt/debugfs_gt_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/debugfs_gt_pm.c b/drivers/gpu/drm/i915/gt/debugfs_gt_pm.c
index 3d3ef62ed89f..f6ba66206273 100644
--- a/drivers/gpu/drm/i915/gt/debugfs_gt_pm.c
+++ b/drivers/gpu/drm/i915/gt/debugfs_gt_pm.c
@@ -336,7 +336,7 @@ static int frequency_show(struct seq_file *m, void *unused)
 		rpdeclimit = intel_uncore_read(uncore, GEN6_RP_DOWN_THRESHOLD);
 
 		rpstat = intel_uncore_read(uncore, GEN6_RPSTAT1);
-		rpupei = intel_uncore_read(uncore, GEN6_RP_CUR_UP_EI) & GEN6_CURICONT_MASK;
+		rpcurupei = intel_uncore_read(uncore, GEN6_RP_CUR_UP_EI) & GEN6_CURICONT_MASK;
 		rpcurup = intel_uncore_read(uncore, GEN6_RP_CUR_UP) & GEN6_CURBSYTAVG_MASK;
 		rpprevup = intel_uncore_read(uncore, GEN6_RP_PREV_UP) & GEN6_CURBSYTAVG_MASK;
 		rpcurdownei = intel_uncore_read(uncore, GEN6_RP_CUR_DOWN_EI) & GEN6_CURIAVG_MASK;

base-commit: 0fd02a5d3eb7020a7e1801f8d7f01891071c85e4
-- 
2.26.2

