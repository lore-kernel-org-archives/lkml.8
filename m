Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21798C433E6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02C1E20672
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="eZCm30jQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgGOPZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgGOPZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:25:20 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD24EC08C5DB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:25:19 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id p15so2273044ilh.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BiW/jN3rL+5vGHysOrPdpgcbXQ4vTbW3++qctnxB/PU=;
        b=eZCm30jQ/Qc+jKEddMFpjDPUVEJDOJ2pl/XK/6BHPnks2yC1LwQwIKyv72gOpCc6lc
         lV81aiqejy5GKid9iK4bdpHGG/fBYBLb5XGkgsdTCfkIjXi2/GWPuKIalBW0LrzcNSrU
         XcsZZBEuWTXwmSEhKlt7lzekUjfaG5Lsamwwlenik2+LS3CnQKlul6rk9OLweAfWtFQC
         1jZPq65bO0bPOuDCA8LxZgIdSEZ9UTt3m3z4V7IKYgYsre3DSs0nLb5odTdPgmqx2AQY
         VENjRQfFl1AyCQ7C6PfzkuQd0KL0GmxDixcrjek12RxJJX0P9gBC0BYi2B2+soPTUwsp
         M1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BiW/jN3rL+5vGHysOrPdpgcbXQ4vTbW3++qctnxB/PU=;
        b=Eah93l7h9DAT+qKH2pQC41jUPREwxFXfEgK0xu+vf8NdNYRje22VPkNi8fv7QAR4/E
         bn2jYERL0yH/IGK3Wb2mHo1FmjfEEkCIKHqjo6pGuGl7ezlomKO/n3Bh2Yn7+56hruBD
         G8R0QdZtzKiLLNsycUhNCwUy5vs0rG8Y9gQx8OLtSL97KjsjJNjzyq509yK6CCis2SlL
         r7WiL4tdsqw6/sA7GIMkUfju88KtQmeTPAZJUK1pBJlGF6LYXDTWEb/z638TgyJcUe1b
         vqF7x6g536l8+c4LFhnLE19wuopzkcAfwBzVMUKw4WIXuQZEreU9wpS1rU5ySOo9rz2U
         olgQ==
X-Gm-Message-State: AOAM533sjQXQ9YDjMo1REMt1i/Cim0ZFESw+BpXS8VPgDYBWym4I+daY
        yhryhg5ccumKux5MBmmH9coXrleJWDmjdw==
X-Google-Smtp-Source: ABdhPJwCzhW5e78PQkSIJCl8zdBuhNHkvJMbJPY3jb2g/z33Q628vl8nCYLAPnihmkQZXphfIS5mwg==
X-Received: by 2002:a92:8b0e:: with SMTP id i14mr9796070ild.307.1594826718885;
        Wed, 15 Jul 2020 08:25:18 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a13sm1211031ilk.19.2020.07.15.08.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 08:25:18 -0700 (PDT)
Subject: Re: linux-next: build failure after merge of the block tree
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200715121423.6c20731b@canb.auug.org.au>
 <CAMuHMdWMmP_YHEwnqmuTMw4-+LSieRaSHeqPLYLZyLq+O7zhyQ@mail.gmail.com>
 <6bc36827-83a7-3695-530d-4b90c08b92c7@kernel.dk>
 <CAMuHMdU3uRV+8ep0YRKuqBitkfVchh1L7=+RVxCAL0rMrQHAiQ@mail.gmail.com>
 <CAMuHMdW78E0xe2ogeF0tAK3EN0vBr-B1RBOQTqi4t_9ByUiEEw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <44248db6-ff4d-aa83-a89e-dd712d540577@kernel.dk>
Date:   Wed, 15 Jul 2020 09:25:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdW78E0xe2ogeF0tAK3EN0vBr-B1RBOQTqi4t_9ByUiEEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/20 9:22 AM, Geert Uytterhoeven wrote:
> Hi Jens,
> 
>> On Wed, Jul 15, 2020 at 5:08 PM Jens Axboe <axboe@kernel.dk> wrote:
>>> On 7/15/20 3:24 AM, Geert Uytterhoeven wrote:
>>>> On Wed, Jul 15, 2020 at 4:26 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>>>> After merging the block tree, today's linux-next build (arm
>>>>> multi_v7_defconfig) failed like this:
>>>>>
>>>>> block/blk-timeout.c: In function 'blk_round_jiffies':
>>>>> block/blk-timeout.c:96:14: error: 'CONFIG_HZ_ROUGH_MASK' undeclared (first use in this function)
>>>>>    96 |  return (j + CONFIG_HZ_ROUGH_MASK) + 1;
>>>>>       |              ^~~~~~~~~~~~~~~~~~~~
>>>>>
>>>>> Caused by commit
>>>>>
>>>>>   91ba0f529364 ("block: relax jiffies rounding for timeouts")
>>>>>
>>>>> CONFIG_HZ_ROUGH_MASK is not defined for this build even though
>>>>> CONFIG_HZ_100 is set. The arm arch does not include kernel/Kconfig.hz.
>>>>>
>>>>> I have reverted that commit for today.
>>>>
>>>> (as I don't have the original patch in my email, I'm commenting here)
>>>>
>>>>     +config HZ_ROUGH_MASK
>>>>     +       int
>>>>     +       default 127 if HZ_100
>>>>     +       default 255 if HZ_250 || HZ_300
>>>>     +       default 1023 if HZ_1000
>>>>
>>>> What about other HZ_* values?
>>>
>>> Which other ones do we have?
>>
>> $ git grep "\<HZ_[0-9]" -- "*Kconf*"
>> arch/alpha/Kconfig:     default HZ_128 if ALPHA_QEMU
>> arch/alpha/Kconfig:     default HZ_1200 if ALPHA_RAWHIDE
>> arch/alpha/Kconfig:     default HZ_1024
> 
> And ARC allows you to enter any integer value:
> 
>     config HZ
>             int "Timer Frequency"
>             default 100
> 
> So probably you want to derive something from the integer value itself.
> 
> Note that not all architectures include kernel/Kconfig.hz.

I've dropped the dependency on Kconfig solving it, and just made it
an initcall setup to generate the mask. That should work on all archs
and not be dependent on fixed HZ settings.

-- 
Jens Axboe

