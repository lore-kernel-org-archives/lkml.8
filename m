Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6430C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0D062084D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fr2l7dlU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404968AbgFXQZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404468AbgFXQZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:25:32 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F69C061573;
        Wed, 24 Jun 2020 09:25:32 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id j80so2405473qke.0;
        Wed, 24 Jun 2020 09:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EX+waRZgWkttNQFyEQaMEGS91DwT52qIcg8cn7tx7x0=;
        b=Fr2l7dlUKiPmEZHXthnoPVJaBTDZ8tQeygaptwCtWakFBu/hKZPdpO/cvCjH+6z1Ww
         Fxd9euxfiC7WJvmRvoI2XwPwPTz8FnhdXODfS/QXWcgg2M7IsoyxD+LiRoMRxBlEUou7
         A1gpl7Qfjjs8rBxSL+vGRHtgUV2Xnh5vWVS/5jYGK3GICSd30q7HORJT2XqKzjtNQR2t
         RGwcwH7R+sLpmW3sJB+aXG456xgsJ7J6PMjKch90MS8eVFynfnkVfRNccG2uJGGIggbW
         icl3XbyIpR2rDt4zBps0WklWsRilZT1peDuYmDsqSNstJGm/C6KSyZeg6yil9cFZrzL2
         B6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EX+waRZgWkttNQFyEQaMEGS91DwT52qIcg8cn7tx7x0=;
        b=eyp502mTOQae0nRTIrs43a8AFUBKM4iRaDu0GXTbjheux+EpLyNFhWsgFLyNCr2GJQ
         1C8kD+iXeQZ89CRYVONqH7EZQvBSlCo/MNt4akJ3YMA0aUy0La045hmE8gxO7UXZbujW
         A7KxmojFuh4BuW8tL5xPuxbmod78yyQn7TMCXtg8I+HejPAAub8xNzT34odzs61doHHo
         dtqu/HRcPvj5KUREGMzib4Vw+vCiGRWRVp5G64FUrJuzX70xlIumAjj4MwijRIXkYa9U
         VuAs+Z69nP8fC0pN8iQaOOyj/GUmqFZBQOT52e5CeUBv/rYG6SrJ3lW4tX679T0WoSjP
         VnvQ==
X-Gm-Message-State: AOAM5326ZoWswa53eiUFu8qQHWcTmMQcINqn9X4TSevJXaqU9VrDnUTk
        iTIWmtz6fFwtelLhTUwrDkU=
X-Google-Smtp-Source: ABdhPJwxFli0DGylImdLbucIC/YTFByOJI9o7sIdwE4PZG41+89LDyF+oJewq4AgmLSxYa1Rjow2zg==
X-Received: by 2002:ae9:e8cf:: with SMTP id a198mr18441339qkg.460.1593015931469;
        Wed, 24 Jun 2020 09:25:31 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id f22sm4508170qko.89.2020.06.24.09.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 09:25:31 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] mfd: core: Make a best effort attempt to match
 devices with the correct of_nodes
To:     Lee Jones <lee.jones@linaro.org>
Cc:     andy.shevchenko@gmail.com, michael@walle.cc, robh+dt@kernel.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux@roeck-us.net,
        andriy.shevchenko@linux.intel.com, robin.murphy@arm.com,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200622151054.GW954398@dell>
 <037c0fd2-df35-5981-7ef2-c6199841650d@gmail.com>
 <20200622191133.GY954398@dell>
 <dc893ce4-8a4d-b7d9-8591-18a8b9b2ea2b@gmail.com>
 <20200623064723.GZ954398@dell>
 <83f2be78-1548-fa2b-199a-2391b2eceb47@gmail.com>
 <20200623195905.GB954398@dell>
 <6684101d-1013-2964-c247-394f9b12a194@gmail.com>
 <20200624074631.GE954398@dell>
 <d7774c42-fd41-9fab-2ea0-cd6bc7d35383@gmail.com>
 <20200624161435.GI954398@dell>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <53200e52-bc53-1351-dc90-b775c29f8456@gmail.com>
Date:   Wed, 24 Jun 2020 11:25:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624161435.GI954398@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-24 11:14, Lee Jones wrote:
> On Wed, 24 Jun 2020, Frank Rowand wrote:
> 
>> On 2020-06-24 02:46, Lee Jones wrote:
>>> On Tue, 23 Jun 2020, Frank Rowand wrote:
>>>
>>>> On 2020-06-23 14:59, Lee Jones wrote:
>>
>> < big snip >
>>
>> Thanks for the replies in the above portion.
> 
> NP.
> 
>>>>>> But yes or no to my solution #2 (with some slight changes to
>>>>>> make it better (more gracious handling of the detected error) as
>>>>>> discussed elsewhere in the email thread)?
>>>>>
>>>>> Please see "[0]" above!
>>>>>
>>>>> AFAICT your solution #2 involves bombing out *all* devices if there is
>>>>> a duplicate compatible with no 'reg' property value.  This is a)
>>>>> over-kill and b) not an error, as I mentioned:
>>>>
>>>> As I mentioned above, I set you up to have this misunderstanding by
>>>> a mistake in one of my earlier emails.  So now that I have pointed
>>>> out what I meant here by "more gracious handling of the detected
>>>> error", what do you think of my amended solution #2?
>>>
>>> Explained above, but the LT;DR is that it's not correct.
>>
>> I don't agree with you, I think my solution is better.  Even if I
>> prefer my solution, I find your solution to be good enough.
> 
> I still don't see how it could work, but please feel free to submit a
> subsequent patch and we can discuss it on its own merits.
> 
>> So I am dropping my specific objection to returning -EAGAIN from
>> mfd_match_of_node_to_dev() when the node has previously been
>> allocated to a device.
> 
> Great.  Thanks for taking an interest.
> 
> Does this mean I can apply your Reviewed-by?
> 

No, please do not.  I don't want to give the patch that strong
of an endorsement.
