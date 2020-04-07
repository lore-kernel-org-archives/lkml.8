Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F50AC2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D252076E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZtSbL6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgDGQiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:38:07 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42465 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbgDGQiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:38:06 -0400
Received: by mail-lj1-f193.google.com with SMTP id q19so4445935ljp.9;
        Tue, 07 Apr 2020 09:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wJFq2XOe7RkgNC35l325ZwPjkblMAPqbWKh6AWFgEI0=;
        b=LZtSbL6m49RtrXGKLs6ozpHCCZbdsGsKQFHI9bDe5IvhMKvsuEEobgcQcQhC+xgiYx
         RXlUoeXJF7fOQUm/mxXaRyqAF97pTd4ZOqouJ87iVsazVMkNQ8+tfJCIcm8Ekw7P5szF
         vVQvmXECwVU3ko/oKpjLx4Uu7sWBZlKAbRGB6UGttmr7RbNHhz74+a6S7O8B+6asnu89
         JcMAQL6I2mpP7Q4+TFehmxU0eME9LFBO7J2mFbCHElMZjH/R3fwxIDRlqLbF/i9Km+6m
         10ut7kt62Klk2PiMBkihw5YRC8NzXRjFs3M7NVqqBpByByJrUFGTOPcmWNkehvMnesDo
         NVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wJFq2XOe7RkgNC35l325ZwPjkblMAPqbWKh6AWFgEI0=;
        b=gY3aRiViPVjyzaMDm8zxP5IQD70fE5EIJM5duL5+8tMG3dp8WemWhYq4qT7gIrP0gg
         hjjK5zuitdMQLfZ6z21H3HNi9j2B2amqQdhNkmwGpvVVE46pLClSYGyLLpVZAUodY3Yk
         tjKxU/pYKK3xM0n/R+PsKvgfFWrHf3cytB6oPdnCLoobzs7oZMKep3ZSowUlz6l5h6fS
         5E6JOXcmXQwuOSewAMPzk2zvF+nwTwmzLoV5OSyNnC749nhWOuSkSwaXHWfrooSasKN8
         A/WBNhyINOLUGcKNKx+0wv183o3s5e+4bFtuYV1G+CQnuZ3huIJGsg9uzycAAT82YNQi
         F9XA==
X-Gm-Message-State: AGi0Pubr6nMK4mg0kYAHlSS/WDrpiHhH3JP1YE0sho5lsdK+MBO0tmwb
        F5QlyYIG3HygA933JbQG6Vcsn3i6
X-Google-Smtp-Source: APiQypLRXTVLhUyQXvlFZhdg1KqTBz6jb+pJgadbyCplIwX4sPW1MzmAkLnY16yhAcVeTQdzNFdVbA==
X-Received: by 2002:a2e:920b:: with SMTP id k11mr2345064ljg.46.1586277482811;
        Tue, 07 Apr 2020 09:38:02 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id j13sm3854133lfb.19.2020.04.07.09.38.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 09:38:02 -0700 (PDT)
Subject: Re: [PATCH v2 6/6] ARM: tegra_defconfig: Enable options useful for
 Nexus 7 and Acer A500
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?UTF-8?Q?Pedro_=c3=82ngelo?= <pangelo@void.io>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200406194110.21283-1-digetx@gmail.com>
 <20200406194110.21283-7-digetx@gmail.com> <20200407100829.GB1720957@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <70ad6fd6-9603-a114-2d0f-608110b68c0b@gmail.com>
Date:   Tue, 7 Apr 2020 19:38:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200407100829.GB1720957@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.04.2020 13:08, Thierry Reding пишет:
> On Mon, Apr 06, 2020 at 10:41:10PM +0300, Dmitry Osipenko wrote:
>> Enable several drivers for hardware that is found on Nexus 7 and Acer A500
>> tablet devices. Please note that some drivers may require firmware files
>> extracted from original Android image.
>>
>> Link: https://github.com/digetx/linux-firmware
> 
> What's the license for these files?

It's either GPL (like touchscreen config) or something else
redistributeable.

> Can they be made available through the official linux-firmware repository?

Yes, but I don't know yet for sure whether it's really needed for all
firmware files.

For example, the T30 Broadcom WiFi doesn't work using stock
linux-firmware, it's on my to-do list to try to figure out why.

While Bluetooth FW seems to be reusable be many different devices,
although (AFAIK) nobody cared to upstream it to the linux-firmware.
