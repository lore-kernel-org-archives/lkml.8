Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E83C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CD0B2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MeHUKee9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgG2MPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 08:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgG2MPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:15:14 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF49AC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 05:15:14 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id y18so10739372ilp.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 05:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sFs8HR0J1hVN4rEPAJYUN8DJiN6sjaEnKfPmViSq2uk=;
        b=MeHUKee9BDzkM/xLCyLYVR/+wuj1bJ7X7td3l8Fhl1cuidmJv3z+ZQCcKd2pK4/yO+
         Fzp4/ZSJfh6qMEDlBjrzCa4UWC4vNECNyJ04ahIia3lP8g6OUZ2rbgwgieZrD6kRha4l
         jF7af35/XauxtwMoYoLmhPZFJjDAdzMPDlCfheHk0YAMO8/VgL1oXbg3JwVR/Dr+ZwBU
         SBINj4cYKPxvQbrIPp56sjOBwzPqd0ZvQ4E+cAUS9De5OV7im5A29qm7zc9CHAtEBdc/
         TNRsd5SH3K1maue1ZOlTlKs88xUKjp448ZKIqjrrqdCNTgk7IqZc5l6qutFvteh9yFPo
         A6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sFs8HR0J1hVN4rEPAJYUN8DJiN6sjaEnKfPmViSq2uk=;
        b=Oco8JP0v8cSslOTP2tyIgo5XRtIq2mtkOFoXGn8hLOk2zE3OwePSnE4VZBlDVuBh+H
         DYHbnXpfobNziZd3N+SkV3K0uxtu1pRFPNgOC4OMHctwh9dee82UybhgIIxOOKA4Tc2Q
         g6PksK9y82ciGbH0vF28HUrCYJbgW4ijd5TtEfIQM3D56feNLkuO02Xln3IUD+e55cJX
         ORfNtpRvIclg8GWm3AUjrkR5PuWKLZyfNgCySxifMAX1KgTXnhQVOPUikiz1ZCuhkRuh
         eaz3HsgWfNuzYCLnHZwpVFLIE/99MU/ZIz13yKLnn5EQs/1QNRarFFKMfm6Qi3hlSiSn
         zNow==
X-Gm-Message-State: AOAM532f2vC9fWilxMiAAAJjzl0JBhAWNBVQk2ocABa56EZpiB10Mxxa
        9D23fVXbHNHMCivsLEwduT/2gw==
X-Google-Smtp-Source: ABdhPJzdzheryXPZ+Sa1SygI0cxlfTOp2dsaG84lZthNBJb6U+958LM5hysWS8nOEftmxfEY4JdnXw==
X-Received: by 2002:a92:1b12:: with SMTP id b18mr23978290ilb.42.1596024913984;
        Wed, 29 Jul 2020 05:15:13 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id v87sm451611ilk.33.2020.07.29.05.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 05:15:13 -0700 (PDT)
Subject: Re: [greybus-dev] [PATCH][next] greybus: Use fallthrough
 pseudo-keyword
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Alex Elder <elder@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org,
        Johan Hovold <johan@kernel.org>
References: <20200727183258.GA28571@embeddedor>
 <63871608-e076-26b0-85df-cff11699c3a3@ieee.org>
 <20200729105157.6acksxuzjdno5omq@vireshk-mac-ubuntu>
From:   Alex Elder <elder@linaro.org>
Message-ID: <e45f807e-dc35-b335-fca0-424d56e05f09@linaro.org>
Date:   Wed, 29 Jul 2020 07:15:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729105157.6acksxuzjdno5omq@vireshk-mac-ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/20 5:51 AM, Viresh Kumar wrote:
> On 28-07-20, 17:37, Alex Elder wrote:
>> On 7/27/20 1:32 PM, Gustavo A. R. Silva wrote:
>>> Replace the existing /* fall through */ comments and its variants with
>>> the new pseudo-keyword macro fallthrough[1].
>>>
>>> [1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
>>
>> Thanks for the patch.  It looks good, but it raises
>> another question I'd like discussion on.
>>
>> It seems that Johan likes default (or final) cases in
>> switch statements without a "break" statement.  Viresh
>> and Bryan appear to be fond of this too.
>>
>> It's pedantic, but I don't like that.  Am I wrong?
>>   --> Johan/Viresh/Bryan would you please comment?
> 
> I am not fond of them as they aren't required for the working of the code. It is
> a bit like using an empty return statement for a routine with void return type,
> though it surely adds some consistency to the switch case.

I understand this perspective, and it's exactly why I wanted
to have a conversation about it (rather than just saying it
should be fixed).  As similar example, I don't like unnecessary
parentheses, but sometimes it's a good idea to have them.

Thanks.

					-Alex

> But if people really feel it must be there, then its fine :)
> 

