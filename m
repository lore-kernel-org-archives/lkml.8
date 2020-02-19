Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5870C34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E572464E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="PYsekawx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgBSPkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:40:15 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44634 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBSPkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 10:40:14 -0500
Received: by mail-lf1-f65.google.com with SMTP id v201so442030lfa.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 07:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DjhGrWlHlzAhSmIGZSJTb9Plyn22VtP6qt1MQHcL+Zk=;
        b=PYsekawxaa7r8OQGnxfNV9VnCXM7BrK+NDwHk7T4i0z/ztAjW1r5lTXG9aEIqTs9dY
         97kQ385qlpSZOGpcd83URJfWGgRk0MLMML8fI3zLpbxGQjtI/u+xf3TV/IO+7J7cplxj
         nQSd9TXyIDpsTxB5HtLVYiS14MaXI1w3REUbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DjhGrWlHlzAhSmIGZSJTb9Plyn22VtP6qt1MQHcL+Zk=;
        b=DzKsvRk3tfdsO23YCqbyOBdZ0IIx9+y66cjxys097yV5LDW2yL0X9q8KwqcTmmgsIC
         K7v/ih2NbR9eVpm/h9Q923n6sjWo+tg2WazaOOLjBFdHyFMf+FDEbEUl7kGe7gy1m+rH
         ZBVypXKob8oqGcvuPmJF4eQUmiD3ZznrphUBJHEbpb0Z8fo9dCQ6Fw4+Le0VasGk+By3
         uvUC8xJ23nF47zd0K9WBFaH0kYNWCG6J/oWeLnzDYYzERLVleuJZjczAuifMz41X2P64
         PYEsht5WOlQNGdjJP+OGPPWhNOQf28Ct4Lqc/Uhpizbr8Q63dKTbYgIA0buzAZl+1kSn
         sZgQ==
X-Gm-Message-State: APjAAAW1gavV5829Vyc3hPNJgIkBVOsADlb5I38mPl5fmuK26mVhuMvC
        uuy9ZGQJLrsedkripa11goO0/Y2H/gNeOp7Y
X-Google-Smtp-Source: APXvYqwBV533EPhDKSU98zhnDXzc4T1ILEZyOcIFNV5+E+aUHF7rksvA7rro099KnL/VyIoD16hSzA==
X-Received: by 2002:ac2:44bc:: with SMTP id c28mr13417993lfm.72.1582126810463;
        Wed, 19 Feb 2020 07:40:10 -0800 (PST)
Received: from [172.16.11.50] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id y7sm1591308lfk.83.2020.02.19.07.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 07:40:10 -0800 (PST)
Subject: Re: [PATCH] vsprintf: sanely handle NULL passed to %pe
To:     Petr Mladek <pmladek@suse.com>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <CAHk-=wjEd-gZ1g52kgi_g8gq-QCF2E01TkQd5Hmj4W5aThLw3A@mail.gmail.com>
 <20200219082155.6787-1-linux@rasmusvillemoes.dk>
 <CAOi1vP-4=QCSZ2A89g1po2p=6n_g09SXUCa0_r2SBJm2greRmw@mail.gmail.com>
 <0fef2a1f-9391-43a9-32d5-2788ae96c529@rasmusvillemoes.dk>
 <20200219134826.qqdhy2z67ubsnr2m@pathway.suse.cz>
 <5459eb50-48e2-2fd9-3560-0bc921e3678c@rasmusvillemoes.dk>
 <20200219144558.2jbawr52qb63vysq@pathway.suse.cz>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <bcfb2f94-e7a8-0860-86e3-9fc866d98742@rasmusvillemoes.dk>
