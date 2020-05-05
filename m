Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8635EC4725A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6537E20836
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BybiyQGR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbgEEPdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730294AbgEEPdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:33:07 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531E1C061A0F;
        Tue,  5 May 2020 08:33:07 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id g10so1695913lfj.13;
        Tue, 05 May 2020 08:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L0UN3GdJ+vKgAwHZGo4xnJdgYYkX+IpknMqsaJEpZ0s=;
        b=BybiyQGRkSRfHqlJtOAL2TZZ9fIM9njtz/iec0blwnKARpU22PJOmso+P2a6V6WikX
         R4eEHy7CRUF88cnyTWXhANjldq+AG5XtduiWedAdSNotH3fRQs8Va+p783PpTYej0KMb
         2We1pvJxMHq9X7oGimCi+O0rQbSOreOqKXOViUlBvsVzgJB+GSrU3ewaAxzBOcIJZEjn
         wqZCWRPYctqXG1KVVDt7QdOjMBGIwfIp2nw9fZGKmPnwSsUnJb+2yuEHWuFy0ehSK432
         st/sxRG7FRz74WOO/pNovUFRz0o/FXTdYmduACtAL0jONMms2Xbwjn0//p5a1yavbXEd
         bgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L0UN3GdJ+vKgAwHZGo4xnJdgYYkX+IpknMqsaJEpZ0s=;
        b=ttFDso1wZX/S2eqhiHz6VRMmmc3dTlZ0kzp73PrzxE4hM7nQ35dU96oJJXja6/aZyl
         oEYoRr+SA/sTeTH63+3AfRaR43KGlJy553L/GuEmMJ2XrH00nF17HqSzSHoVwmzzQKJ9
         dcvA0ApLOgRc0b0D5aXm4oKWDR/5d9849VWy0RnkkayEnHAsYhsdocA1ndgTgls1+htF
         pq/LaroitMinSJ1/kaTryo9x2k6BbOinlHb/Lxw8+LcnX8zePGiX6HXnsk4BwaMh3Wlb
         4aKFZd0ieZcovNsRismIL2/l5pcYsKgLEoG3aF6i8IUgwEyLjsH18uxadez4bw5k3CnG
         5N9Q==
X-Gm-Message-State: AGi0PuaCNhld19hVnxXpyMqWXEBjrcI2dApce1wwJu0l9q0xXA4GgCXK
        W7aZnKpIInjuTEyrHm14In2jjzhF
X-Google-Smtp-Source: APiQypJzIQigA9yElUci4Z1uO/sOB3hgnu6E74GLqXTUAPfxzXJVk3uVF0WpPra2UA6plGy32awuag==
X-Received: by 2002:a19:cc92:: with SMTP id c140mr2058528lfg.34.1588692785272;
        Tue, 05 May 2020 08:33:05 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id r80sm2240082lff.5.2020.05.05.08.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 08:33:04 -0700 (PDT)
Subject: Re: [PATCH v7 0/6] Support NVIDIA Tegra-based Acer A500 and Nexus 7
 devices
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?UTF-8?Q?Pedro_=c3=82ngelo?= <pangelo@void.io>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Zack Pearsall <zpearsall@yahoo.com>,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200505022517.30523-1-digetx@gmail.com>
 <20200505151136.GA26776@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c34c3bc7-73f7-730c-1581-2e12f3e1d913@gmail.com>
Date:   Tue, 5 May 2020 18:33:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505151136.GA26776@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

05.05.2020 18:11, Michał Mirosław пишет:
> On Tue, May 05, 2020 at 05:25:11AM +0300, Dmitry Osipenko wrote:
>> Hello,
>>
>> This series introduces upstream kernel support for Acer Iconia Tab A500
>> and ASUS Google Nexus 7 tablet devices. Please review and apply, thanks
>> in advance.
>>
>> Changelog:
>>
>> v7: - This version brings support for a Nexus 7 variant that uses Ti PMIC
>>       instead of the Maxim PMIC. Previously we assumed that variant with
>>       the Ti PMIC doesn't exist in a wild, but turned out that it was a
>>       wrong assumption. In a result the device-trees are separated into
>>       more DTSI pieces, which combined together form the final device-tree.
>>       Thanks to Zack Pearsall for testing the Ti version!
> [...]
> 
> Hi Dmitry!
> 
> This Ti-based (PM269) version might be very similar to Asus TF300T I have.
> I'll have a look on your DT during the weekend.

Will be great, thank you!
