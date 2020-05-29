Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084D5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBD48208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590712146;
	bh=DKnOyZi2mBJQEjOSuWV7+V3bYxdX9qqqGfacJ2kbdhQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CCi3OGOBTbFcDXl9uSxGHsy1S9BIan5DwYplnLgSO3GcHt6lFUAXiXYGIgIB5XR3J
	 jIwIyEQ1PDf+c7TByxYm12ephCYuFexlMM9XCA2/8xW30i+tT0uc8zgJToK+9pOnpL
	 WZyXIjiTsk/UsMyT1tnChIXvo+XriFYp6IRFwZm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgE2A3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 20:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgE2A3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 20:29:03 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6432BC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 17:29:02 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id l15so405801lje.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 17:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RqQPXCknqeht4znYNw1eKMLef3jV5ztDDKZ3nxZLz1Q=;
        b=JFfOZug7M3Uhs+N82974hhRp6ypgQ+HSSuT2eDGGGiCdJcPfoo36KQ/AZpzr1YYRuK
         jra3rvQnsGb3cWRUylV5/UXxqt7LztsFNyp1vzj2pllwtESOoY3hsBohNsHPa1+ClHbC
         oRmnoXW52iuYmEfw85KcSalxZDPS317Hrd2dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RqQPXCknqeht4znYNw1eKMLef3jV5ztDDKZ3nxZLz1Q=;
        b=i1WYqTDBXpHR7vt0QWOsn7lNP/FeOCOTm3hnFoni6PnB7FXOrsQtfaw4n7rON8qV95
         ioXWZJ/FcG+lGmzUwd91c4a7RXkNtA9/vj8D6tq6voXNDYAIPb5bMa+spkM4UvhP8fTI
         lcPiDN2J9paoQCGcTaul3Mu6RSgLY5DiqsdB/JT1l/cCHh0QPbHoBvpNTI27ZW1JYZr/
         0vhy77vLRXcxKycLldc3nG+91/Vb4BJwyVYghEMIhfVEgq3eKVoAR76++Q0zAD3uueHx
         v/itoUBIOpjG34rS+1KGIP0+6MXzvAX6QpKlagt+1iqvTPDjHglU3LdV8cWUIgVrn0OV
         NEZg==
X-Gm-Message-State: AOAM533ahX/nZ9TA1zTGUsi0G7pIoN2J0tSR9gWKexwFJW70mtUA5Ybo
        Lxdmij8DmpZ32VIIbsiJhF7vGmQ+FAI=
X-Google-Smtp-Source: ABdhPJzEiSMovz5uJehH5bnIcDg2H6Shb9LqyuE2k4wDcKgyKjHqy2zjSYPbnVspxXs9Wi/fWmB8GA==
X-Received: by 2002:a2e:9cc7:: with SMTP id g7mr2771194ljj.423.1590712140387;
        Thu, 28 May 2020 17:29:00 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id d18sm696352lji.8.2020.05.28.17.28.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 17:28:59 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id s1so459296ljo.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 17:28:59 -0700 (PDT)
X-Received: by 2002:a2e:9f43:: with SMTP id v3mr2962979ljk.285.1590712138637;
 Thu, 28 May 2020 17:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <e3b30905-4497-29b4-4636-a313283dbc56@i-love.sakura.ne.jp>
 <20200528065603.3596-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200528110646.GC11286@linux-b0ei> <e0d6c04f-7601-51e7-c969-300e938dedc0@i-love.sakura.ne.jp>
 <CAHk-=wgz=7MGxxX-tmMmdCsKyYJkuyxNc-4uLP=e_eEV=OzUaw@mail.gmail.com>
 <CAHk-=wjW+_pjJzVRMuCbLhbWLkvEQVYJoXVBYGNW2PUgtX1fDw@mail.gmail.com> <13b0a475-e70e-c490-d34d-0c7a34facf7c@i-love.sakura.ne.jp>
In-Reply-To: <13b0a475-e70e-c490-d34d-0c7a34facf7c@i-love.sakura.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 May 2020 17:28:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjj9ooYACNvO2P_Gr_=aN0g=iEqtg0TwBJo18wbn4gthg@mail.gmail.com>
Message-ID: <CAHk-=wjj9ooYACNvO2P_Gr_=aN0g=iEqtg0TwBJo18wbn4gthg@mail.gmail.com>
Subject: Re: [PATCH v2] twist: allow converting pr_devel()/pr_debug() into snprintf()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 5:08 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> You mean "export these behavior as kernel command line options"? That will
> involve run-time costs (while build-time branching based on #ifdef can
> completely eliminate run-time costs).

Are _any_ of these things meaningful?

> Also, as number of options which
> can be controlled at boot-time grows, the kernel command line will become
> too long to specify all of these behavior.

So? We have explicitly added boot-config files for exactly this,
because people who do boot-time tracing wanted this.

> Why do you think "syzkaller is special" ? There is no syzkaller-specific
> choice.

ALL of these are designed to be totally about syzkaller. Nobody else
has ever asked for the TWIST options. And if they have, they'd still
make more sense as generic real actual options than as some odd
"twist" thing.

> Current kernel is not well segmented enough to allow switching based on
> per process flags. We can't distinguish whether some kernel message was
> caused by a process with such flags.

Who said anything at all about per process?

> All we could afford is to switch based on kernel boot command line. But
> that will entail a lot of code/data (and runtime-cost) which is not used
> if the administrator does not turn on the switches.

Absolutely nobody cares.

In fact, I'd prefer it just so that the options would be individually
explained, and not hidden away in some odd kernel config file, and
would be visible and force people to have sane nam,es.

> After all, switching at the kernel configuration phase is the most simple
> approach.

No it isn't. It's the UGLIEST possible approach, forcing a nasty
horrible config process to be even worse, forcing a compile-time
decision for something that isn't at all obvious should be
compile-time, and forcing crazy ugly config option names because they
are all just odd.

I have complained about this for MONTHS. You never never actually
explained why you want these badly named config options.

If it's something _so_ core that it affects performance, then no,
syzkaller shouldn't be messing with it in the first place, because
then you'd be testing something that is entirely irrelevant to anybody
else.

And if it's about things like "disable sysrq-k", and it might be
useful to somebody else than syzkaller, then it would be *much* better
off as a boot option so that you don't have to recompile the kernel to
pick it.

Some things might even be worth having a runtime option for.

But this "put random options, give them random names, and force them
all as compile-time options in a nasty kernel config process" just
smells.

And if they are _so_ specialized that only syzkaller could possibly
care, I still maintain that they shouldn't go upstream at all.

               Linus
