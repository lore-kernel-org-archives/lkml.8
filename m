Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8A1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 784F9206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ndu3Uq8m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgHTIu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 04:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgHTIuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 04:50:25 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2271C061757;
        Thu, 20 Aug 2020 01:50:24 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d188so704906pfd.2;
        Thu, 20 Aug 2020 01:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DBkev/tvu1fiDGLiQGbd1WuoTNLvp7U5tTXawjMYG/U=;
        b=Ndu3Uq8mOlAB8uENa/CanUwGnl5u+NHnytug+a0MJuUls0S5QlE6qZk6uoPv3It2gh
         R6dUOn8lRhCm8BWquhOzjpuWSCVmuyEcLMtBUURCj5YeqxHd74QnLOzqtt5rMuhpD3Uk
         roEQ10r7kvHIi7+cxE1UY7vuKIXqfSCOlsMYyRIPfpqZR2Rrz+B6MQD1Gsq/0P8RT8wU
         fbxLKwXrQA6PjXsX97iJpiQ9U0MJm7f3r1avDe51htCZLDaY6XbkcuFDGS8QgKGlpSQw
         tpngQnAp1IrUiJXxQQNcVGrcO1gbHPlDf/yLadFiqaL1c/WeajYucdHDMmtQg/TjOjLp
         q16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DBkev/tvu1fiDGLiQGbd1WuoTNLvp7U5tTXawjMYG/U=;
        b=Uou9+1pMfMMlWmWgWyPzqhvwRhYKcQ5g/2s/BPZXk9BPWJQUeD2b08tRMpLCPO/VsJ
         5yzVb7yBaTyDUM4ZjPxzQ8xWG9z8NuCD2xcA8ZGKuNRDCj1+0D3oZaH7AQs0enfEr/pI
         uFkxWrKjwUkMThJrBeO7FUtzw1eUJrUDiyictMHShBJ6W7lMzOl5n6XIjhUORoRSWDc3
         uN3218iozrJHZGlIkDsCEYT09GpBTz6Ut+F0jPrqoz3GrzC1mAy+3zlOEPplp+RYgb+R
         bDA26KchAqLeWx0DscArCdDS1fxqoHFIzW8Sl9dZih2wMGRJvXp/DtjntGK8ZCknOnQw
         d6NA==
X-Gm-Message-State: AOAM530nbGFWrZl02T1zCv+CbKn2XKWwxzi+XygHlFW+zUCnrBGYZQMp
        cF6y/vCa/XO1cyp2byGX5piN9shTUoD4FHGU
X-Google-Smtp-Source: ABdhPJxCGL34hWekjNcc6JUXVYWE+M4duJGVRTFnKvcir+Dci9nYUFO8mc8LR5hw2WnN9ntzcklsNA==
X-Received: by 2002:a63:742:: with SMTP id 63mr1689192pgh.295.1597913424191;
        Thu, 20 Aug 2020 01:50:24 -0700 (PDT)
Received: from blackclown ([103.88.82.201])
        by smtp.gmail.com with ESMTPSA id h3sm1731449pgj.4.2020.08.20.01.50.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Aug 2020 01:50:23 -0700 (PDT)
Date:   Thu, 20 Aug 2020 14:20:12 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     jerome.pouiller@silabs.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 2/6] staging: wfx/main.c: Fix a spelling mistake "negociate"
 => "negotiate"
Message-ID: <99deaab6dbe1d1a8325ec7f340109d9f9b5026fb.1597913333.git.usuraj35@gmail.com>
References: <834139101223e627665c939388cd7c542920c531.1597913333.git.usuraj35@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <834139101223e627665c939388cd7c542920c531.1597913333.git.usuraj35@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
---
 drivers/staging/wfx/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
index 11dfa088fc86..4263f912760b 100644
--- a/drivers/staging/wfx/main.c
+++ b/drivers/staging/wfx/main.c
@@ -384,7 +384,7 @@ int wfx_probe(struct wfx_dev *wdev)
 	err = wfx_sl_init(wdev);
 	if (err && wdev->hw_caps.capabilities.link_mode == SEC_LINK_ENFORCED) {
 		dev_err(wdev->dev,
-			"chip require secure_link, but can't negociate it\n");
+			"chip require secure_link, but can't negotiate it\n");
 		goto err0;
 	}
 
-- 
2.17.1

