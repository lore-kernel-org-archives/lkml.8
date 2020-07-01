Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B56C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E43320780
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xIDiEYkl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbgGAMr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730678AbgGAMrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:47:23 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E44EC03E97A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 05:47:23 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k6so23680742wrn.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 05:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RppFHH3LPgV9Fbxkc7EFxUD1a+LbYIuGU1AKsrw/uFk=;
        b=xIDiEYklS6lSZpP6D9pgP0igi/DuLWfHQtgqSxQrazIxDKzatFbofzd5A2lxZECBRp
         xgjtQ9qigjPm2I9PvVxfMtgVOIO3zEMvCEvi853x8QO6KLsAr0R7mmgVIfL4RruJlql+
         xtvfOzVAj5ODP/aWq4ks/9xr7+uRNHZiDwRvvbfKMAlEFVGgBJ4MP7BztMTQk9lB1cy6
         pO6NX2PcayLNiR9Ei7AhrqSWZWqG5xjsk2bCLWAueBI1qbYBzRjjcpWOaGChQi+lfluF
         84QFziwLTyWWS1h3rphJzHL8TLCaYECg1Le1+RLbeX02xJMNoPAV4Pdm4iq52qPR7Z5X
         eakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RppFHH3LPgV9Fbxkc7EFxUD1a+LbYIuGU1AKsrw/uFk=;
        b=D235dMOaN6xoQr7qwDSg0kwiq9dOncmgNVusWeEg2wHZIfVxT+XiO3T6gcTA2tVjvT
         c+AudKF+AEttbLmsc0W2t4wu0L4EJGzgUp8tWaB84u70aXte/sGEoOn5OLIl611Mq0rb
         kivfyO+NQ+XWSd+pvDRMzE35L7mlCJlpT0XtCAuPmRLurja01jJahNQuhv60u1Q2WjXU
         Ryvr7CufHXcG6Q4SEKrdfJieVqDClflxMHbbpxa/l+lUfXWLyihiiBGxTE7ziQZaWNxU
         YWrf0fWXdT/AQLDZf0Oo0EBxhFMZoOZ662MGifAgz9qB4WoCUdh0+vXT/Ay0L41SE5ZN
         ja0g==
X-Gm-Message-State: AOAM5308nLeiU2RZJPScD+ydJjlkRkGRVZB9TabYHk5q5fJGzhtqg3ML
        obBXxVWQXFJClE4ABJtdbfAvkg==
X-Google-Smtp-Source: ABdhPJyC8rXxEDpXbOyCSZxcsN81UfnduDOhMYWpILYzv9Y/zpJP7ApdbBjcGjp+fUgrrteEcjr51Q==
X-Received: by 2002:a5d:6907:: with SMTP id t7mr26577073wru.329.1593607641927;
        Wed, 01 Jul 2020 05:47:21 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id o29sm7817862wra.5.2020.07.01.05.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 05:47:21 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     ulf.hansson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 13/15] mmc: host: sdhci-msm: Demote faux kerneldoc header down to basic comment block
Date:   Wed,  1 Jul 2020 13:47:00 +0100
Message-Id: <20200701124702.908713-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701124702.908713-1-lee.jones@linaro.org>
References: <20200701124702.908713-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__sdhci_msm_set_clock()'s function header is the only one in
kerneldoc format.  Which seems odd as it's not part of an
external API and isn't referenced anywhere else.  Seeing as
there has also been no attempt to describe the expected
function arguments either, we're going to assume that this is
not actually a bona fide kerneldoc use-case.

Fixes the following W=1 kernel build warnings:

 drivers/mmc/host/sdhci-msm.c:1595: warning: Function parameter or member 'host' not described in '__sdhci_msm_set_clock'
 drivers/mmc/host/sdhci-msm.c:1595: warning: Function parameter or member 'clock' not described in '__sdhci_msm_set_clock'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mmc/host/sdhci-msm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 0c02f8a2d11ab..7a574fc7635c4 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1583,7 +1583,7 @@ static unsigned int sdhci_msm_get_min_clock(struct sdhci_host *host)
 	return SDHCI_MSM_MIN_CLOCK;
 }
 
-/**
+/*
  * __sdhci_msm_set_clock - sdhci_msm clock control.
  *
  * Description:
-- 
2.25.1

