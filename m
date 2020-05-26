Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1794BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 13:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9B3E2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 13:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590501534;
	bh=46DlyYeRMc1Y1HkqQhwUSrFF/HgsXBGPaEM/hbCSiMc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=b7U78qpTvmWwCXEUg/DTYH/O0Sht4DlY4IOMJZQI7eTuH5zl8Et3j96KZ+xLbN3Cu
	 ydJ+3PwUv2VAhwdF60/TBUg7XXZJYfFY+MmBkF9ygiuIevfpgsQsNKQzqbdKUNPRdj
	 xqRf9JwLmj4zQugYYZY4oKZq4bnSHJH+/bAGaa1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbgEZN6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 09:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbgEZN6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 09:58:52 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F004C03E96E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 06:58:52 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id d7so16312950ote.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 06:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XWqm20ortSoNX+nbX7a42upA+Vp64e+AVN09KF9Ad8M=;
        b=dH/zxctH3oJeLyU5L+BqkAe7IuarlhEZvNhoE61BAaOVZQYyWBIx6XMKPEj9Q2xMWP
         ZsEFnhvFyiLx3H8BBdfGDHVnBXtNyuTxECLTFxOv9e6JXEKggaRuPijgIy8jOBVnTLmg
         810kGA3cnWAe5bxBSO7qekFipcvZXgBSCLPGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XWqm20ortSoNX+nbX7a42upA+Vp64e+AVN09KF9Ad8M=;
        b=IJdp01KSYkHaIFrjKgdi5fLWzk/8dAq+R7RVvNIVXd010F1tiPpUWtAQ/cJZgWtCo3
         cJl0cCq6T8LcjPIVlnYAiaPJ5N84fn07XSYuiyKrxEy1Wvr/+caSeRp2OGuC9RHDyZx6
         p45uuxFrLN8Px4+yJRUBqGA1U6udC6J8zVqzXcxaoDWl2yACxdwu4Bzlz97furWoCAR9
         maIY98ecfgfqw9BokzW1WG7rUPn6+ESu6jZTx1xImVvfDwxU+pSOflcV6ZfQ7IwFj1iR
         zIvqgGYKNnLc08bmgH8ceprzMcVVhgcGpxB+A2BxI4oIbDLDoTaz9PwhoZdV40jg6QBG
         Cpfw==
X-Gm-Message-State: AOAM5310tOwL2wijM+NFeO6nG7lsq6fqO2SM6Cy3okDIgZiBDTZ37yI3
        z3S835N0Q8Pcaw+6zehmwBxgGxkg0Tg=
X-Google-Smtp-Source: ABdhPJz+/zK5moeWMtUn69a8IIKjkkhGLNDtnmG2OwfD8yave3Ngp7r9TvkVF/HxgAP9kKH0Uj/a2A==
X-Received: by 2002:a9d:2da8:: with SMTP id g37mr932324otb.293.1590501531610;
        Tue, 26 May 2020 06:58:51 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d19sm10979ooa.48.2020.05.26.06.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 06:58:50 -0700 (PDT)
Subject: Re: [RESEND] kunit: use --build_dir=.kunit as default
To:     Vitor Massaru Iha <vitor@massaru.org>, shuah <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200414230950.83665-1-vitor@massaru.org>
 <CAFd5g47CaeEBiJsiSUtihHQF+OGpfCg76dS2ys2mwy2qn_L5-w@mail.gmail.com>
 <c035d65b-7e93-f948-22f9-73a56193ec36@kernel.org>
 <b04934ab91fd57e6df35279ad8a2619afb00b452.camel@massaru.org>
 <6403abc0c60fcb5069e1cdea0bb7f25b6dc8070f.camel@massaru.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5599cbd7-2c2d-7035-deea-25e6e0da407e@linuxfoundation.org>
Date:   Tue, 26 May 2020 07:58:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6403abc0c60fcb5069e1cdea0bb7f25b6dc8070f.camel@massaru.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/20 8:27 PM, Vitor Massaru Iha wrote:
> On Mon, 2020-05-25 at 22:52 -0300, Vitor Massaru Iha wrote:
>> Hi Shuah,
>>
>> On Fri, 2020-05-22 at 16:40 -0600, shuah wrote:
>>> On 4/16/20 5:11 PM, Brendan Higgins wrote:
>>>> On Tue, Apr 14, 2020 at 4:09 PM Vitor Massaru Iha <
>>>> vitor@massaru.org> wrote:
>>>>> To make KUnit easier to use, and to avoid overwriting object
>>>>> and
>>>>> .config files, the default KUnit build directory is set to
>>>>> .kunit
>>>>>
>>>>>    * Related bug:
>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=205221
>>>>>
>>>>> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
>>>>
>>>> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>>>>
>>>
>>> Applied the patch to kselftest/kunit on top of
>>>
>>> 45ba7a893ad89114e773b3dc32f6431354c465d6
>>> kunit: kunit_tool: Separate out config/build/exec/parse
>>>
>>> from David's work resolving merge conflicts. Please check if it is
>>> sane.
>>>
>>> thanks,
>>> -- Shuah
>>
>> The kunit branch had some problems related to identation. KUnit's
>> code
>> has mixed identation, and with that, in conflict correction, it ended
>> up breaking python.
>>

Thanks for sanity checking my merge.

>> In addition I found a bug: related to the creation of the
>> .kunitconfig
>> file inside the default build directory.
> 
> This is actually related to the other patch "kunit: use KUnit defconfig
> by default"
> 
> 
>>   Should I send the patch again?
>> Or do I make a bugfix patch?
>>

Please send the fix.

thanks,
-- Shuah

