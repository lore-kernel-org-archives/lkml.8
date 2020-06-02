Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7983C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 10:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0808206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 10:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D3v51V4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgFBK4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 06:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgFBK4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 06:56:07 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC9CC061A0E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 03:56:06 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x13so2938560wrv.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 03:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zoyTcyBnHY+drX5v7SAgyghAKKMbaJC1+1oDWq+RDXs=;
        b=D3v51V4YKXhUKnJPtW4V4QvG5a8/aZCj0VeqUCP5QQD3Z4XAqvw0Hx3MIZUNhsJWCM
         2OOTvhnnW66j1NnxnuOCLbWZ6WkSSQ9P2RBVyIFAnG1hBsU2jv26UHA3wLgqAegM1Jok
         5LgPVVZJ2PGCYi6V2FnEm0or4NXh69KIHz7qHDX82xotr3NTmC0IzztpdReRJ8ZEf/UV
         P+0ohbjgCwgwOL7wHyGc64lctqSWbjgj66xveQZ8lW4kp1fB7lhZH7vmoyUvMOpF9hYx
         llCC3youihpIiVRh/v7JhY1QAwV6NF3Q2Z9WRTdXYiNI66l+Tlt5ILVjYBouQvjUDI40
         hbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zoyTcyBnHY+drX5v7SAgyghAKKMbaJC1+1oDWq+RDXs=;
        b=JbvEeXlf4NC6+2seoIFWv7QqQSL5cmwkiFSD75qrYcl8FQnqL7tsFfaqaarNeWDZO7
         3F2Q6JkR01kNGSmlodOEWgJOSDqPYNEX27MxiP+37h/wt9APCCF0nuVhJ5vK1c5/FomM
         sLvGmp7K32dpyhcBqlZ2QYPjMk2GLD3GC8uMNjX87VFLzKb9aQqECK9axdiQqwNfOILu
         G53vPLq6q0ciGrI9FEgmc5WQy784rwvxCYnPn9zrfg5b/2OuNSwMrsRq8uAUtUONPvje
         DYMNyOZ/PZAA/gRS/GBKMv+402HeevTdb7XH2OIJnPmztnJixM2KXUsMd1Btzis63twF
         RpYA==
X-Gm-Message-State: AOAM531PldFLjcmzizB8Wab+3h9iAqHZzMOs/4B0bU6BNoEFjn2oWiCA
        M5z8K0vp6UXaR9ByHQGFhNHOkw==
X-Google-Smtp-Source: ABdhPJxK9ZB5DguLdg9OqabgaHC8y249h8H0GKOz+wifrgio3qbISgDQgaumSCMFIn+/FF9jJirWNA==
X-Received: by 2002:adf:ea8b:: with SMTP id s11mr26398235wrm.168.1591095365239;
        Tue, 02 Jun 2020 03:56:05 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id y66sm2991524wmy.24.2020.06.02.03.56.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jun 2020 03:56:04 -0700 (PDT)
Subject: Re: [RFC v1 2/3] drivers: nvmem: Add driver for QTI qfprom-efuse
 support
To:     Doug Anderson <dianders@chromium.org>
Cc:     "Ravi Kumar Bokka (Temp)" <rbokka@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        dhavalp@codeaurora.org, mturney@codeaurora.org,
        sparate@codeaurora.org, c_rbokka@codeaurora.org,
        mkurumel@codeaurora.org
