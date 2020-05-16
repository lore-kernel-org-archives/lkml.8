Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F242CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C978F20756
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVCSWv3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgEPMBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 08:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726197AbgEPMBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 08:01:05 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C593DC061A0C;
        Sat, 16 May 2020 05:01:04 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id g1so4974813ljk.7;
        Sat, 16 May 2020 05:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=maa80O9Mp0YSg09Dy+CLlBgK4ldcCteGDupy5daUMyw=;
        b=rVCSWv3GvdPBAeiy6urN8tEtdldaQnvhaZQ9mdrWjYe4VAEpAls26omi3YgUJpIjJM
         4WB8aax2Xg3hpPSC8++9rqjvfKc8fA2u3z2BvZ8rz6QiLq0Jo/uhGmIyey9O7oaF/uvi
         f+FAyof98u/ID0TUlIODdC/JgGqmZpnhPsD7u3XI92jXuZip+M2zEItFmsyvk6jq7qWI
         ch3xDek/U0S0AKLPziIm19M39BQ4m75WxCfPhOxJ8CWbofpRTMXzNGqp7WfmAQ36BOmZ
         e/9LwYKqIAnAzEzEXHBC9qnqZG0CSkssCNxWh+6dY+6thbgXB5suTUK6ydOR3+0CY/gV
         EKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=maa80O9Mp0YSg09Dy+CLlBgK4ldcCteGDupy5daUMyw=;
        b=pRHzehvPNyc6/79owQuCYmXAiXwT/WASA9y95aaojlmZWYSYpaWJvvkz3PJpvH7udB
         nSTABSsZkFaVaSItqreeu/Bex0top7yUb6y0hEP7oV9hZUzz+Ud1mhIjoFuqjkOWMI4f
         XiJ7xRYPj7qxnCE0I1DXUxB9t4G6fJwW0FYMFrJO6DZ9GQ06Kkbn3AMx6Tio88pXuOf6
         GOs+9aAnkCoPwteTQe7EaZ0IiarfEaYmL5yy2BCI62BZmIjugmh92yqx7neML21KArlI
         tbNvKikRfAB3OE4X0+j4En3QXZFh8LFZp+7JeR1dZ7aoqODlvzG5modtmF1mN41IpMyu
         LwXg==
X-Gm-Message-State: AOAM533UWrdUuvyDtrwHidS8BHqE2chzGH7YOw9vgcm003uYOSDCe1xs
        xuHMO4H1v4q6cKKm6+8Zc0cZRCKY
X-Google-Smtp-Source: ABdhPJwEif/nVkI+YlSLfYMj99nue1o7Kpg1fDFdSyNqRyhbvXbnghHDiJ28F3UWdG7PwqW9UwoPpw==
X-Received: by 2002:a2e:7807:: with SMTP id t7mr5157389ljc.151.1589630462545;
        Sat, 16 May 2020 05:01:02 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id b28sm2631501ljo.1.2020.05.16.05.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2020 05:01:01 -0700 (PDT)
Subject: Re: [PATCH v8 2/6] ARM: tegra: Add device-tree for ASUS Google Nexus
 7
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
References: <20200514213654.12834-1-digetx@gmail.com>
 <20200514213654.12834-3-digetx@gmail.com>
 <20200515181847.GA13860@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <cf73df1a-92ed-f509-74e8-1c847945fb14@gmail.com>
Date:   Sat, 16 May 2020 15:01:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515181847.GA13860@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

15.05.2020 21:18, Michał Mirosław пишет:
> On Fri, May 15, 2020 at 12:36:50AM +0300, Dmitry Osipenko wrote:
>> There are few hardware variants of NVIDIA Tegra30-based Nexus 7 device:
>>
>> 1. WiFi-only (named Grouper)
>> 2. GSM (named Tilapia)
>> 3. Using Maxim PMIC (E1565 board ID)
>> 4. Using Ti PMIC (PM269 board ID)
> 
> Hi,
> 
> I've briefly looked at the PM269 devicetree (PMIC part) and it looks very
> similar, if not the same, to what I deduced from the TF300T kernel.

Hello Michał,

Definitely there are board parts that are reused by different devices.
This is not surprising since most of the boards are designed by the same
company.

> Those devices don't look to differ much from original Cardhu tablet
> devkit, so maybe the trees can base off of that?

I don't think it's really possible in a case of Nexus 7 because in
overall the used hardware components differ a bit too much. It shouldn't
worth the effort, IMO.

> I would also guess that because of this 'ram-code', memory timings would
> be duplicated between devices. I can see small differences between
> ram-code=1 timings of Grouper and TF300T, though they look like arbiter
> tuning differences. I'll have to test if my TF300T works with Grouper's
> settings. In case they work, could you split the memory timings to another
> dtsi file?

Yes, perhaps this could be done. The memory timings on Grouper and
Tilapia are pretty much the same as well. As you noticed, there are some
tuning differences of TF300T in comparison to the Nexus 7, the same
applies to the Grouper and Tilapia variants.

> BTW, shouldn't EMC timing set match MC? I see more frequencies listed in
> MC than EMC nodes.

The MC timings are exactly the same on Grouper and Tilapia, but EMC
timings have a very minor differences, and thus, the common.dtsi misses
these differentiating EMC timings, they are defined in grouper.dtsi and
tilapia.dts.

I guess we indeed could try to select the lowest common denominator
timing and re-use it. I'll consider this change for v9, thank you very
much for the suggestion.
