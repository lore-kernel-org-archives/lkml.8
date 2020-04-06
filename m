Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2311C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 00:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C678320678
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 00:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G8TvgV1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgDFAcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 20:32:46 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39481 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbgDFAcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 20:32:46 -0400
Received: by mail-pl1-f193.google.com with SMTP id k18so5231339pll.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 17:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BmHMcZC/yhqWoXwUpcTR1X3nyLa2fdxVh+jOQWGNruk=;
        b=G8TvgV1dRjX+fRqES+PvYyblutibdQ+P/vUKP4kXMgLJ8QXvsJpCkLqY7GYhC1rHvN
         1ZrNlnzsXp2bywZsXx4NrWY5qAIbv8otScQR6P6WZa7e6za4D7bJT++2Yc8ayhgT7bBk
         acYzOcUW3F6xjxZIq+crF+l1OfBmgK/ailCCvNVncd4HVPKrGOf6ZTj/mHp7RWpkYl+s
         K4mPU6A7AUkckZHywHJhpIH3rhYUyPASo95a8BhsPGMH2ou0ViDqPD7MvgW+iceualnc
         0LjycEfoZLmfOyujZYeQdJT5rKtMQC8mRhJZH67GsgoZ3vrXwLXXw0X0UNdf9Raenjmz
         w/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BmHMcZC/yhqWoXwUpcTR1X3nyLa2fdxVh+jOQWGNruk=;
        b=XEtDLas5QZC6RbNWpcse22edYdZZCpbI4oeCP9cPcgX2lzMymMD+/5kGbiiNuKCYuR
         v9K4yDPUtHeI8BUvNN0QZ4i8/ksJtJtoBf0pXfgYcBT/l/u+H2D8+A6rA/NMBPB90cS7
         0Po0Lasx0DbWtLuj3FMZn14B5OV0OADu1a141C+fMI+lVBCuOgz6fmFfPwY+hQF6Sdqc
         sLkpKWnKV3F4QP017MXfUTtjzLBuhLSTuJeFOJ/VWJyRKexFAUMIyJGrzFAgDJOR1u7P
         RuyYU2K5nGSW3x2fgpdFEw1SRkXqg8NAapgrewAnoW8G8LX1BJnVa7R6am0rakWyMe8G
         Rx/g==
X-Gm-Message-State: AGi0PuaDpRGVEzLSezHiFPtEXeJ110zZ4OAB5FAnudspRGSFsK4ZM5cX
        exAcoS1Odoq7h2lkG3lP/4WKDzonhq0=
X-Google-Smtp-Source: APiQypL96eZMSILPhO0ZW9MTIR6nTEF+9EUJkE883OgIqnJB3GN0SbdobCnDKKaqMYLdx9cfyr82IQ==
X-Received: by 2002:a17:902:b48b:: with SMTP id y11mr18041570plr.131.1586133164846;
        Sun, 05 Apr 2020 17:32:44 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q91sm10685212pjb.11.2020.04.05.17.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 17:32:44 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Subject: [PATCH] ASoC: qcom: common: Silence duplicate parse error messages
Date:   Sun,  5 Apr 2020 17:32:29 -0700
Message-Id: <20200406003229.2354631-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All error paths in qcom_snd_parse_of() prints more specific error
messages, so silence the one in apq8096_platform_probe() and
sdm845_snd_platform_probe() to avoid spamming the kernel log.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 sound/soc/qcom/apq8096.c | 4 +---
 sound/soc/qcom/sdm845.c  | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index d55e3ad96716..287ad2aa27f3 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -116,10 +116,8 @@ static int apq8096_platform_probe(struct platform_device *pdev)
 	card->dev = dev;
 	dev_set_drvdata(dev, card);
 	ret = qcom_snd_parse_of(card);
-	if (ret) {
-		dev_err(dev, "Error parsing OF data\n");
+	if (ret)
 		goto err;
-	}
 
 	apq8096_add_be_ops(card);
 	ret = snd_soc_register_card(card);
diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index b2de65c7f95c..68e9388ff46f 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -559,10 +559,8 @@ static int sdm845_snd_platform_probe(struct platform_device *pdev)
 	card->dev = dev;
 	dev_set_drvdata(dev, card);
 	ret = qcom_snd_parse_of(card);
-	if (ret) {
-		dev_err(dev, "Error parsing OF data\n");
+	if (ret)
 		goto parse_dt_fail;
-	}
 
 	data->card = card;
 	snd_soc_card_set_drvdata(card, data);
-- 
2.24.0

