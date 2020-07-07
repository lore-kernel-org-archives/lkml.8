Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBFBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD9C8206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y6F9hlhl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgGGKRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbgGGKRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:17:23 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6875C08C5DB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:17:22 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a6so1414409wmm.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GL1MoJKxnZtWyOmgkHZ5ZdLcj+7xXQIgEe9rUvPd4fk=;
        b=Y6F9hlhltdfKqf7rUHge+Z/I8Om08eU1SVFzRpv3TDOhmPvM9NURwqhOyyLVfI1Vb4
         BqUBp0JbKvL5b8IjHEUFXRsWnP36t2lkN2REOpkuVSjdiuAe56EMv2KCjf7uDPtI0Lpi
         jOTz+FHuWVueoCq7I7YD4Uv+TqF/FEaBTg8jla19QgpBMo1Pio0tYDrtAFkgsdqCz9N6
         fpFI3yKqDfH1I/os94fMLiK9ei7oND1VEkkMLIUYq13l9KmD6P8SyzeiTXRJkr5e9v1H
         JgC+/inW/oO6efg0baiUOq+sZeQQGGrv2ZIbVih4nL+lFEk2d1gDBg+PELv6YK8Oevnl
         HEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GL1MoJKxnZtWyOmgkHZ5ZdLcj+7xXQIgEe9rUvPd4fk=;
        b=V/1hjkqbdfaAv6ds4yr/SlzaQlKd9dwU4qIvkuElF+eo/+Lwqeyd0NeLknAZmsB/le
         rmHTlTbBAy6BR53WfcqxapQZyXmyPyPP40PUlVlBtxvKXPxn0SCno9PCcNYU24mzRlE+
         iHSRey+UgI5APlYagPyMmOYFiQfeaxbU8FKde9xp5vPva2PyG2QRfVBaimNdKfn6EaaN
         3aNWvUtHxfNik1oemgDT8KXnnbsiulVCxBi/jWicKTU70HPcgcPJvKgMWLTVL6lJBPQM
         zTfSpZS/TGqij/1UoX7GQER6qUQTC015QvVjIZTQapnJjRWkp8D558HsEiqA7r1oaRH6
         XBKw==
X-Gm-Message-State: AOAM533MMRjP4hEgofuVs7xe7WnYK8Jok76P9S0K3hN/OCQm5XeUVtRo
        PWAxD3HkG0PkweU7HT7BCT26JQ==
X-Google-Smtp-Source: ABdhPJys3a86OxKV+EWBwNFIyLWi784LN6fGl3f7t0+dy9DQHj3SWrOybRjJElejQDlEqlUS/0V1dA==
X-Received: by 2002:a7b:c208:: with SMTP id x8mr3446081wmi.49.1594117041183;
        Tue, 07 Jul 2020 03:17:21 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id z8sm469409wmg.39.2020.07.07.03.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 03:17:20 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 27/28] ASoC: codecs: tlv320aic26: Demote seemingly unintentional kerneldoc header
Date:   Tue,  7 Jul 2020 11:16:41 +0100
Message-Id: <20200707101642.1747944-28-lee.jones@linaro.org>
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

 sound/soc/codecs/tlv320aic26.c:138: warning: Function parameter or member 'dai' not described in 'aic26_mute'
 sound/soc/codecs/tlv320aic26.c:138: warning: Function parameter or member 'mute' not described in 'aic26_mute'

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/codecs/tlv320aic26.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index 032b397356438..4569bbc08acb3 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -131,7 +131,7 @@ static int aic26_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-/**
+/*
  * aic26_mute - Mute control to reduce noise when changing audio format
  */
 static int aic26_mute(struct snd_soc_dai *dai, int mute)
-- 
2.25.1

