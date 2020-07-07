Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97ADEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71199206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WAOUaxcv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgGGKRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgGGKQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:16:57 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E44C08C5DB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:16:57 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k6so44563465wrn.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3bZAeFSvmpf6EGc1Rrn0+wIXui3QoI3bJ6wz54zb8+8=;
        b=WAOUaxcvTIM+kgWqOPLkQO4t70ks1L8rcPeDMg8pQrArTyQIPJe3qJ2b6X9yfmIOtN
         FoVH/1sxUaBU+lLS1q0NXqVn5rMbuOrXCOjCTVQCkvErCympXu/1zVBbW/R6A5BJVKZo
         ByWRWPmFEchS4xkyIHSzSz9G9RHBo8c+Q+WD5keTRSHptVe9L/hfTEHJnKm14KCr+WfK
         7ld7Tl3ZD7VAdo7qF1vXsXViNmFFwcCzjktzAES9B/Keda+pdD/MBrNHF8hm9AnHEIBF
         p8DUsIDCLdkfuJnhk/kQKKIwxnmabi7l1DNAVoRo6wPW3rjq/h4AOh8/swp1letY5w+p
         v9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3bZAeFSvmpf6EGc1Rrn0+wIXui3QoI3bJ6wz54zb8+8=;
        b=U328ezURM/LZzGc2eOwEYqx2kdP4EBd18Q1iUbouSwLj9hyYaXZ1anyxajnaTWpJbW
         a882ymYYLubwNcYWcluRWLpqTG5hC1xI/nlcpGxG7uXVUGanNp/JdT7UWanI1S0lXGgc
         B16lo8j7RQzddW5pIgVOSCXQyrtHDJTgRo0yuIIlqgpp0kiIGPJusx5NIF9E3M06wl/a
         qR+NMm+MKwLPhJ8TuA/kO5WDJr6/zqvupaqRSF9lO+xsr3/V39vQVDQWoSBhG7lyQENv
         4U2kLXiOsvO/CaO6p81Hpf/uHVoZo57XKaCjNJLvJFcay1FR5tEdhFXNNoExFdUuJtR+
         HnuA==
X-Gm-Message-State: AOAM533JUI3ft3+LcodIrmw+LkHsh3CpfePPD5dxomA8WenH6+tLG5bw
        6bchFikFwjBALCcRwDVr4fM87Q==
X-Google-Smtp-Source: ABdhPJxe7ZibCsreBnej5nYrQVJiRA2C6Ue1mU4csLgJ2IUwGSMta3Aa6li7Bu4sjMAwkzjp/Id2dQ==
X-Received: by 2002:adf:fe0e:: with SMTP id n14mr52181174wrr.325.1594117015828;
        Tue, 07 Jul 2020 03:16:55 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id z8sm469409wmg.39.2020.07.07.03.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 03:16:54 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Markus Pargmann <mpa@pengutronix.de>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 06/28] ASoC: fsl: fsl_ssi_dbg: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Tue,  7 Jul 2020 11:16:20 +0100
Message-Id: <20200707101642.1747944-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707101642.1747944-1-lee.jones@linaro.org>
References: <20200707101642.1747944-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to document either of the demoted functions here.

Fixes the following W=1 kernel build warning(s):

 sound/soc/fsl/fsl_ssi_dbg.c:90: warning: Function parameter or member 'flag' not described in 'SIER_SHOW'
 sound/soc/fsl/fsl_ssi_dbg.c:90: warning: Function parameter or member 'name' not described in 'SIER_SHOW'
 sound/soc/fsl/fsl_ssi_dbg.c:99: warning: Function parameter or member 's' not described in 'fsl_ssi_stats_show'
 sound/soc/fsl/fsl_ssi_dbg.c:99: warning: Function parameter or member 'unused' not described in 'fsl_ssi_stats_show'

Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Markus Pargmann <mpa@pengutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/fsl/fsl_ssi_dbg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi_dbg.c b/sound/soc/fsl/fsl_ssi_dbg.c
index 2a20ee23dc52d..2c46c55f0a882 100644
--- a/sound/soc/fsl/fsl_ssi_dbg.c
+++ b/sound/soc/fsl/fsl_ssi_dbg.c
@@ -78,7 +78,7 @@ void fsl_ssi_dbg_isr(struct fsl_ssi_dbg *dbg, u32 sisr)
 		dbg->stats.tfe0++;
 }
 
-/**
+/*
  * Show the statistics of a flag only if its interrupt is enabled
  *
  * Compilers will optimize it to a no-op if the interrupt is disabled
@@ -90,7 +90,7 @@ void fsl_ssi_dbg_isr(struct fsl_ssi_dbg *dbg, u32 sisr)
 	} while (0)
 
 
-/**
+/*
  * Display the statistics for the current SSI device
  *
  * To avoid confusion, only show those counts that are enabled
-- 
2.25.1

