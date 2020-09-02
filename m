Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B39C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 21:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09EE4208C7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 21:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="AB0MaNCk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgIBVzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 17:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgIBVzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 17:55:05 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AAAC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 14:55:03 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t13so604827ile.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 14:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ps+XeqB+p7D2S/+k/QEvmkR2jE9sCYa4Xd9wag4GxpM=;
        b=AB0MaNCkviMoCkUPNhIjnEsEB8o0jRUgmMRikw3j8a6r/BL5wj+1Hv8XD4oB3IOV7+
         RxASFmUnMT8mN30DY0xVcbKg0jupM1Iys9TGBU6BBqGqub+I97mZwgA7CZA7fndhUfHN
         NRk2OEbUoho1JJU9c1QVxPT9kqL+dWbjcgrQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ps+XeqB+p7D2S/+k/QEvmkR2jE9sCYa4Xd9wag4GxpM=;
        b=mnJ+NKudV0lBx5h1f7QJJZWQmxHImfzf4z7v/kJjnjXuRlSFlEgV6ibdFKJ8Wsa6Eb
         QdP4Krdvivf7dojQJXa/X+VSzH3pF0tfBr3I4dd5a5LJNYrcNQEXkMWU5x6eArz/cIXM
         y/uyTDDQ8Lk247GQrjb0H4cJrrinNtXXsH3VZF/NjgkvPh4QLjLTzPYia3D9JwldI2zo
         MoQcKV/IGb3M4zSTiN4q7+MR6HDIhomhNZmXm8RNofMcttimI1iHI+ntUg96YlGeexhs
         /3OePo04Sa3eL7B+t/2B+qP3NaVohSay8/TNFRlyX2XtEUitbrxm/aWK7qIrM20qjn4o
         a3Xw==
X-Gm-Message-State: AOAM531MhufpJA+mWT4a8uYQlE8gI58Owd11Aemajn+xInL8q5XYqJ/x
        +IT9f2IY5BuF0lxbO5gvOiGHxNzXPGgzGLv5p7wCjw==
X-Google-Smtp-Source: ABdhPJy97FUI6rJ48aGJxnvh7IN7gU9TzCT/M1np4E9sl6wQh/UUi09mdFx/frMtZ62Jv6PieN5csJ517+Pr2wxETeY=
X-Received: by 2002:a05:6e02:10ce:: with SMTP id s14mr286462ilj.13.1599083702841;
 Wed, 02 Sep 2020 14:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599072725.git.nachukannan@gmail.com> <CAEXW_YSt49yGH+Wc63zfm4i7n1M_YxETbAA8nxmfDH1B3WFQXg@mail.gmail.com>
In-Reply-To: <CAEXW_YSt49yGH+Wc63zfm4i7n1M_YxETbAA8nxmfDH1B3WFQXg@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 2 Sep 2020 17:54:49 -0400
Message-ID: <CAEXW_YQN6BAUDR8EwcE=0kcFL+huk-c1WvkzQ63BXx9N21kM8A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Trace events to pstore
To:     Nachammai Karuppiah <nachukannan@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        computersforpeace@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 2, 2020 at 5:47 PM Joel Fernandes <joel@joelfernandes.org> wrot=
e:
>
> On Wed, Sep 2, 2020 at 4:01 PM Nachammai Karuppiah
> <nachukannan@gmail.com> wrote:
> >
> > Hi,
> >
> > This patch series adds support to store trace events in pstore.
> >

Been a long day...

> > Storing trace entries in persistent RAM would help in understanding wha=
t
> > happened just before the system went down. The trace events that led to=
 the
> > crash can be retrieved from the pstore after a warm reboot. This will h=
elp
> > debug what happened before machine=E2=80=99s last breath. This has to b=
e done in a
> > scalable way so that tracing a live system does not impact the performa=
nce
> > of the system.
>
> Just to add, Nachammai was my intern in the recent outreachy program
> and we designed together a way for trace events to be written to
> pstore backed memory directory instead of regular memory. The basic

s/directory/directly/

> idea is to allocate frace's ring buffer on pstore memory and have it
> right there. Then recover it on reboot. Nachammai wrote the code with

s/right/write/

 - Joel


