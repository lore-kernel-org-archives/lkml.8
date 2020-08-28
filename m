Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251A6C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF7CD2078A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YDvbZll7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgH1KJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 06:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbgH1KJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 06:09:42 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A79C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 03:09:42 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z9so398774wmk.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 03:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=m1YLyJUJCn3oBul9/khpe2532Xp6POTXvt7taeRkGPU=;
        b=YDvbZll7Ma7sTT+UPVORezULJlnx2tLfQ5IeE3Ehw57Kq2kkU/64SeqXuWw20swHB3
         DRSP1n7jHPr8urmDdaKZSWN+tS6LcvCpPSGokVwqyHBZ5IvOprC+08jw+ruC99ayLMuG
         8atji1mzhlt/j6cS1lgrOfyGuwEcNpksJ0etGBqElxC6aXiAhR+hQzrS0PzcfF7Qd6Ux
         oXeBNlOxbPHK4b0Zo0A84nlF+KGFkhzVo040o6iK1myBSFcKSWVru5dkp0z4tzSwLfK7
         LP9lNSlKR5ZaMMfDdYgCsNu4oLwPZAVk2SssF2ZcRVPK5CD3bjwFQU1KXK3W6xzh8aEN
         yqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=m1YLyJUJCn3oBul9/khpe2532Xp6POTXvt7taeRkGPU=;
        b=cAeRxEprVFGsHli0gCihvOOGJEL2P5BqWezDmTGt6ohTGfSMDf3sc0wBhBIfs5Nrbr
         FQzKULfUJAWCcSF5NUYtd6cBZ9LC/SAxuMxKtLP58H/MQ6zt5xzo/kWki4RjaQVzaQVc
         qcoqgjISpgvAYE0pL2p0ukQK/SztiUScdPko2eaFzFjV0fu3r7JF5LjW2MZTt2IZdIPQ
         4s5N/oOt3ar1fAQzxIUv81ucDUehdNeE4Bh3BAjtoRVXkOEZeghK4ZXi3dakKm0wbfxt
         Jq5ntp+ilHZknTqpQLSBWq7jQbKAhhfp6e8RDmbMaPLS41D0XnaoOXaf5bJjR0/4jSAH
         1cQg==
X-Gm-Message-State: AOAM5335xctTHLC+wYmkco03faXlZ5z+5a4NCSXX2+VL7q1DQiclPjvC
        dHpFnPlQFzy9D6JSTlr3uZMY+w==
X-Google-Smtp-Source: ABdhPJxgckZPiiORSGh1t7YPnXLaoCx7sqGLxWs0rDpMahar5tKh4ddv01PRLYLdrPq+EKDyrsXwZg==
X-Received: by 2002:a1c:541b:: with SMTP id i27mr837248wmb.179.1598609380973;
        Fri, 28 Aug 2020 03:09:40 -0700 (PDT)
Received: from dell ([91.110.221.141])
        by smtp.gmail.com with ESMTPSA id c206sm1419164wmf.47.2020.08.28.03.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 03:09:40 -0700 (PDT)
Date:   Fri, 28 Aug 2020 11:09:38 +0100
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
Subject: Re: [PATCH 1/3] mfd: madera: Simplify with dev_err_probe()
Message-ID: <20200828100938.GH1826686@dell>
References: <20200826144935.10067-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200826144935.10067-1-krzk@kernel.org>
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
>  drivers/mfd/madera-core.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
