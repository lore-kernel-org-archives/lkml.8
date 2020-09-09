Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA0BC10DAA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B320220BED
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599686340;
	bh=NaF+C47vMciV3tTCzfNYf2LpQKqsQX5Sgec1MU0HeA8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=cUwikKwvdVZDMAQXD1sto/j0oOWwNhzbEJdHo7U01kkDsksG1W4ewr8UU+gHXXkJA
	 fbPkO2P+UcQO2sd1s99/2mjR61sePfeB0tP4xttDYtrecfrBsZtqSJkt32FnVX+1K7
	 JHsvIOJsjIK+EJLbmnixNIwRFPj/BhcJwXGw14c0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbgIIVS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 17:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730093AbgIIVS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 17:18:56 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1800C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 14:18:55 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id r9so4812448ioa.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 14:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YGsQQlz6o7re87zliFW6CFb7fsznxyHEdlHXDCAkS/M=;
        b=B+XJN/PQh4hCB2hzKIrjAtQmclW/e7KA6p9/oKkiG/oLJsvkyb8oBzvacTjPcogtHp
         406Ao3BGmnAl+5Xsx9Zmj/FYJarVhT6eZHDwV9b0bkcOxqe55Sy2o7OlR0KiVSpVl6hD
         V2iKJ2arseDOs3bReM4RhkNmFFOD+jI9Ui5lQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YGsQQlz6o7re87zliFW6CFb7fsznxyHEdlHXDCAkS/M=;
        b=Q0olAgc/pFAB6k+I9bQblggUWKv9u/XR5nTQBJY62VDD7GV8jbB1b7Nr5eeKeJSjE8
         2W87y9uQ7RWNLZj2rwROhTkcNw3kCQ7sDJtAfc+4b27zCu82C3cpWWYIwTVqohNFMwVU
         K2kGluvhEAV7/bYoMEdwvdwX1uO3i7lPA1ymkZjnYt8lGchlR8JYxaBMThAExptDG1uZ
         eTQliIHBcIcGAUpce90MX9HMwV3LgJZ5euwZ7yaPDJK138OKPDxff6+nLG76hXDu88kg
         BUqOq12F92IvkmYHvI2ID13TtbEGaTLfOQSK/B/utCRtiQbcDe4RrkCxgQJOF1dijm/0
         0FBQ==
X-Gm-Message-State: AOAM530y+2AgaDXVOfRfKx0290rcZ+Jed08wGohc7yFDXz4gmqRTVeIi
        nBtrdBym66VyZ88favGK4ZkzYA==
X-Google-Smtp-Source: ABdhPJwEGOpQQ/oFPj/OTMIB4P9DK001RefgaqrQ3mSdAFXYoJFPmqBPCYTG7w22csuPnaHZy8gfiA==
X-Received: by 2002:a6b:6e0b:: with SMTP id d11mr4919660ioh.155.1599686335302;
        Wed, 09 Sep 2020 14:18:55 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r2sm1990810ilq.18.2020.09.09.14.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 14:18:54 -0700 (PDT)
Subject: Re: [PATCH] selftests/lkdtm: Use "comm" instead of "diff" for dmesg
To:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <202006261358.3E8AA623A9@keescook>
 <202009091247.C10CDA60C@keescook>
 <7271a7e7-c4fb-c656-f6d2-6ff4a29a9e06@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e3c86b0d-ca8c-51a1-4678-f3d37a8f8a3f@linuxfoundation.org>
Date:   Wed, 9 Sep 2020 15:18:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7271a7e7-c4fb-c656-f6d2-6ff4a29a9e06@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/20 2:49 PM, Shuah Khan wrote:
> On 9/9/20 1:49 PM, Kees Cook wrote:
>>
>> On Fri, Jun 26, 2020 at 01:59:43PM -0700, Kees Cook wrote:
>>> Instead of full GNU diff (which smaller boot environments may not have),
>>> use "comm" which is more available.
>>>
>>> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>>> Link: 
>>> https://lore.kernel.org/lkml/CA+G9fYtHP+Gg+BrR_GkBMxu2oOi-_e9pATtpb6TVRswv1G1r1Q@mail.gmail.com 
>>>
>>> Fixes: f131d9edc29d ("selftests/lkdtm: Don't clear dmesg when running 
>>> tests")
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>
>> Shuah, this really needs to land to fix lkdtm tests on busybox. Can
>> you add this to -next? (Or is it better to direct this to Greg for the
>> lkdtm tree?)
>>
> 
> Kees, Thanks for the ping. I can queue this up in -next
> 
> Greg, would you like me to take this through selftest tree?
> 
> In case you want to take this through lkdtm tree:
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> 

Kees,

Just saw your reply. Will wait for v2.

thanks,
-- Shuah

