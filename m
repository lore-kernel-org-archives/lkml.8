Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1932C35641
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE8924672
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Er3whwMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgBVA2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 19:28:32 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40052 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgBVA2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 19:28:31 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18so4018597ljo.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 16:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3ADTmfft80RI7c2WY4TOkzrerMdgpKiB03T3sJQNmxs=;
        b=Er3whwMCAVF/DBsN73siP1gSa3KXpBJQrxPXuPeG4XI0lo1atKo+Tw0mY0Z64SRm+J
         3OqT65FrvtCeT7bNRITTFOJ0yVZ1sWYihv7d7RV7fwUbDppiazC7Z7k8XrJLrVOv1o1M
         zp0XUxufCWdPgO1EOJNc5/YuOR8aVjGEOpV6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3ADTmfft80RI7c2WY4TOkzrerMdgpKiB03T3sJQNmxs=;
        b=XXZMtP1PPXhXKmzO7gobI/1qnjtadlnCsjKuSS3KxokXN6pE/R3Y3lbh8mJdyPEb5e
         r+8zX03xkQhBw738jbOHjDMguUu9EflJVqjesYTFByjBKEcEfMP1YQhoiYfC1jwXNJtC
         P9ixHQFoYsuWZN0NrgVx8hfBz93Ji9RWw5BIoXjL4HSeDqK7IwHIifRJLP8xl4s/oHCn
         hfN+fIQXKPHcWn07QvBe7j54Dm/sI+aRYunOq4o+nGcp/UfWZ4yH4lhnZk2dc7eZsm/Q
         enaZYIVQbb+RvS01dk++jDTUS/vgKGjs8JvV3+pTpbsO2XDfoytOg+DgD8rbwSmuTlEi
         tB1A==
X-Gm-Message-State: APjAAAWYTOcuvgalyDkIGudS1h3upCMfWBBFsHDi85vnlC4MPIebnGZt
        isGaP7xjHu7kLvecg+0vFL8obg==
X-Google-Smtp-Source: APXvYqwKYJ7W1iIgFdvVZmv0oo87jXC/8pPf5wbrmjfa5AKW+rpyFHJfX9vkjxDWuaRz/+vixJI3rA==
X-Received: by 2002:a2e:730e:: with SMTP id o14mr23885198ljc.51.1582331308263;
        Fri, 21 Feb 2020 16:28:28 -0800 (PST)
Received: from [192.168.1.149] (ip-5-186-115-35.cgn.fibianet.dk. [5.186.115.35])
        by smtp.gmail.com with ESMTPSA id y7sm2401215ljy.92.2020.02.21.16.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 16:28:27 -0800 (PST)
Subject: Re: [PATCH v1] lib/vsprintf: update comment about simple_strto<foo>()
 functions
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
References: <20200221085723.42469-1-andriy.shevchenko@linux.intel.com>
 <20200221145141.pchim24oht7nxfir@pengutronix.de>
 <CAHp75VfR+X6Mw8ywKNW5mTomzmuHSM8ecQUhxtM=LUkWaSe9CA@mail.gmail.com>
 <20200221163334.w7pocmbbw4ymimlc@pengutronix.de>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <d6c3b369-9777-9986-f41f-3f3a4f85d64c@rasmusvillemoes.dk>
Date:   Sat, 22 Feb 2020 01:28:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221163334.w7pocmbbw4ymimlc@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2020 17.33, Uwe Kleine-König wrote:
> On Fri, Feb 21, 2020 at 05:27:49PM +0200, Andy Shevchenko wrote:
>> On Fri, Feb 21, 2020 at 4:54 PM Uwe Kleine-König
>> <u.kleine-koenig@pengutronix.de> wrote:
>>> On Fri, Feb 21, 2020 at 10:57:23AM +0200, Andy Shevchenko wrote:
>>>> The commit 885e68e8b7b1 ("kernel.h: update comment about simple_strto<foo>()
>>>> functions") updated a comment regard to simple_strto<foo>() functions, but
>>>> missed similar change in the vsprintf.c module.
>>>>
>>>> Update comments in vsprintf.c as well for simple_strto<foo>() functions.
>>
>> ...
>>
>>>> - * This function is obsolete. Please use kstrtoull instead.
>>>> + * This function has caveats. Please use kstrtoull instead.
>>
>>> I wonder if we instead want to create a set of functions that is
>>> versatile enough to cover kstrtoull and simple_strtoull. i.e. fix the
>>> rounding problems (that are the caveats, right?) and as calling
>>> convention use an errorvalued int return + an output-parameter of the
>>> corresponding type.
>>
>> It wouldn't be possible to apply same rules to both. They both are
>> part of existing ABI.
> 
> The idea is to creat a sane set of functions, then convert all users to
> the sane one and only then strip the strange functions away. (Userspace)
> ABI isn't affected, is it?

There are lots of in-tree users of all these interfaces, converting them
all is never going to happen. And yes, there are also kstrtox_user
variants which are definitely part of ABI (more or less the whole reason
kstrox accepts a single trailing newline but is otherwise rather strict
is so it can parse stuff that is echo'd to a sysfs/procfs/... file).

But, one can at least try to unify the underlying integer parsing, and
provide knobs for users (meaning other parts of the kernel) to decide
how lax or strict to be in a given situation. Based on an idea from
Alexey Dobriyan of creating a single type-generic parser, I did that a
couple of years ago. It rebased pretty cleanly, so if anyone wants to
take a look:

https://github.com/Villemoes/linux/tree/parse-integer

There's certainly more to do, but just doing all kstrtox() in terms of
parse_integer() seems to reduce vmlinux size. Next steps would be the
simple_strtox family, which more or less just need PARSE_INTEGER_WRAP
AFAICT.

And stuff like strtoul_lenient in kernel/sysctl.c is an example of a
caller that wants to specify the laxness of the parsing (no overflow
allowed, so simple_* doesn't cut it, but we're parsing a string where we
might want to continue after the current number, so kstrtox is too
strict in terms of what trailers are allowed).

Rasmus
