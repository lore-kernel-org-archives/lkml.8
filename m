Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDFAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1F152074B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iQ5hcO8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgFLMiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 08:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLMiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 08:38:10 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F898C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 05:38:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c3so9544908wru.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 05:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3GhP3uz0XN6OU0twcZsptRwHlkZxcUOkI66yWE4C4Ro=;
        b=iQ5hcO8xBJOgPqnUvGNqnCuAYoyYn9av0SSPL1mJ2dW+9FHnsIeqKkfAkNk0/pQ5mj
         oez3VPL1T2Axh07pvGsbzc3fGus+FREEDOW7lQetNbN7Vso5Mfl+rWFlK+pSWrjiwUa2
         U4h/tV74irexipyOiFC21F6b9VgktOC7kDNTgGcsrmad6hGchmGarfpscpvfQGOJ+SKe
         IofO62pX+G8cqrgAMpCEdyK8IRpc/8gs5Sb06WKm3k2dTP1VlQ/6ZGhS/9yr2kOWDe0O
         sppflITo/T6kMHKhuHDhY7pzoxRrIpXaacmhOSacCU2Y/QCAKpO+p0nPFkilZeXkrqjN
         Mn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3GhP3uz0XN6OU0twcZsptRwHlkZxcUOkI66yWE4C4Ro=;
        b=XLjX1e95D0OUPf7PVq5anSj9ZGiXKrmB7SUvGRlgGcJCirYZfw6/tb9kX1XcUxCbKM
         pPv57seFMDPpN2FId4IxwLc3StF1/P59yppsJthARk8TZCjxDLdld+N99Sss4Rq+zxPP
         mHqcxwjQxW9d22fxu/oX6WC4YUc7fgyMcd2gWq+vDFc8LsJAbX6xG7TQ7BoumrFvIbBP
         3ugzALHPZR67IrVQeDb8IrpX6ukV9KYOzvaQ7Ykp8StLM32Px/6Uxj+SS1rHC0/DkNoO
         t4XjMiidF9JZme/cTdonD9eqsJYYER3H0AMJ5qxHc0V+r6lz3+EWHH6yZ4C+122q7FR/
         jVSw==
X-Gm-Message-State: AOAM530ER5KBAT9OJ3WKOl/BFUwp93mBquqn+Klec4VCEaELJUxrwjW9
        cz0Hg5BjgFyqHJsDvgoTuOp/iw==
X-Google-Smtp-Source: ABdhPJzSPU3xAksW5P8P/fHH+J+BcWe+8ALGCptbAJ4fCUPMaUis1RTCbWo6ng9R3/v3s8Hab9j61A==
X-Received: by 2002:a5d:4f81:: with SMTP id d1mr15556564wru.95.1591965486947;
        Fri, 12 Jun 2020 05:38:06 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id g18sm9392299wme.17.2020.06.12.05.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 05:38:06 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 2/2] ASoC: qcom: common: set correct directions for dailinks
Date:   Fri, 12 Jun 2020 13:37:11 +0100
Message-Id: <20200612123711.29130-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200612123711.29130-1-srinivas.kandagatla@linaro.org>
References: <20200612123711.29130-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently both FE and BE dai-links are configured bi-directional,
However the DSP BE dais are only single directional,
so set the directions as supported by the BE dais.

Fixes: c25e295cd77b (ASoC: qcom: Add support to parse common audio device nodes")
Reported-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/common.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index 6c20bdd850f3..8ada4ecba847 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -4,6 +4,7 @@
 
 #include <linux/module.h>
 #include "common.h"
+#include "qdsp6/q6afe.h"
 
 int qcom_snd_parse_of(struct snd_soc_card *card)
 {
@@ -101,6 +102,15 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 			}
 			link->no_pcm = 1;
 			link->ignore_pmdown_time = 1;
+
+			if (q6afe_is_rx_port(link->id)) {
+				link->dpcm_playback = 1;
+				link->dpcm_capture = 0;
+			} else {
+				link->dpcm_playback = 0;
+				link->dpcm_capture = 1;
+			}
+
 		} else {
 			dlc = devm_kzalloc(dev, sizeof(*dlc), GFP_KERNEL);
 			if (!dlc)
@@ -113,12 +123,12 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 			link->codecs->dai_name = "snd-soc-dummy-dai";
 			link->codecs->name = "snd-soc-dummy";
 			link->dynamic = 1;
+			link->dpcm_playback = 1;
+			link->dpcm_capture = 1;
 		}
 
 		link->ignore_suspend = 1;
 		link->nonatomic = 1;
-		link->dpcm_playback = 1;
-		link->dpcm_capture = 1;
 		link->stream_name = link->name;
 		link++;
 
-- 
2.21.0

