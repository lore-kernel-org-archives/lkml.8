Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60228C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 394B620738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FTcBBZsq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgGGOiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbgGGOiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:38:05 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1064CC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:38:05 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o8so43522645wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j306gyjagAnal9NO9hxv+ks7W0GYhjttqc5twDw7Zos=;
        b=FTcBBZsqkkNyUiAEpUDu2DT5/rR3PslRgh6m1YKkzbz2J2rpneHY37t/nxabjcduOr
         gFpeKCRREntWYiNYwmQ+uKkEMazFirg1ZNU/cmmI4C7jpYoSc1olPXZ1sizl7lkRsLkf
         /4So5bw/2TFBGWv1+MLgv5qn3xjO3RoztYcGXwbzdet0CQ9Ead2vkTjRE7fg1lw+do7F
         nxEQ7I2WCsPjvvyLDEBdAIfdMqXKXTnSfGeD72rM+AN1NSxPq5h9ciIEl8AC3BkYQwk6
         iQBz5laqp3uH0sKSuBXp7ZESiTIl7iXRSU399b8zxklirEQXK/G4bzEyRxmSetYgIgyp
         3sPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j306gyjagAnal9NO9hxv+ks7W0GYhjttqc5twDw7Zos=;
        b=JDlGS+UBnVMXZ36dYtkSKMU8tBWCrnML76xl7JrEYRju707SMNF+3Zfv2KCIT9FyaT
         SSCrkh7nOohAoufwIZDfmpep9G+9dneiMeKtpBL5zlLdXeQsjvcz5+UacgjDSFGV/23q
         maERZ+6Xgl1KRx7ITDHMieznKPn2HTWlNxzf3tPu7hXxXollQogisU+5WjDiH+kT9NX3
         F09BOL6BSkaxZeztwOVfB9BLhf9J301T+sJ4aZ0fBPInaPGpOXP/oBwVwiS3Yo42yeUu
         9zVNGgGQ1qy4G7R+7SYFWsogtrnqS4qmxXbKVhy7eUGbjZfae1uLFV7af/XgsSYanuQF
         IfTg==
X-Gm-Message-State: AOAM531pHO3DuQInJBOYtUDj+M9BJhCOayA0bOyTmDbXEdQcwD6k/g5K
        6cW3GIyX7MuD89tI1tQeQgvJXg==
X-Google-Smtp-Source: ABdhPJxKLiJn098g+A6y4NWEb4pZx+Ro+yEniW+fCbR/jJLf8gPOa1nqxsmv9r9NEk9oYPOgaUjfxQ==
X-Received: by 2002:a1c:2485:: with SMTP id k127mr4431876wmk.138.1594132683827;
        Tue, 07 Jul 2020 07:38:03 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:38:03 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v2 11/28] ASoC: pxa: pxa-ssp: Demote seemingly unintentional kerneldoc header
Date:   Tue,  7 Jul 2020 15:37:25 +0100
Message-Id: <20200707143742.2959960-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707143742.2959960-1-lee.jones@linaro.org>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the only use of kerneldoc in the sourcefile and full
descriptions are not provided.

Fixes the following W=1 kernel build warning(s):

 sound/soc/pxa/pxa-ssp.c:186: warning: Function parameter or member 'ssp' not described in 'pxa_ssp_set_scr'

Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/pxa/pxa-ssp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 6a72cc1665b7c..d1e09ade0190d 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -178,7 +178,7 @@ static int pxa_ssp_resume(struct snd_soc_component *component)
 #define pxa_ssp_resume	NULL
 #endif
 
-/**
+/*
  * ssp_set_clkdiv - set SSP clock divider
  * @div: serial clock rate divider
  */
-- 
2.25.1

