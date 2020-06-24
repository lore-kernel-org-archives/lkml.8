Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B924C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1304320CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFBN12aB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404570AbgFXPvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403931AbgFXPvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:51:36 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D06AC061573;
        Wed, 24 Jun 2020 08:51:36 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id u17so2084595qtq.1;
        Wed, 24 Jun 2020 08:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OCTRPctFFpx+aJELBCUccAzQ7DxE/nJNw3rXnEquQLM=;
        b=oFBN12aBhFMNm20MuO5zZdopwr4turKFOKrM2v9T/yy/tIjWIqwNmv9lhfJ7GEo1nJ
         3JhvlgHrTy6opzdGbl0JEJjwOfGSj6MB15M7ASOJ8eLdH9dTMQ6T0IecnVoPoLCxNw6F
         47wJdrzDzY62KMrt9DuAE+vrfnfHXh9aG0vOuMqNvW/bsYhFH27yshh8OZ5qXgkHSDU+
         e0jcliItYSTHk4yTlfXACT8Gm2F6DkzWpIKgMiGBWuVrEFbJ9QxY35173+gzBD9O11H3
         wawthk3A4yMRakY/o7nv3iqLB3RSPFZGL9txRkPlwW8wbgV0wMxwwEmDoBxyDMm/7Olo
         W5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OCTRPctFFpx+aJELBCUccAzQ7DxE/nJNw3rXnEquQLM=;
        b=R6EVE17iXbBRzc6SGnuwYJk/yBrvwpj5oZHlNoeKSO/kPbBhY9pV/iZUOrirfwk28H
         0tF9slRpVep0KN5sY/MveuFu9IzXirBsHfZb6ALJ+fmftDjamXD4ctpr09E6FtEgOghD
         JanSzjS81nhJTFjOxi/R1P0xOS77blbhYnP2M4mm9adApYbQeOrLC6+3q/a1HrGJhoWk
         y9WqKw9oCVdwrxDYACN3O7ivF0SkbpojDal8TBJaB1NXIvh7meYLh57zUAjQf3O+7KaR
         rvgB6e5QchQsIw9Fiyta1I1jfCpenQ3bryDf3BAr/aO0N1Q57Q8+QRmTI/REq5t9m8at
         72FQ==
X-Gm-Message-State: AOAM533LXTSHBTUOFyYvVwovZhvfZpmWwkX6XIqh7VUhA+ZA+i5YiA1C
        4YRpboqo23ORDRmlZA08mLs=
X-Google-Smtp-Source: ABdhPJy1e1vJJM+J98uJc4itRbEG5EBXp0uiQVb9aNso0GWU8UqdxCPUrbhjAJk/YUX7fswV7L2vvA==
X-Received: by 2002:ac8:19cb:: with SMTP id s11mr27364417qtk.105.1593013895675;
        Wed, 24 Jun 2020 08:51:35 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id q47sm4143309qta.16.2020.06.24.08.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 08:51:34 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] mfd: core: Make a best effort attempt to match
 devices with the correct of_nodes
To:     Lee Jones <lee.jones@linaro.org>
Cc:     andy.shevchenko@gmail.com, michael@walle.cc, robh+dt@kernel.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux@roeck-us.net,
        andriy.shevchenko@linux.intel.com, robin.murphy@arm.com,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200622085009.GP954398@dell>
 <cd8952da-cc55-8087-b9f6-876417beb188@gmail.com>
 <20200622151054.GW954398@dell>
 <037c0fd2-df35-5981-7ef2-c6199841650d@gmail.com>
 <20200622191133.GY954398@dell>
 <dc893ce4-8a4d-b7d9-8591-18a8b9b2ea2b@gmail.com>
 <20200623064723.GZ954398@dell>
 <83f2be78-1548-fa2b-199a-2391b2eceb47@gmail.com>
 <20200623195905.GB954398@dell>
 <6684101d-1013-2964-c247-394f9b12a194@gmail.com>
 <20200624074631.GE954398@dell>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <d7774c42-fd41-9fab-2ea0-cd6bc7d35383@gmail.com>
Date:   Wed, 24 Jun 2020 10:51:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624074631.GE954398@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-24 02:46, Lee Jones wrote:
> On Tue, 23 Jun 2020, Frank Rowand wrote:
> 
>> On 2020-06-23 14:59, Lee Jones wrote:


< big snip >

Thanks for the replies in the above portion.


>>>> But yes or no to my solution #2 (with some slight changes to
>>>> make it better (more gracious handling of the detected error) as
>>>> discussed elsewhere in the email thread)?
>>>
>>> Please see "[0]" above!
>>>
>>> AFAICT your solution #2 involves bombing out *all* devices if there is
>>> a duplicate compatible with no 'reg' property value.  This is a)
>>> over-kill and b) not an error, as I mentioned:
>>
>> As I mentioned above, I set you up to have this misunderstanding by
>> a mistake in one of my earlier emails.  So now that I have pointed
>> out what I meant here by "more gracious handling of the detected
>> error", what do you think of my amended solution #2?
> 
> Explained above, but the LT;DR is that it's not correct.

I don't agree with you, I think my solution is better.  Even if I
prefer my solution, I find your solution to be good enough.

So I am dropping my specific objection to returning -EAGAIN from
mfd_match_of_node_to_dev() when the node has previously been
allocated to a device.


> 
>>>>> It also suffers with false positives.
>>>
>>
>> Sorry for the very long response, but it seemed we were operating
>> under some different understandings and I hope I have clarified some
>> things.
> 
> Likewise. :)
> 

