Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E501FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 13:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35AD2070C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 13:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuo9yXLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgAUNqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 08:46:12 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40679 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgAUNqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 08:46:11 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so3242090wrn.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 05:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=wAY0nGub2moizimjMlOKmqPi5sNjGPoo+Z284BPsaCc=;
        b=cuo9yXLBGjziwDj/A6x10/sKWHDeExpaLuKbn3FeIY5k3mb1BtbvglgOkkpJ27c7jz
         0JDueHaFQXwH2bylKo4sH64kO80d4iKVyTd6+LFNX3BhvAIoNUY8SmXfTiUvyidxetPM
         LCh7mlc4tgsY07y1O+HJs009/v2Gffy3q0Zzci8bbmOp5cfY5mB673j6DHsbAgMTRbMv
         LQeY5vrx4vKmg5uYfHEYPHU1b+TjlmjcDiHwZXBPF5Ml5UXcQ+VyGbRkJe4DeRg1qQ73
         simo3o6HgJMPU9iSLG8HtXpvWBwn/va5w5By/Lj2H5S1FQQmBXRIipulGs3uevG1nqYv
         mhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=wAY0nGub2moizimjMlOKmqPi5sNjGPoo+Z284BPsaCc=;
        b=Z28TF7nm+071MydQcxlXB7t+y+/EJdhj/FiE3UqLDiemsA5VuZHBogXjPrYz39Hjhj
         63dPHaazXjprNPMQNk2yTf10wsF4URKTuUrb8qh9jpEJww0pj4zxCKDme31/F/txP8mq
         PEsTyUpV7U2AJYEOecOgxtVnodZRLMEVZ1Qm1kBy5vR168d4k1yuUGXOY9POgxc+tZCZ
         3jO1xGrpEXa+gbp3vW8j/Cv5p12Y7O1zRRqCoDQX/5LQ6uANti8c/3NNKRCSKfi6AMWg
         at1W6VULnvCbFvkpD7O/CBqd2t0kNTHcM2aESb5ZcpjRQRBWt9z6DeakYMMaQ96nrIIn
         E7AA==
X-Gm-Message-State: APjAAAXLhRqZy6e/3xVnEAw/XL1StWjgPBr4EV3i+3faHkvlEipE+kNf
        cpKQYBUigAmgIctdolnwY9A=
X-Google-Smtp-Source: APXvYqwM+GcOM1c9G2LksV3HvuxQf28J4FTXh6Lj7WmD431sO3LHrradtTe08HLQBb5B96WUcsT2yQ==
X-Received: by 2002:a5d:640d:: with SMTP id z13mr5181359wru.181.1579614369515;
        Tue, 21 Jan 2020 05:46:09 -0800 (PST)
Received: from localhost.localdomain ([197.254.95.38])
        by smtp.googlemail.com with ESMTPSA id x17sm51590093wrt.74.2020.01.21.05.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 05:46:09 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] drm/i915/atomic: use struct drm_device logging macros
Date:   Tue, 21 Jan 2020 16:45:55 +0300
Message-Id: <20200121134559.17355-2-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200121134559.17355-1-wambui.karugax@gmail.com>
References: <20200121134559.17355-1-wambui.karugax@gmail.com>
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
2.17.1

