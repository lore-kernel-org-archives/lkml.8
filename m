Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54008C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E461C214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNcWA/DM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgIJRT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgIJRSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:18:48 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A008C061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:18:48 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id q63so6074179qkf.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KOPXfJ4o+30xKb8orSC8RLivwhkM6sb3eQ91eOmY0Vo=;
        b=gNcWA/DM9IKpsqtMRdGgyqQBa8ngfSU0q04kaiB/amfRI5odcxESYG9avLfaext3aR
         MTBhV7S0tIkeb6rvVo/oM4QNgeAnZobe2glDYt3akPElqv7scj9/BCIuGRH8BOwLKgHC
         8T7CvZ3siJpvaw1VkA9fqbjVSW5pMMp03K2VOVLo344lOlhMt+OwM3PKI5+zMDyQj14Z
         bIf0x2ixTqcKpb+zjZPuNYb3mhvU/fYE8w0QWQ2XvytuC4yuU0KeDHHKz6nsOBLyWQiY
         xIvGAS3BHP9rpF6YcHRcpDs3TuLpEYX8sQN4TzTLBWQ8xqTvLYevBPB9zqAYKqgDCbWm
         uSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KOPXfJ4o+30xKb8orSC8RLivwhkM6sb3eQ91eOmY0Vo=;
        b=HNN3r1O6DC3n7xWSr/CpBPJeBMHeVQNbF8ySukHZk8iKPIgHV/8B7bXehHb+X+Fv4l
         rvzHCf2JAZRlFGeOiUvwjizXhcQzrhvJwPHe+dr8KDAt3m9sjf584qU9GTJP0TvMzqFK
         tgDKTWCxisKgqpdvheqs96imgi8ao5MuBd3N8BOgz4ayaJ/IrNLbCXt/3h075T6VYKrK
         cNbsBVrOzDWesq3cWV8xKInMPIcu2Cycu2sjQo7irbRSq9VKeBSmPykdaASAhu/eU8Qh
         ggG3oXtLZe3X12YgGQGB7qgzQuNf28Bb2sO6Y2GOgywE7QmcJ8pWLX+lMGRk8jknTa1O
         9r+w==
X-Gm-Message-State: AOAM531p2zcLS1ax6crUOmSsfR6gNg9+ZVtyvJ6FWd+/aBYv3aW3wIyz
        K54d6knudETdxmPsJXx/gGc=
X-Google-Smtp-Source: ABdhPJxwB25vHPpgRsVbfVcHXlqygPLmZlVsqyZuhSN4fHMZ/F6hTxWL8F5aoBE4JZF8QQlHp/ZDzw==
X-Received: by 2002:a37:b347:: with SMTP id c68mr8956861qkf.430.1599758327484;
        Thu, 10 Sep 2020 10:18:47 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id a25sm7370452qtd.8.2020.09.10.10.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 10:18:46 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Eric Anholt <eric@anholt.net>, Maxime Ripard <maxime@cerno.tech>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/vc4: Fix bitwise OR versus ternary operator in vc4_plane_mode_set
Date:   Thu, 10 Sep 2020 10:18:32 -0700
Message-Id: <20200910171831.4112580-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/gpu/drm/vc4/vc4_plane.c:901:27: warning: operator '?:' has lower
precedence than '|'; '|' will be evaluated first
[-Wbitwise-conditional-parentheses]
                                fb->format->has_alpha ?
                                ~~~~~~~~~~~~~~~~~~~~~ ^
drivers/gpu/drm/vc4/vc4_plane.c:901:27: note: place parentheses around
the '|' expression to silence this warning
                                fb->format->has_alpha ?
                                ~~~~~~~~~~~~~~~~~~~~~ ^
drivers/gpu/drm/vc4/vc4_plane.c:901:27: note: place parentheses around
the '?:' expression to evaluate it first
                                fb->format->has_alpha ?
                                ~~~~~~~~~~~~~~~~~~~~~~^
1 warning generated.

Add the parentheses as that was clearly intended, otherwise
SCALER5_CTL2_ALPHA_PREMULT won't be added to the list.

Fixes: c54619b0bfb3 ("drm/vc4: Add support for the BCM2711 HVS5")
Link: https://github.com/ClangBuiltLinux/linux/issues/1150
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/vc4/vc4_plane.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index 24d7e6db6fdd..89543fa8ca4d 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -898,8 +898,8 @@ static int vc4_plane_mode_set(struct drm_plane *plane,
 		vc4_dlist_write(vc4_state,
 				VC4_SET_FIELD(state->alpha >> 4,
 					      SCALER5_CTL2_ALPHA) |
-				fb->format->has_alpha ?
-					SCALER5_CTL2_ALPHA_PREMULT : 0 |
+				(fb->format->has_alpha ?
+					SCALER5_CTL2_ALPHA_PREMULT : 0) |
 				(mix_plane_alpha ?
 					SCALER5_CTL2_ALPHA_MIX : 0) |
 				VC4_SET_FIELD(fb->format->has_alpha ?

base-commit: 8c3c818c23a5bbce6ff180dd2ee04415241df77c
-- 
2.28.0

