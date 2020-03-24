Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BB5C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A2620870
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y1/ZhNe7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgCXKhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:37:21 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:43261 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgCXKhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:37:21 -0400
Received: by mail-qv1-f68.google.com with SMTP id c28so8894467qvb.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 03:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mHb6avZsjHJ/TKbLuEMm7CgBz/6fJFKyU+4Pe2avM3g=;
        b=Y1/ZhNe7chv45rsG8WTNu5t7LAnGfIWi8lPHsuQ2KBDWBbL2KPuF80Man2GDhAzEXa
         SYaJluioMPBG/vZMuw9uKRIBN6CnG3HkR5LzlGRA3qzjympqpb0LYpGicN+DH5fgCp2N
         C59/ekEydbANaQeQrMZpE+DAfPXnzX8kFySVqGnKrJBh+vW6bBRKO19lv1z1plEALTi+
         1HMkYaJ30iOeH69ADu2KEoVkfBWMlXWU7cpjb6SXszQqfxDPu2WdE5BtUt+rSmicXEKr
         PseuisztiKysOphtpAV+QU9YsQzfYn2ZzFptDHZFCha88SGOO7dw4AhB3l99deufvc0W
         4kjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mHb6avZsjHJ/TKbLuEMm7CgBz/6fJFKyU+4Pe2avM3g=;
        b=qMpWYwnBkLNIdbRhiGTn2elREJWDWLW7l28g5xjkuWlRLXLKSVkdP4lvlTHTeYrcXL
         0gQxVUxwVD4tOcTYNM8Hbyt0Qy8o6JyCayRvDLSPo5obKF30vatcdgOSJiG/Hv0XBOQw
         TwGHPZQpq3t0g2a38fvgfxTKUpDcp00ndEwwr+3cjhr7FW2qzXR1e9JnIkP2fnnwbWO1
         FS1PCM4zTL7itKMPVWDGesSH31AE/KQMJLn3VNZag1Sg3zMXroRshtNIN3N1YrtDFuWc
         E6J8dXa3Ar7GLXwoVmPtO4TqxSpfwalm9heEJmcApGKVgCb+UNpF/ujKNv8+uaIZIjqd
         zn6w==
X-Gm-Message-State: ANhLgQ3JRr4qr8V9hb5Uwo7CLAIXZEH+gQzNhyY8Md7dYbf4laXiMXol
        QOMhGebkkTMsGqHFBp28JftAcxv1ShXwVgfzzrRL2g==
X-Google-Smtp-Source: ADFU+vtuSTRJY0riN2HY+9LhV6INyzH7kttuW2AB2KUEdM7r1AMlhU2SC4mAInLplBv7HBsmocUQQ3PlBb7TEaskMwc=
X-Received: by 2002:ad4:49d1:: with SMTP id j17mr13837987qvy.80.1585046239828;
 Tue, 24 Mar 2020 03:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200307135822.3894-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <6f2e27de-c820-7de3-447d-cd9f7c650add@suse.com> <20200308065258.GE3983392@kroah.com>
 <3e9f47f7-a6c1-7cec-a84f-e621ae5426be@suse.com> <CACT4Y+a6KExbggs4mg8pvoD554PcDqQNW4sM15X-tc=YONCzYw@mail.gmail.com>
 <7728c978-d359-227f-0f3e-f975c45ca218@i-love.sakura.ne.jp>
In-Reply-To: <7728c978-d359-227f-0f3e-f975c45ca218@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 24 Mar 2020 11:37:07 +0100
Message-ID: <CACT4Y+YEYYNv-=AgNthQvLkeK-8uEeRs4XEuRqphfZBhc2hc5g@mail.gmail.com>
Subject: Re: [PATCH v2] Add kernel config option for fuzz testing.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 21, 2020 at 5:50 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2020/03/10 15:30, Dmitry Vyukov wrote:
> > Re making it a single config vs a set of fine-grained configs. I think
> > making it fine-grained is a proper way to do it, but the point Tetsuo
> > raised is very real and painful as well -- when a kernel developer
> > adds another option, they will not go and update configs on all
> > external testing systems. This problem is also common for "enable all
> > boot tests that can run on this kernel", or "configure a 'standard'
> > debug build". Currently doing these things require all of expertise,
> > sacred knowledge, checking all configs one-by-one as well as checking
> > every new kernel patch and that needs to be done by everybody doing
> > any kernel testing.
> > I wonder if this can be solved by doing fine-grained configs, but also
> > adding some umbrella uber-config that will select all of the
> > individual options. Config system allows this, right? With "select" or
> > "default if" clauses. What would be better: have the umbrella option
> > select all individual, or all individual default to y if umbrella is
> > selected?
>
> So, we have three questions.
>
> Q1: Can we agree with adding build-time branching (i.e. kernel config options) ?
>
>     I fear bugs (e.g. unexpectedly overwrting flag variables) in run-time
>     branching mechanisms. Build-time branching mechanisms cannot have such bugs.

My vote is for build config. It's simplest to configure (every testing
system should already have control over config) and most reliable
(e.g. fuzzer figures out a way to disable a runtime option).


> Q2: If we can agree with kernel config options, can we start with single (or
>     fewer) kernel config option (e.g. CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING=y) ?
>
> Q3: If we can agree with kernel config options but we can't start with single
>     (or fewer) kernel config option, can we agree with adding another kernel
>     config option which selects all options (e.g.
>
>       config KERNEL_BUILT_FOR_FUZZ_TESTING
>              bool "Build kernel for fuzz testing"
>
>       config KERNEL_BUILT_FOR_FUZZ_TESTING_SELECT_ALL
>              bool "Select all options for Build kernel for fuzz testing"
>              depends on KERNEL_BUILT_FOR_FUZZ_TESTING
>              select KERNEL_DISABLE_FOO1
>              select KERNEL_DISABLE_BAR1
>              select KERNEL_DISABLE_BUZ1
>              select KERNEL_CHANGE_FOO2
>              select KERNEL_ENABLE_BAR2
>
>       config KERNEL_DISABLE_FOO1
>              bool "Disable foo1"
>              depends on KERNEL_BUILT_FOR_FUZZ_TESTING
>
>       config KERNEL_DISABLE_BAR1
>              bool "Disable bar1"
>              depends on KERNEL_BUILT_FOR_FUZZ_TESTING
>
>       config KERNEL_DISABLE_BUZ1
>              bool "Disable buz1"
>              depends on KERNEL_BUILT_FOR_FUZZ_TESTING
>
>       config KERNEL_CHANGE_FOO2
>              bool "Change foo2"
>              depends on KERNEL_BUILT_FOR_FUZZ_TESTING
>
>       config KERNEL_ENABLE_BAR2
>              bool "Enable bar2"
>              depends on KERNEL_BUILT_FOR_FUZZ_TESTING
>
>     ) ?

I think this option is the best. It both allows fine-grained control
(and documentation for each switch), and coarse-grained control for
testing systems.
We could also add "depends on DEBUG_KERNEL" just to make sure.
