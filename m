Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C1EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D484206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QGMjHJlQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgGGKRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbgGGKRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:17:18 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8604DC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:17:17 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z13so44551976wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EXLqTyUKMLj4M51ntYR1QA4V9xA1YrzmuNUETaX0PBA=;
        b=QGMjHJlQ9LWikvX6Na5JwK9UPUmF/DNUlzfwClDFWUzxLNI3vHyW3hm6xlfswr2AV8
         wkFMnZoIWoQ8W/vbLtLairtyr3oUjXlaXBn79y60eIPJCInMUGmqhIwj5oH14AoPyTuW
         PpuseWJtIwwqJ+wYUvHy5dH0KlMSlu3UwlLaMIwhi5Ru3QdAjHI0pt0KyOvCYdK+XJuB
         g5A8bJoPOmMZSw0D/+fiy6siWxtEreitU2khKnrX6y7K+Wbf/i7VhqyVGk1Vfn7qfBdZ
         zdC4l9jK22GpHnEbOHuseblQoFf5gMl+OxkiwHcQ/RKvu1QoDmvGzarx+CMpe8vRPBXe
         tr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EXLqTyUKMLj4M51ntYR1QA4V9xA1YrzmuNUETaX0PBA=;
        b=dwAYJNAmcDrA/z6dZEcGjqE/uI7z5zU9cP8JaJ9QKfoo+N3q8gRYSOR0IOQhEX8BgH
         oNY+c/ZpOGCLakvZtVZPgq6vdaDOfqcPnu2go9UO25Try+7N2Ur7Go3kJrffESJbP7uW
         IwgP8RGUhNpN/84YzEltH2cj72nYeDxOmWg7y6GiucEEU/52SXR+CFBSCOUOI6dozagX
         gezPjdsvFLKDgc7VkQMfWwsBVOjo0Ya2mUF667lBWIGVCmzNwPPnlXd5se0Jy9ayv5P1
         J3ka/jdX0XzhFGIcGAaY244aQKYNQsCwuv0zLhsp4t/dNHevbkYgJEgCAyeG3Glqp11+
         OPrg==
X-Gm-Message-State: AOAM532ZvXddl1Bl7yao4o6Lfub4RAZHamr9k3oMznR5nb5qd/zcpWt/
        uccHRejcZVZE/uyJHt9A6DtEcQ==
X-Google-Smtp-Source: ABdhPJxqAC3BtmcDgPQdVNfB2mynSSt1Kjfhgyv7zPY1kPqaosnB4BBwP2w2zFQNZfEfX5SODLsnZw==
X-Received: by 2002:adf:dfd1:: with SMTP id q17mr50235597wrn.94.1594117036243;
        Tue, 07 Jul 2020 03:17:16 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id z8sm469409wmg.39.2020.07.07.03.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 03:17:15 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Richard Purdie <richard@openedhand.com>
Subject: [PATCH 23/28] ASoC: soc-ac97: Demote seemingly unintentional kerneldoc header
Date:   Tue,  7 Jul 2020 11:16:37 +0100
Message-Id: <20200707101642.1747944-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707101642.1747944-1-lee.jones@linaro.org>
References: <20200707101642.1747944-1-lee.jones@linaro.org>
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

