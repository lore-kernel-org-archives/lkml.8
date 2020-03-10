Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A99C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 06:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E032464B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 06:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jqLnVSvq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgCJGaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 02:30:15 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38184 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgCJGaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 02:30:15 -0400
Received: by mail-qk1-f196.google.com with SMTP id h14so5756260qke.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 23:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gvwbq8vKuqwlRVNXqh+0cFkyyH5WIkQBCTcGi/pa5dM=;
        b=jqLnVSvqq4c3HcH7I/vZjiAkEMkWkP8oWYPONi7tkPXhrk5903q7rn8seEDmI6Nsnz
         lWd2BD1e5R0yJETlLT1Qz7YHdek0VbGjwsGGx71PsbnhsTd2Gpl2q3E82pbLXAJ+FqBw
         XJnRr+6qUdRyKNsKeAXkHJOHzAXWs4D91JiMDfCqEungBDQTOtcUl2ZwnoRiY4uM4pKZ
         Noe4RfhILbzf+3idisQRNxCOXyuRIHvYWAgiUIbZN3ntLX+eCZA2M4y4+6BX5J/MRO2y
         lZBtb3iERs2C9LRn6CUcbEeJpL1GMKgrDp2v0KSB4So+7BI+Y0RnPHYcx/2ZmoXul0G1
         jrFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gvwbq8vKuqwlRVNXqh+0cFkyyH5WIkQBCTcGi/pa5dM=;
        b=lXKqteVgt1is9YpW7q6DZYmDGtgNfTtTUHwfUeOpOdA9SRLS7dOmTikVmAOEj+F6g3
         wFuDOp2Xo6Q869va++XJdQuj4XmjS3rbv9WtwpsvkMgSOxytlTuIuu7fxu1fZvxygD+Z
         vL4nnfhmMoac72z11XWAVf+dfqGZduSQxvSxCOwbgdb7cKEoEiE66AM3j9rhnZ13YhJq
         /xy05HU8CtjT07ZObDaCIz1+lm4PT4jWUIXIwksJzugWtvRKmFIZZRetljuCwvxncbfq
         3tCjGD01eIBHb5lqb45kdS0836i3QTJ7KTGA+x5p9fUIzb2dzi5CG/c8L1Rtdn4Bu+RG
         V9jg==
X-Gm-Message-State: ANhLgQ1eG1OY5Qr7XB+Or+MOn6hEyfZbjdFu7eGqjrYF3pjKB5oDXVbW
        gC/DyYnZZVfMzWmDSzaPHJ2E/SPGYiX0jj/y91XvfA==
X-Google-Smtp-Source: ADFU+vtT3mCr0iCe/Hyq0ynpYLyaKYYOq+A2Mha2dKDRMoggzgUwyCu+6lL5ogXPAtsnUWqm1DODRwfLE3APFeRTNUU=
X-Received: by 2002:ae9:e003:: with SMTP id m3mr18920202qkk.250.1583821813342;
 Mon, 09 Mar 2020 23:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200307135822.3894-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <6f2e27de-c820-7de3-447d-cd9f7c650add@suse.com> <20200308065258.GE3983392@kroah.com>
 <3e9f47f7-a6c1-7cec-a84f-e621ae5426be@suse.com>
