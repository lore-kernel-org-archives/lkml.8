Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0FAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C64D820771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C+DvgwtI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgGGOit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgGGOiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:38:18 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B932C08C5E2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:38:18 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a6so45417414wrm.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wlcleqYJY5jQ1OZcMa4GgQUjEFsprvthMn+zX7CdCH0=;
        b=C+DvgwtImCJiiCVNxFwI9tT6IRQA5rXY9b0UMNq/qhCDZJquNaMLx1Q027QICk1xw6
         GOcMf0ZeJzxE16mOIP1eh8YHcFNXeCt6BMeMYGeSxEzmXLFRTkUS20lyaPihXAlgOo7n
         3wNkADF2GRmNbauV/DltdxYgl0GoSQPwvkmZyKXUOpKKk3ipTlo7/NkL4p8cA6Z6ECdJ
         ZR4HMK2QM2YJBpGt8wfV72UC6VNVFCCY4ahwb+tPnvIGzY3H8OnSZTNZYWvHp9e/gjvg
         cX0wPlpkVMbw3sBrQkauQHX6xvWLsYdN2dMTjhVYzzzbh/g01qqPoVl3KyHSgRAuL6R8
         1IXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wlcleqYJY5jQ1OZcMa4GgQUjEFsprvthMn+zX7CdCH0=;
        b=Or2ym6nhb2o5mtVsYs17RJ/ZAg/wid0qCW5ysMYMz6Tert/9uO5qH87No3YUF2Ma6B
         GW2QwoRLFRsbgUJRyYosN/LHVtRdn2qOQygCDXaSxQlRLxcJNxfnuBCCaNRMDx1+kRyz
         EGUxU529EcQkLJ3nzD5Dh9/9eQQm5DQZ8tqMmjg9sw3YMJ5pyhI1RHcN9gVhNl2YXDB1
         BdQu3wDclN+CGzRoNniMTOXveuhL4xa46Ja+PIFwq9Wn3/bYCu0g8SXpWT46mo/rwkJT
         vJQ98/sY0sOBxGSJq3W2ixif8cNMp+DS63R8sRtZeJpXpA/ePbcAEJ4hFUPKSrpCABv0
         cX4g==
X-Gm-Message-State: AOAM533U8g0nGLcQBb+bGrvVSM553szj+NwpL+9lcHiomkw/X+RsC/kn
        DJmZEEZdqjRXgIOoSGo6OdymOA==
X-Google-Smtp-Source: ABdhPJwKOPKcRllwzqIDBY+TgIWIRPSnExaAAvyTfdJWtFOiySyUOdAS4Vf5gq6RLSb6KEqnudtfkg==
X-Received: by 2002:adf:f10a:: with SMTP id r10mr23439173wro.406.1594132697074;
        Tue, 07 Jul 2020 07:38:17 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:38:16 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Samuel Ortiz <samuel.ortiz@nokia.com>,
        linux-omap@vger.kernel.org
Subject: [PATCH v2 21/28] ASoC: ti: omap-mcbsp-st: Remove set, but unused variable 'w'
Date:   Tue,  7 Jul 2020 15:37:35 +0100
Message-Id: <20200707143742.2959960-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707143742.2959960-1-lee.jones@linaro.org>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like 'w' has remained unchecked since the driver's inception.

Fixes the following W=1 kernel build warning(s):

 sound/soc/ti/omap-mcbsp-st.c: In function ‘omap_mcbsp_st_chgain’:
 sound/soc/ti/omap-mcbsp-st.c:145:6: warning: variable ‘w’ set but not used [-Wunused-but-set-variable]

Peter suggested that the whole read can be removed, so that's
been done too.

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Samuel Ortiz <samuel.ortiz@nokia.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/ti/omap-mcbsp-st.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/ti/omap-mcbsp-st.c b/sound/soc/ti/omap-mcbsp-st.c
index 5a32b54bbf3bb..0bc7d26c660aa 100644
--- a/sound/soc/ti/omap-mcbsp-st.c
+++ b/sound/soc/ti/omap-mcbsp-st.c
@@ -142,11 +142,8 @@ static void omap_mcbsp_st_fir_write(struct omap_mcbsp *mcbsp, s16 *fir)
 
 static void omap_mcbsp_st_chgain(struct omap_mcbsp *mcbsp)
 {
-	u16 w;
 	struct omap_mcbsp_st_data *st_data = mcbsp->st_data;
 
-	w = MCBSP_ST_READ(mcbsp, SSELCR);
-
 	MCBSP_ST_WRITE(mcbsp, SGAINCR, ST_CH0GAIN(st_data->ch0gain) |
 		       ST_CH1GAIN(st_data->ch1gain));
 }
-- 
2.25.1

