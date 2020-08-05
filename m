Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5151CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EAA92075A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596655099;
	bh=Wdf0Tn/N4MqyPZ0mHpM9d4Q/BFvmnsDNb0MHROp1xAc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=eGrEWb4P7jdgcg88M3gYN6TEdZTqqFHFHsYiyg0myhUGYunIzfwP86rMGe2tTLHMw
	 aqP9TlPvl2K9F0VHnWqy3okb+X6lq3z1qe3QyOsLIkJNDtFqNqfI14M135vXmJuwsi
	 dkez7IZ2Ob0JsICKNAfdLYFmimIjOFSIwhqMjVis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgHETSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbgHETQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 15:16:24 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E221AC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 12:15:47 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id o21so19875281oie.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 12:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jYEN2cvet5zB5B5eyNC+shZAVcvkiH+f+FbncW7ectU=;
        b=Ena+3Y8jxN4bGxdwm2AgkNEPvhg6MLLZCSTy7U08iocYStSazDPf+mGA4GOi9UBExJ
         yyTAwbejrI9oilVci6jN+uTDCXPdwtYjC29V613/TBch+v6qBURzpNLeeokDLwtyHbJg
         bUATeRa0Te0lbhpCWgdx5vOURqCdNxw8cjPj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jYEN2cvet5zB5B5eyNC+shZAVcvkiH+f+FbncW7ectU=;
        b=dqEzeNNSFUJbNt6QpF7fpwd3EuwOuN4oK83h/VGu8NpIrkrYIkxx7MIvr9RhP4hUf3
         2rDyuh9J/fKrA4oVW/DQBP1Ztbhe5fJCTnVwX/NUzj5Pt1u2JDI33aZvQLpY+j6tqh6u
         h8qYcezBPCmZ736k/qi+jm+t9PKmEAslr1R7KYP1Uwoew/GmFfazRgmJv5m2HFOdz4ml
         W22e0zQROlbqVuxmM+fH0tIygOtGCg33t6wwuZ8zNWOvsp/yahUm66X5TJd5JGfnbJon
         f47LYgFFM3L2frKEm0MfUBV50v37MEJW5azHB29FEFfPHXaTy/9dy3k1e+HNIAfauccy
         ++ug==
X-Gm-Message-State: AOAM533/4oKVwrd43HGZALIb8gZAXzMja4wUv+9BEvua/XTPT3VFKEj5
        E2xYg1/kP4KexxeiP6Iq1FtyDg==
X-Google-Smtp-Source: ABdhPJw4kgHT2DVcqZYav5EpT9M+m+g1ZhwCut2UPLjmjltFinAwFibAgUqzfTyBmsEbXr2RgRzHYg==
X-Received: by 2002:aca:b30b:: with SMTP id c11mr2101630oif.48.1596654945457;
        Wed, 05 Aug 2020 12:15:45 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o22sm539984ota.49.2020.08.05.12.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 12:15:44 -0700 (PDT)
Subject: Re: [GIT PULL] Kselftest update for Linux 5.9-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <0e3a9c1f-7ac6-33e2-ed11-5a56659fc5f7@linuxfoundation.org>
 <CAHk-=wi4iDwuazgXQ-1yvM_JMTBepi9rc-zfSMeyjfDgSS2fgA@mail.gmail.com>
 <8d894cb3-83ac-66bc-48ec-dc273d1afcbe@linuxfoundation.org>
 <CAHk-=wiKe_rBFthfttj1fM3cwqaArSUN0Dz1KhARdMNo1a2F=A@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3c439640-111e-7399-5839-a5cba4a98a54@linuxfoundation.org>
Date:   Wed, 5 Aug 2020 13:15:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiKe_rBFthfttj1fM3cwqaArSUN0Dz1KhARdMNo1a2F=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/20 11:32 AM, Linus Torvalds wrote:
> On Wed, Aug 5, 2020 at 7:13 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> Please pull the following Kselftest update for Linux 5.9-rc1.
> 
> Ok, it worked fine this time, although now you lost the note about the
> conflict ;)
> 

Sorry about that. I should have included that as well.

> I took the version from the seccomp tree that seemed to be the
> slightly cleaned-up one.
> 

Yes. The version from seccomp tree is the one to pick up. Thanks
for working through this.

thanks,
-- Shuah
