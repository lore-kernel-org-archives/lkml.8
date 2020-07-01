Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3341C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 20:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 918C12082F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 20:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593636693;
	bh=cUJjMPByfU3fDLcRmB6TduvjMVpsJzR1z3CvTDmFFcY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UOG3/WQAFDclZfzL4CdZ+641OsUuYeOGvGZweUZmERbTNzkykYSK1QatcXIZ9+d/P
	 wHLHyft+gh5oqXK6+s4Wbdqygigv+jLhqvwKUfYvCOOM4iCOnuHRkVJWdnKBMbMQJu
	 Q1O43Sh2tUavotWmQAitHXZPg7dF2Bb2QcUZMkcU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgGAUvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 16:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgGAUvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 16:51:31 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914E4C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 13:51:30 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id n23so28921770ljh.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 13:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LfKvJDfH+JgSbbJW8lIadNI33mwPlCXJ+3I1TVMp16U=;
        b=ajljEXMkWnVATS+Y0B8quCPCXM8vWY7jwlI22KMwwx56KKYKjJ5ho3GoksFEekSUav
         9w08LuNbtn9E7JI9E3uHZi/Tpy2EzqacgSunOz8sILShQuJHUkPpBvgwdBQcTxOIK0aJ
         3i3MAe//YEoHEdnGkOgZbG7KvOE3bgYfBntYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LfKvJDfH+JgSbbJW8lIadNI33mwPlCXJ+3I1TVMp16U=;
        b=d9U05vZCW+cemHL2oEyfminJqPGl9UQ6SAwlsbRIrUAVqHHHmfKoZqUY9BA+Otr7aP
         wnU9GNpTp64l1R5RNPUpvhpDgOmCMNy8O9R5bVfLELSKSm6fnrd4F6OBPwihnDQCt6eb
         yDeLPNkSZ1Xs4XQrrC/3WmcSTa+XBtXDtqXBivPd2zCE8/s3JkDGZI2cjy80iRlzZM4b
         /begntmkcBXh8uanNe+REYh4p8uud60b2AJf+daAQUHaFQ4/eT8s5OfzuezAhGGMUxeE
         UI4VHwT6GrEUNZwjVcuYRSns5NFAORHpHfILOAK7VKBRgBzluXvbrd7nzygeZ1//9Wp8
         D6KQ==
X-Gm-Message-State: AOAM533NITCTMU7gpTnrEqhBP6YWnJlyt5n9wfcV2j7oZi6tZIOC2i/x
        HkC1zBpGg9MK+U5NIe95Q+Hvs5f5BG0=
X-Google-Smtp-Source: ABdhPJw9NgoKTcHzswf2eZi/WVXv5qlpeVBXYCOQzNrhjSeVVs0Lz1dlwE9B+NUZ1Yy2bl6Ef3313g==
X-Received: by 2002:a2e:3909:: with SMTP id g9mr11947218lja.54.1593636688653;
        Wed, 01 Jul 2020 13:51:28 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 190sm2204693ljf.38.2020.07.01.13.51.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 13:51:27 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id t25so24294318lji.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 13:51:27 -0700 (PDT)
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr13959524ljj.102.1593636687265;
 Wed, 01 Jul 2020 13:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wizu7DA7EDrsHQLmkTFBvCRxNyPMHaeMDYMF_U75s9RvQ@mail.gmail.com>
 <5F1767D0-416A-4BA4-9DFF-E82D1EA3F5EE@amacapital.net>
In-Reply-To: <5F1767D0-416A-4BA4-9DFF-E82D1EA3F5EE@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Jul 2020 13:51:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh0X1YBQm8b6dqu=FpE8jgHriisXDeqJ7jai41Ob+sJDA@mail.gmail.com>
Message-ID: <CAHk-=wh0X1YBQm8b6dqu=FpE8jgHriisXDeqJ7jai41Ob+sJDA@mail.gmail.com>
Subject: Re: objtool clac/stac handling change..
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 1:36 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
> We ought to be able to do it the way I described and get decent code generation too.

No, we really can't.

Each access really needs to jump to an exception label. Otherwise any
time you have multiple operations (think "strncpy()" and friends) you
have to test in between each access.

That is why *fundamnetally* the interface to "unsafe_get/put_user()"
takes a label for the error case. There is absolutely no way to make
any other interface work efficiently.

(Unless, of course, you make the exception handling something that the
compiler does entirely on its own. But that has never been a good idea
for the kernel, and I wouldn't trust a compiler to do what the kernel
needs).

Side note: the labels can be hidden. I did (long ago) send out
something that did a

    uaccess_try {
         val1 = unsafe_get_user(addr);
         val2 = unsafe_get_user(addr2);
    } uaccess_catch {
         error handling here
     };

kind of thing, but that was just syntactic wrapper around that label
model. And honestly, it doesn't really change anything fundamental, it
really ends up with exactly the same issues just with a slightly
different syntax.

(I did that because we had the nasty "put_user_ex()" interfaces, which
were horrible horrible crap, and if one access took an exception, then
all the other ones did too).

The "label for error case" is actually simpler to follow both for the
user and for a compiler. Yes, it's a bit odd, but once you get used to
it, it's really quite regular. But having a different error handler
for the "user_access_begin()" failure and the actual access failure
really does end up generating duplicate code and confusion.

              Linus

              Linus
