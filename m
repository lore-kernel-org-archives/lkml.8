Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2664C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B48AD2080C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a1OzZbrw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbgFSJWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 05:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbgFSJWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 05:22:21 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1073EC0613EF
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 02:22:21 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c3so8922099wru.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 02:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L71i+j/szZ7a8yGgwnVT3FfQFDxm9SJ0Uj41IoLV1CQ=;
        b=a1OzZbrwfniynVKe6QiK+hebSHxNLFGB8WM24FEk1lDgajQdYblZyDW0yeNiwq+nDE
         CAPW3zrokwPHeg2/LnZwylSM35IJuThBCleOjVDjkDukAqyhmbEmmmJDgQk8jSZywCP1
         8Kho7w+QZQJW5M/Eczo4y4b1IV31CPdGpiFAiY4xebE72C1WidO8z9BhSVEd+EHLrj6O
         uld+Iwl1zZEiaCmnkjil6ykX8audfQ6v+A95Bly86wZzfXCjni1gJyoVQQsIzwtV0zPF
         W6rG1XcE9Sb75vmfuxfDqsFBpCqMeGKC/16yQImGstEeper1M5yxmCkHRd8JbJScLNYI
         X1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L71i+j/szZ7a8yGgwnVT3FfQFDxm9SJ0Uj41IoLV1CQ=;
        b=eNmWqUbJ8Kzd1EHgfwBGZQ7umKgo1i7ds3+jlWCL5EJDOd4KMu7w44m2a/b97C5m58
         NYHGFI26iPSXb11OX+FC9+DS/n5WevBwjWPEoHwsWs/Es4sS2pLU7+gjPTw4vq/ACnwq
         2V0lsxAUXZXGCNaz1DwAB5Qr1BoYz3vOzl2eYN7OLJXEA4MmM8ZRWUA99Q9WxPqYUZV6
         Bob4rYgyqWkXaj5xOL5155QTR5r++xw/oFBmnwTxS1jycQf12mWa/GBcuIn2Rd/+ZHgL
         PpDlQg1bF/Vv86Z1NToMmTDi0g0XBXx0m1PmBPim31tnwSU/ylb1yQEHsuaKgu6goeH8
         2Jjg==
X-Gm-Message-State: AOAM533M9IgWQeD2d3VP8BBNNt5DrZnUlXCuhOtV4tKy4Ok6h/nBQTMx
        iBtaGVOHjVR/22GkapIQvvBWGdodH2w=
X-Google-Smtp-Source: ABdhPJx/iu2eXJuPLBTnYxbIQ5rBLnywVCjKtEl6S2bMpKuZsPPZW3xjM/nSG406VRLssLKInXLnVg==
X-Received: by 2002:a05:6000:1192:: with SMTP id g18mr3203376wrx.326.1592558539289;
        Fri, 19 Jun 2020 02:22:19 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id y6sm6461571wmy.0.2020.06.19.02.22.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2020 02:22:18 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] dt-bindings: nvmem: Add properties needed for
 blowing fuses
To:     Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, dhavalp@codeaurora.org,
        mturney@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Ravi Kumar Bokka <rbokka@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        sparate@codeaurora.org, mkurumel@codeaurora.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20200617145116.247432-1-dianders@chromium.org>
 <20200617074930.v3.2.I3b5c3bfaf5fb2d28d63f1b5ee92980900e3f8251@changeid>
 <254998b9-c45e-bd6b-bc9a-b5934c0fea8e@linaro.org>
 <CAD=FV=Vec5FVrDVkmUQTfa6bP+1d3yOtj_FsgVAFdHLLbZ8VDA@mail.gmail.com>
 <db6cc914-0520-5286-f852-473fc63bd6c7@linaro.org>
 <CAD=FV=UZAtJY42jwSZy+Z+O3AdZqDxnjY1zzOswqQRDY91uPpA@mail.gmail.com>
 <0b0b52db-da8c-e958-d72e-797e319bbe9c@linaro.org>
 <CAD=FV=UShR-a8kEvpNEx5gGkUr=DhX-=kzcBQ1SegQTQMoCyKw@mail.gmail.com>
 <159249930746.62212.6196028697481604160@swboyd.mtv.corp.google.com>
 <CAD=FV=Unm8RK9GDNyuRZjznT21ef=jqcqhMXUWDV6HPkhn3coQ@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <59a988e2-d09c-6cd1-aea1-f4edee09b122@linaro.org>
