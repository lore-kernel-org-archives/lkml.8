Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C39C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AF1220738
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G03qVrj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbgFVOhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbgFVOhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:37:00 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A113C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 07:37:00 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k1so7664826pls.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 07:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t3k98uqLUbsbenoKJRmJ5jM5z4HxpBNQ2xj0GuTh8yY=;
        b=G03qVrj55e7LDYdknFi4s2nL7rtTpCQUSF8Zz+JHlvm35ro+nr76bAY71hDYZfDiV3
         Kxe2JLWOeu7dI7+SYPcHpTmhtrPTiSl37dj2XAVimZU+As5yL69FBik7532qj2qkDkMI
         1mBEGupiWoWCKLNfF1bt2w00n6ArUTj6a0/1W3lFoCLLuUUFfEk1C/FqqCJ4Ob4D7CSW
         UCMrILqg5ehc7EWeeyvVfp7+M8Di1MJcgG/UXWhYlgXYUzeoMxe+PVjEeLBbb6movnKu
         meK5guSXva4vwkvKTYsQgS+QSTCuE+RrtznjxBAZkE0WQpnlr47NPUmNh9yixKVLmG2b
         3vPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=t3k98uqLUbsbenoKJRmJ5jM5z4HxpBNQ2xj0GuTh8yY=;
        b=kU2ZDfPL1Pvw4z3obopWrW/8lJMm49BfNw5AF6Av5fHpEgS3gwRaREX2hQfkjdRqyz
         zz+uIpTAYWnZz3Bvqx5PXveiRlV4jVQW5UvUmilGPzY4rwtzLlpxa93YbNbaWkxuwbfr
         5A8kRdPqUPFBIuxN5j/35o5r9ReNJDDwpFlD3WbGr1W5NFJ6a3DGSuMrWoDCyp2qTF6p
         DKtYWdW99MAMEViTROXeHEnXLOyyLcv0PwTXa0xiSxgloHFOjbt2PFRYYjdvZUj8v4HV
         /Y0xmBN2emUzsUAztvD8vUzYz/LBYc4L24b/Svj87F/MVn5TKBH0BB1wY4pKTZ5QlqKN
         DL1Q==
X-Gm-Message-State: AOAM533uW3AJvoFl1r/dGO8xOdE1OKXrp8eTrHRex0p5deTL5kCNmWGu
        CFLRHHjztFXOEwo3QtJxsu8mkvzq
X-Google-Smtp-Source: ABdhPJyCNc+L2udkdEKC2rn8aT3WoVSOZaAdBUTRBVsTyP8dPmR/8JqH97LXgot4aTcgALXvCGlJrA==
X-Received: by 2002:a17:90a:be10:: with SMTP id a16mr17198525pjs.150.1592836619913;
        Mon, 22 Jun 2020 07:36:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b4sm14509284pfg.75.2020.06.22.07.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 07:36:59 -0700 (PDT)
Subject: Re: [tip: sched/urgent] sched: Fix RANDSTRUCT build fail
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>, x86 <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
References: <159178525684.17951.17825196124597318263.tip-bot2@tip-bot2>
 <202006192008.337CB5212E@keescook>
 <CAHk-=wgj17RR3zetey4fpbOxbC58A=jMt87bQ9QRe4QDnxE46w@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <86b83934-6498-28b0-8756-33254b900bc3@roeck-us.net>
Date:   Mon, 22 Jun 2020 07:36:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgj17RR3zetey4fpbOxbC58A=jMt87bQ9QRe4QDnxE46w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/20 9:32 AM, Linus Torvalds wrote:
> On Fri, Jun 19, 2020 at 8:14 PM Kees Cook <keescook@chromium.org> wrote:
>>
>> On Wed, Jun 10, 2020 at 10:34:16AM -0000, tip-bot2 for Peter Zijlstra wrote:
>>> The following commit has been merged into the sched/urgent branch of tip:
>>>
>>> Commit-ID:     bfb9fbe0f7e70ec5c8e51ee55b6968d4dff14456
>>> Gitweb:        https://git.kernel.org/tip/bfb9fbe0f7e70ec5c8e51ee55b6968d4dff14456
>>> Author:        Peter Zijlstra <peterz@infradead.org>
>>> AuthorDate:    Wed, 10 Jun 2020 12:14:09 +02:00
>>> Committer:     Peter Zijlstra <peterz@infradead.org>
>>> CommitterDate: Wed, 10 Jun 2020 12:30:19 +02:00
>>>
>>> sched: Fix RANDSTRUCT build fail
>>>
>>> As a temporary build fix, the proper cleanup needs more work.
>>>
>>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>>> Reported-by: Eric Biggers <ebiggers@kernel.org>
>>> Suggested-by: Eric Biggers <ebiggers@kernel.org>
>>> Suggested-by: Kees Cook <keescook@chromium.org>
>>> Fixes: a148866489fb ("sched: Replace rq::wake_list")
>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>
>> Hi, can this please get sent to Linus before -rc2? With a148866489fb in
>> -rc1, all the CI with the GCC plugins installed have been failing their
>> all*config builds. This entered -next 9 days ago (and fixed the -next
>> builds), but Linus's tree is still failing:
> 
> Ugh.
> 
> I actually think the problem goes deeper than that.
> 
> The code expects the list entries to be of type 'call_single_data_t'
> 
> Then they damn well should be that type.
> 
> Note how "call_single_data_t" also implies certain alignment rules
> that the hack in 'struct task_struct' does *not* have, and while that
> doesn't matter on x86, it could matter on other architectures.
> 

Yes, that came up before. At least, with this patch, I don't see any compile
or boot test failures. This patch wasn't supposed to be a clean solution
(Peter is working on that) but a quick fix that can be applied easily
and at least improves the situation.

As it is, the mainline kernel currently relies on having RANDSTRUCT
disabled, and still has all the other problems you mentioned here,
so it is definitely much worse.

On the other side, a148866489fb has been in the tree for more
than three weeks now. Maybe we can wait more time for a more
comprehensive solution which hopefully doesn't introduce other
problems.

Guenter

> So no, I don't think Peter's patch is correct. It may make the build
> pass, but that "check the offsets between two fields" is not
> sufficient.
> 
> Now, if we could create a new
> 
>    struct __call_single_list_entry {
>         struct llist_node llist;
>         unsigned int flags;
>    } call_single_list_entry_t;
> 
> and use that as part of thecall_single_data_t and only use that for
> tyhe traversal of the list, then that would avoid the alignment issue
> and the waste of space in struct task_struct.
> 
> Hmm?
> 
> Peter/Ingo?
> 
>                  Linus
> 

