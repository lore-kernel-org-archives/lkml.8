Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD42C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F18D20760
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593617683;
	bh=2GbCdUbx0DakCgQlkBylpGE8be+rhaQdujz9hLlpozg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=mnpG42dR2EDEtCztoMhf+CiNSFE24uYakHl5/A6bFdtARhitqCumgUqYllwMfYThF
	 Pn1iJSN+hAidUuCvpA+wIaAdJ0mVDvmxB0fYt0ucUt9xzF+VMCMX9+6LG0hn284YBU
	 fF5kSAOEt2aOILv/DL3hpOzsLwdSb2cLVij5ZH8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbgGAPem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731399AbgGAPel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:34:41 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0D1C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 08:34:41 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 18so21723857otv.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BO3A9UFCSekFMTeFwoQzee/zUYU1XRTbKaOkhPKAKz0=;
        b=auaWToNTNPAI7ppvFZCdj7N27JvGATqL//VThzIioprulKBRax839H40k4lzaT97m0
         7p9o6uS/CoEjrFVQjaVfHrDIsS7eTlvle0sMHYHgWZNL3RWbumy8/gJcOv6qobzlBGmS
         gIvR96Kz1+B31Kg3YlsDBbxbYtZaSbK6tffDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BO3A9UFCSekFMTeFwoQzee/zUYU1XRTbKaOkhPKAKz0=;
        b=Il8NQ4YOKaJE10Clx2/dWFBKjlDfGh7y0ZGukOgv4OgFR55gYdSbey85gfduVHmK6Q
         CL2dDvJUqRZv+26YofD7frwBuFRgt42DDZg0zYSVqPSfLUQdcqEfY4sgVA0j5Z/NyiZf
         zqrqqhxKq7+qilhQCGPGU3d7DgaWEmBvImwnrQ/6pLgI2z56GEUMG3PY+eEQU22WEL8E
         L9TO66BpRhN0fCxZuknhOvOEx+sqVrDO8qZqyv7ZmcX20w9F6hKybi5fHtWq233Ef9kn
         8368PsJxoeb1p5IHxQAQGB7nCaTnobltN33YXd82WmYOjEXZqZgEYQrKNQAYItnosdks
         sZfg==
X-Gm-Message-State: AOAM533voirMzLjSmIqqIwRFXVsZD3lYe5iC/0TO/6XWOFxUxM0++wkJ
        fqNGENUX9/bL0yJuhozEB7m2qw==
X-Google-Smtp-Source: ABdhPJwCAss0hEdRm8bsv6r18PQcnLkyq29udZm9VQ81HYaIJde7cAzf55HrjDKUfb+UruvuD7hWkw==
X-Received: by 2002:a9d:73c9:: with SMTP id m9mr14088153otk.94.1593617680732;
        Wed, 01 Jul 2020 08:34:40 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z17sm98607oic.32.2020.07.01.08.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 08:34:39 -0700 (PDT)
Subject: Re: [PATCH 5.7 000/265] 5.7.7-rc1 review
To:     Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        skhan@linuxfoundation.org
References: <20200629151818.2493727-1-sashal@kernel.org>
 <42dadde8-04c0-863b-651a-1959a3d85494@linuxfoundation.org>
 <20200629231826.GT1931@sasha-vm> <20200630083845.GA637154@kroah.com>
 <20200630151248.GY1931@sasha-vm> <20200630153325.GA1785141@kroah.com>
 <20200701144000.GC2687961@sasha-vm>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7c55aa3f-1027-a640-9501-55502fd2745d@linuxfoundation.org>
Date:   Wed, 1 Jul 2020 09:34:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200701144000.GC2687961@sasha-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/20 8:40 AM, Sasha Levin wrote:
> On Tue, Jun 30, 2020 at 05:33:25PM +0200, Greg Kroah-Hartman wrote:
>> On Tue, Jun 30, 2020 at 11:12:48AM -0400, Sasha Levin wrote:
>>> On Tue, Jun 30, 2020 at 10:38:45AM +0200, Greg Kroah-Hartman wrote:
>>> > On Mon, Jun 29, 2020 at 07:18:26PM -0400, Sasha Levin wrote:
>>> > > On Mon, Jun 29, 2020 at 02:37:53PM -0600, Shuah Khan wrote:
>>> > > > Hi Sasha,
>>> > > >
>>> > > > On 6/29/20 9:13 AM, Sasha Levin wrote:
>>> > > > >
>>> > > > > This is the start of the stable review cycle for the 5.7.7 
>>> release.
>>> > > > > There are 265 patches in this series, all will be posted as a 
>>> response
>>> > > > > to this one.  If anyone has any issues with these being 
>>> applied, please
>>> > > > > let me know.
>>> > > > >
>>> > > > > Responses should be made by Wed 01 Jul 2020 03:14:48 PM UTC.
>>> > > > > Anything received after that time might be too late.
>>> > > > >
>>> > > > > The whole patch series can be found in one patch at:
>>> > > > >     
>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.7.y&id2=v5.7.6 
>>>
>>> > > > >
>>> > > >
>>> > > > Looks like patch naming convention has changed. My scripts look
>>> > > > for the following convention Greg uses. Are you planning to use
>>> > > > the above going forward? My scripts failed looking for the usual
>>> > > > naming convention.
>>> > > >
>>> > > > The whole patch series can be found in one patch at:
>>> > > >     
>>> https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.6-rc1.gz 
>>>
>>> > > > or in the git tree and branch at:
>>> > > >     
>>> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git 
>>> linux-5.7.y
>>> > > > and the diffstat can be found below.
>>> > >
>>> > > Sorry for that. I was hoping to avoid using the signed upload 
>>> mechanism
>>> > > Greg was using by simply pointing the links to automatically 
>>> generated
>>> > > patches on cgit (the git.kernel.org interface).
>>> > >
>>> > > Would it be ok to change the pattern matching here? Something 
>>> like this
>>> > > should work for both Greg's format and my own (and whatever may come
>>> > > next):
>>> > >
>>> > >     grep -A1 "The whole patch series can be found in one patch 
>>> at:" | tail -n1 | sed 's/\t//'
>>> >
>>> > If those don't work, I can still push out -rc1 patches.
>>> >
>>> > It might be best given that the above -rc.git tree is unstable and 
>>> can,
>>> > and will, change, and patches stored on kernel.org will not.
>>>
>>> That's a good point. Maybe we should push tags for -rc releases too?
>>> that would allow us to keep stable links using the git.kernel.org
>>> interface.
>>
>> If we really want to do this, then yes, we could.  But that kind of goes
>> against what we (well I) have been doing in the past with that tree...
> 
> We've been force pushing it, yes, but if we add tags it would just keep
> older version around so I don't think it would change much for our
> workflow, but it would make it easy to get to older versions.
> 

I can make changes to my scripts as long as the process is consistent
for stable releases. Let mw know what you come up with, I will make
adjustments to my scripts.

thanks,
-- Shuah
