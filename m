Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD85C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 04:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 662BF206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 04:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MttvtiJA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgGPE2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 00:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgGPE2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 00:28:08 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C6FC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 21:28:08 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 80so4360096qko.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 21:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M/DmHETZOAY7H70Ux+TlQEI0fnuJDUnsXDXca6tT46g=;
        b=MttvtiJAL/Z4cy1qvGZG6Fln4g0zsBEgJIxXkKsC5wdcZx5VUygmatZNCIGxxsU5mk
         YxAFJdhdO4N+HPCFbCjs3j0W/ECegXrJRvfaxzgzZU4DTbw99XWQrvLjfsBMxgMiWN06
         z3Ouhbx4RtJrgLFfurVRxZAEd+/+SDC/JI0INOUTHf01E8uE6CclPefOiZ9qZyMgjhYP
         W/F6ULpN4aoc6gcBYcd21XIUMrmqJIDTX091uoovWUBKDFm+21OsblbEvkoNFb/jzA5f
         GzQzQoHCnoG72CVLGShWNmtt98ZqsyeA5UJgeE0votEVQqDXRN8kq6lyBRDxrWD3v8xg
         Ro0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M/DmHETZOAY7H70Ux+TlQEI0fnuJDUnsXDXca6tT46g=;
        b=qZcpH/PNbN/HMY29hm+KgOgkUiFBEWoN1KORkfuGRlD+A0tox9fc016YWfE6zLAz/b
         N3tgZWaxs/ezNU40/nWQlUD9iq7cyrVG5jz0/OrUI7pVgaKmnf0Y++sDoVb1UOIhc/cC
         4kz3OMOrcG0+sayO5BNERDorff+A98kbCri7iDbsWekgwPpJZ3jaf8CQGdANLYtGVgNF
         zzkSAP2jE7b/+zbXV2GPgMiBngU6NO9qaKB3xhRwah2hud8PPGJ+EbDQBHlB/jR4Ls8l
         /UK9PeOL0x4xpbooYmGSX5E6lCcBY6BbgIUctSv72fwb2HbaoRhgPhUEONpw3UskHEca
         48xA==
X-Gm-Message-State: AOAM5333HgG8uvvQoc722X6mckg4i5eN1vJ1JODMQJWtBOksjxKnoINS
        LNmhXmxzUhBsEw7guYbzSX0=
X-Google-Smtp-Source: ABdhPJyqZ06OE7DJZF6oZZcBoK379ofd//uSbRPcAsHFWSjy6GHaa3/nYk1wRYFZasP51XtjA7fXvg==
X-Received: by 2002:a37:9b08:: with SMTP id d8mr2291995qke.105.1594873687122;
        Wed, 15 Jul 2020 21:28:07 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id 79sm5466778qkd.134.2020.07.15.21.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 21:28:06 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/i915/display: Ensure that ret is always initialized in icl_combo_phy_verify_state
Date:   Wed, 15 Jul 2020 21:27:42 -0700
Message-Id: <20200716042742.123169-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.28.0.rc0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/gpu/drm/i915/display/intel_combo_phy.c:268:3: warning: variable
'ret' is uninitialized when used here [-Wuninitialized]
                ret &= check_phy_reg(dev_priv, phy, ICL_PORT_TX_DW8_LN0(phy),
                ^~~
drivers/gpu/drm/i915/display/intel_combo_phy.c:261:10: note: initialize
the variable 'ret' to silence this warning
        bool ret;
                ^
                 = 0
1 warning generated.

In practice, the bug this warning appears to be concerned with would not
actually matter because ret gets initialized to the return value of
cnl_verify_procmon_ref_values. However, that does appear to be a bug
since it means the first hunk of the patch this fixes won't actually do
anything (since the values of check_phy_reg won't factor into the final
ret value). Initialize ret to true then make all of the assignments a
bitwise AND with itself so that the function always does what it should
do.

Fixes: 239bef676d8e ("drm/i915/display: Implement new combo phy initialization step")
Link: https://github.com/ClangBuiltLinux/linux/issues/1094
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_combo_phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_combo_phy.c b/drivers/gpu/drm/i915/display/intel_combo_phy.c
index eccaa79cb4a9..a4b8aa6d0a9e 100644
--- a/drivers/gpu/drm/i915/display/intel_combo_phy.c
+++ b/drivers/gpu/drm/i915/display/intel_combo_phy.c
@@ -258,7 +258,7 @@ static bool phy_is_master(struct drm_i915_private *dev_priv, enum phy phy)
 static bool icl_combo_phy_verify_state(struct drm_i915_private *dev_priv,
 				       enum phy phy)
 {
-	bool ret;
+	bool ret = true;
 	u32 expected_val = 0;
 
 	if (!icl_combo_phy_enabled(dev_priv, phy))
@@ -276,7 +276,7 @@ static bool icl_combo_phy_verify_state(struct drm_i915_private *dev_priv,
 				     DCC_MODE_SELECT_CONTINUOSLY);
 	}
 
-	ret = cnl_verify_procmon_ref_values(dev_priv, phy);
+	ret &= cnl_verify_procmon_ref_values(dev_priv, phy);
 
 	if (phy_is_master(dev_priv, phy)) {
 		ret &= check_phy_reg(dev_priv, phy, ICL_PORT_COMP_DW8(phy),

base-commit: ca0e494af5edb59002665bf12871e94b4163a257
-- 
2.28.0.rc0

