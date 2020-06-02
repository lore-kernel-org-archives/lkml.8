Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A781AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 707DD206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591129560;
	bh=AHjEmJ7U0OYUipYTkwgoxUgEYg3OPlzl1W+N9Up4phU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=jBKQaOmDdPEzGG9JuVQfxIj0rOYDe3Tsa1Uyz/dTiJYJc101EhuEhaOfgk8NcxVIz
	 tra5FSUUZmLzQqiK+9vy0CQQulENyG3xqFFQ5h92jk+spPhPVKdTd7NuwRIYk33yFC
	 xa0gBtACdjMhzEu7xn3eP1IneuQlWEnHigG2aZ8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgFBUZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 16:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgFBUZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 16:25:58 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAABC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 13:25:58 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 69so7010otv.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 13:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0VkbADwNNL4t8G+Nl0yEBT+sG9zYHlegci6mldBU13Y=;
        b=M5wAwey1R6AjLyR6zhAr4Mpq3OcoUq5oRmv0alkvKituK2UFsV9YsoowLwmP7ckkhv
         iEQiCoCjRkzxUMirgAQVPtdcBWS8k1Mq8icDa7QVdRvpJ8BLwHDJkFs6Y+e/PXJETKdo
         7belOu9rdJZtt8eC4X02eItmbB10YzzmS1sX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0VkbADwNNL4t8G+Nl0yEBT+sG9zYHlegci6mldBU13Y=;
        b=c7xiRXnUepugyBdkFChmgFd51Sep3uHNAMaraVSbcUxRc07bGZHci3rMg2CDHcIKxz
         Jd8Ci4LnKok6gcCXFLwbxVJ/j3kKos81I572IvEBGTwI8B4twtU56cgnQ7+utQRw0cDV
         ciwMbsdNI/lqj4Ggbi6hOe8uC3Hba65dzPXde3r+gry5QwOqfsxhepOh1wvY8IccWFOr
         +TpPxP+2C09PDdd6XxoG8KQeqcpaKQpWi6DwkFE8rY6UFoIFYZRnJu6K0jwuOm0cVffm
         3p6pvDPOuamMWZbvQX/HVPYfvfZLQC9GsXzcTnQ49J3YJLkNxAZMgzzJChd0Xckg1yLs
         BClA==
X-Gm-Message-State: AOAM53252aoDZwxz2Mksd8JAJ24Xlvnxi9Zgb/DuVoljtWS4qD0E7F+z
        bj+6i4XhY/On8bDvB4VGHUFpX1pde+w=
X-Google-Smtp-Source: ABdhPJygg7YgN4Su8lffxlYwOaMZvO9xKa6xEYOTJMPYYNrSkrsDqKu04VllsWOZa5yCnrrJWxg7Ig==
X-Received: by 2002:a9d:6ad5:: with SMTP id m21mr704370otq.307.1591129557722;
        Tue, 02 Jun 2020 13:25:57 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u93sm881318otb.33.2020.06.02.13.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 13:25:57 -0700 (PDT)
Subject: Re: [PATCH] arch/x86: reset MXCSR to default in kernel_fpu_begin()
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Shuah Khan <shuah@kernel.org>,
        Petteri Aimonen <jpa@git.mail.kapsi.fi>,
        Dave Hansen <dave.hansen@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, skhan@linuxfoundation.org
References: <8b1f0bfa-79b0-74e4-0241-8b2a94491807@linuxfoundation.org>
 <C6F6F6E4-CBD8-4E72-812B-99F008ECAA4F@amacapital.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b4629042-21c7-2b38-4c3f-44f9be469cca@linuxfoundation.org>
Date:   Tue, 2 Jun 2020 14:25:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <C6F6F6E4-CBD8-4E72-812B-99F008ECAA4F@amacapital.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/20 1:50 PM, Andy Lutomirski wrote:
> 
> 
>> On Jun 2, 2020, at 10:27 AM, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> ﻿On 6/2/20 11:03 AM, Andy Lutomirski wrote:
>>>> On Tue, Jun 2, 2020 at 3:56 AM Borislav Petkov <bp@alien8.de> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On Tue, Jun 02, 2020 at 01:29:51PM +0300, Petteri Aimonen wrote:
>>>>> The kernel module is not actually x86-specific, even though it is
>>>>> currently only enabled for x86. amdgpu driver already does kernel mode
>>>>> floating point operations on PPC64 also, and the same module could be
>>>>> used to test the same thing there.
>>>>
>>>> Then make it generic please and put the user portion in, say,
>>>> tools/testing/selftests/fpu/ and we can ask ppc people to test it too.
>>>> People might wanna add more stuff to it in the future, which would be
>>>> good.
>>>>
>>>>> To deterministically trigger the bug, the syscall has to come from the
>>>>> same thread that has modified MXCSR. Going through /usr/sbin/modprobe
>>>>> won't work, and manually doing the necessary syscalls for module loading
>>>>> seems too complicated.
>>>>
>>>> Ok, fair enough. But put that file in debugfs pls.
>>> I think I agree.  While it would be delightful to have general
>>> selftest tooling for kernel modules, we don't have that right now, and
>>> having the test just work with an appropriately configured kernel
>>> would be nice.
>>
>> Let's extend it to do what we want it to do. I will happy to take
>> patches. If you have some concrete ideas on what we can add, please
>> do a short summary of what is missing. I will find a way to get this
>> done.
>>
>>> How about putting the file you frob in
>>> /sys/kernel/debug/selftest_helpers/something_or_other.  The idea would
>>> be that /sys/kernel/debug/selftest_helpers would be a general place
>>> for kernel helpers needed to make selftests work.
>>
>> Is this a workaround for the lack of selftest tooling for kernel
>> modules? In which case, let's us focus on fix selftest tooling.
> 
> The goal here is to have a selftest that runs kernel code as part of its operation. That is, the selftest is, logically, starting in userspace:
> 
> setup_evil_state();

Is it correct to assume the stuff checked differs from test to test
and done in user-space.

> ret = call_kernel_helper();

> check_some_other_stuff();

Is it correct to assume the stuff checked differs from test to test
and done in user-space.

> undo_evil_state();

Is it correct to assume undoing evil differs from test to test
and done in user-space, provide it can be done from userspace.

> 
> And the call_kernel_helper() could be moderately specific to the test.
> 
The overall plan sounds good to me. I am all for adding support to
selftests so we can keep extending it.

thanks,
-- Shuah
