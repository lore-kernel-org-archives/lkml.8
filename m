Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0D6C33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 15:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FACC206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 15:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxJZParO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbgASPIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 10:08:23 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37212 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgASPIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 10:08:23 -0500
Received: by mail-lf1-f67.google.com with SMTP id b15so21982798lfc.4;
        Sun, 19 Jan 2020 07:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+7KYOQATip0h7rnxmjkNNHlDrDfQnXI4lJLsaS+raAU=;
        b=MxJZParODgEJH45y9oOfXM7GvrC92kSHtOfJj9qLBsTV5Gjvx+hMl3shhVNTKqhHif
         lz6xh9cWVVJqY4AAVhmPo6vdTLchPKHN597LaXLycAc/q+ZiSGPAHgQw9fBpPzynJkEr
         Rdf0LRaZRh8pC6YSiIx+3AxHOYacj0Y2o6jM+MAIRmqgPeGxotWwTAzfiZZ5uLv91SSX
         /yY62WyNMa33+8IFHOeaxQCF9keawKV+Pz84NYqRxkjVYqMEArtxsPVfXAo0Q0VOZv0F
         fYZJswUCJ5CVqtArI2odv9LfQmtUlHWij/WFG0AbEgAfsauBzOIp9tPYNxP06aqiS0lX
         YZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+7KYOQATip0h7rnxmjkNNHlDrDfQnXI4lJLsaS+raAU=;
        b=pliYhwbvUH/Qa2mJQsVs3KOj9iSrV1Vf9Q5ldwVPeB7WG0wyHTddNBZtt80gRuSnpO
         465qm2W4hEAeZwKIcKcgqW7+iu66y42lD/OAem/ucFGazerL+TIludKQi4+wITCZ6Yp+
         ILHkrDTssAO5F3jFLKOKsto/WHt7jOC4TmYjmkLat76xmlVkYiXo2SnLsfM09GS3VKRt
         19ks2a7CVaBq24QfGVjo7QB5sbooZglHmsLjLmI5iuQW/15bOYIXBehfAoZzZQOAvUY/
         eq0tGMedHoH4/L6a+lPz2x+QZGq8iZHoYjQgYCvs06n+pOaCi6P2Y32gw0WhL/sGOE4D
         tcTA==
X-Gm-Message-State: APjAAAX0aolXwhhgpeaPQHoD1pQZpoNr2yQd8xJ1ASsgkC6HEf9XA81r
        gewikawhzVrTPNsGJVcbLZDjcPR5
X-Google-Smtp-Source: APXvYqyFraP/PHzOgXIXY2Q/8zcn3zJTvbnVbwmmY7lx3EOBfqNOh2PP6rYfxUwcHzDbr7VkYzKsIA==
X-Received: by 2002:a19:7502:: with SMTP id y2mr10852990lfe.55.1579446500102;
        Sun, 19 Jan 2020 07:08:20 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id x23sm15277240lff.24.2020.01.19.07.08.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jan 2020 07:08:19 -0800 (PST)
Subject: Re: [PATCH v8 11/22] ASoC: tegra: Add fallback implementation for
 audio mclk
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1578986667-16041-1-git-send-email-skomatineni@nvidia.com>
 <1578986667-16041-12-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <bb571c51-9b04-9751-4298-22377108958f@gmail.com>
Date:   Sun, 19 Jan 2020 18:08:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1578986667-16041-12-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

14.01.2020 10:24, Sowjanya Komatineni пишет:
> mclk is from clk_out_1 which is part of Tegra PMC block and pmc clocks
> are moved to Tegra PMC driver with pmc as clock provider and using pmc
> clock ids.
> 
> New device tree uses clk_out_1 from pmc clock provider as audio mclk.
> 
> So, this patch adds implementation for mclk fallback to extern1 when
> retrieving mclk returns -ENOENT to be backward compatible of new device
> tree with older kernels.
> 
> Fixes: 110147c8c513 ("ASoC: tegra: always use clk_get() in utility code")

I don't think that it is correct to use the Fixes tag here because this
patch doesn't fix any real problem of the referenced commit, instead the
Stable CC tag should be used.

> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---[snip]
