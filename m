Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9FAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 00:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E83920756
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 00:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oxTXEciB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgHLATI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 20:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgHLATH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 20:19:07 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1ACC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 17:19:07 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c19so3113351wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 17:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=YEjwPZh5RXt3Ie4FbKarHOy1S3LP80s3dHh0ey0Ay4c=;
        b=oxTXEciBXvnoM4ZLAb8X5sfDonmIlC+BBp8vPKTxI3GL6ri2Fp0SBg69HUYV0+50dy
         hoaCxYBxWL7N/kYFMTRWL23dGWY4xtzMaBW6350pxKg9sD3t0bgXSyW9HkBBUNLB7+fn
         kdqveXEEa+wJnIDhUOxFrGuQEMXkBEEDCGEKbTWTGByO2v8fpAIccs1LlsDE/8AG8Usy
         lY7BnpqF3vUverHMsV+w5jpI/qoZaSHivLLBYPNlhT/bsdeljxKvF9vsyT8WDvdsEWM3
         u1kQ82vIkN/EeQVy7U5o0WqyH57XTsmvXB4O8y8iiI+u4PzL8XRrHsECY4k8Cx3L/FWR
         Wt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=YEjwPZh5RXt3Ie4FbKarHOy1S3LP80s3dHh0ey0Ay4c=;
        b=sHPtdy7y7Djcse1gPxRrnxABiwGsrm10pshRs7Mlc73hctYdowFFP0ZzNqAO7LPJgp
         uHfPsWkdVSiSZcRJQExfHmKUgwwztI/30N+6d/629yKfbmxaoK326h70ZOv6r5EFLZja
         vEx8+ywP6ckjq7iP+ycBxKjsxYJB3OosoMig2D4yG8/KdvNnPxX7rCZxkbqf07HcWI3r
         L0thXfDYHQTcqUPBza/0GSBMOHGF/szmS4zusOx11wsdCFmsry7VlyVKTla1J+vImq9f
         IIkf8v8hH3pi10eMBx8uQRy+HrIUlxn8lDovqSH1Ur08hH2y9+y/g9uG/XuZlADHucqc
         Oz+w==
X-Gm-Message-State: AOAM533smcHtwKyIaFNHNh6AU2sLe1n4+r4w+8RvEpXrJ3vNb0odF/2Y
        oY0XXn1/yOqo2UnIux2TS28wfg==
X-Google-Smtp-Source: ABdhPJx1rPs1jQi+VpfsboKy/mFx11ZgBxMh2H/MVyfAqyy8DznA/GYinlhj+AbBtVqFp1QrxeOV+A==
X-Received: by 2002:a1c:2742:: with SMTP id n63mr5827207wmn.24.1597191546141;
        Tue, 11 Aug 2020 17:19:06 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id j5sm747480wmb.12.2020.08.11.17.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 17:19:05 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, rjw@rjwysocki.net
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, pavel@ucw.cz, len.brown@intel.com,
        rnayak@codeaurora.org, dianders@chromium.org, khilman@kernel.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH 1/2] PM / Domains: Add GENPD_FLAG_SUSPEND_ON flag
In-Reply-To: <20200811190252.10559-1-sibis@codeaurora.org>
References: <20200811190252.10559-1-sibis@codeaurora.org>
Date:   Tue, 11 Aug 2020 17:19:03 -0700
Message-ID: <7heeoc3edk.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sibi Sankar <sibis@codeaurora.org> writes:

> This is for power domains which needs to stay powered on for suspend
> but can be powered on/off as part of runtime PM. This flag is aimed at
> power domains coupled to remote processors which enter suspend states
> independent to that of the application processor. Such power domains
> are turned off only on remote processor crash/shutdown.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Seems like a useful use-case, but i think there should be a bit more
description/documentation about what is the expected/desired behavior
during system suspsend when a power-domain with this flag is already
runtime-PM suspended.  Similarily, on system resume, what is the
expected/desired behavior?

Kevin
