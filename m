Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EF2C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 21:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFBA720663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 21:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vS3P/SI7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732700AbgCPVRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 17:17:04 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36468 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732636AbgCPVRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 17:17:04 -0400
Received: by mail-qt1-f195.google.com with SMTP id m33so15627405qtb.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 14:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6FuZZoVTFoFF+1kD/gUu0wVHL7she4RE1ISWVv5X9/Y=;
        b=vS3P/SI72Ul6DR1lMgGssHto6g2grnX9qlthgAH3MQfmuXC8X32mBEV5vRMILYFoOq
         4onAUSdTQuBwhU0RuSci5/PTf1r4JBaUP8Pw0DyYOWja6pAkXMATZKnLyjyFZEGi+GA/
         eCDQlvBCRoEzFSHEzjyIod/Hajg3WiKRzy1Y3Ojd8TGeVi2RTyLkv2JxJXW+vsx5GDYY
         WNg2Xvb6E7w7rb+ylM+6oO9aGCkI3rJhKrXAXeRNMiFn7ivrSzDCkzvRnvwc/qzEBWn0
         IBtQ02xNfhoR+D4fAsK7NATVfiG+qj8CTzFQe2nPxlmTI1GBmzEoljvP0picHIgld4qx
         JMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6FuZZoVTFoFF+1kD/gUu0wVHL7she4RE1ISWVv5X9/Y=;
        b=todTUXSikuT5uvwwyw6aoOlAXbkO85qaqVIc5YoUYfNrFExAF6IKF7oPmSBYFHG/j8
         RfbFEFeQbk6b4rAyHrNYrGrFUZkM+sfNcVlkMXCyCudHy0xFQz1SM+gsPEHJsiPfeAg9
         RapAp1+rB1IPiqNA/fxX2EXAqcKy1YN7ah9X7jH8aKTmxPGQY2dMfKDomMdvFZcCygX6
         2xjlOnKSWS2dpRhvIZpMIHDDGL7HpAZIe54uLQwMvVv2KyWxdwcRnWc5G6bOKHhnbJR4
         5DPGzMLDyEK0HdvgBiTL/2Phvdz0n+VMXtQuuHyc4ZeQ+HmgN2gM9/b1jl0p4DtCMuwg
         puDw==
X-Gm-Message-State: ANhLgQ3k5f0e51KuFNGW3mK5EOoT0kyHyMvfXFkzCmWEkGWPVnRrCqNg
        E03XNhTYMHwlKP+AWBc+utE=
X-Google-Smtp-Source: ADFU+vvhoV+Um0FzZrMDfLcuJCaJUEsDuGqA2Mhz9ejyhF6zsDn0DKV3vmnWwROYKPClMo1LTYQOsA==
X-Received: by 2002:ac8:481a:: with SMTP id g26mr2174747qtq.267.1584393423506;
        Mon, 16 Mar 2020 14:17:03 -0700 (PDT)
Received: from localhost.localdomain ([179.159.236.147])
        by smtp.googlemail.com with ESMTPSA id p23sm579055qkm.39.2020.03.16.14.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 14:17:02 -0700 (PDT)
From:   Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        sumit.semwal@linaro.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        Rodrigo.Siqueira@amd.com, rodrigosiqueiramelo@gmail.com,
        andrealmeid@collabora.com
Subject: [PATCH] Staging: drm_gem: Fix a misaligned comment block
Date:   Mon, 16 Mar 2020 18:15:53 -0300
Message-Id: <20200316211553.2506-1-igormtorrente@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a checkpatch warning caused by a misaligned comment block.

Signed-off-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
---
 drivers/gpu/drm/drm_gem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 000fa4a1899f..6e960d57371e 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -222,10 +222,10 @@ drm_gem_object_handle_put_unlocked(struct drm_gem_object *obj)
 		return;
 
 	/*
-	* Must bump handle count first as this may be the last
-	* ref, in which case the object would disappear before we
-	* checked for a name
-	*/
+	 * Must bump handle count first as this may be the last
+	 * ref, in which case the object would disappear before we
+	 * checked for a name
+	 */
 
 	mutex_lock(&dev->object_name_lock);
 	if (--obj->handle_count == 0) {
-- 
2.20.1

