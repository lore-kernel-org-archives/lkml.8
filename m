Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E0BC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 21:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D4C220758
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 21:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="djNZsNkc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgIBVsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 17:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIBVr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 17:47:59 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D09C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 14:47:59 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id g13so508113ioo.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 14:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xily/0xvJGstnoyA+d4M7lfqBwEiG+KuuEoHjuwJurQ=;
        b=djNZsNkcJEUqSMyXoGRoGMbecvhRQg7H6wFV0CGohP7g3I0JzmlxO/zspibZuAoEIY
         zErSvTEBqP/ytOvJf4PsfEddQTzx7u1lyk00ycRPE5myKyJ5GKJecPJWCGZz6NOHx/Mw
         6Anit2n407iyA9SdzdNEDjFMNUdMft36P78pM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xily/0xvJGstnoyA+d4M7lfqBwEiG+KuuEoHjuwJurQ=;
        b=KVgdl3u1FNaTNFwixuVrQIVRQpGflqaA/wC1VlPwDiY2RVI0IgqzOX/yz+BltgAtTJ
         TeRgIvENrpuf54LUJCtSGsNtvI7oOdzgGm9nHANFG3RdUJ81kJTvL6wkWKS93VSsSyxB
         nyW9fhxnBURLJXRwL7y7Dbn3tGQqEpB4Vp7UvFGwCpwyJ3/MkzLGPYmQlN37DUMdFQ+A
         acbUhTiQbT7zjIVRD5UgWc+gaYnmt8MPYijieXXFDqGovXIm5q0m6xMA1vwhjLLc8NLD
         5y+j5uRa9p9d8Cv0Pdwh/h+IKYVkiLwRmM0Qcnle2CKrKkMQlMEJfrLDm3EW+0DchQnO
         pGGA==
X-Gm-Message-State: AOAM532ZprGc1Te4To2SfJchXMcpiiQNFEzTw8rjGSdBS6XC1BxZlLvd
        hEVauhHYdUNd9DIFqirY6do4ooxRxpyeIakKL3VyJQ==
X-Google-Smtp-Source: ABdhPJxN0cceSnVlbQW+tWtPGkNqVzCBlZ3FCJAVfmg+JHubdmrqXrtTHD3JYsPvRu9MZfgY1z2IGZRr8eb7ByAU0s0=
X-Received: by 2002:a05:6638:24d1:: with SMTP id y17mr102793jat.42.1599083278337;
 Wed, 02 Sep 2020 14:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599072725.git.nachukannan@gmail.com>
In-Reply-To: <cover.1599072725.git.nachukannan@gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 2 Sep 2020 17:47:44 -0400
Message-ID: <CAEXW_YSt49yGH+Wc63zfm4i7n1M_YxETbAA8nxmfDH1B3WFQXg@mail.gmail.com>
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

On Wed, Sep 2, 2020 at 4:01 PM Nachammai Karuppiah
<nachukannan@gmail.com> wrote:
>
> Hi,
>
> This patch series adds support to store trace events in pstore.
>
> Storing trace entries in persistent RAM would help in understanding what
> happened just before the system went down. The trace events that led to t=
he
> crash can be retrieved from the pstore after a warm reboot. This will hel=
p
> debug what happened before machine=E2=80=99s last breath. This has to be =
done in a
> scalable way so that tracing a live system does not impact the performanc=
e
> of the system.

Just to add, Nachammai was my intern in the recent outreachy program
and we designed together a way for trace events to be written to
pstore backed memory directory instead of regular memory. The basic
idea is to allocate frace's ring buffer on pstore memory and have it
right there. Then recover it on reboot. Nachammai wrote the code with
some guidance :) . I talked to Steve as well in the past about the
basic of idea of this. Steve is on vacation this week though.

This is similar to what +Sai Prakash Ranjan was trying to do sometime
ago: https://lkml.org/lkml/2018/9/8/221 . But that approach involved
higher overhead due to synchronization of writing to the otherwise
lockless ring buffer.

+Brian Norris has also expressed interest for this feature.

thanks,

 - Joel

