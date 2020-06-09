Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FCDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0C68207ED
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="fDMbGnBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgFILLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 07:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728153AbgFILLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 07:11:35 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1611AC03E97C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 04:11:34 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id g18so17173854qtu.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 04:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sTdGo3DblQ0pGhGEDTWDVKCaveUZcKh4mSSj2RqdS0Q=;
        b=fDMbGnBKZSsZq6q++M5Vh5Us6bXnxUE6gJeZN3mP7Py357Fzr+RwgB8LKCKec/AX63
         LjP+4JRcc0PIgeEjpXQS+49r2U9IBWhlXSC1PfnHq2si3JB2zo1Z0fp5HPwsaauYGnRX
         pinYzad0KmHYLdiBRYDgS+eWP2olDCkem0CtYl6vHEACuHVeaNO2T70USDGcNEEPQXqW
         Bx9fyxiaZlUdMGj5QDA8eXpsQz0ka1ilADz9CdQHRTA/x/8H0vX/FuBauxvMrX9DfyPp
         3a6o9f92htuvqyW1iItmJ7+Wlg0JV2WCflq+1VF8kJ5BEYySA7Sq/s5zX/8aPtIjrWNA
         oI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sTdGo3DblQ0pGhGEDTWDVKCaveUZcKh4mSSj2RqdS0Q=;
        b=ZyCqeVRznKnIQE2eUcVTKcMi8YwCXLP3BHQZ+qRauvXSajVuaBDWPFixEJ7iJlaL8g
         l7CEg5niRZd20AEINv+7St4/Wj3hNDezH7UYThKhw5KhRHfDaRCGodHim/it+48xpufa
         rVifzJ31WcyYaAek7yhJNdP1wnVVxvf8LTWcKiKuwOU14wzdCun2LzgF7JgscJ/t2P+X
         GX8kOigFtQ3toTyXGp7nJet//Jks1Enh1CE3zfHY8VF3kDfVQkwpWDiKTc63n6JXVPhP
         a+t11iHQlO/8JwLLJ6rQpEAXGi8XKyrjUlDfkSASLwUAYj79El6jEAW3YIfCT8va+XCl
         9rMw==
X-Gm-Message-State: AOAM531wSet3Hi2Q3W90X/xtblfAXTSb7GWn1egkCLMra5b+yH7+zl3l
        ImEoUDSDvUeIxFXXSY3bNqyD6T+uNOU=
X-Google-Smtp-Source: ABdhPJwzf0+pPjjN5JWfR9h23JReYx6jqS0+L7BcJuungkkL08paCPxsU4BybDuTYxplLN44yzW8+g==
X-Received: by 2002:aed:3ec4:: with SMTP id o4mr29118167qtf.357.1591701093474;
        Tue, 09 Jun 2020 04:11:33 -0700 (PDT)
Received: from [192.168.0.189] ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id a15sm8967374qkl.20.2020.06.09.04.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 04:11:33 -0700 (PDT)
Subject: Re: [PATCH 0/5] soundwire: qcom: add mmio support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Vinod Koul <vkoul@kernel.org>
References: <20200608204347.19685-1-jonathan@marek.ca>
 <7fc23e7d-b6ef-b97d-0252-8b6fafae64ac@linaro.org>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <cd08caf4-6de7-29ff-4bf7-ce88edeed11d@marek.ca>
Date:   Tue, 9 Jun 2020 07:11:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <7fc23e7d-b6ef-b97d-0252-8b6fafae64ac@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/20 5:26 AM, Srinivas Kandagatla wrote:
> Thanks Jonathan for the patches,
> 
> On 08/06/2020 21:43, Jonathan Marek wrote:
>> This adds initial support for soundwire device on sm8250.
>>
> 
> One thing off my list!!
> 
>> Tested with the "wsa" sdw device, which is simpler than the others.
> 
> WSA881x?
> 
> did you test both enumeration and streaming?
> 
> Are you planing to add any new WSA or WCD codec support for this SoC?
> 
> thanks,
> srini
> 

Yes, dual WSA881x. I tested streaming, however for the dual WSA881x case 
I need specific amixer settings and an extra hack to make it work (seems 
to port config stuff is broken, especially around VISENSE, it tries to 
use it in the wrong direction I think). For a single WSA881x, it can 
work without any extra hack.

The SoC has at least 4 codec drivers to add ("wsa macro", "rx macro", 
"tx macro", "wcd938x"), with what I am doing right now I only need the 
"wsa macro" codec which I've ported over from downstream. For now I am 
only looking at sending patches for the required ADSP changes, but may 
consider doing something with the "wsa macro" driver at some point.

>>
>> Jonathan Marek (5):
>>    soundwire: qcom: fix abh/ahb typo
>>    soundwire: qcom: add support for mmio soundwire devices
>>    soundwire: qcom: add v1.5.1 compatible
>>    soundwire: qcom: avoid dependency on CONFIG_SLIMBUS
>>    soundwire: qcom: enable CPU interrupts for mmio devices
>>
>>   drivers/soundwire/Kconfig |  1 -
>>   drivers/soundwire/qcom.c  | 42 +++++++++++++++++++++++++++++++++++----
>>   2 files changed, 38 insertions(+), 5 deletions(-)
>>
