Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6543C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 20:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD466206F7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 20:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pBoJdxmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbgDHU4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 16:56:42 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36516 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729034AbgDHU4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 16:56:41 -0400
Received: by mail-lj1-f195.google.com with SMTP id b1so9228549ljp.3;
        Wed, 08 Apr 2020 13:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k7W1LSJnyBpBqS6USdNla5UnwT1uvs+x6GmGI5Wj1nk=;
        b=pBoJdxmRrElfPueYY2Z/y2jY4IqgZdcVTGcqViSbQlhCjSyYL8OuuY5tmwsidneJhw
         gRm/A0eAPRpUuKE0DRjpI8zYPJcX/7+bkRjAKqa8M0HKu0YkWUJHnezPeBDw9TcLTpTV
         uWNkYEQ4+cDVYMv6PsL4FVpsqwdm5juxa3W/1lOO3MeB1yW+/LJ0inrn5bVhgJ3wuu75
         R7Bl9LucLBaRFVBuxOTnYB3JuXzMl2M2oyJ+mPWLtTGdaE1R6I6Kgj/yyvXy8CWsKTB3
         P86hdOIyK92Q5VadTjGxqvDgMHQ7RuRgRIgGNbERKuonReXgz9mAJB7amQnpzONTmfAG
         +ZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k7W1LSJnyBpBqS6USdNla5UnwT1uvs+x6GmGI5Wj1nk=;
        b=rryMLqfydhycoMNqWkxiW3Zuh7XceEBOK80ZKE4M4Abq6iuw3/EOc4tw3KLaTnvxQm
         WL7rCqivYZ8oeiK3qoZx9CrEm/tC5NQ4qZ7FLZWiWFkhYRYhDjBHWxaR0g1ClDNr5TVz
         GCipyim5ngLhsPxd9493Q8T73aNh0nbAYsxGtxIoz8oG0b6+TQ+Fz0h0fD3wsITHhxUN
         tsKA3EQWU0+3gMz1o/jpGTqBYatzP+ckH8nPJXRdbWOwUDcOaE1Bynw0f2BQ99kHTJPD
         irh+uRFh5d72po8cDGe/HyESUzhb+IryXfESS+aSMoxuk6F7t1fW9HYh6PFQoTO1bhJN
         IfeA==
X-Gm-Message-State: AGi0Pub1DsTiCJXgm2FbNJOLGDpwUZOPMyyoPXKHXTSw1jrOEhHBOVkl
        XxIsYCwd+1hCQs3z14AkxX8kF4TV
X-Google-Smtp-Source: APiQypIVrQsd027XKa4Gyc+it5YmFALZZ5Ua78jTKySAoL8q4aGBDzUR4xeDBoh2fBDrrta+RRuHog==
X-Received: by 2002:a2e:3012:: with SMTP id w18mr6354389ljw.100.1586379398846;
        Wed, 08 Apr 2020 13:56:38 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id z7sm1905199ljc.17.2020.04.08.13.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 13:56:38 -0700 (PDT)
Subject: Re: [PATCH] soc: tegra: fix tegra_pmc_get_suspend_mode definition
List-Id: <soc.lore.kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, soc@kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200408190127.587768-1-arnd@arndb.de>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <50869779-9a58-4248-a189-e51bf806695e@gmail.com>
Date:   Wed, 8 Apr 2020 23:56:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200408190127.587768-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.04.2020 22:01, Arnd Bergmann пишет:
> When CONFIG_PM_SLEEP is disabled, the function is not defined,
> causing a link failure:
> 
> arm-linux-gnueabi-ld: drivers/cpuidle/cpuidle-tegra.o: in function `tegra_cpuidle_probe':
> cpuidle-tegra.c:(.text+0x24): undefined reference to `tegra_pmc_get_suspend_mode'
> 
> Change the #ifdef check according to the definition.
> 
> Fixes: 382ac8e22b90 ("cpuidle: tegra: Disable CC6 state if LP2 unavailable")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
