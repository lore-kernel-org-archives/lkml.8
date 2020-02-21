Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF293C35669
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76512073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="TzE0OKRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbgBUXwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 18:52:34 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34436 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgBUXwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 18:52:34 -0500
Received: by mail-lj1-f196.google.com with SMTP id x7so3991535ljc.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 15:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=37taAW5B0H3QnMxnoDwbwTmsfR9PUSHDmfFTksmg34c=;
        b=TzE0OKRdyDVakmN5Ccv9lK426rKmJdfiIDBA3K1rysdgeI1zaNlWZ8EIYQ9z2qYTtl
         lknCCU7X/eUoCSUG+Mgf+jyy9vuaJP9nEeESL9aOcRHKq6Z9ifnU7T2vUlDoPFeU7Bia
         ORmXZHrp9L3EYUn3BOMtl3FiK39IGn32u8i04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=37taAW5B0H3QnMxnoDwbwTmsfR9PUSHDmfFTksmg34c=;
        b=bptcP2FQyHxMwi7KUOIbZTOJ3JekEvala0Xi1x5CI6C/MDW6erCAjjzjte8ObRfVCc
         yH0l53UkskvuOn8s0IulqVVzhFoxRrAu+AJAwPMr8EBAjM3QukJeGPiPHLw3v1YTwhG/
         zm0LYX5SjSGVP7N0pI4Ns2LaFo9ZZhp3l47oygRcL4KlVaRBtuQd2VR/rUWknFtR65Py
         zTBdh/YmJRDkkOTshduTQQSTjDHFMH91C9iLzKVEjfdsGUMbZV8RUqJ1NyCcqUNgUXD+
         f/n2w7Es+US8ItrGIwbJ67INQ/ck5Kl4AcgCPsfdBxZDgtap+AaR78RNlwpKKpaQYorY
         bAwQ==
X-Gm-Message-State: APjAAAU2F0tPa5FhhIAZ8gSh/jeHSG3Ax6y+l61AM+dEEeZfVfOaAEc4
        bXoKV2cnugOd70/Z3UhYnMufWjyGln01UpGJ
X-Google-Smtp-Source: APXvYqwLB2N/GjtMztU31UKgh5A06Jxv1Qnwd1X7Th9MuPWCFH9qjT6wtz+briWNa2l39TLMrhfD7Q==
X-Received: by 2002:a2e:2201:: with SMTP id i1mr23457116lji.110.1582329150369;
        Fri, 21 Feb 2020 15:52:30 -0800 (PST)
Received: from [192.168.1.149] (ip-5-186-115-35.cgn.fibianet.dk. [5.186.115.35])
        by smtp.gmail.com with ESMTPSA id m14sm2281645lfk.7.2020.02.21.15.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 15:52:29 -0800 (PST)
Subject: Re: [PATCH] vsprintf: sanely handle NULL passed to %pe
To:     Petr Mladek <pmladek@suse.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <CAHk-=wjEd-gZ1g52kgi_g8gq-QCF2E01TkQd5Hmj4W5aThLw3A@mail.gmail.com>
 <20200219082155.6787-1-linux@rasmusvillemoes.dk>
 <CAOi1vP-4=QCSZ2A89g1po2p=6n_g09SXUCa0_r2SBJm2greRmw@mail.gmail.com>
 <0fef2a1f-9391-43a9-32d5-2788ae96c529@rasmusvillemoes.dk>
 <20200219134826.qqdhy2z67ubsnr2m@pathway.suse.cz>
 <5459eb50-48e2-2fd9-3560-0bc921e3678c@rasmusvillemoes.dk>
 <20200219144558.2jbawr52qb63vysq@pathway.suse.cz>
 <bcfb2f94-e7a8-0860-86e3-9fc866d98742@rasmusvillemoes.dk>
 <20200220125707.hbcox3xgevpezq4l@pathway.suse.cz>
 <CAOi1vP8E_DL7y=STP5-vbe_Wf5PZRiXWGTNV3rN96i4N2R3zUQ@mail.gmail.com>
 <20200221130506.mly26uycxpdjl6oz@pathway.suse.cz>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <cec0c65b-5b5d-6268-dae0-1d4088baab76@rasmusvillemoes.dk>
Date:   Sat, 22 Feb 2020 00:52:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221130506.mly26uycxpdjl6oz@pathway.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2020 14.05, Petr Mladek wrote:
> On Thu 2020-02-20 16:02:48, Ilya Dryomov wrote:

>> I would like to see it in 5.6, so that it is backported to 5.4 and 5.5.
> 
> OK, it would make sense to make the patch minimalist to make it
> easier for backporting.
> 
> 
>> Please note that I sent v2 of my patch ("[PATCH v2] vsprintf: don't
>> obfuscate NULL and error pointers"), fixing null_pointer() and adding
>> error_pointer() test cases, which conflicts with this restructure.
> 
> IMHO, v2 creates even more mess in print tests that would need
> to be fixed later.
> 
> If we agree to have a minimalist patch for backport
> then I suggest to take v1. We could clean up and update
> tests later.
> 
> Rasmus, others, is anyone against this approach (v1 first,
> tests later)?

Sorry to be that guy, but yes, I'm against changing the behavior of
vsnprintf() without at least some test(s) added to the test suite - the
lack of machine-checked documentation in the form of tests is what led
to that regression in the first place.

But I agree that there's no point adding another helper function and
muddying the test suite even more (especially as the name error_pointer
is too close to the name errptr() I chose a few months back for the %pe).

So how about

- remove the now stale test_hashed("%p", NULL); from null_pointer()
- add tests of "%p", NULL and "%p", ERR_PTR(-123) to plain()

and we save testing the "%px" case for when we figure out a good name
for a helper for that (explicit_pointer? pointer_as_hex?)

?

Rasmus