References: <1589307480-27508-1-git-send-email-rbokka@codeaurora.org>
 <ffaccce7-95c0-2f95-ad3b-55f1da42eaee@linaro.org>
 <14e1fa51-066c-6e1b-01a4-2103612de9e9@codeaurora.org>
 <d5902226-21b3-7941-6405-688d7a115142@linaro.org>
 <b80aaca0-0594-e04b-5320-b5b3c4478161@codeaurora.org>
 <d76e4eb2-fa6a-0b76-3912-83bce678bc96@linaro.org>
 <CAD=FV=XW7GymV_pr_0SvUPWwL6WnPhqMq-crq-RbR_us3-ShNA@mail.gmail.com>
 <9864496c-b066-3fe8-5608-bd9af69663f4@linaro.org>
 <CAD=FV=UbZPQ74COXJbOikq9Wcx1UvtuMuMA+nqkx44uySoqggg@mail.gmail.com>
 <99f07eaa-d072-f391-098e-e6f7a50a1960@linaro.org>
 <CAD=FV=W+UES1f3reMhvPPUho5FbaZXdU-2jkRaPcbBEzDWT+WQ@mail.gmail.com>
 <9ecb5790-47fe-583b-6fc3-8f4f3ce7860e@linaro.org>
 <CAD=FV=XbbUkeSwvcverBS8t6BCHuw3UT0_KYfx9LFGqmZyY2hA@mail.gmail.com>
 <871dd2c1-4b16-f883-b8c5-806a0df1edf8@linaro.org>
 <CAD=FV=UCwUO5aKrUj7e+v6Bpkh_O+wuSXD5tJHdGOfaVTL0t1w@mail.gmail.com>
 <1211660e-f1b0-0636-2dcf-1bc765118de3@linaro.org>
 <CAD=FV=VcfYVQMmWvSkBG0VNBcqt5a3Y_b4eNBgDenPB5wUNGaw@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <1d276cdc-247c-b663-0f69-0961cf75134b@linaro.org>
Date:   Tue, 2 Jun 2020 11:56:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=VcfYVQMmWvSkBG0VNBcqt5a3Y_b4eNBgDenPB5wUNGaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/06/2020 19:08, Doug Anderson wrote:
>> Am not 100% sure if "qcom,fuse-blow-frequency" is something integration
>> specific or SoC Specific, My idea was that this will give more
>> flexibility in future. As adding new SoC Support does not need driver
>> changes.
>>
>> Having said that, Am okay either way!
> Yeah, it's always a balance.  I guess the question is: why do we think
> driver changes are worse than dts changes?  The value still needs to
> be somewhere and having it in the driver isn't a terrible place.
> 

TBH, its an overkill if we are using same IP version across multiple SoCs.

> 
>> Incase we go compatible way, I would like to see compatible strings
>> having proper IP versions to have ip version rather than SoC names.
>>
>> Having SoC names in compatible string means both driver and bindings
>> need update for every new SoC which can be overhead very soon!
> Almost certainly the compatible strings should have SoC names in them.
> Yes it means a binding update every time a new SoC comes up but that
> is just how device tree works.  Presumably there's enough chatter on
> this that Rob H has totally tuned it out at this point in time, but
> there are many other instances of this.
> 
> NOTE: just because we have the SoC name in the compatible string
> _doesn't_  mean that the driver has to change.  You already said that
> the IP version can be detected earlier in this thread, right?  You
> said:
> 
> I found out that there is a version register at offset of 0x6000 which
> can give MAJOR, MINOR and STEP numbers.
> 
> So how about this:
> 
> a) Compatible contains "SoC" version and the generic "qcom,qfrom", so:
> 
> compatible = "qcom,sdm845-qfprom", "qcom,qfrom"
> 
> b) Bindings will need to be updated for every new SoC, but that's
> normal and should be a trivial patch to just add a new SoC to the
> list.
> 
> c) If the driver can be made to make its decisions about frequencies /
> timings completely by MAJOR/MINOR/STEP numbers then it can use those
> in its decision and it will never need to use the SoC-specific
> compatible string.  The SoC-specific compatible string will only be
> present as a fallback "oops we have to workaround a bug that we didn't
> know about".

This makes more sense to me, I would still stay with  MAJOR/MINOR/STEP 
numbers mostly unless we are dealing with some corner cases.


thanks,
srini
> 
> 
>> Rob can help review once we have v2 bindings out!
> Sounds good.  If you're still not convinced by my arguments we can see
> if we can get Rob to clarify once we have a v2.:-)
> 
> 