In-Reply-To: <3e9f47f7-a6c1-7cec-a84f-e621ae5426be@suse.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 10 Mar 2020 07:30:01 +0100
Message-ID: <CACT4Y+a6KExbggs4mg8pvoD554PcDqQNW4sM15X-tc=YONCzYw@mail.gmail.com>
Subject: Re: [PATCH v2] Add kernel config option for fuzz testing.
To:     Jiri Slaby <jslaby@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 9, 2020 at 4:39 PM Jiri Slaby <jslaby@suse.com> wrote:
>
> On 08. 03. 20, 7:52, Greg Kroah-Hartman wrote:
> > On Sat, Mar 07, 2020 at 05:28:22PM +0100, Jiri Slaby wrote:
> >> On 07. 03. 20, 14:58, Tetsuo Handa wrote:
> >>> While syzkaller is finding many bugs, sometimes syzkaller examines
> >>> stupid operations. Currently we prevent syzkaller from examining
> >>> stupid operations by blacklisting syscall arguments and/or disabling
> >>> whole functionality using existing kernel config options, but it is
> >>> a whack-a-mole approach. We need cooperation from kernel side [1].
> >>>
> >>> This patch introduces a kernel config option which allows disabling
> >>> only specific operations. This kernel config option should be enabled
> >>> only when building kernels for fuzz testing.
> >>>
> >>> We discussed possibility of disabling specific operations at run-time
> >>> using some lockdown mechanism [2], but conclusion seems that build-time
> >>> control (i.e. kernel config option) fits better for this purpose.
> >>> Since patches for users of this kernel config option will want a lot of
> >>> explanation [3], this patch provides only kernel config option for them.
> >>>
> >>> [1] https://github.com/google/syzkaller/issues/1622
> >>> [2] https://lkml.kernel.org/r/CACdnJutc7OQeoor6WLTh8as10da_CN=crs79v3Fp0mJTaO=+yw@mail.gmail.com
> >>> [3] https://lkml.kernel.org/r/20191216163155.GB2258618@kroah.com
> >>>
> >>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >>> Cc: Dmitry Vyukov <dvyukov@google.com>
> >>> ---
> >>>  lib/Kconfig.debug | 10 ++++++++++
> >>>  1 file changed, 10 insertions(+)
> >>>
> >>> Changes since v1:
> >>>   Drop users of this kernel config option.
> >>>   Update patch description.
> >>>
> >>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> >>> index 53e786e0a604..e360090e24c5 100644
> >>> --- a/lib/Kconfig.debug
> >>> +++ b/lib/Kconfig.debug
> >>> @@ -2208,4 +2208,14 @@ config HYPERV_TESTING
> >>>
> >>>  endmenu # "Kernel Testing and Coverage"
> >>>
> >>> +config KERNEL_BUILT_FOR_FUZZ_TESTING
> >>> +       bool "Build kernel for fuzz testing"
> >>
> >> If we really want to go this way, I wouldn't limit it for fuzz testing
> >> only. Static analyzers, symbolic executors, formal verifiers, etc. --
> >> all of them should avoid the paths.
> >
> > No, anything that just evaluates the code should be fine, we want static
> > analyzers to be processing those code paths.  Just not to run them as
> > root on a live system.
>
> Even static analyzers generate real-world counter-examples in .c. They
> are ran dynamically to check if the issue is real or if it's only a
> shortcoming of static analysis. Klee is one of those and I used to run
> it on the kernel some time ago. Throwing such generated input results in
> the same weird behavior as using fuzzy testing, while it's still not
> fuzzy testing, but accurate testing.


I am all for naming/framing this as a more generic option (good it at
least does not have SYZ in the name :)).

Re making it a single config vs a set of fine-grained configs. I think
making it fine-grained is a proper way to do it, but the point Tetsuo
raised is very real and painful as well -- when a kernel developer
adds another option, they will not go and update configs on all
external testing systems. This problem is also common for "enable all
boot tests that can run on this kernel", or "configure a 'standard'
debug build". Currently doing these things require all of expertise,
sacred knowledge, checking all configs one-by-one as well as checking
every new kernel patch and that needs to be done by everybody doing
any kernel testing.
I wonder if this can be solved by doing fine-grained configs, but also
adding some umbrella uber-config that will select all of the
individual options. Config system allows this, right? With "select" or
"default if" clauses. What would be better: have the umbrella option
select all individual, or all individual default to y if umbrella is
selected?

FTR, some of the things we would like to disable are collected here:
https://github.com/google/syzkaller/issues/1622

Steve, I am not sure if by lockdown you mean the existing lockdown
mechanism, or just something similar in nature. As Tetsuo pointed, the
possibility of using the existing lockdown mechanism for this was
discussed here (and rejected):
https://lore.kernel.org/lkml/CACdnJutc7OQeoor6WLTh8as10da_CN=crs79v3Fp0mJTaO=+yw@mail.gmail.com/
