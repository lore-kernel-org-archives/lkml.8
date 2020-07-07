Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA95FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6EFA20738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lhNJKuTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgGGOiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbgGGOh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:37:56 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C36EC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:37:56 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so42387481wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pNlZaQWHbaIHYTs0iyc+dtmoOXHEctaupDIvIqecIP4=;
        b=lhNJKuTp0CYdX9JvN+4GWjIHCd6ykjyYPgZscDP4ZJr3VhIQgn6l+v31ttYzo82MNJ
         9/FrRsudQ4kC1XEUyGzfI6aXU1wYt86SIEYwImLLbLkivHL+ZDpYENA6suz7PtNuVlLC
         Pi1aRNWquTNYhR+LvPy7//58CtbJRZefqWVbRDfubzrRxeTcDhnMoQlUrtt/uMD3ibnE
         /CH+Ukq5GCbNhM/5K3UFviwFYqEBkxwMJe4OG0YkJU5PmrdxXTKLKJdJGh7vwUriWyRl
         gAe7+yi6dotNXn5Fkf0yGEnFrBKnhin1xRZ/tfzjZGdhoAG1t95ogiyxYbvIwOPyD3qX
         YHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pNlZaQWHbaIHYTs0iyc+dtmoOXHEctaupDIvIqecIP4=;
        b=RktiWUnX8VMYEn0ttpP/HyBqHC5p9zElWoyXZGhJu9AwkngXAMGqXQ/uZRZGSYyuvz
         iOdOQGXRtYzuzJq8cdN+y3veludkBXHvINby0I5B59Dli29N95M/5N+AYkZmdl8rWuam
         7PiATOUzcmCD+K5w2v8OL0L+PhjaxYXwTS1Owcqn3EFugTvV3zck77WGZNWfEtcVlwkd
         t2ah6Mlrun56m5x6ZKl9V2WQ4smhpOYkd2delAzf/ofwTQ4yZ6OXUQ+RezRAId60vN3H
         A6FPAYY32X+kE1xbkBHYDGu6bM/kUIvbvZGref60M1KnXrkwIp2u+Rl4YgXllnMjHhxI
         saYg==
X-Gm-Message-State: AOAM533R+ugTVbphO+tKI3zGWj22o6Dkh7M/RU0fdgFEOq1keDCFRSiR
        Puu9m9syIDm7o8fZP0Vjyy1XQg==
X-Google-Smtp-Source: ABdhPJzLNQlLqusIHk2mLl1/WjSQ/SnrLnewJMjZfIAz00+9GI0iQljPIoAb6xWPa8CAe0qK4FdXSQ==
X-Received: by 2002:adf:e48f:: with SMTP id i15mr18532930wrm.327.1594132675143;
        Tue, 07 Jul 2020 07:37:55 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:37:54 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Vladimir Barinov <vbarinov@embeddedalley.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 07/28] ASoC: fsl: fsl_spdif: Use correct formatting when denoting struct documentation
Date:   Tue,  7 Jul 2020 15:37:21 +0100
Message-Id: <20200707143742.2959960-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707143742.2959960-1-lee.jones@linaro.org>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc expects struct documentation to start with "struct $NAME".

Fixes the following W=1 kernel build warning(s):

 sound/soc/fsl/fsl_spdif.c:104: warning: cannot understand function prototype: 'struct fsl_spdif_priv '

Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Vladimir Barinov <vbarinov@embeddedalley.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/fsl/fsl_spdif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 5b2689ae63d4d..7aa3bdec5b6b5 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -81,7 +81,7 @@ struct spdif_mixer_control {
 };
 
 /**
- * fsl_spdif_priv: Freescale SPDIF private data
+ * struct fsl_spdif_priv - Freescale SPDIF private data
  *
  * @fsl_spdif_control: SPDIF control data
  * @cpu_dai_drv: cpu dai driver
-- 
2.25.1

