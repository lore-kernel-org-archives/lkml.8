Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7ABC2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E9620780
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+TJUW80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgDHOkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 10:40:06 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:47088 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgDHOkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 10:40:05 -0400
Received: by mail-lf1-f67.google.com with SMTP id m19so3274703lfq.13;
        Wed, 08 Apr 2020 07:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mT95lQCkhBdMpNK+wCwJVLQFubt0We+EU+RGsEst00k=;
        b=C+TJUW80s4ICV4iIDL2Xv4P2rEaAfprrIC5vML/OW4ADtGz9mm/CdS1YrccnZhK5z5
         xW5Tq/fQ96IKuaJg0oaxXjzIOEZ0QaMG6dG1zSELO7OrNgHlZSRt0PpAfWND+2jdhmir
         m5KBfCJ9veDqtgAPLQikb3YOUqNSk9H0CGMDsqRuhW8ddQfFKtPSH8CtfJyQOiATnEkA
         WEuZTvKP7boIL0mkbFcQAcDXrQiWTjB1efgB9j7ud5Ib4Vyy9RaE7jZpyuNHaYzee8ca
         Yug3xife/Bk4xo9QRF/GbHzvDxDaJ5GCPHiPYe8L4NSmEsQy/LMe2vU9qg2g0+NNpzrz
         GPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mT95lQCkhBdMpNK+wCwJVLQFubt0We+EU+RGsEst00k=;
        b=WVK6FqILY6iHEt+MTbKeSmjtBl5RuIvhA/5Icu1QqF5E0crNIvy6SZziCKnp4u3xC8
         TcESH7W5fScyGaqEs6c1IPWa4R8M1K6ExvtRWs07dzdO23ZdLY+T23AWrauCnV9MaYRb
         u33UBlwDMqDXtYZZ4FScKwLZjvrhNF9Gj6e5y66JWcJOO2Wh55vnJacdZlk2Hv9VCc9l
         tG0899fn1P9Lw3tV2cu2GWyXYHv1fEYqT8tVulsbvqnjzil15ZlPp+mGiaeV8OZ9Cm3d
         mo8P2nwuLtlbbEkIOs7ETDZEtEr8ydEWO2wGv186kFtDh45Upnkt3tW3m7a4l6qBMLIb
         sbtg==
X-Gm-Message-State: AGi0PuYGgmrYQ1dikIHsNk2ZnZLrmBUfita2lPd67VXjyxpMF9V7UFw7
        F4L+lKK3uF/TD+eJWseDtMaQMBvh
X-Google-Smtp-Source: APiQypL1MgjqXQVGY/+BzqIZTD/XQMvp4r63ch4UWxYMnhIjCPOfkGyERhubDt+w6UWbIxPESQ3AZw==
X-Received: by 2002:ac2:414f:: with SMTP id c15mr4788355lfi.2.1586356802923;
        Wed, 08 Apr 2020 07:40:02 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id b28sm16718683ljp.90.2020.04.08.07.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 07:40:02 -0700 (PDT)
Subject: Re: [PATCH v2 6/6] ARM: tegra_defconfig: Enable options useful for
 Nexus 7 and Acer A500
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?UTF-8?Q?Pedro_=c3=82ngelo?= <pangelo@void.io>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200406194110.21283-1-digetx@gmail.com>
 <20200406194110.21283-7-digetx@gmail.com> <20200407100829.GB1720957@ulmo>
 <70ad6fd6-9603-a114-2d0f-608110b68c0b@gmail.com>
 <CAMdYzYr76GUEEXgKippfCJDTU1L+A0UXTyO_B14vkOxVp_pijw@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7a12e4bf-43bc-0788-d20c-6681af705137@gmail.com>
Date:   Wed, 8 Apr 2020 17:40:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAMdYzYr76GUEEXgKippfCJDTU1L+A0UXTyO_B14vkOxVp_pijw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.04.2020 03:37, Peter Geis пишет:
...
>> For example, the T30 Broadcom WiFi doesn't work using stock
>> linux-firmware, it's on my to-do list to try to figure out why.
> 
> I've encountered the same issue on the Ouya, only the original
> firmware that came with it will work with the chip. (AW-NH660)
> I wonder if it's an azurewave quirk.
> 
> I've also noticed the Ouya specific configuration txt file seems a lot
> more involved than the standard brcm configs.

The T20 boards also use Azurewave module and it works fine with the
stock linux-firmware, although that is BCM4329.

It could be that the configuration format differs for the stock
firmware, but we don't really know yet.