Date:   Fri, 19 Jun 2020 10:22:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=Unm8RK9GDNyuRZjznT21ef=jqcqhMXUWDV6HPkhn3coQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/06/2020 18:25, Doug Anderson wrote:
> Hi,
> 
> On Thu, Jun 18, 2020 at 9:55 AM Stephen Boyd <sboyd@kernel.org> wrote:
>>
>> Quoting Doug Anderson (2020-06-18 08:32:20)
>>> Hi,
>>>
>>> On Thu, Jun 18, 2020 at 7:01 AM Srinivas Kandagatla
>>>>
>>>> On the other note:
>>>>
>>>> clock-names are not mandatory according to
>>>> Documentation/devicetree/bindings/clock/clock-bindings.txt
>>>>
>>>> For this particular case where clock-names = "sec" is totally used for
>>>> indexing and nothing else!
>>>
>>> So I guess in the one-clock case it's more optional and if you feel
>>> strongly I'll get rid of clk-names here.  ...but if we ever need
>>> another clock we probably will want to add it back and (I could be
>>> corrected) I believe it's convention to specify clk-names even with
>>> one clock.
>>
>> TL;DR: I suggest you call this "core" if you want to keep the
>> clock-name, or just drop it if there's only one clk and move on.
> 
> Ah, true.  "core" sounds good.
> 
> 
>> It's not required to have clock-names with one clk, and indeed it's not
>> required to have clock-names at all. The multi clk scenario is a little
>> more difficult to handle because historically the clk_get() API has been
>> name based and not index based like platform resources. When there is
>> one clk the driver can pass NULL as the 'con_id' argument to clk_get()
>> and it will do the right thing. And when you have more than one clk you
>> can pass NULL still and get the first clk, that should be in the same
>> index, and then other clks by name.
>>
>> So far nobody has added clk_get_by_index() but I suppose if it was
>> important the API could be added. Working with only legacy clkdev
>> lookups would fail of course, but clock-names could be fully deprecated
>> and kernel images may be smaller because we're not storing piles of
>> strings and doing string comparisons. Given that it's been this way for
>> a long time and we have DT schema checking it doesn't seem very
>> important to mandate anything one way or the other though. I certainly
>> don't feel good when I see of_clk_*() APIs being used by platform
>> drivers, but sometimes it is required.
>>
>> To really put this into perspective, consider the fact that most drivers
>> have code that figures out what clk names to look for and then they pile
>> them into arrays and just turn them all on and off together. Providing
>> fine grained clk control here is a gigantic waste of time, and requiring
>> clock-names is just more hoops that driver authors feel they have to
>> jump through for $reasons. We have clk_bulk_get_all() for this, but that
>> doesn't solve the one rate changing clk among the sea of clk gates
>> problem. In general, driver authors don't care and we should probably be
>> providing a richer while simpler API to them that manages power state of
>> some handful of clks, regulators, and power domains for a device while
>> also letting them control various knobs like clk rate when necessary.
>>
>> BTW, on qcom platforms they usually name clks "core" and "iface" for the
>> core clk and the interface clk used to access the registers of a device.
>> Sometimes there are esoteric ones like "axi". In theory this cuts down
>> on the number of strings the kernel keeps around but I like that it
>> helps provide continuity across drivers and DTs for their SoCs. If you
>> ask the hardware engineer what the clk name is for the hardware block
>> they'll tell you the globally unique clk name like
>> "gcc_qupv3_uart9_core_clk", which is the worst name to use.
> 
> OK, sounds about what I expected.  I suppose the path of least
> resistance would be to just drop clock-names.  I guess I'm just
> worried that down the road someone will want to specify the "iface"
> clock too.  If that ever happens, we're stuck with these options:
> 
> 1. Be the first ones to require adding clk_get_by_index().
> 
> 2. Use the frowned upon of_clk_get() API which allows getting by index.
> 
> 3. Get the first clock with clk_get(NULL) and the second clock with
> clk_get("iface") and figure out how to specify this happily in the
> yaml.
> 
> If we just define clock-names now then we pretty much match the
> pattern of everyone else.

Thanks to Stephen Boyd for his inputs and directions here!

I guess we have to live with "clock-names" for now for both consistency 
and reasons detailed by Boyd.

Am okay with the clock-names!

--srini
> 
> 
> Srinivas: reading all that if you still want me to drop clock-names
> then I will.  I'll use clk_get(NULL) to get the clock and if/when we
> ever need an "iface" clock (maybe we never will?) we can figure it out
> then.
> 
> 
> -Doug
> 
