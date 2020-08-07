Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468C3C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 04:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C14F221E2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 04:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wdxYhCbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgHGE4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 00:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgHGE4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 00:56:38 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA0DC061575
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 21:56:38 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bh1so473347plb.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 21:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wd1MfQvSWLmmJO4zDD5azoRIzS7zA7zFDWuYNS3rHPI=;
        b=wdxYhCbW/m9+zY/y0s3LI+VPcTgpUnboEDxgwnGr6LXNgCYUf5jwgSrVZ9BP9ToPOC
         ObrAx0k+uhECSfgtk3CqG7vaa7z/DqKeS3kuNDs0gmWC9QUkHXWs3AH8xvhmwKQRC0JC
         Dg/eOOioHwt5SvDMzv6zMwZ8ALjjGcHqRaQExTVpmEiH6ZsDa+4kkE3gZwlayWUHWH72
         h7Mvr1zwPrdplvHtkSj8G6PVOUFheA7Wh3JF5zz2IK7MBBNaO52GZlf5GxAb0woqOiJb
         7D4mu4iACmUXP9uKJAzyr4MmiIQiOKvyfM15qk8+28/xfJWbY9IUbT46EwxyqcLUCoGo
         tVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wd1MfQvSWLmmJO4zDD5azoRIzS7zA7zFDWuYNS3rHPI=;
        b=NigfFc2bNIrgQp0khfTBKF8d7+V1KWhqO240V8MF/SQ4omesKtCO3tE/gz6An1CfuC
         RVnNzcW84QzWZJVXrgMXkQQcuMxzpCWBwXVZiC1iWWaX8hoq8XK682ZJbd7QK7rp7j9+
         DbCXPtIZvaFST8YGlW8Gpy8DuO7fEdpl0KPrj5Y7BjVWCwG655rXaFTFkbOQTnZz6rPY
         6MJdiV1hR3NDLUjO8LlDRlY4QHw1L2Qe+yxU4o9O/hjuQpOCZxtv4y2Qy1TAgimc1rPF
         PPejX2UXcJdF2A1tkTcdkxHVi6BfNpSik3C6Zb5jsgimWWj9V2oOSFUMcX5fQAPrxS3/
         IWsg==
X-Gm-Message-State: AOAM532rsn7OQOYQLJ4AArqaCWY0xVW0ZzepiieukJqWLEzyZwKwIhGq
        izSP0nZRzBKsSMRXMoGDC/SWAA==
X-Google-Smtp-Source: ABdhPJz9XIc3pjV5fb0FJWvryYU8Y62DTGqhWirVLCiOsji8ipi2ZdmEZzkrs4uzUoaN9T6Vh7TSoQ==
X-Received: by 2002:a17:90a:3ccc:: with SMTP id k12mr10904883pjd.184.1596776197482;
        Thu, 06 Aug 2020 21:56:37 -0700 (PDT)
Received: from localhost ([223.190.59.99])
        by smtp.gmail.com with ESMTPSA id e14sm11011839pfh.108.2020.08.06.21.56.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Aug 2020 21:56:36 -0700 (PDT)
Date:   Fri, 7 Aug 2020 10:26:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 35/41] ARM: s3c: remove cpufreq header dependencies
Message-ID: <20200807045630.zq6gayz65rdxaiy4@vireshk-mac-ubuntu>
References: <20200806181932.2253-1-krzk@kernel.org>
 <20200806182059.2431-35-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806182059.2431-35-krzk@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-08-20, 20:20, Krzysztof Kozlowski wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The cpufreq drivers are split between the machine directory
> and the drivers/cpufreq directory. In order to share header
> files after we convert s3c to multiplatform, those headers
> have to live in a different global location.
> 
> Move them to linux/soc/samsung/ in lack of a better place.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/mach-s3c24xx/common.c                         |  1 -
>  arch/arm/mach-s3c24xx/cpufreq-utils.c                  |  2 +-
>  arch/arm/mach-s3c24xx/iotiming-s3c2410.c               |  2 +-
>  arch/arm/mach-s3c24xx/iotiming-s3c2412.c               |  2 +-
>  arch/arm/mach-s3c24xx/mach-bast.c                      |  2 +-
>  arch/arm/mach-s3c24xx/mach-osiris-dvs.c                |  2 +-
>  arch/arm/mach-s3c24xx/mach-osiris.c                    |  2 +-
>  arch/arm/mach-s3c24xx/pll-s3c2410.c                    |  4 ++--
>  arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c           |  4 ++--
>  arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c           |  4 ++--
>  arch/arm/mach-s3c24xx/s3c2410.c                        |  1 -
>  arch/arm/mach-s3c24xx/s3c2412.c                        |  1 -
>  arch/arm/mach-s3c24xx/s3c244x.c                        |  2 --
>  arch/arm/mach-s3c64xx/s3c6400.c                        |  1 -
>  arch/arm/mach-s3c64xx/s3c6410.c                        |  2 +-
>  arch/arm/plat-samsung/include/plat/cpu.h               |  9 ---------
>  drivers/cpufreq/s3c2410-cpufreq.c                      |  5 ++---
>  drivers/cpufreq/s3c2412-cpufreq.c                      |  5 ++---
>  drivers/cpufreq/s3c2440-cpufreq.c                      |  5 ++---
>  drivers/cpufreq/s3c24xx-cpufreq-debugfs.c              |  2 +-
>  drivers/cpufreq/s3c24xx-cpufreq.c                      |  5 ++---
>  .../linux/soc/samsung/s3c-cpu-freq.h                   |  4 ++++
>  .../linux/soc/samsung/s3c-cpufreq-core.h               |  6 +++++-
>  include/linux/soc/samsung/s3c-pm.h                     | 10 ++++++++++
>  24 files changed, 41 insertions(+), 42 deletions(-)
>  rename arch/arm/plat-samsung/include/plat/cpu-freq.h => include/linux/soc/samsung/s3c-cpu-freq.h (97%)
>  rename arch/arm/plat-samsung/include/plat/cpu-freq-core.h => include/linux/soc/samsung/s3c-cpufreq-core.h (98%)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
