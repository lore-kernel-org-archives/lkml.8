Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1346C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97D0E208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E/6Z7lX1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgH1KKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 06:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbgH1KKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 06:10:47 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D48C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 03:10:46 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q9so415715wmj.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 03:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4JMFr37STORIgQm4bGEPTAK7/SSI+Z3+hSKZb/jWMU8=;
        b=E/6Z7lX1dsrGY7Qz9e8ERJFdEWAi6Gq+LQeGQ6iQSyk4/VPsQA5bwQc95uE2CYoGf1
         2Gdrh5HzLDnqKQJSGCpWN1EPyRBfF5SnUHF3ThWjBAt3AneY2bckqlYuemdLTl/4JFRN
         Dvo+6qDabXIQF/REsdK6ydQ9T0ZhcZUe53vz/jmnbj5ij4+nNU09HsD9lrNPjw8garom
         fAhtPMM6z8qTWZ8iXQ1WrlacR5jSIKFC9nXHkmoO3/pDyrtpmglCAkGHA7asTGIvZ4p9
         qDEV6w00/ZPPS6yvvZ7QjqBcvK416IOiANM7xgZXferQQ5OJNlAlUxHseyoFyT6cyxnW
         yBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4JMFr37STORIgQm4bGEPTAK7/SSI+Z3+hSKZb/jWMU8=;
        b=tOmA1Sz4z7hEqbdXUVDyZAcerkt4/EpNsPjVApXwMG+lSZ0hW8C6Xm3fRNyCftP+Ud
         oA1fy/BCCPvzRhMueGyJ5/kaqJpRiEwZnkty8Eo/9HaP/ewGwMovhquJ6z1JjxqFH9FK
         IzNCRV9mbuYGDMAvl3Egh8s0qXf8aJ7cnQXV0d7oV4vxap5/2d5wjs3tf2kN9vZdXQDk
         igBNEI3a/bXjUXtJpxnpRjA694DwWLfRLfU7zXVoXqJ0ZGKMXQKMZsdoU8hGx+HiA91C
         gnoQvoDSk4E70ud4MHE7i7gi6gFNu2VUkQkJ+OycBD4my3E4AHwSV5RaNfCmAYYdqGL/
         neQg==
X-Gm-Message-State: AOAM53335FODdwKX0xUdTiqooeebVgl6w+DTJMsUfRFG5qOq2QwIjHCa
        EHvC8uL6RCVWCugN4Fd/H33yCA==
X-Google-Smtp-Source: ABdhPJyd+zEtUn0Pjz24wfI5YhO/ufo1ZrWKml5JZ0SodFr9cwTiaHJAlEhrfM6A5OyXlNedrLY2Yw==
X-Received: by 2002:a7b:c316:: with SMTP id k22mr898552wmj.150.1598609445574;
        Fri, 28 Aug 2020 03:10:45 -0700 (PDT)
Received: from dell ([91.110.221.141])
        by smtp.gmail.com with ESMTPSA id g18sm1243165wru.27.2020.08.28.03.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 03:10:44 -0700 (PDT)
Date:   Fri, 28 Aug 2020 11:10:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] mfd: wcd934x: Simplify with dev_err_probe()
Message-ID: <20200828101039.GJ1826686@dell>
References: <20200826144935.10067-1-krzk@kernel.org>
 <20200826144935.10067-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200826144935.10067-3-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020, Krzysztof Kozlowski wrote:

> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/mfd/wcd934x.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
