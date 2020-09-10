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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A90C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7DD92076C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFEjsz6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgIJRGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgIJRFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:05:52 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C793C061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:05:52 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id w12so6803432qki.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kX63D1UHED1kS8hbCxUzu+mEWg7ZHS1VFvzltaxjL10=;
        b=KFEjsz6dsif7THN645xuBX/Te4+yd6MQ/TqEo10SYpgYzr6PqmPiUvOnofhZTm8pLJ
         i1MSGyiUENF2fRYa4g7GQyXxK3QGxk0ORzFvLkYrquAF92ONVfZSpirXIun2NYHPJjA/
         SklQ2A5KYMnTEbIBXPvILYPo87Bh4Mtyif+RUApWr4mGX9fMK0BgMEh72V8C35BkVVhZ
         k6gq97Fv/tAkKyUTFXItuHq5Xp4FrAITe3pZgmcixtymxAzJAZFpbtyXIUMfeWKHaCmU
         GUojq/Qd0HEpx0bdDj14qXy97BfhZsdn85u6NEhuJddW8wrCVxfshFetMeUfhMjEgqlG
         43Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kX63D1UHED1kS8hbCxUzu+mEWg7ZHS1VFvzltaxjL10=;
        b=UV9sEMZPWjcV0k0OAh1vW4A6EOHJcH8hQmqfqukBpbrOJ+XK/H6f/ml5YcosuNihtb
         hTTLo0rfB5VzzYVoewhPoZEjnvFV6hKkECiYAbqP22oNoYPxZny0Rlgh+EJtOHaOKeHp
         CNIK68uSRrfftXpO/yYaH51ZDR0vVX33kG+CX8mKHqq9pLvurNbH206xuRSQ7RWipB+3
         UQlbwmtOgQJm33sRhTcSpykuSkEciRYTslQe3/ibi0NrZpEuF/ytD5s4kmaG3Ikwyrn8
         OWnzSgtclJRdaHZKw53AkKlNV7IMN2+5cTBt6lfpdloggIw/V1b+t28j0wQ5RmrRN7dS
         R9Tg==
X-Gm-Message-State: AOAM5315UxRe50XZK9/tgRPnsvWJAoFzUaYDmS2iaYWBTOOo7QUWtWqi
        ymsAZF/dbIRFjmn+Xowuz3k=
X-Google-Smtp-Source: ABdhPJzfkyubjrBmIlbp6+8/VJ+krP7Kmjd4yU/hWgCJgzQjIQ0+RGK4MS0ntgOg5NX5QZvDFILGMQ==
X-Received: by 2002:a05:620a:8c8:: with SMTP id z8mr8748406qkz.63.1599757551410;
        Thu, 10 Sep 2020 10:05:51 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id j11sm6924193qko.111.2020.09.10.10.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 10:05:50 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Eric Anholt <eric@anholt.net>, Maxime Ripard <maxime@cerno.tech>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/vc4: Update type of reg parameter in vc4_hdmi_{read,write}
Date:   Thu, 10 Sep 2020 10:04:02 -0700
Message-Id: <20200910170401.3857250-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns 100+ times in the vc4 driver along the lines of:

drivers/gpu/drm/vc4/vc4_hdmi_phy.c:518:13: warning: implicit conversion
from enumeration type 'enum vc4_hdmi_field' to different enumeration
type 'enum vc4_hdmi_regs' [-Wenum-conversion]
        HDMI_WRITE(HDMI_TX_PHY_POWERDOWN_CTL,
        ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~

The HDMI_READ and HDMI_WRITE macros pass in enumerators of type
vc4_hdmi_field but vc4_hdmi_write and vc4_hdmi_read expect a enumerator
of type vc4_hdmi_regs, causing a warning for every instance of this.
Update the parameter type so there is no more mismatch.

Fixes: 311e305fdb4e ("drm/vc4: hdmi: Implement a register layout abstraction")
Link: https://github.com/ClangBuiltLinux/linux/issues/1149
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

Note, the variable names in these functions do not really make much
sense after this patch but attempting to flip the variable names made
everything feel even weirder. Feel free to rewrite this in whatever way
you prefer, I just don't want my builds to be chalk full of warnings :)

 drivers/gpu/drm/vc4/vc4_hdmi_regs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi_regs.h b/drivers/gpu/drm/vc4/vc4_hdmi_regs.h
index 47364bd3960d..7c6b4818f245 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi_regs.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi_regs.h
@@ -392,7 +392,7 @@ void __iomem *__vc4_hdmi_get_field_base(struct vc4_hdmi *hdmi,
 }
 
 static inline u32 vc4_hdmi_read(struct vc4_hdmi *hdmi,
-				enum vc4_hdmi_regs reg)
+				enum vc4_hdmi_field reg)
 {
 	const struct vc4_hdmi_register *field;
 	const struct vc4_hdmi_variant *variant = hdmi->variant;
@@ -417,7 +417,7 @@ static inline u32 vc4_hdmi_read(struct vc4_hdmi *hdmi,
 #define HDMI_READ(reg)		vc4_hdmi_read(vc4_hdmi, reg)
 
 static inline void vc4_hdmi_write(struct vc4_hdmi *hdmi,
-				  enum vc4_hdmi_regs reg,
+				  enum vc4_hdmi_field reg,
 				  u32 value)
 {
 	const struct vc4_hdmi_register *field;

base-commit: 8c3c818c23a5bbce6ff180dd2ee04415241df77c
-- 
2.28.0

