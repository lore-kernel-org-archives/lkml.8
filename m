Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3851C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834CC2082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMNgFL/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgBEWsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:48:30 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36396 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbgBEWs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:48:29 -0500
Received: by mail-pl1-f195.google.com with SMTP id a6so1481739plm.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 14:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=PpXc9eGx8mcZf+vTZK5Ba0L/N5UX9htwO7sqPi6XZsc=;
        b=SMNgFL/jhiO3zIjz99w16lh07Gg/HOi/3Fah7l3tX2IAa7WXJjM+XltPwC6c6pAX6N
         xGVWN3dlvZ0b7b+v8N4FN7ZPBHW1QWA4DVoVF0tSvlXIZbWdymHgiHcdRJZpy1hbR1zY
         wWwD2WvGwVnmQPXWYVvHsHy6hs1Y3Ze1GcMmRLBO+WFwQ9EM+vUj6rQRjL3Uc5exqlUL
         dg77uXZd91b2xpjooA6KECKvlUqkh3NpHwOEkbPiNloI0f7Gt+W/MVKZZ4J5R4iBwWi/
         scPuyyN70Oq2zL/cgFFg2T+SAQve+ed6rze9+B5PqEIG87gBYgPEtRJe6NNx+2n532yQ
         wSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PpXc9eGx8mcZf+vTZK5Ba0L/N5UX9htwO7sqPi6XZsc=;
        b=oCeRkZ0xN4lhEdup1W0MdQFMS/iiCCRVgUgSazCswaUQDH2aplqkql8OADVRGzEeZ9
         aTe0xDU+77JDmdqfZrWyephhm0LY69okfYwpQ63Qnez+/ijzCXwLHPCudKWI5X9rIw6h
         cPYA6/4P0pByrD1zCrBIH8XA0gcXIcpmJzGFLyJaI0z1x3FBP9eqOIM8XiX1P+JAspWN
         wN3lAnTL5ed3s0HdgVg84aTNreKi87V00Pgkp4KT6d233nej1TDVcnn7ysUC5SthsIQw
         6csPQXHDHIJJ2nvEVXZnqEfy6oUMIWvJPA1gZXAp5f/1CFD3GiTHXS+//L7RKp+4G/Uh
         YGQg==
X-Gm-Message-State: APjAAAWuq3mE0xHy6U/qodcyr79cAVrpOMEPQd/5kvFPZnbPAFWjQbIU
        IoiMZK3F5ZYbli8tBZt/0SQ=
X-Google-Smtp-Source: APXvYqzloYilRHl6BGDoe75J25lP0N4nzNWO7dU4jQPXJ2ADS8hdg9EbLWsW7cpaKNNri83O1RTBSw==
X-Received: by 2002:a17:902:7048:: with SMTP id h8mr369123plt.64.1580942908485;
        Wed, 05 Feb 2020 14:48:28 -0800 (PST)
Received: from [192.168.0.16] ([97.115.141.236])
        by smtp.gmail.com with ESMTPSA id c184sm548652pfa.39.2020.02.05.14.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 14:48:27 -0800 (PST)
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
Message-ID: <fffab888-8337-c659-fcb6-4f9fa765513a@gmail.com>
Date:   Wed, 5 Feb 2020 14:48:26 -0800
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
>
Hi Masahiro,

I found a way to make this work on the openvswitch out of tree kernel 
module.  KCFLAGS
doesn't work because it is added at the end of the gcc command line and 
we need to
add a '-include <file>' directive so that the include file comes 
*before* all other include
files.  I fix this by inserting the '-include <file>' command line 
option to the beginning
of our own Kbuild NOSTDINC variable.

Thanks for your help in debugging this.

- Greg