Date:   Wed, 19 Feb 2020 16:40:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219144558.2jbawr52qb63vysq@pathway.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/2020 15.45, Petr Mladek wrote:
> On Wed 2020-02-19 14:56:32, Rasmus Villemoes wrote:
>> On 19/02/2020 14.48, Petr Mladek wrote:
>>> On Wed 2020-02-19 12:53:22, Rasmus Villemoes wrote:
>>>> --- a/lib/vsprintf.c
>>>> +++ b/lib/vsprintf.c
>>> The test should go into null_pointer() instead of errptr().
>>
>> Eh, no, the behaviour of %pe is tested by errptr(). I'll keep it that
>> way. But I should add a #else section that tests how %pe behaves without
>> CONFIG_SYMBOLIC_ERRNAME - though that's orthogonal to this patch.
> 
> OK, we should agree on some structure first.
> 
> We already have two top level functions that test how a particular
> pointer is printed using different pointer modifiers:
> 
> 	null_pointer();     -> NULL with %p, %pX, %pE
> 	invalid_pointer();  -> random pointer with %p, %pX, %pE
> 
> Following this logic, errptr() should test how a pointer from IS_ERR() range
> is printed using different pointer formats.

Oh please. I wrote test_printf.c originally and structured it with one
helper for each %p<whatever>. How are your additions null_pointer and
invalid_pointer good examples for what the existing style is?

707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 649)
test_pointer(void)
707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 650) {
707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 651)  plain();
3e5903eb9cff7 (Petr Mladek      2019-04-17 13:53:48 +0200 652)
null_pointer();
3e5903eb9cff7 (Petr Mladek      2019-04-17 13:53:48 +0200 653)
invalid_pointer();
707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 654)
symbol_ptr();
707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 655)
kernel_ptr();
707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 656)
struct_resource();
707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 657)  addr();
707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 658)
escaped_str();
707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 659)
hex_string();
707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 660)  mac();
707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 661)  ip();
707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 662)  uuid();
707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 663)  dentry();
707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 664)
struct_va_format();
4d42c44727a06 (Andy Shevchenko  2018-12-04 23:23:11 +0200 665)
struct_rtc_time();
707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 666)
struct_clk();
707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 667)  bitmap();
707cc7280f452 (Rasmus Villemoes 2015-11-06 16:30:29 -0800 668)
netdev_features();
edf14cdbf9a0e (Vlastimil Babka  2016-03-15 14:55:56 -0700 669)  flags();
57f5677e535ba (Rasmus Villemoes 2019-10-15 21:07:05 +0200 670)  errptr();
f1ce39df508de (Sakari Ailus     2019-10-03 15:32:19 +0300 671)
fwnode_pointer();


> I am open to crate another logic but it must be consistent.

So yeah, I'm going to continue testing the behaviour of %pe in errptr, TYVM.

> If you want to check %pe with NULL in errptr(), you have to
> split the other two functions per-modifier. IMHO, it is not
> worth it.

Agreed, let's leave null_pointer and invalid_pointer alone.

>>>> BTW., your original patch for %p lacks corresponding update of
>>>> test_vsprintf.c. Please add appropriate test cases.
>>>
>>> diff --git a/lib/test_printf.c b/lib/test_printf.c
>>> index 2d9f520d2f27..1726a678bccd 100644
>>> --- a/lib/test_printf.c
>>> +++ b/lib/test_printf.c
>>> @@ -333,7 +333,7 @@ test_hashed(const char *fmt, const void *p)
>>>  static void __init
>>>  null_pointer(void)
>>>  {
>>> -	test_hashed("%p", NULL);
>>> +	test(ZEROS "00000000", "%p", NULL);
>>
>> No, it most certainly also needs to check a few "%p", ERR_PTR(-4) cases
>> (where one of course has to use explicit integers and not E* constants).
> 
> Yes, it would be great to add checks for %p, %px for IS_ERR() range.
> But it is different story. The above change is for the original patch
> and it was about NULL pointer handling.

Wrong. The original patch (i.e. Ilya's) had subject "vsprintf: don't
obfuscate NULL and error pointers" and did

+	if (IS_ERR_OR_NULL(ptr))

so the tests that should be part of that patch very much need to cover
both NULL and ERR_PTRs passed to plain %p.

Rasmus
