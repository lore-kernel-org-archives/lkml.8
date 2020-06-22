Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C5CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE3E520732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592837184;
	bh=RN9WLRGnrtPmBWYNtHcqVPLynmrX6nclTsxOlWcuXHc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=RypXvpDV+QfR7k0AXMCIP1+vDbrX+fHmO9yBrNdksb6WV1r/xDfBmK92NX8i6oDfa
	 Zk1chdA3WTU6DhzMvgoi0N+HSHh9dSBYaod9O8KQGuBIRBSDUqAhe8+gPfDGjA5L/L
	 TKMn0mcW1I8R8fXAxtS6g14X2XkpELWP4HSYEYbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbgFVOqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbgFVOqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:46:20 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A72C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 07:46:20 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id x202so15849418oix.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 07:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bibVHEU3JMl6WYz1eGuG4xe8py8Hpo9EpfUixb5KAwQ=;
        b=X0FJOcp6+5/IGDlD6069Y26SKrjwT9WG1ad1kqnco1dtIv1V8IFOU64KGlgAFym0ni
         XZH3Of/dCoZzu26HH6veTfiZ8GxyXu9vXBHnW3T2aysKegvAlbVDwC9oRES7uzRXO3lf
         zXhwqPTlC9wfbWpFsdq80ygL5J3kmemq8JWos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bibVHEU3JMl6WYz1eGuG4xe8py8Hpo9EpfUixb5KAwQ=;
        b=ndLuX62bVsgyK6Kzh8FHQEvkWKiQOmEoqrkheFYLDnyfDa4k5SgkN8x0nC2kf+yWQv
         77V0uLdICIC3IPKVGBdS06891LJ88TWyny3NHrsxjWz7JUjlHbKnkAsRo0A45UEz0tsY
         8MKAiGEx1SEImEl3zyp+N63mGOV1ETQ64x+ECehnPBMg4H9bk0pa2cXGacuiLgsYZeGo
         K0O9IjBtSDuUz6avifhA8cse790+o24Yjp7KdaJ2MVvmejR1eIA2gP6Kxumea+YundBX
         7gELX6scCh/8GziIbt4QwCegPnAsJH5sTNJPE5Ou3Vepgnfpl6ROzfKseACwsnScHBIH
         JPFQ==
X-Gm-Message-State: AOAM5307y+0eYqyfLhmRYosmgC01/ZbYDdDgx1tVjWP9ecxZD4cDGzEP
        bGIsePvUHMzijiORQERpGtXjyg==
X-Google-Smtp-Source: ABdhPJxoDeOi/h22SFplMsaTYfOqsWxP58QzPKlvnYmt5yxokfMtFgLKIV40/BxXqkjjsMjZkvu4Fw==
X-Received: by 2002:aca:eb12:: with SMTP id j18mr12510057oih.28.1592837180117;
        Mon, 22 Jun 2020 07:46:20 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u80sm3272937oia.5.2020.06.22.07.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 07:46:19 -0700 (PDT)
Subject: Re: [PATCH] scripts: add dummy report mode to add_namespace.cocci
To:     Matthias Maennich <maennich@google.com>,
        Julia Lawall <julia.lawall@inria.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        YueHaibing <yuehaibing@huawei.com>, jeyu@kernel.org,
        cocci@systeme.lip6.fr, stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200604164145.173925-1-maennich@google.com>
 <alpine.DEB.2.21.2006042130080.2577@hadrien>
 <bf757b9d-6a67-598b-ed6e-7ee24464abfa@linuxfoundation.org>
 <20200622080345.GD260206@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0eda607e-4083-46d2-acb8-63cfa2697a71@linuxfoundation.org>
Date:   Mon, 22 Jun 2020 08:46:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622080345.GD260206@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/20 2:03 AM, Matthias Maennich wrote:
> On Thu, Jun 04, 2020 at 02:39:18PM -0600, Shuah Khan wrote:
>> On 6/4/20 1:31 PM, Julia Lawall wrote:
>>>
>>>
>>> On Thu, 4 Jun 2020, Matthias Maennich wrote:
>>>
>>>> When running `make coccicheck` in report mode using the
>>>> add_namespace.cocci file, it will fail for files that contain
>>>> MODULE_LICENSE. Those match the replacement precondition, but spatch
>>>> errors out as virtual.ns is not set.
>>>>
>>>> In order to fix that, add the virtual rule nsdeps and only do search 
>>>> and
>>>> replace if that rule has been explicitly requested.
>>>>
>>>> In order to make spatch happy in report mode, we also need a dummy 
>>>> rule,
>>>> as otherwise it errors out with "No rules apply". Using a script:python
>>>> rule appears unrelated and odd, but this is the shortest I could 
>>>> come up
>>>> with.
>>>>
>>>> Adjust scripts/nsdeps accordingly to set the nsdeps rule when run 
>>>> trough
>>>> `make nsdeps`.
>>>>
>>>> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
>>>> Fixes: c7c4e29fb5a4 ("scripts: add_namespace: Fix coccicheck failed")
>>>> Cc: YueHaibing <yuehaibing@huawei.com>
>>>> Cc: jeyu@kernel.org
>>>> Cc: cocci@systeme.lip6.fr
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Matthias Maennich <maennich@google.com>
>>>
>>> Acked-by: Julia Lawall <julia.lawall@inria.fr>
>>>
>>> Shuah reported the problem to me, so you could add
>>>
>>> Reported-by: Shuah Khan <skhan@linuxfoundation.org>
>>>
>>
>> Very cool. No errors with this patch. Thanks for fixing it
>> quickly.
> 
> I am happy I could fix that and thanks for confirming. I assume your
> Tested-by could be added?

Yes

Tested-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> Is somebody willing to take this patch through their tree?
> 

My guess is that these go through kbuild git??


thanks,
-- Shuah


