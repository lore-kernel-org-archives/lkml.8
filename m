Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5099C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 832272075B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eKf7OQbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgGGKRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgGGKQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:16:52 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF65EC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:16:51 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k6so44563192wrn.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Ojcexqfn/ZS3noXIMdqlD9+JbA+cGF+iBmDVVcfGM0=;
        b=eKf7OQbj/SAKIuqAfQubX24p12bDVbV98ZLiLwXpicE8+hlGHR2Lwqg2oTYcLwu/qD
         Bn5Gn1gBc/1gGzBGsmqTb+Q+gUH+21qv7MFJY6nOjy++f7nMMe8Uoj5EWJRz+g+D/XLb
         lTtDXG7caO9jtnbnh02SmWHCT20SHTj18dUEk2p19o/ko5C6t0jv1EgkhiXWypF+9X83
         Yg2bkKaO/kwFRZb6VQD/FOiRIyeNO8bncKjdrWxHfp/Q3nQSOfaHxzzXXVE8YKEnUc15
         o/LFftlJi1GnXMqcbZ9j6KBshO9S1Arc8MHEO5MopHLhfQ3irAsVv5y6Ee972eCGsmtq
         8Nyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Ojcexqfn/ZS3noXIMdqlD9+JbA+cGF+iBmDVVcfGM0=;
        b=li75j5Ju9jxkEh1JKUTiNxFUYuXrKrLoteOB84OwvHbEIUYv69on914hyoGRFt0x/u
         qp+TA2OWiDys99d+0fAgX+Kfh68q1rdHLachc7FCQ/puclu86clYFcyHewtkfb3i3DNr
         POAytzoBnY0DpUMkyw8xec5zspkNz6CKstStzAJ3czX+/nqlxMPFpGFSCO0diyeG6/L7
         YmQhJRO1DVxUVOPVNiCvJGl9iUmrPMfiO8mCuNhz9NF30AF5aEFs+zZy8ghOljWUs/oq
         xlpPd7qewiOlqNU3NfNetREI5QrWnV5CMKdnHH52wRaP4NzZnxiPXKANtRvyXEKTWXO+
         T+4w==
X-Gm-Message-State: AOAM530y07WSvQ6tEzwH43MwAtUKhResxFuegNNXHJW3l5d1Jv22JsDp
        pQePNN/fJDOzpUMxsbwr6ZReXg==
X-Google-Smtp-Source: ABdhPJxXHqSXuvC/N6FMDoHvlD9BJG1LNiYAOWrAD6I4lg3PAZdm04pKuSFnfS9ZIM3N4PgczWCONg==
X-Received: by 2002:a5d:474f:: with SMTP id o15mr50415169wrs.306.1594117009607;
        Tue, 07 Jul 2020 03:16:49 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id z8sm469409wmg.39.2020.07.07.03.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 03:16:48 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Sedji Gaouaou <sedji.gaouaou@atmel.com>,
        Frank Mandarino <fmandarino@endrelia.com>
Subject: [PATCH 02/28] ASoC: atmel: atmel_ssc_dai: Demote function header which is clearly not kerneldoc
Date:   Tue,  7 Jul 2020 11:16:16 +0100
Message-Id: <20200707101642.1747944-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707101642.1747944-1-lee.jones@linaro.org>
References: <20200707101642.1747944-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to document the demoted function here.

Fixes the following W=1 kernel build warning(s):

 sound/soc/atmel/atmel_ssc_dai.c:892: warning: Function parameter or member 'ssc_id' not described in 'atmel_ssc_set_audio'

Cc: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Cc: Frank Mandarino <fmandarino@endrelia.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/atmel/atmel_ssc_dai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 0f18dfb85bfed..3a0335864034a 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -885,7 +885,7 @@ static int asoc_ssc_init(struct device *dev)
 	return 0;
 }
 
-/**
+/*
  * atmel_ssc_set_audio - Allocate the specified SSC for audio use.
  */
 int atmel_ssc_set_audio(int ssc_id)
-- 
2.25.1

