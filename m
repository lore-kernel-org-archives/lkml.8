Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85AFC4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B3D20732
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JvaV8Kgi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbgBZT0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 14:26:16 -0500
Received: from mail-pf1-f169.google.com ([209.85.210.169]:43480 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgBZT0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 14:26:16 -0500
Received: by mail-pf1-f169.google.com with SMTP id s1so258077pfh.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 11:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5DzNmsGKabIiqxsuQFEwzfHh7R7C4KklYepK1ybNRcI=;
        b=JvaV8KgiqzoZBj6ydSQ9wuuSPmKsMcZlCBzIlL19/gYR0rinDPmvgQGXcIqtx1mDHc
         vFuipNjmbQwwkwM7sTSAyvGWM+yoKuDdXDhC8yd7Aj+gtgkk17kno5FXqnhPg+UUAUxE
         YbX/zPf26fsBftBmqKkM8PPSvOOCQ6ddOIvcLMPCHd5arVBaO/tFElf6CiY4LJ+cnWMw
         xrd1hh8jCWfIFRgiGphyi3upMeyTQfi3R7ZI4EWrWm0sDRAeWvkN7BD8jNMs1xNchCMO
         x0e0Y4TJYgMBYN6HA1qU1rDALtp0tPX+HlIQUUXZCFxzVEUJiyDhz2mVNfPsIWkhMNtU
         gK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5DzNmsGKabIiqxsuQFEwzfHh7R7C4KklYepK1ybNRcI=;
        b=kIwdT9AAeph9soO0pYbrtsoLCmeUhZ+x+a81VymQGbT96XZq3UiWBIOFTJCm88vfcz
         16RqnKsSRobfuZWrqI1JcJrwn47j3Toz9wOk2AlB9F7W5eHK7eDaQS23CFqeFu5zB8DC
         DcnF3ZTjsl4KdOiLNyr8ASlwrFgPNMEQX+4F9o3N2k0YCOF7LoAnJkEXR9BbB3ygn2Ev
         otHk3gswbeHpt/KYVXMMOL6RqHzHk90ECNwsE2AsjTC7bZtbggQDagEoWxaKYfu4kEdr
         vDPzWAXRNll5ePxkUxZ56ZV1j7cPtHABENUhGA8Xh3LEd/pv3HhmvG7VxKXriSIKWzpz
         kLPQ==
X-Gm-Message-State: APjAAAUY5ChvxJcnA0e3A/DkO3crSdkpRyM5e7eRUXhmFRfDg5SSld76
        8V5l3zEYYCtXn/ciwiWOqnBx5ulIiSvjaVWGra6RLw==
X-Google-Smtp-Source: APXvYqzCv4FxJcU96d7Vawq5DT3fARMj+obiX5wNUed9wf7xv+ae1CrV4f6IlV+FQmKVwCj9r2U464S4CiH/TgtxTyE=
X-Received: by 2002:a63:4e22:: with SMTP id c34mr356104pgb.263.1582745173398;
 Wed, 26 Feb 2020 11:26:13 -0800 (PST)
MIME-Version: 1.0
References: <20200222072144.asqaxlv364s6ezbv@google.com> <20200222074254.GB11284@zn.tnic>
 <20200222162225.GA3326744@rani.riverdale.lan> <CAKwvOdnvMS21s9gLp5nUpDAOu=c7-iWYuKTeFUq+PMhsJOKUgw@mail.gmail.com>
 <202002242122.AA4D1B8@keescook> <20200225182951.GA1179890@rani.riverdale.lan>
 <202002251140.4F28F0A4F@keescook> <CAKwvOdnkr1W4LTm8XmTKGkSDUhSBRowLbKwJwyitDMAGLh9ywg@mail.gmail.com>
 <202002251358.EDA50C11F@keescook> <20200226015606.ij7wn7emuj4bfkvn@google.com>
 <202002252103.B4BBF01091@keescook> <16822a0460e37e7a388217c63da8882d2904d8fc.camel@linux.intel.com>
In-Reply-To: <16822a0460e37e7a388217c63da8882d2904d8fc.camel@linux.intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 26 Feb 2020 11:26:02 -0800
Message-ID: <CAKwvOdm1qoKdq=Cp3nrYPR6oXkGZ32Hmh2TPVgatKAvDHk7q4g@mail.gmail.com>
Subject: Re: --orphan-handling=warn
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michael Matz <matz@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 11:11 AM Kristen Carlson Accardi
<kristen@linux.intel.com> wrote:
>
> On Tue, 2020-02-25 at 21:35 -0800, Kees Cook wrote:
> >
> > Thanks for looking into this! It'll be really nice to have the orphan
> > section warnings working in the kernel. And getting the ground work
> > for
> > FGKASLR ready will be nice!
> >
> > Kristen, can I convince you that FG stands for function-granular
> > instead of fine-grain? :)
> >
>
> Yes, sounds good to me - that way if we ever do basic block reordering
> or some crazy thing like that we don't have to say even-finer-fine-
> grained KASLR :).

LOL (I laugh now, but "never say never.")
-- 
Thanks,
~Nick Desaulniers
