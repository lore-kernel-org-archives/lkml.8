Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B998C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9E682074B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BELLA6N9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbgGQUPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 16:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgGQUPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 16:15:52 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DC1C0619D2;
        Fri, 17 Jul 2020 13:15:52 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f5so14034830ljj.10;
        Fri, 17 Jul 2020 13:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pGSWJ5XYOtcYSjTY3+CBpiz/oD76kPsZM5XqQ8FWvSY=;
        b=BELLA6N91lnpbdhxonBdgZmBUyrDCvC+AJuWnPbHUjorHWWAiYkP/evijphwa/OX1x
         YeFlbj6YB5jlGA/fsG/t+r03EL6zRuUjHLPrBtgqliVc7Hd9kL4rYdr0C3PditKj8WBy
         qAIuJOUr1KOxGJ734crwoBgzpRjKccfHFkAk5Dynfw+Bqi8Ae+vDAP1u5zpLn8PloLNy
         bfobdnrO2RCG5JyFcQeu0iE5lMepTDkksou970p948VIyFmMq8eEzGQFjw933huhS91P
         g0jg8ne/+S8kSRtZEaAt57hxW3iSdfrAPuIpMlNqmLEo4rd1yJdBj//WhGUt8tp1T2FY
         GHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pGSWJ5XYOtcYSjTY3+CBpiz/oD76kPsZM5XqQ8FWvSY=;
        b=oiaznSb1W9hlYpkz2GFghp8kFqh/7kaqJcN4VDgWX0/Dw9WXOz/JT8Oj0JIX+5expL
         yK+g2Onz1U+57FF7NukA6wArorPKmxnG2d+z3KLc0Po0G89hq3DjzLPHUK+ayHa4ZlRR
         t7x6WTu+IuCFYOR1EP5Jo5cfs5gpz3W0AV8GcffGegwY9tW5nYuKJXas3FnlaLDHEqE2
         zocQiriOL8jmAg2euF6hUn5cEr7pCrzStljBF0w48GFk0yCSqd/KdX9O0o8MDcFGCNeL
         s3FTltcuuEnMQMPd8L854cGTaGzGgmnrm5e3Zx2F9HX6ia9rjRPGD8XjnR3q8rn9gyDW
         oXgQ==
X-Gm-Message-State: AOAM530jMLrFovQA1wp+QDRVcXQkbsP27W9deSuw/n8D8+8nFdKGGDZJ
        Y5RFixXTn9njYkLQBYkFfswbKHOj
X-Google-Smtp-Source: ABdhPJzGg/3QGq9nWf3y7/hzCu0T7c59zBG7m6H4CCp7NGUQevFAgTUsL9a8rwWlbc2nt1kxemJEcA==
X-Received: by 2002:a2e:978d:: with SMTP id y13mr4982584lji.227.1595016950819;
        Fri, 17 Jul 2020 13:15:50 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-76-4-184.pppoe.mtu-net.ru. [91.76.4.184])
        by smtp.googlemail.com with ESMTPSA id g142sm2056988lfd.41.2020.07.17.13.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 13:15:50 -0700 (PDT)
Subject: Re: [PATCH v4] clk: tegra: pll: Improve PLLM enable-state detection
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200709172057.13951-1-digetx@gmail.com>
 <997361b8-4466-cdf0-beeb-eedcbeb48597@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e713d98b-deab-f0e5-6224-6c1f13a37b46@gmail.com>
Date:   Fri, 17 Jul 2020 23:15:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <997361b8-4466-cdf0-beeb-eedcbeb48597@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.07.2020 19:55, Jon Hunter пишет:
...
> I have tested this on Jetson TK1 using u-boot to verify the behaviour
> and it does indeed work as described here. I have also ran it through
> the automated testing we have for Tegra and see no immediate issue.
> Therefore ...
> 
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> 
> Thanks!
> Jon

Awesome, thank you!
