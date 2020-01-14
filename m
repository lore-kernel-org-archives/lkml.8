Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0CDC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5CE207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDTnAV12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgANJv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 04:51:56 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38717 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgANJvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 04:51:55 -0500
Received: by mail-wm1-f65.google.com with SMTP id u2so12892266wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 01:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o6uF9w8E7yvP5smyAJROwJ+EkA/g5VkgLfeYCPIXr3I=;
        b=VDTnAV12L2Bbd0ejVn5vg+4wqrGQ2jw1FU0q4w6S5SfOA/pSQgUwMHIPlXLgYCix23
         DLkjL77Uu+P9zFktrP1nDLVoQkwLdBQ/lxi4iUo9ZptMwPSkjW8niBEMGOroa7kdBk6n
         jO0ZB887EubI2Z/ocKW6zEqJpnTlUmK/vahNi+RyiZ1fNyuDpt6HIBJdiV7S+C1zP+vU
         yT3os+Zh3XBb7Tfefec/a3EJIfxIvB34/QN5Cjygu/T7sZ6EYmj1j3Q7mVGpIKODvvNC
         8gJ4AH4t2EpFMacL6cMTEkTxzELtqd/P5ab1z7Nyoyy6WitF6sxyf0NcIFuOJ0XTLFvs
         blYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o6uF9w8E7yvP5smyAJROwJ+EkA/g5VkgLfeYCPIXr3I=;
        b=LR9IdNlHtkNt0l4tFcDbc2i1F/U215AnrytmZyIutXw4ND5/Wrk3Z8GTKDOPn66uID
         jXwz7CzDk4X3uplWO6DaWchZ2NOZBuIWqxPKojM4FPbDJrMXQkV+YWjsHf0LAwIsOS3u
         03BemW2WEagcfBqunfJp762S2EO5OBfAI8LbMUblJ2j6n/25PmqIGqs4mi1zY/wWt6az
         01EL40GvbOthRuX/aAJmTwuWuAADDCiPl0lAtf++SLWJWHetDplquo4YDI0GStAm60aD
         WvZ+xEoYsesKKioMZ70L37tUPmbAWXyBFwpLNfVKCh9WR+n7SDQkpcOWSkiqw6cmOXpq
         b9zQ==
X-Gm-Message-State: APjAAAXA23x8kBx5WeurwoLDkWme1TBz/5hjdxacybuLH2qsy0dm2IPZ
        TZAZ7B9KASAzw+PG3N3iESk=
X-Google-Smtp-Source: APXvYqyZHiFMjbaCeOQWHXrv2GRCipiqqF+NyL8v599/nPOW9BBAN3WkCBsROYqWOuXyZ5gZOr8Hpw==
X-Received: by 2002:a7b:c318:: with SMTP id k24mr26656383wmj.54.1578995514255;
        Tue, 14 Jan 2020 01:51:54 -0800 (PST)
Received: from localhost.localdomain ([154.70.37.104])
        by smtp.googlemail.com with ESMTPSA id y20sm17454881wmi.25.2020.01.14.01.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 01:51:53 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] drm/i915/atomic: use new logging macros for debug
Date:   Tue, 14 Jan 2020 12:51:03 +0300
Message-Id: <20200114095107.21197-2-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114095107.21197-1-wambui.karugax@gmail.com>
References: <20200114095107.21197-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to the new struct drm_based logging macros to replace the printk
based macros in i915/display/intel_atomic_plane.c.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_atomic_plane.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_atomic_plane.c b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
index 3e97af682b1b..8cbb29a860a3 100644
--- a/drivers/gpu/drm/i915/display/intel_atomic_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
@@ -183,10 +183,11 @@ bool intel_plane_calc_min_cdclk(struct intel_atomic_state *state,
 	 * must be true since we have crtc_state).
 	 */
 	if (crtc_state->min_cdclk[plane->id] > dev_priv->cdclk.logical.cdclk) {
-		DRM_DEBUG_KMS("[PLANE:%d:%s] min_cdclk (%d kHz) > logical cdclk (%d kHz)\n",
-			      plane->base.base.id, plane->base.name,
-			      crtc_state->min_cdclk[plane->id],
-			      dev_priv->cdclk.logical.cdclk);
+		drm_dbg_kms(&dev_priv->drm,
+			    "[PLANE:%d:%s] min_cdclk (%d kHz) > logical cdclk (%d kHz)\n",
+			    plane->base.base.id, plane->base.name,
+			    crtc_state->min_cdclk[plane->id],
+			    dev_priv->cdclk.logical.cdclk);
 		return true;
 	}
 
-- 
2.24.1

