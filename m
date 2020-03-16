Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9EDC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4CE20679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l1jWliND"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbgCPPLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:11:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38449 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731631AbgCPPLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 11:11:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id x11so16950155wrv.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 08:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uMLkobIeM9DCkYCP5Y/MHr6L2BuJYzjWCEI6GI6xP84=;
        b=l1jWliNDgPxq9N9s7HgwP/YBv3zwSYsNS2CAOnN8TAfAGqm/CbNWBl828eQoD9dQp3
         DL27nsTNd0QBLJp+3wBm9uTsH593tulDiGCmrN4sWt+voD3enxJLMUsC0aDvk9rMR2rB
         U5PVx3oXWJTNPVNawqWuDSG8yeqEFpOrxP1pKSepO/KA8TNkjnAWVGUBte0E7JX6ldH9
         3qO2Xxa+n8H8Yn1ui+6se0WSHVL4EW0//PvtpmpLZBYzVf9zRtHCurouZCxdZ98tBkDy
         8IRpgXO6yak0zwFnXVNwXpRrNJak5+mSb18bW5W0aQcwCL/JfwpaF14mm7A5BUk6CLL3
         oyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uMLkobIeM9DCkYCP5Y/MHr6L2BuJYzjWCEI6GI6xP84=;
        b=brYYwXQnJ2McavYwz33qMvC7AQOoVbOpdeHZ5O05mGhZFi7Rv21bsZ3jZiw1Qnipnw
         3tE38E9gLgR2FW+EDuN0ZhZVjlQqAq1qhN5z7ueoO5mQ1Z7xo2c3dWqqnFmXOKRNkN8/
         KlkPWNEy95rN/hC0389/zBEx0/0cKdCgZuB2pLl63QIIT5hL8VuzKdS6xc+kjG4ux4HG
         LavfhbWhYBLAAkp3p3vbG8BSSmEs8mU240aQY9oA0AN+2o4zGz/fjFcAVbuL6IqPYxpi
         9KOkFGCxI7pQ+XF8yRRfeRNzgAUOzaAO0MUp1bsLpL/4n45vpo4Of6MS/krYiFt+quMN
         WHqA==
X-Gm-Message-State: ANhLgQ0t4/6+SqnYbj8kOVs85/3cRlNSK8T57qdMwSj5HdQQJJW2BEM3
        FdhhupQ71c0eiohEFNieQ3y5Nw==
X-Google-Smtp-Source: ADFU+vvnSbRNrjh7UKOltQra2NXVuqL+ACmrLbkOHpSHUtXiWR8Zc936fH6eF5TIBGv8gmyyfa/0Og==
X-Received: by 2002:adf:e550:: with SMTP id z16mr11337435wrm.394.1584371480434;
        Mon, 16 Mar 2020 08:11:20 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id y69sm31530923wmd.46.2020.03.16.08.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 08:11:19 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        vkoul@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: soc-dai: return proper error for get_sdw_stream()
Date:   Mon, 16 Mar 2020 15:11:10 +0000
Message-Id: <20200316151110.2580-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_soc_dai_get_sdw_stream() returns null if dai does not support
this callback, this is no very useful for the caller to
differentiate if this is an error or unsupported call for the dai.

return -ENOTSUPP in cases where this callback is not supported.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/sound/soc-dai.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 7f70db149b81..78bac995db15 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -433,7 +433,7 @@ static inline int snd_soc_dai_set_sdw_stream(struct snd_soc_dai *dai,
  * This routine only retrieves that was previously configured
  * with snd_soc_dai_get_sdw_stream()
  *
- * Returns pointer to stream or NULL;
+ * Returns pointer to stream or -ENOTSUPP if callback is not supported;
  */
 static inline void *snd_soc_dai_get_sdw_stream(struct snd_soc_dai *dai,
 					       int direction)
@@ -441,7 +441,7 @@ static inline void *snd_soc_dai_get_sdw_stream(struct snd_soc_dai *dai,
 	if (dai->driver->ops->get_sdw_stream)
 		return dai->driver->ops->get_sdw_stream(dai, direction);
 	else
-		return NULL;
+		return ERR_PTR(-ENOTSUPP);
 }
 
 #endif
-- 
2.21.0

