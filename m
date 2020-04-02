Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97834C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EED6206F5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXLJyF7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388851AbgDBOw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:52:58 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:47011 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388828AbgDBOw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:52:58 -0400
Received: by mail-lj1-f195.google.com with SMTP id r7so3487138ljg.13;
        Thu, 02 Apr 2020 07:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OL/tVc1Ch0fuHCWGLDW0Ztss4EfxD7apFgMsfQsUr7k=;
        b=XXLJyF7xqJnLsf3hdgwiZ4/6fLutg8R+bEQTaJJqAeYpNor8HeBOvDfKkexPjnzahg
         +frziBQdgK3hB1ePSeped/hKH0YLg2DoJjK+3kGLOUiymHQfuQELDwVhuCh1wN/AEsj3
         zIfCwHuQfaSXAhgByi1w+ZRufw9ziTNKPlAT3+62tzm6ll/lgGnwVwyhIT+LjSrt55eG
         k13OhX+VLhwvD+/C2RBX8+uvBlD8U5j3KjStGieqDeISRqPeeo2HHKtiCTSHgQjcsGYY
         QYGBhtRdTaLNRCAAB13kjntO7MF6gYxJw9nw+cDxhtSkEN7UckHq+wKdtdzmvNDaHSQs
         6nPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OL/tVc1Ch0fuHCWGLDW0Ztss4EfxD7apFgMsfQsUr7k=;
        b=Gx9YYgIWYon/MuuxV0rs4Kt6CmCDzn4v46Xq5DNgsr9zmITu/1RrJBSxi8vWoQ7Aqw
         jeYPBc9QFWQSLClQtHiO1gLYNJ0VHTynuwKxFKMUi38OjLNrxWGSgiXJJlMreGujEzim
         0gNoV9h/uv0sKSmzJM3ARGqW0h1I9KaeuwtHEpTwMXVqlnzZnqhI84s7vD4SKYL3r2Pd
         IDqTT5KzCOpXumzzudTabm0bt4g1Iiv68Zp4Lmgpqx4ovGq85dTpAfZ4JB2vwBydVoZZ
         VXfqvIv1mr8iwWqvN+UcbiQlx7YuaP5WioCFfTnlxYKm/MwN6qHBPzzIeD4gimceXz3z
         vaFA==
X-Gm-Message-State: AGi0PuYsjzWzWwjUdZaOl60OhSvj+n4gYzBTuy3lutBFOXrAAizcRn15
        tEAcgwr4bRDxRjWtdAIMqF0LIznv
X-Google-Smtp-Source: APiQypLjaRISzAROt9vUoQ7mTnsDUyvNC/1ydvIVFNPjf8gKXPfxEOQBVVn2YEr/ZcVFzDNztZhQng==
X-Received: by 2002:a2e:904b:: with SMTP id n11mr2225309ljg.171.1585839173690;
        Thu, 02 Apr 2020 07:52:53 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id c22sm3976478lfi.41.2020.04.02.07.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 07:52:52 -0700 (PDT)
Subject: Re: [PATCH v1 5/6] dt-bindings: ARM: tegra: Add ASUS Google Nexus 7
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
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200331214327.6496-1-digetx@gmail.com>
 <20200331214327.6496-6-digetx@gmail.com>
 <20200402045008.GB11124@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4c059f4a-111a-086b-c165-eb8ae798d606@gmail.com>
Date:   Thu, 2 Apr 2020 17:52:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200402045008.GB11124@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

02.04.2020 07:50, Michał Mirosław пишет:
> On Wed, Apr 01, 2020 at 12:43:26AM +0300, Dmitry Osipenko wrote:
>> Add a binding for the Tegra30-based ASUS Google Nexus 7 tablet device.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/arm/tegra.yaml | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/tegra.yaml b/Documentation/devicetree/bindings/arm/tegra.yaml
>> index 7fd0b66c69b2..fb3bbf7a5fb4 100644
>> --- a/Documentation/devicetree/bindings/arm/tegra.yaml
>> +++ b/Documentation/devicetree/bindings/arm/tegra.yaml
>> @@ -62,6 +62,13 @@ properties:
>>                - toradex,colibri_t30-eval-v3
>>            - const: toradex,colibri_t30
>>            - const: nvidia,tegra30
>> +      - items:
>> +          - const: asus,grouper
>> +          - const: nvidia,tegra30
>> +      - items:
>> +          - const: asus,tilapia
>> +          - const: asus,grouper
>> +          - const: nvidia,tegra30
>>        - items:
>>            - enum:
>>                - nvidia,dalmore
> 
> Is it really necessary to list every possible device using a SoC chip?

Yes, otherwise make dtbs_check will give you a warning about the unknown
compatible.

> Wouldn't it be enough to just list SoC value nvidia,tegraXYZ and allow
> any other supplemental "compatibles"?

I don't know what was the initial intention of having boards defined in
a way it's currently done, maybe Rob;Thierry;Stephen;Jon could clarify?
