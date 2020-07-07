Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50078C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26AE420738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o5qFIiE6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgGGOi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbgGGOiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:38:20 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9980AC08C5E1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:38:20 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j4so42988549wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EXLqTyUKMLj4M51ntYR1QA4V9xA1YrzmuNUETaX0PBA=;
        b=o5qFIiE60x8cX+Bhm0rgzWF0oy0LXLTwf++5sVrWU5JMR62946RZ49b2fud+ahUxan
         M3fyhMHkqfpuyZPTvDJ6FLSUfLQZSmxONDGQ5cEbwEnAEEIlIjX/w+B9YHhPuaO/ydBR
         +7G31bbUN/ChKb43mdklUoqkHM2wTxewBYKlrV8Ic+LjI5zxU0xnw/9ps3p7Q/IYFkZC
         bSPRlsbBl90eqE1Wrcaad9xHV1OArmn3GcJA4JxXnmZq9Z8XjsfwdVfYMJFL+IbYyqIP
         ghwioQaNbFCOyXYEV0SfC7uV+2lls7XmQ01d5xuzA3RjuI1uH+nHX6DtiKjxfhFRljqM
         ec+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EXLqTyUKMLj4M51ntYR1QA4V9xA1YrzmuNUETaX0PBA=;
        b=mOu27x+XB2kz+EdvtxwdEKlRWENP75qYcPUHv2O3wByWEXdTSBlpcfmvIudQF3+1Bk
         vWl4A1tvouAijyDQ9Co31kMf2AX7AycD9YduLiqnjjXGeN1pGHQJI2MmkJbXDypkBkpE
         SZ6qEoQ5Sjbswl8HZZ6HBDMPrE92P6OebtqaPxknX4K033QZ9He2fHcgaAQBJFclVylb
         n/8BcyWR9KLC+7ma3c067w/utsgBeIQbPOqjQsQIH7yx8Q+JzT3NtEygkZ2MOGglwQa0
         5qSif3nbeUQFBe/yyRPAOfnba1A/8fFuZxjFiOsg9G4hQFQXUhhYuazxNxc9t/xy2Dva
         gHjQ==
X-Gm-Message-State: AOAM530l0XscMBEL4Vqnv6R8Amvw0yA6as35Zf5JHfFbg+HIGIGtWFD5
        P3/Ylife0VBNFa3mEQzHf71tyA==
X-Google-Smtp-Source: ABdhPJyRMAvI6NkTDV7IWsTK5HtfFZ6l9B/O82Lz0Ooky54tkmtjUVeL9Ss/7Rr8kNE7uRm+HvYhCg==
X-Received: by 2002:a05:6000:6:: with SMTP id h6mr53076969wrx.26.1594132699386;
        Tue, 07 Jul 2020 07:38:19 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:38:18 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Richard Purdie <richard@openedhand.com>
Subject: [PATCH v2 23/28] ASoC: soc-ac97: Demote seemingly unintentional kerneldoc header
Date:   Tue,  7 Jul 2020 15:37:37 +0100
Message-Id: <20200707143742.2959960-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707143742.2959960-1-lee.jones@linaro.org>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the only use of kerneldoc in the sourcefile and no
descriptions are provided.

Fixes the following W=1 kernel build warning(s):

 sound/soc/soc-ac97.c:402: warning: Function parameter or member 'ops' not described in 'snd_soc_set_ac97_ops_of_reset'
 sound/soc/soc-ac97.c:402: warning: Function parameter or member 'pdev' not described in 'snd_soc_set_ac97_ops_of_reset'

Cc: Richard Purdie <richard@openedhand.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/soc-ac97.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-ac97.c b/sound/soc/soc-ac97.c
index 906106ed8ca14..af789552a9d4c 100644
--- a/sound/soc/soc-ac97.c
+++ b/sound/soc/soc-ac97.c
@@ -391,7 +391,7 @@ int snd_soc_set_ac97_ops(struct snd_ac97_bus_ops *ops)
 }
 EXPORT_SYMBOL_GPL(snd_soc_set_ac97_ops);
 
-/**
+/*
  * snd_soc_set_ac97_ops_of_reset - Set ac97 ops with generic ac97 reset functions
  *
  * This function sets the reset and warm_reset properties of ops and parses
-- 
2.25.1