>
> This requires a new backend - ramtrace that allocates pages from
> persistent storage for the tracing utility. This feature can be enabled
> using TRACE_EVENTS_TO_PSTORE.
> In this feature, the new backend is used only as a page allocator and
> once the  users chooses to use pstore to record trace entries, the ring
> buffer pages are freed and allocated in pstore. Once this switch is done,
> ring_buffer continues to operate just as before without much overhead.
> Since the ring buffer uses the persistent RAM buffer directly to record
> trace entries, all tracers would also persist across reboot.
>
> To test this feature, I used a simple module that would call panic during
> a write operation to file in tracefs directory. Before writing to the fil=
e,
> the ring buffer is moved to persistent RAM buffer through command line
> as shown below,
>
> $echo 1 > /sys/kernel/tracing/options/persist
>
> Writing to the file,
> $echo 1 > /sys/kernel/tracing/crash/panic_on_write
>
> The above write operation results in system crash. After reboot, once the
> pstore is mounted, the trace entries from previous boot are available in =
file,
> /sys/fs/pstore/trace-ramtrace-0
>
> Looking through this file, gives us the stack trace that led to the crash=
.
>
>            <...>-1     [001] ....    49.083909: __vfs_write <-vfs_write
>            <...>-1     [001] ....    49.083933: panic <-panic_on_write
>            <...>-1     [001] d...    49.084195: printk <-panic
>            <...>-1     [001] d...    49.084201: vprintk_func <-printk
>            <...>-1     [001] d...    49.084207: vprintk_default <-printk
>            <...>-1     [001] d...    49.084211: vprintk_emit <-printk
>            <...>-1     [001] d...    49.084216: __printk_safe_enter <-vpr=
intk_emit
>            <...>-1     [001] d...    49.084219: _raw_spin_lock <-vprintk_=
emit
>            <...>-1     [001] d...    49.084223: vprintk_store <-vprintk_e=
mit
>
> Patchwise oneline description is given below:
>
> Patch 1 adds support to allocate ring buffer pages from persistent RAM bu=
ffer.
>
> Patch 2 introduces a new backend, ramtrace.
>
> Patch 3 adds methods to read previous boot pages from pstore.
>
> Patch 4 adds the functionality to allocate page-sized memory from pstore.
>
> Patch 5 adds the seq_operation methods to iterate through trace entries.
>
> Patch 6 modifies ring_buffer to allocate from ramtrace when pstore is use=
d.
>
> Patch 7 adds ramtrace DT node as child-node of /reserved-memory.
>
> Nachammai Karuppiah (7):
>   tracing: Add support to allocate pages from persistent memory
>   pstore: Support a new backend, ramtrace
>   pstore: Read and iterate through trace entries in PSTORE
>   pstore: Allocate and free page-sized memory in persistent RAM buffer
>   tracing: Add support to iterate through pages retrieved from pstore
>   tracing: Use ramtrace alloc and free methods while using persistent
>     RAM
>   dt-bindings: ramtrace: Add ramtrace DT node
>
>  .../bindings/reserved-memory/ramtrace.txt          |  13 +
>  drivers/of/platform.c                              |   1 +
>  fs/pstore/Makefile                                 |   2 +
>  fs/pstore/inode.c                                  |  46 +-
>  fs/pstore/platform.c                               |   1 +
>  fs/pstore/ramtrace.c                               | 821 +++++++++++++++=
++++++
>  include/linux/pstore.h                             |   3 +
>  include/linux/ramtrace.h                           |  28 +
>  include/linux/ring_buffer.h                        |  19 +
>  include/linux/trace.h                              |  13 +
>  kernel/trace/Kconfig                               |  10 +
>  kernel/trace/ring_buffer.c                         | 663 +++++++++++++++=
+-
>  kernel/trace/trace.c                               | 312 +++++++-
>  kernel/trace/trace.h                               |   5 +-
>  14 files changed, 1924 insertions(+), 13 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/ram=
trace.txt
>  create mode 100644 fs/pstore/ramtrace.c
>  create mode 100644 include/linux/ramtrace.h
>
> --
> 2.7.4
>
