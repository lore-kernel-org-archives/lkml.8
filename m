Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFADC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 881242073E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="igUVII5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgGGQha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGQg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 12:36:56 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6CDC08C5DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 09:36:55 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z2so23620152wrp.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 09:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=89ssfiDaoOJSnjV248d4sDefUT+7TO0HxUeigRg/Xi8=;
        b=igUVII5dZ2G5KVSukaILRqxVMXxGWlzOmIIK0fjLv5HWnWKekkDNcTXX9hPb1wQwN8
         FTPapeYqOVja2FGOzgs/K81A9eNNe7LdIa2R0rAWj8EssShRgcuphy6vBK/RVDUMJ4ID
         afHei0QePdDSFkpA1Bww2imqh2kbl+5qYpaIq3qicJkR0QAhQ1FD3+pMWVzTqe4+da1z
         1dcLS0wHxrbYzxAjc0SaOoUDlFoh6wL02xIuEffBjmsJocDi2vudx04v9ZV4BXNvBVqP
         Z+ItAR+E3tjX64F0bLJGf3BjW7DeGbI8MUh+OAV+U9eiUsexu89nvkg0yvy+eFnSKIjP
         CQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=89ssfiDaoOJSnjV248d4sDefUT+7TO0HxUeigRg/Xi8=;
        b=XYjQVeOAz36oaXX8hnmj+ig8g7DfYf/9fwl22XbFcnbrXdDUabNksDRItGHrxzx8XT
         OYqD1oQhTnIJewRQ1zghZVciI1ZTdlwJHa/rtB+gMbYaRiCpCxj8iFb71zj+Nea/DHYT
         2ldUEJeKWxazaBObrQCHBFdGMIWgZTms2elpA2Q0JrXm8LrdXJpYTHqUe9ssr4m6YN9F
         6niNZy5MaStRCB4Idbdu8iVJXuiHu2FpOWlQgW0QZcCAdGeFvDV/++T+qwvc+twmCpdS
         k2kN4DTDhui3q2JlaNX3CbXVj+OUlWjyKp78mm1nBHPVeOKUG9dX0qfSnSMgFi7ViIkO
         2Auw==
X-Gm-Message-State: AOAM531awejsCdPYjYzwwkr2c6J7yBMZUYL/yK+KKeBRQOpAY2mAY2TB
        d1EzXIflo4ms/6IrP3T9t/DHLA==
X-Google-Smtp-Source: ABdhPJwCyvOuGqMhL0YVGz/yoxJtvXzq8/2DIwLjjCWwVY+dCgTdX/SvInkwsOOlCV4xU5MUfG3y8w==
X-Received: by 2002:a5d:60d0:: with SMTP id x16mr56186871wrt.5.1594139814687;
        Tue, 07 Jul 2020 09:36:54 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id p14sm1925874wrj.14.2020.07.07.09.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 09:36:54 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 04/11] ASoC: q6asm: use flags directly from asm-dai
Date:   Tue,  7 Jul 2020 17:36:34 +0100
Message-Id: <20200707163641.17113-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
References: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use flags set by asm-dais directly!

This will be useful gapless case where write needs a special flag to indicate
that last buffer.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index f5d1f3c2c1ec..d6728304ce6a 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -1546,10 +1546,7 @@ int q6asm_write_async(struct audio_client *ac, uint32_t stream_id, uint32_t len,
 	write->mem_map_handle =
 	    ac->port[SNDRV_PCM_STREAM_PLAYBACK].mem_map_handle;
 
-	if (wflags == NO_TIMESTAMP)
-		write->flags = (wflags & 0x800000FF);
-	else
-		write->flags = (0x80000000 | wflags);
+	write->flags = wflags;
 
 	port->dsp_buf++;
 
-- 
2.21.0

