Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2C6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC21620738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vs9u6fko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgGGOib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbgGGOiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:38:25 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D374C08C5E1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:38:25 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f7so42389289wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GL1MoJKxnZtWyOmgkHZ5ZdLcj+7xXQIgEe9rUvPd4fk=;
        b=vs9u6fkoHdTRsoIwOztyIF1QFyoLJ+DBOn61usrEsJa8M/xEsFz6ccynCe3suiWI+J
         wagk06+451E7C2zn0WCt74jl5nlJqEhHDLkhajDlwKLxfpgSxC4M4q4fF1Q89wvwVBUF
         jve/9coueBoszftEXEflGjtwcIhdarMn+tFbiQqJa1GudAy6ev1furWHGgRHcCaBbtTp
         a9h83mDRjxnTvBYqShL8PaEm5hnvsF7stpAChgwzB5D+lYGb60bstU9/BdCOh0Q4cPe9
         ZPndxE4hZWNAzb19+hWUfepNHF69vsrqN4F+8PHwo6Tu5C17wHLumK19fX/OA7tz/FOS
         QctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GL1MoJKxnZtWyOmgkHZ5ZdLcj+7xXQIgEe9rUvPd4fk=;
        b=O8Up+emb1P4L8ZlRJGxug1vV6dkWk01Vp4My6cF3BF+vZpHouBLBvQEqFW0LI4tJiw
         YSdq/Lh0OK4ZB+Enqw3Z7jLNvQwkkowV3vRL8Ji3zY2xt4ymW4xeUM+cPrQs04BVLVIk
         mPRe307I/rzi8dvs0+qz+/ibyq5Z5heWJoxoXgNQiXLP2H10vl8ihWii1UKsUyp0PgLT
         qw53Xm8iUyQBkvUeoket+0Pu2VDC86FtMVkYmdFVef84oLz3+/JxvEYVewRiduS5m6ba
         uh+bjTiwcht9VclfOtDPMRIukd2i2PWmELuLu37r8IaDSi2nucuL5u8wm3d5xTKuWtx8
         FddA==
X-Gm-Message-State: AOAM5304xToS/qT2Y1WCZdEdheAtIwzVIecSqXDiDQcpiatgWSqoOkHe
        1U3F8AwlSgSY0lnbY0GTBHOfeA==
X-Google-Smtp-Source: ABdhPJzd2FTv80CNQ/tL+xGiVbCx50HF+5XZshFx4c6WGmM6f7LoU39lGcsU04vGFOfZUWMHOWSnlw==
X-Received: by 2002:a5d:5341:: with SMTP id t1mr57527312wrv.207.1594132704004;
        Tue, 07 Jul 2020 07:38:24 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:38:23 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v2 27/28] ASoC: codecs: tlv320aic26: Demote seemingly unintentional kerneldoc header
Date:   Tue,  7 Jul 2020 15:37:41 +0100
Message-Id: <20200707143742.2959960-28-lee.jones@linaro.org>
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

