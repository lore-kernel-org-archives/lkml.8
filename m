Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDEFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9E8020659
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ofK7eD8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbgFDUL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgFDUL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:11:26 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6E3C08C5C0;
        Thu,  4 Jun 2020 13:11:25 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id n23so8927645ljh.7;
        Thu, 04 Jun 2020 13:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XU0sQ4AkY1li005iXLFGPT/yJrACPsD+D0QUcwKxbto=;
        b=ofK7eD8B1/9BSCaSgojRaCOmwx01Ttt6nsbP4g8v2aLHAkH8xvErsn+Td7xlEDLlUN
         MBl3OUUJDhmzTCWBpdPLbeh4Y+oX5fZuZaJHgkU1SaZ9F2msGWYkEewBtG+fOTmUX4gE
         RSuLeFyxSKShmRKWomc4bC7nYahl5KUJIMHV/5A2aGTxZsYKSmO3tLhJFrGZk80okEyV
         CO0zEe+puJNnWbGo7uP2SLGbRR89p65GVVfEFaTrLEPksbLXcGgq23TBBLTsQ5D/jIVF
         EoKyy+YfwXcASnsw02P0PSozsMqB4OB4Q6Jo5lIGJHkfIVAj06UggOCS74xPVi5JdkSx
         X3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XU0sQ4AkY1li005iXLFGPT/yJrACPsD+D0QUcwKxbto=;
        b=VR/azh3wI5y5ixQbSQyq9bNDyyExx356vaJEgdaTqtdFPl/RVTuLIQrjE18uZ4Vboo
         1Uof8jDohjRhwPsNg+UQp4I/IcKFTBvzYC3VJNUTbtOGDWviMpzh34MoXqy3oZreTLZK
         v2PWiIbyMat85wuDbANmCnV8H382PJlefRHhtZ4xAePUN6y4uaoh9ineVXLpo9n3VV4z
         279ksccnASJ/PuqHHEYbqJ3kAOS94PaTPolDe9ZBT2ZW3QWd+rslGgxkI+7LQ8qq9qP3
         l2kKE6bwZSwklgbRjokaGRRgO16xE5ObaB6E2LbzHuqjwv+wh57eiUs2mzf+0jiC+ZJT
         o73Q==
X-Gm-Message-State: AOAM531b8IuiC+MPBaddxq3Ic7KvofDcPANE4IujLxd7Wm+wijQlxH+0
        Z73taC3il29qDrJJ8ClAWarbrcoL
X-Google-Smtp-Source: ABdhPJx0A2rPrPu2k48Hoi2XL4mtgbkathz1czvfCgSp5jecedoeGvSXplvI9Pkp7ZF0kezRsDI5Fw==
X-Received: by 2002:a2e:2e08:: with SMTP id u8mr2814161lju.132.1591301483156;
        Thu, 04 Jun 2020 13:11:23 -0700 (PDT)
Received: from [192.168.2.145] (109-252-173-94.dynamic.spd-mgts.ru. [109.252.173.94])
        by smtp.googlemail.com with ESMTPSA id c4sm113241lja.56.2020.06.04.13.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 13:11:19 -0700 (PDT)
Subject: Re: [PATCH v8 2/6] ARM: tegra: Add device-tree for ASUS Google Nexus
 7
From:   Dmitry Osipenko <digetx@gmail.com>
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
 <cf73df1a-92ed-f509-74e8-1c847945fb14@gmail.com>
Message-ID: <16146336-e853-0130-3d07-d5352546453b@gmail.com>
Date:   Thu, 4 Jun 2020 23:11:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <cf73df1a-92ed-f509-74e8-1c847945fb14@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.05.2020 15:01, Dmitry Osipenko пишет:
> 15.05.2020 21:18, Michał Mirosław пишет:
>> On Fri, May 15, 2020 at 12:36:50AM +0300, Dmitry Osipenko wrote:
>>> There are few hardware variants of NVIDIA Tegra30-based Nexus 7 device:
>>>
>>> 1. WiFi-only (named Grouper)
>>> 2. GSM (named Tilapia)
>>> 3. Using Maxim PMIC (E1565 board ID)
>>> 4. Using Ti PMIC (PM269 board ID)
>>
>> Hi,
>>
>> I've briefly looked at the PM269 devicetree (PMIC part) and it looks very
>> similar, if not the same, to what I deduced from the TF300T kernel.
> 
> Hello Michał,
> 
> Definitely there are board parts that are reused by different devices.
> This is not surprising since most of the boards are designed by the same
> company.
> 
>> Those devices don't look to differ much from original Cardhu tablet
>> devkit, so maybe the trees can base off of that?
> 
> I don't think it's really possible in a case of Nexus 7 because in
> overall the used hardware components differ a bit too much. It shouldn't
> worth the effort, IMO.
> 
>> I would also guess that because of this 'ram-code', memory timings would
>> be duplicated between devices. I can see small differences between
>> ram-code=1 timings of Grouper and TF300T, though they look like arbiter
>> tuning differences. I'll have to test if my TF300T works with Grouper's
>> settings. In case they work, could you split the memory timings to another
>> dtsi file?
> 
> Yes, perhaps this could be done. The memory timings on Grouper and
> Tilapia are pretty much the same as well. As you noticed, there are some
> tuning differences of TF300T in comparison to the Nexus 7, the same
> applies to the Grouper and Tilapia variants.
> 
>> BTW, shouldn't EMC timing set match MC? I see more frequencies listed in
>> MC than EMC nodes.
> 
> The MC timings are exactly the same on Grouper and Tilapia, but EMC
> timings have a very minor differences, and thus, the common.dtsi misses
> these differentiating EMC timings, they are defined in grouper.dtsi and
> tilapia.dts.
> 
> I guess we indeed could try to select the lowest common denominator
> timing and re-use it. I'll consider this change for v9, thank you very
> much for the suggestion.

Hello Michał,

I tried to investigate whether we could unify the memory timings and
it's hard to tell. The values are mostly off by one in most cases for
one or two registers, in others cases a memory-chip feature is enabled
or disabled for the same memory module. It certainly feels like we could
safely ignore all those minor differences, but I don't have enough
expertise in order to decide firmly. In my opinion it should be better
to leave the memory timings as-is for the starter, we could always get
back to the unification later on.
