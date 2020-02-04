Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54FAC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 22:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DEA2082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 22:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uQnUHfdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgBDWC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 17:02:58 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44633 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbgBDWC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 17:02:58 -0500
Received: by mail-pg1-f196.google.com with SMTP id g3so4653251pgs.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 14:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=cw7uphHP9U6UP+lxamhBKouzCmQh7IsOGgJhwnSNEpw=;
        b=uQnUHfdRIINQILC2vRhlGkfEXV7/liBdS6QaMg0YF6q1CGpK6rMZpNPZG9zXgQeeIQ
         2tXaPr0DFInuRmBMRG5JRCe7d4jcpjLg9zsCbVTrvmUQdCtfZ+i9QSZxpPrbjkh1IWnh
         Zxq3X4+r+nhA/VVK+ExH5EGCsE2wFdJ0d6tIIt3WYMhaB2mbHgb3pezQPrlkzhh9XkfZ
         uU0RIShMQBqMG+ue5S0Tawxj5xXrADcyBwyi7RD/9T7ZCDfTkZlBwljmVQSSjNQ8MTrt
         AwICamJr2Vze485Ve9ATOP5OEQ8F+XAhiMfyYcOAT+D1pHEHZ/cq3euRl0FO+pcpGD7P
         sVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cw7uphHP9U6UP+lxamhBKouzCmQh7IsOGgJhwnSNEpw=;
        b=M5zeouMh4xOQvA+AQXXg1wiGZFEYPuR89k9G80J2ankiX7KAcVFuaImQ++tJq3M7Or
         vPvTy6qZddR2O9nciK/HXA0Z+uCun+38Icj+vzCesGMuysRl1vUVFtDNXALhnaMFLb4v
         lpL4Av+X2M8YH9Xnq5BOdc0epXDfyrrjpHdpRrjtkU5N4dQwVIYxO48tG55AWpy07HVJ
         Didbd4Is4ERkOI8y23YdkTw5760PPIPuU+85TKplhM4HVsjHP6Sa4Er3SrE8IuPIPgyI
         0JOREGCSkdazWOa/Fdtk3+VHhbNbAfYI79eHF2TFMhhvO4c6AXdqGaQkkZeZg6kRvP1G
         Vexg==
X-Gm-Message-State: APjAAAUwjcFlYqhvxP9r8le91ayyL5txze2YfKoN2DqXTEkQowckieUm
        L5U9ZxZmx5cv8wR3Hs2iAoE=
X-Google-Smtp-Source: APXvYqzgNdF5P9pxxeKfQGmx7wbYhoI8qMqKyh9CCxGBAM9YByTCjdKgzhIZdEPwZrbPHr5B5wCJtQ==
X-Received: by 2002:a63:120f:: with SMTP id h15mr4104893pgl.235.1580853777898;
        Tue, 04 Feb 2020 14:02:57 -0800 (PST)
Received: from [192.168.0.16] ([97.115.141.236])
        by smtp.gmail.com with ESMTPSA id gx2sm4698984pjb.18.2020.02.04.14.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 14:02:57 -0800 (PST)
Subject: Re: [PATCH] kbuild: Include external modules compile flags
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dev@openvswitch.org, dsahern@gmail.com
References: <1580161806-8037-1-git-send-email-gvrose8192@gmail.com>
 <CAK7LNAQyh9CFgKd1DtAPFW8DuHNp1gn8YABuP8-LsF=hHK2DFw@mail.gmail.com>
 <f6ffa0d0-8214-8fc0-4fe9-4b70a1581d3e@gmail.com>
 <677aff5a-a52e-08ae-f341-547af08f7566@gmail.com>
 <CAK7LNARsBQm8jTs6PZDHAVFX4GZ_=Ls-5MOutNJFOHBN29Gd5w@mail.gmail.com>
From:   Gregory Rose <gvrose8192@gmail.com>
Message-ID: <660c4df3-16c8-4b06-9f06-cd847871e7ad@gmail.com>
Date:   Tue, 4 Feb 2020 14:02:55 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAK7LNARsBQm8jTs6PZDHAVFX4GZ_=Ls-5MOutNJFOHBN29Gd5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/1/2020 10:07 PM, Masahiro Yamada wrote:
> On Thu, Jan 30, 2020 at 3:09 AM Gregory Rose <gvrose8192@gmail.com> wrote:
>>
>> On 1/28/2020 7:37 AM, Gregory Rose wrote:
>>> On 1/27/2020 7:35 PM, Masahiro Yamada wrote:
>>>> On Tue, Jan 28, 2020 at 6:50 AM Greg Rose <gvrose8192@gmail.com> wrote:
>>>>> Since this commit:
>>>>> 'commit 9b9a3f20cbe0 ("kbuild: split final module linking out into
>>>>> Makefile.modfinal")'
>>>>> at least one out-of-tree external kernel module build fails
>>>>> during the modfinal make phase because Makefile.modfinal does
>>>>> not include the ccflags-y variable from the exernal module's Kbuild.
>>>> ccflags-y is passed only for compiling C files in that directory.
>>>>
>>>> It is not used for compiling *.mod.c
>>>> This is true for both in-kernel and external modules.
>>>>
>>>> So, ccflags-y is not a good choice
>>>> for passing such flags that should be globally effective.
>>>>
>>>>
>>>> Maybe, KCFLAGS should work.
>>>>
>>>>
>>>> module:
>>>>          $(MAKE) KCFLAGS=...  M=$(PWD) -C /lib/modules/$(uname
>>>> -r)/build modules
>>>>
>> Hi Masahiro,
>>
>> I'm unable to get that to work.  KCFLAGS does not seem to be used in
>> Makefile.modfinal.
>
> I quickly tested it, and confirmed
> KCFLAGS works for external modules, too.
>
>
> Makefile.modfinal includes scripts/Makefile.lib
>
>
> So,  c_flags contains $(KCFLAGS)
>
>   c_flags -> KBUILD_CFLAGS -> KCFLAGS
>

Hi Masahiro,

I must have missed  something then - again, my unfamiliarity with the 
Linux Makefiles is probably tripping me up.  I'll
dig around and see if I can get that working.

Thanks for your help,

- Greg

