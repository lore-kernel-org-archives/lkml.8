Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F060C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 332952073E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hiRSb5Yt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgGAJpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729125AbgGAJpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:45:46 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1511C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 02:45:45 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l17so21719852wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 02:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6VkV+wbco7PMo2lrx2pWkKGDXAggcNMM6AGCXcdqnrg=;
        b=hiRSb5YtCTCYJXD4xuWILS0OgVMj5jSL9PZ+ZswTZO25rKabPqPkdc1LzvwF3lIiyr
         C5c6VZax5MG6lpW2/PZ8TkPt6nd4uwb4p0lFMrJIF++V07/sxOOP8mWVZZ9Gmr7mhhSI
         rkiZkoyyVHP2obLKQrNlH8pi/nS95nCR8e/9Q+Y/ifsLDHEhd3xQbXSoe9JZw0436aAT
         yE6bzjghW9ovcNixvKN8vXLA3nI1u42g4bRgz1M+BlRRhgrdb0isQzkzFn1rB2AdU0MV
         5e6F3gUfScBIZ0OwKD6M30aIg/SXuZFO8nuT48BQ8X3cOQIuY12XWrIqsP3SShe58uS4
         FWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6VkV+wbco7PMo2lrx2pWkKGDXAggcNMM6AGCXcdqnrg=;
        b=FsAvOtK5EUTo9AJMVNfsz1Eeyc+1Un3cmY/VgNXCPVFwZROsXEZJOKpvUgCqWPWiej
         p25asHCZxuuhLpjC0uEFO41Mruere4cg2ziO+oT6KTrdJmgFOe891+3VDALB2rY2OiOn
         g2F6+RGjFg9lYFYQYinEW9MyTDCam3LLa+9UTzzjpI+JYXTKvWS6xhenhJRs7mti0Jy/
         HeZJqvwVmwKgMZ1IBgo60Og2kVeiCeswKzmJrj4AiWSvr/46zCAJnmmRn9u9GH0LMwPx
         7o/yDksdlwzA2LLhCTIzecCngPxQh1uTVpQHZ8Y1deXxNXU6FpYJp7zMLZRhigNL2Uai
         LvqQ==
X-Gm-Message-State: AOAM532ggj0OIFIJnxg0OXmLlWZCfPQHn4yg6Du0nwMSHR3an0SNnca8
        mOvLmUdpcM+sr1hnWM2KxRb7ql2wOA0=
X-Google-Smtp-Source: ABdhPJzyXvtz+lTTpNdu32MAj1FLMURsJ8+tDmEox8kYVm5CuY66aCjaqa1zO7wtqrwlDeiOEbT2pw==
X-Received: by 2002:a1c:3546:: with SMTP id c67mr26090842wma.102.1593596744035;
        Wed, 01 Jul 2020 02:45:44 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:54f4:a99f:ab88:bc07? ([2a01:e34:ed2f:f020:54f4:a99f:ab88:bc07])
        by smtp.googlemail.com with ESMTPSA id c206sm6860256wmf.36.2020.07.01.02.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 02:45:43 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] thermal: core: Remove old uapi generic netlink
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200625144509.17918-1-daniel.lezcano@linaro.org>
 <20200625144509.17918-3-daniel.lezcano@linaro.org>
 <CAP245DUMjTQr2vKirZ+FxEYWC=VQ_k+OegxQgXcKDU8ThWuCsQ@mail.gmail.com>
 <0fe6837f-9b44-4578-23f2-3e4932d01122@linaro.org>
 <CAP245DUG-OsSD-_CucMMQ26HpzjJhn0emfq_go923NsDq6RqOg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c664d247-7f9b-603f-c318-48e534aedfc9@linaro.org>
Date:   Wed, 1 Jul 2020 11:45:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAP245DUG-OsSD-_CucMMQ26HpzjJhn0emfq_go923NsDq6RqOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/2020 11:33, Amit Kucheria wrote:
> On Wed, Jul 1, 2020 at 2:56 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 30/06/2020 13:47, Amit Kucheria wrote:
>>> On Thu, Jun 25, 2020 at 8:15 PM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> In order to set the scene for the new generic netlink thermal
>>>> management and notifications, let remove the old dead code remaining
>>>
>>> s/management/management api/
>>>
>>> s/let/let's/
>>>
>>>> in the uapi headers.
>>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> ---
>>>>  include/linux/thermal.h      |  5 -----
>>>>  include/uapi/linux/thermal.h | 12 +-----------
>>>>  2 files changed, 1 insertion(+), 16 deletions(-)
>>>>
>>>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>>>> index faf7ad031e42..fc93a6348082 100644
>>>> --- a/include/linux/thermal.h
>>>> +++ b/include/linux/thermal.h
>>>> @@ -302,11 +302,6 @@ struct thermal_zone_params {
>>>>         int offset;
>>>>  };
>>>>
>>>> -struct thermal_genl_event {
>>>> -       u32 orig;
>>>> -       enum events event;
>>>> -};
>>>> -
>>>>  /**
>>>>   * struct thermal_zone_of_device_ops - scallbacks for handling DT based zones
>>>>   *
>>>> diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
>>>> index 96218378dda8..22df67ed9e9c 100644
>>>> --- a/include/uapi/linux/thermal.h
>>>> +++ b/include/uapi/linux/thermal.h
>>>> @@ -6,21 +6,12 @@
>>>>
>>>>  /* Adding event notification support elements */
>>>>  #define THERMAL_GENL_FAMILY_NAME                "thermal_event"
>>>> -#define THERMAL_GENL_VERSION                    0x01
>>>> +#define THERMAL_GENL_VERSION                    0x02
>>>
>>> This hunk should be removed since you set version back to 1 in the
>>> next patch and we don't actually intend to bump the version yet.
>>
>> Well, I've been very strict here for git-bisecting.
>>
>> I move to V2 because of the removal, but when adding the new genetlink
>> code, the family name changed, so we returned back to the V1 as it is a
>> new genetlink thermal brand.
> 
> I don't understand the move to v2 for an empty skeleton UAPI. For the
> purposes of bisection, couldn't you just remove all the v1 UAPI (w/o
> bumping to v2) and then add a new UAPI in the next patch?
> 
>> The name is change because it is no longer event based but also sampling
>> and commands.
> 
> In this case, just to avoid any confusion, the new UAPI could be v2
> making the transition clear in case of bisection.
> 
> I'm afraid the v1->v2->v1 is a bit more confusing.

Let me elaborate a bit:

Why there is this patch ?
- By removing this code first, the next patch will just contain
additions, I thought it would be clearer

Why increase the version here ?
- Code must continue to compile and as the 'thermal_event' family is now
different from V1, the version is changed

Why the version goes to V1 in the next patch ?
- The family name is changed as it is not doing event only, so it is a
new netlink thermal protocol and we begin at V1

So the main reason of this patch is to be very strict in the iteration
changes. May be it is too much, in this case I can merge this patch with
4/5, the old netlink protocol removal will be lost in the addition of
the new protocol. I'm fine with that if you think it is simpler.




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
