Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D26C4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3503024687
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fffrfVvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgBZLkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 06:40:41 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45243 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgBZLkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:40:41 -0500
Received: by mail-ed1-f65.google.com with SMTP id v28so3332716edw.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 03:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zhdrq93u488Q5ODutFuefjV07O1clZCZbbsXFR1BfLs=;
        b=fffrfVvd/UhPYb8m3UauCjRjgmcH8wj8E+I2mvQmHzLgfB0Kspa/Y/afcyuNIyjFQm
         wpsrGGANSHOt8zlclCogz5kjI4j3UXvsKt//1TdwW3U6TtnvKn1G/WP8Ro1WGeYTuiFI
         wUPjn6ocuHxnIAnX+sD86Hs/VC8Mk6XPC/bvbF00ZthfFVsU0ZhEi7J35yI+YIBLVsf4
         oNOuxvx3+a1mUWXATaLuEQPFfGqHn6wLeZj6TKDWILj8lIZ0uDWvB3eplZksKAvXE+PB
         wQijSt9zeEz+/iq+MR3nsogR8n3O4ob5dKaUhHSNTxN7Rstz+ZHkNr6lRkWbxRChjVBS
         Fvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zhdrq93u488Q5ODutFuefjV07O1clZCZbbsXFR1BfLs=;
        b=Cg5rH7c0G/eLCX0n8YGv3qG8FekTOngGHXPOaJQQqGX0zU80wcTNSaY6uJYQMhTBMN
         uMwsOIvi4+eGI4l4al2Fmt7etIHTPM1ob9nZCe5xlWHgC6W4dY2gWz1Hu/5pDHI0M/s7
         lXJ7A3ej59GNNudpIHkbFxf6BZ7Z699L1eQ2N/Ye6ZRUcF7utX2uS5EhbAmYSckQ4jg1
         +y9IiGL8R0jA3z/vws8Z4jcB7vsxuxpcvAfvhpUUHclwGGplw95XkFukL8xdMHR82At6
         d0wLPIF8mpogA64srAfHZlHliewyGAT3N/9vc6/p3C3cy0HgXSFGUl4wdq0ome1IgdiT
         QKwQ==
X-Gm-Message-State: APjAAAUObzMo3s1RYFHJX7ZUoMvB+HXP0Zwr3Z+SuwuW4pwOtJtymKzv
        WqZuQ4o0VRFwmSv6EnemQPlePZJi193ndE+muVEJXg==
X-Google-Smtp-Source: APXvYqxfxP+ZGsWK0o+sCSs/mIuHiSLlkJF2U06Ollo4fytkeCHy23VfbkWdTK3g9fY9azfXlGBwMZQhxXFAAB3GKzY=
X-Received: by 2002:a50:fd15:: with SMTP id i21mr4355734eds.12.1582717238839;
 Wed, 26 Feb 2020 03:40:38 -0800 (PST)
MIME-Version: 1.0
References: <20200226023027.218365-1-lrizzo@google.com> <20200226081048.GC22801@kroah.com>
 <CAMOZA0+4Qg+bDQ1xGQ0jL=dvXK80LuxOa7tEd-=iBwat2M9pfg@mail.gmail.com> <20200226101449.GF127655@kroah.com>
In-Reply-To: <20200226101449.GF127655@kroah.com>
From:   Luigi Rizzo <lrizzo@google.com>
Date:   Wed, 26 Feb 2020 03:40:27 -0800
Message-ID: <CAMOZA0LOYhnHM3_dB0ZxWMMtLT6Lya1NGOWFN_ihD_kq7bhsng@mail.gmail.com>
Subject: Re: [PATCH 0/2] quickstats, kernel sample collector
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        akpm@linux-foundation.org, naveen.n.rao@linux.ibm.com,
        ardb@kernel.org, Luigi Rizzo <rizzo@iet.unipi.it>,
        Paolo Abeni <pabeni@redhat.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 2:15 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Feb 26, 2020 at 01:52:25AM -0800, Luigi Rizzo wrote:
> > On Wed, Feb 26, 2020 at 12:10 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Feb 25, 2020 at 06:30:25PM -0800, Luigi Rizzo wrote:
> > > > This patchset introduces a small library to collect per-cpu samples and
> > > > accumulate distributions to be exported through debugfs.
> > >
> > > Shouldn't this be part of the tracing infrastructure instead of being
> > > "stand-alone"?
> >
> > That's an option. My reasoning for making it standalone was that
> > there are no dependencies in the (trivial) collection/aggregation part,
> > so that code might conveniently replace/extend existing snippets of
> > code that collect distributions in ad-hoc and perhaps suboptimal ways.
>
> But that's what perf and tracing already does today, right?

Maybe I am mistaken but I believe there are substantial performance and use case
differences between kstats and existing perf/tracing code, as described below.

kstats is meant to be a) used for manual code annotations and b) be as
fast as possible.
For a) there are already several places in the kernel (a grep
indicates fs/fscache, drivers/md/,
some drivers; I am sure there are more places) where we accumulate and export
metrics in ad-hoc ways (packet sizes, memory requests, requests
execution times).
There are other places where we would in principle have the information (eg
CONFIG_IRQ_TIME_ACCOUNTING knows intervals spent in soft/hard interrupts;
napi calls report how much of the budget has been used; NIC drivers know actual
batch sizes) but we don't try to accumulate it even though it would be
precious for
performance tuning.
kstats in my view fits this use case

For b), the manual annotations are as fast as possible, and kstats_record() with
a hot cache takes only about 5ns, and 250ns with cold cache (this is probably
the same as the existing code that it is meant to replace), and
inherits the accuracy
of the base clock (ktime_get_ns() is about 20ns on x86).
This means that we can definitely tell apart samples that differ by
O(50ns), which is
the order of magnitude of cache misses, and instrument even
sub-microsecond sections
of code with limited impact on performance. For networking code for
instance, or other
high speed drivers, scheduler-related functions, signaling latencies
etc, those are
a significant use case.

The tracepoint/kprobe/kretprobe solution is much more expensive --
from my measurements,
the hooks that invoke the various handlers take ~250ns with hot cache,
1500+ns with cold
cache, and tracing an empty function this way reports 90ns with hot
cache, 500ns with
cold cache.
As a consequence, enabling tracing through those hooks is only viable
on much longer time
intervals, and the much coarser accuracy (anything shorter than those
90..500ns becomes
hidden in the noise) would hide shorter phenomena.

>  You need to
> integrate into the existing subsystems of the kernel and not duplicate
> things, creating new user/kernel apis whenever possible.

For the above, I am not sure this is a duplication.
Perhaps part of the problem is that "perf and tracing" are too general
terms, and while
at a high level they encompass every possible monitoring activity, the
actual implementation
seems to me orthogonal to kstats. Of course we can fold the 300 lines
of kstats into
perf/tracing, but then I wonder, do we need to bring in the whole
thing when all we need
is just the smaller component ?

cheers
luigi
