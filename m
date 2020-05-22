Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162FFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A0520723
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDzZnaHB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbgEVV3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 17:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731027AbgEVV3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 17:29:00 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EA0C061A0E;
        Fri, 22 May 2020 14:28:59 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z64so1255706pfb.1;
        Fri, 22 May 2020 14:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7AgyhMxVLyakTMRRXW07NLGBZHzapPWETMMsFXtXr+M=;
        b=LDzZnaHBc+7izwAt2eZqYYpFwCQ80g/eritVnD0lIft1wlJJ+y+9kvOByKggECdF1C
         IjufMVnhaJODAPJc2Egt84jokZb+UE3/3GFsqs0m9i02TPfhZXS492ikl/rlobudpGZ2
         LMO4NeiKMYm/V75KErlYWLgttC7QLR0iTW9Y+UZ8T7XmqIbuK5x1TA1I8J3m2volKtuu
         9lCEZ4OHniAXcQV/GpJ0t3EGC7NPStZrctbqoiLLowTr2C2QHaUuS8QVx+U8fg5rPAnJ
         krXhTkE8yHCjFWU1sa8JZq3/al99BI//2KKbdoRL/SNCoDtHO0Pn1hyVVpAlVZuD7lcu
         +BVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7AgyhMxVLyakTMRRXW07NLGBZHzapPWETMMsFXtXr+M=;
        b=aalnE5QeGr5fVNBZRYj5oIloqEQFNde2XXqcefutEVZRHOvgx67flO7tkjJ5zj/5Pc
         yOkjSk+3GA9nS5bATaix9I6XIr5zj2mCFk/tlTS+PZwDmJ5tMgshzS9DAKW367HxhGd9
         4nMwplN68heSWomilQCfZY4upY8kwnWDD4c4Of42yij8g+w8H14xVaKwFcQ7sMYWzpyS
         DOmRSRFWzKK3kcj0wxuwf7Z5mTfCxmIO4+rKOhDf7GiPKDs6yplLLCylhMY32avofxvH
         8dUW5uXKd+y9PYY9FsAgUU3u6jIbiSzBzCEkjsaSxG1sccNIv0VvGdJWV89ZFckSmNdm
         kJWQ==
X-Gm-Message-State: AOAM532g0YOQbkwpbIXwp7IzBA0bidQi8qR8KXb6ozC4+JaJuTqPXkuv
        NCKaocVKoYVnWwTHErJaFT8lEAfp
X-Google-Smtp-Source: ABdhPJzsEzHoYY8Ru7VnVm29EF3/xQR5FxexZ4eICnwdiufoYfdhEFGIXGFYtFdKwbPIOJLpposIcQ==
X-Received: by 2002:aa7:9515:: with SMTP id b21mr5527258pfp.282.1590182938729;
        Fri, 22 May 2020 14:28:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o68sm7241858pfb.206.2020.05.22.14.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 14:28:57 -0700 (PDT)
Subject: Re: [PATCH] csky: Fixup calltrace panic
To:     Guo Ren <guoren@kernel.org>
Cc:     Guo Ren <ren_guo@c-sky.com>,
        =?UTF-8?B?556/5LuZ5re8?= <xianmiao_qu@c-sky.com>,
        =?UTF-8?B?5bCa5LqR5rW3?= <yunhai_shang@c-sky.com>,
        Guo Ren <guoren@linux.alibaba.com>, linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200517175220.GA48379@roeck-us.net>
 <D93AFA5B-3BF1-4E11-B278-22E980C3EE36@c-sky.com>
 <45e1a784-f8fe-5f17-45ca-3eb5453d4bb4@roeck-us.net>
 <CAJF2gTQj+FzDMM7YNX=iwjpJL3zfuDDua34o+m4pK0rdRYFPwg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <15bbf77c-e0cf-59a5-6abc-9eeae93ccc74@roeck-us.net>
Date:   Fri, 22 May 2020 14:28:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJF2gTQj+FzDMM7YNX=iwjpJL3zfuDDua34o+m4pK0rdRYFPwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/20 8:28 AM, Guo Ren wrote:
> Hi,
> 
> On Thu, May 21, 2020 at 10:46 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>> We tested it with https://github.com/c-sky/gcc (gcc-6.3)
>>>
>>
>> That won't work for me. You really might want to consider
>> supporting upstream gcc. I'll try disabling CONFIG_STACKTRACE
>> for csky build tests. If that doesn't work, I may have to
>> disable affected csky build tests for the time being.
>>
>> Guenter
> 
> Not only CONFIG_STACKTRACE,
> Disable FRAME_POINTER (Kernel hacking -> Compile the kernel with frame pointers)
> 

You are correct. This is what my test builder now does:

Build reference: v5.7-rc6-37-g115a54162a6c
gcc version: csky-linux-gcc (GCC) 9.3.0

Configuration file workarounds:
    "s/CONFIG_FRAME_POINTER=y/# CONFIG_FRAME_POINTER is not set/"

Building csky:defconfig ... passed
Building csky:allnoconfig ... passed
Building csky:tinyconfig ... passed

Guenter
