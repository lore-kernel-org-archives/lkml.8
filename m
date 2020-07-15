Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23ABEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFECC2065D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SinIXReR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbgGOJoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729592AbgGOJoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:44:55 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0EAC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:44:55 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q5so1732998wru.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PqrROLW34HUUtR2h51/zb0sAvx91AU1D+g0vWHL8Q9E=;
        b=SinIXReRv8gqiSN2QfRyGZoxeCSVs1tW6IJ0fPIXqJKyYvSmw8FpS+EVBSF+0RW2Sh
         ZfKeXn9lmtbB+SD4BCJTJtQtDjyF2+P5LA2TO/WhKm/a78apZ8l4h9DB5vNSrDY7ImIu
         27zi1mRvX6cZpJGg/WmAanuUBKuAlFUU9iN8VbKWgpo540NBthUPbNZPqtKKMlWE5juh
         Ut84YQeS4jXHNSmflZPszNc5fOGAmn02ROdfQGAteYwrd9dDC6lrCh/JloCEggU+Wffe
         XRSDKtOVNA3pnZjeWEYAlDKuTayNQ2dWFNwMG7b7jH0R7Za1vatKApj6jDIhtjHreS2w
         RZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PqrROLW34HUUtR2h51/zb0sAvx91AU1D+g0vWHL8Q9E=;
        b=bYgHpS/dJ016a3+FIesdaSQUnwije5fdHxhXkChLC0nhlOZL0gnbcl4ziuYHy63KKt
         pbUj+RS4BQz3iw51XmT1+Bxc/Ncmlwg1QU18zXafpVq8tZ5hJBzV4k1oODWbO8by/7uW
         grvjdFyRFHAlnVz4nHNdB61NM9Xwm+7S8aa4V8LT4XK9drekdQgEEjJiw2uTYMCul289
         DtqNKt94o254/qiUBRt+PHKA8VXVxNyGFyoUSJ8vBxePleJwJ5PF0rO+g8Ht6amYkgoa
         ZY2YAOHGDWF7Ofz5P4FgDwchkcFWNMZ2v0cFiAIARZJcz6v0DkGjqAhV2vwWjCrvNc5F
         zJpg==
X-Gm-Message-State: AOAM532c4DgipQq7Hvnt1b58T7aRZwp4h6FsAHLUqTNNIrobaVhBlV6c
        0vC/d6Af7KQ1wlAUshyiXQ2YIQ==
X-Google-Smtp-Source: ABdhPJz9iEgW39p9NP+x+8HK/WX7+X1jz9XTLGQ3OWUni12lXxbaIHvRiJa1hStnOPuDJMtNRKu1oQ==
X-Received: by 2002:a5d:444e:: with SMTP id x14mr9877312wrr.279.1594806293824;
        Wed, 15 Jul 2020 02:44:53 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id r10sm2774916wrm.17.2020.07.15.02.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 02:44:53 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/1] ASoC: fsl: fsl-asoc-card: Trivial: Fix misspelling of 'exists'
Date:   Wed, 15 Jul 2020 10:44:47 +0100
Message-Id: <20200715094447.3170843-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/fsl/fsl-asoc-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index faac6ce9a82cb..399c9aad48b1d 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -92,8 +92,7 @@ struct fsl_asoc_card_priv {
 };
 
 /*
- * This dapm route map exits for DPCM link only.
+ * This dapm route map exists for DPCM link only.
  * The other routes shall go through Device Tree.
  *
  * Note: keep all ASRC routes in the second half
-- 
2.25.1

