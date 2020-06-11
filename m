Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8A6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1A782072F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591887023;
	bh=GUPirhi++sGd/n+z2zQONJz91xoiKqWfx/iAoZPsrRQ=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=ZfwAOGptTErLmXbH8OAanVkzSqoo6XvqWIG3fN5u8GQ1zkMkGPOpMB2vLPZnhW4H7
	 8VF+2w/jWS9cUNybmGU0D6aexpRdCK2mzEeae5fQKJcs8xgw4kPj1UJHsffONT2DoB
	 32zh7AAKCeF/a9vhWz4n6xfwkyADuyEwqGuFbC5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgFKOuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgFKOuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 10:50:21 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACCDC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 07:50:20 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id t25so5621259oij.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 07:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EpArnbAkNEJ1Mu9C2KT3lz8Ka6l4hEnz5L2UCeLp+A8=;
        b=Ej47b5ksuQyZKnIwlBWAFKrkfCPrVUoHe5r+RPTtFtzfzGvGBahnf3PWsNPzxW6GpH
         vJ8j67vQ0i0OucPdXsDqi7OvO1adKpQq2u54vgfTSIRH5cTbZs2GK7au6uN0p/sL42jf
         H/qgy5qZsBdX9C7d5nC0RMTZBQHA4b0BMEmYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EpArnbAkNEJ1Mu9C2KT3lz8Ka6l4hEnz5L2UCeLp+A8=;
        b=L+k3r+89RmdWK2f01HERUEbxsv0vM0xr9TaF0gZ7upwNO9BwybibN+LMgT+zBkZ6hR
         3m6+iMdDZOVA5YuHY4wqcxvJc+LdpJYDqMoO3h3bu7wRzvr7MwY7u/ty/VmAyrKeMgOj
         5YezEm/x1/NjvPy8lpFixhuO0eJJjJAwsj0PamJe1uSCv+cD6e44wnuu0XUoj/6IRY+c
         EfNHsfOhPSB7LldQiXijRgWlBOGaioPpTbWJk1m3jLWXKhZgaIIQ3ZsxTRRv+x1wqSgE
         wMSPFySVs+gxyHYUcYlBC8MK8pUpI58VSMGqlTZDrssyOMHUjJx7RMtU5HE3qlFtm2rA
         VZaA==
X-Gm-Message-State: AOAM532tijDqgS2UkcQK/MeAmTd3OjXCQqU7LzINeaHE75nLBmYg37mr
        gCrV/R647OGhpA57XzY38joFlQ==
X-Google-Smtp-Source: ABdhPJwFHS5D+73uwTizvX8joYisff7vxV87zzKD+FCKSmnYYjcy9EklAYBDfNG0nuYrZQ2AOidk8w==
X-Received: by 2002:a05:6808:50:: with SMTP id v16mr6149708oic.93.1591887020306;
        Thu, 11 Jun 2020 07:50:20 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k15sm710695oom.22.2020.06.11.07.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 07:50:19 -0700 (PDT)
Subject: Re: [PATCH] arch/x86: reset MXCSR to default in kernel_fpu_begin()
To:     Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>
Cc:     Petteri Aimonen <jpa@git.mail.kapsi.fi>,
        Andy Lutomirski <luto@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, skhan@linuxfoundation.org
References: <20200611091822.GA30352@zn.tnic>
 <301D30B5-26F7-454B-8C0C-A5DFC73222CF@amacapital.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <95d023b3-9b88-618e-440a-fc9361ae617f@linuxfoundation.org>
Date:   Thu, 11 Jun 2020 08:50:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <301D30B5-26F7-454B-8C0C-A5DFC73222CF@amacapital.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/20 8:19 AM, Andy Lutomirski wrote:
> 
> 
>> On Jun 11, 2020, at 2:18 AM, Borislav Petkov <bp@alien8.de> wrote:
>>
>> ﻿On Thu, Jun 11, 2020 at 10:36:08AM +0300, Petteri Aimonen wrote:
>>> Hi,
>>>
>>>> How about putting the file you frob in
>>>> /sys/kernel/debug/selftest_helpers/something_or_other.  The idea would
>>>> be that /sys/kernel/debug/selftest_helpers would be a general place
>>>> for kernel helpers needed to make selftests work.
>>>
>>> Seems like this is the consensus for now.
>>>
>>> Any opinions on whether the module should remove "selftest_helpers"
>>> directory on unloading, or not?
>>>
>>> 1) Removing would break if other test modules will use the same dir.
>>> 2) Not removing will leave the directory dangling.
>>> 3) Remove only if empty is one option, though I'm unsure how to
>>>    cleanly check if debugfs directory is empty.
>>> 4) E.g. /sys/kernel/debug/x86/ is created centrally and a symbol is
>>>    exported for its dentry. But I'm not sure if it really makes sense
>>>    to add another exported symbol just for selftest_helpers.
>>
>> I'd say you do the simple thing and cleanup after you're done, i.e.,
>> remove the dir. When something else starts using it, then it would need
>> to be taught to deal with multiple users.
> 
> Seems good to me. Let’s have at least two users before we go nuts with the architecture :)
> 

I am good with this. Let's start with simpler approach and build.
Please cc linux-kselftest and add me to the patch thread.

Thanks for this work. I think this will help expand coverage.

thanks,
-- Shuah

