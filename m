Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD1BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 04:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64449221E2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 04:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lqEZ9A/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgHGEyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 00:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgHGEyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 00:54:44 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BFAC061756
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 21:54:43 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a79so356489pfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 21:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Uw+hzHkkFQHpKKttBQnfQJy4eV1x+mEGfbQUFATKQ5o=;
        b=lqEZ9A/sLBE1dxCtyaaFdylpUwfG+ecetWBLdSWxJKfm/3ZqWSvRiYSlWMci3zYJOk
         larrrdPz5aE3fmGeE2b9BG/zphuVufLWJNP7RpYOa+bKIXgPntq4xKaFNajbj2S8y15n
         nsNd6F7jo6qfSc5j7KYJ3fhW75F8Qs2qicNfIlyTuzz94a0TSzbjgKVozaf/FmfKPTdX
         6PBOb2gVFj66mtHewKfR1RwdVpyP78vPZfHbQBMdv1WVDoTFyfFR/XKTCdG9ZAoH90QY
         AwwcBfB+Br8ZXzlQVy0uLdruT7fz45KrcsR4Hv0FiCoEdE5WI17QleyMfscJadW3avLX
         KgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uw+hzHkkFQHpKKttBQnfQJy4eV1x+mEGfbQUFATKQ5o=;
        b=b4CA8PjeiMvPgrnIs3jQycDywdueErCmfubcFSFnkHt0fFCieMneTUFizroM27pAO6
         qfKFKqA3Ds7cywX2amMxixinyWSEJyRywzJ5blEkwZ02aYebRwqAcldPq5FWYiXlEtNq
         tqLuN9U39MiCaaevdkH80jPUUktUpjFLjs8ilKAz1OP8fIuFVLi5xdHOaAI24GGG+8XE
         kWMP1urTf/KVmjqqHWPdVH8BqjVkxkz9mpICL7X3cPb/OFSCs6fAocNPE3JnlUAVk+sa
         Tb9CP6JuUHPLnar8wm+zooTn6jSMvB38k//KqfgtW82Dg6fANj4Khc8NYgr5FoS+tXIy
         yJFA==
X-Gm-Message-State: AOAM5306wELdKW4ST9pulUyJ7yGxTIP83Zx9rS9uVqEbSLWYVjooWFk0
        lIs1Mu43HyB8hU+qA35dNzQE6A==
X-Google-Smtp-Source: ABdhPJxzEGct9GafiVQIRxPUdzuAW68/6ub98vgg/4bs88pQQ5Y01QiyZQGfAIlFu7w/7t8F0tWvYQ==
X-Received: by 2002:a63:954c:: with SMTP id t12mr9852650pgn.387.1596776083077;
        Thu, 06 Aug 2020 21:54:43 -0700 (PDT)
Received: from localhost ([223.190.59.99])
        by smtp.gmail.com with ESMTPSA id h63sm9182699pjb.29.2020.08.06.21.54.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Aug 2020 21:54:42 -0700 (PDT)
Date:   Fri, 7 Aug 2020 10:24:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 34/41] cpufreq: s3c24xx: split out registers
Message-ID: <20200807045436.m3fsaew4632l36u7@vireshk-mac-ubuntu>
References: <20200806181932.2253-1-krzk@kernel.org>
 <20200806182059.2431-34-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806182059.2431-34-krzk@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-08-20, 20:20, Krzysztof Kozlowski wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Each of the cpufreq drivers uses a fixed set of register
> bits, copy those definitions into the drivers to avoid
> including mach/regs-clock.h.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> [krzk: Fix build by copying also S3C2410_LOCKTIME]
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