> some guidance :) . I talked to Steve as well in the past about the
> basic of idea of this. Steve is on vacation this week though.
>
> This is similar to what +Sai Prakash Ranjan was trying to do sometime
> ago: https://lkml.org/lkml/2018/9/8/221 . But that approach involved
> higher overhead due to synchronization of writing to the otherwise
> lockless ring buffer.
>
> +Brian Norris has also expressed interest for this feature.
>
> thanks,
>
>  - Joel
>
> >
> > This requires a new backend - ramtrace that allocates pages from
> > persistent storage for the tracing utility. This feature can be enabled
> > using TRACE_EVENTS_TO_PSTORE.
> > In this feature, the new backend is used only as a page allocator and
> > once the  users chooses to use pstore to record trace entries, the ring
> > buffer pages are freed and allocated in pstore. Once this switch is don=
e,
> > ring_buffer continues to operate just as before without much overhead.
> > Since the ring buffer uses the persistent RAM buffer directly to record
> > trace entries, all tracers would also persist across reboot.
> >
> > To test this feature, I used a simple module that would call panic duri=
ng
> > a write operation to file in tracefs directory. Before writing to the f=
ile,
> > the ring buffer is moved to persistent RAM buffer through command line
> > as shown below,
> >
> > $echo 1 > /sys/kernel/tracing/options/persist
> >
> > Writing to the file,
> > $echo 1 > /sys/kernel/tracing/crash/panic_on_write
> >
> > The above write operation results in system crash. After reboot, once t=
he
> > pstore is mounted, the trace entries from previous boot are available i=
n file,
> > /sys/fs/pstore/trace-ramtrace-0
> >
> > Looking through this file, gives us the stack trace that led to the cra=
sh.
> >
> >            <...>-1     [001] ....    49.083909: __vfs_write <-vfs_write
> >            <...>-1     [001] ....    49.083933: panic <-panic_on_write
> >            <...>-1     [001] d...    49.084195: printk <-panic
> >            <...>-1     [001] d...    49.084201: vprintk_func <-printk
> >            <...>-1     [001] d...    49.084207: vprintk_default <-print=
k
> >            <...>-1     [001] d...    49.084211: vprintk_emit <-printk
> >            <...>-1     [001] d...    49.084216: __printk_safe_enter <-v=
printk_emit
> >            <...>-1     [001] d...    49.084219: _raw_spin_lock <-vprint=
k_emit
> >            <...>-1     [001] d...    49.084223: vprintk_store <-vprintk=
_emit
> >
> > Patchwise oneline description is given below:
> >
> > Patch 1 adds support to allocate ring buffer pages from persistent RAM =
buffer.
> >
> > Patch 2 introduces a new backend, ramtrace.
> >
> > Patch 3 adds methods to read previous boot pages from pstore.
> >
> > Patch 4 adds the functionality to allocate page-sized memory from pstor=
e.
> >
> > Patch 5 adds the seq_operation methods to iterate through trace entries=
.
> >
> > Patch 6 modifies ring_buffer to allocate from ramtrace when pstore is u=
sed.
> >
> > Patch 7 adds ramtrace DT node as child-node of /reserved-memory.
> >
> > Nachammai Karuppiah (7):
> >   tracing: Add support to allocate pages from persistent memory
> >   pstore: Support a new backend, ramtrace
> >   pstore: Read and iterate through trace entries in PSTORE
> >   pstore: Allocate and free page-sized memory in persistent RAM buffer
> >   tracing: Add support to iterate through pages retrieved from pstore
> >   tracing: Use ramtrace alloc and free methods while using persistent
> >     RAM
> >   dt-bindings: ramtrace: Add ramtrace DT node
> >
> >  .../bindings/reserved-memory/ramtrace.txt          |  13 +
> >  drivers/of/platform.c                              |   1 +
> >  fs/pstore/Makefile                                 |   2 +
> >  fs/pstore/inode.c                                  |  46 +-
> >  fs/pstore/platform.c                               |   1 +
> >  fs/pstore/ramtrace.c                               | 821 +++++++++++++=
++++++++
> >  include/linux/pstore.h                             |   3 +
> >  include/linux/ramtrace.h                           |  28 +
> >  include/linux/ring_buffer.h                        |  19 +
> >  include/linux/trace.h                              |  13 +
> >  kernel/trace/Kconfig                               |  10 +
> >  kernel/trace/ring_buffer.c                         | 663 +++++++++++++=
+++-
> >  kernel/trace/trace.c                               | 312 +++++++-
> >  kernel/trace/trace.h                               |   5 +-
> >  14 files changed, 1924 insertions(+), 13 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/reserved-memory/r=
amtrace.txt
> >  create mode 100644 fs/pstore/ramtrace.c
> >  create mode 100644 include/linux/ramtrace.h
> >
> > --
> > 2.7.4
> >
