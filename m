Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A5AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ED3A20780
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QDsiLTzw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732408AbgFWQYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732212AbgFWQYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:24:53 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7A8C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 09:24:52 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so3900316wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 09:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k367pPi484Y9kqFj9L898KRU1GSNFO6+EeCIEPfvBJY=;
        b=QDsiLTzw3+x58fLhSo7sIymXLYZF4pMvb8DpM1VoQWnWNFGFAfw7Ztf6d1tMdEo1PR
         thqX5nxKJQ4CHRLuSnHcGZ96dDiJBxo9YUa0GKaduVNwFq+B8q1+N1+IVU7LqJCchiI/
         o/mW0Ezvb2gg46TdtJaQ+l9NrHkfpJcgibZds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k367pPi484Y9kqFj9L898KRU1GSNFO6+EeCIEPfvBJY=;
        b=MCz62xrawpXM6PptvJr1Ia3A3vf/fQzYAOA1IOCZJyjUEIKAVDSVzqG4RcvLiJMCst
         j9PHEqjx+LzKyrwlYzZfWLorcFZwBLQadG5ek7reg4laK1xFeHdFXE0C73j/+OAq5xMU
         aAv0WlWcatU+j1rVmCvJ43Nq93nemvP+KaRbHpeAY83aajynChkBY3/HjTEwpoCTtEFN
         voWtLoINrRMRTLW6RRb1UIwmPuTCXiJEDogHLSEhdbAG0opvd70ksp+CE76g3Z6n1Y/r
         j/lq2JhoQRr4YAqwPIscB7xdskBIBMkPz7m4XqStAzh8UsBeWYpz769rNtZxUCIOcYVO
         xFeQ==
X-Gm-Message-State: AOAM532NdTFjLScMeO54I4Ra2CuA95qQngIRFlGE1jRMI9YH+sjZuLou
        aTwokvh0lmeG7RDO3YjEZbNW4rkDJ0NqWT9nH2hnwg==
X-Google-Smtp-Source: ABdhPJxvX3K+jnTtOtYx0HTHHZBqcuVZPcjvflAhi+vkNusR5T41ex8V/k8bAFtX3IXYIbFAnZJhiP73WUsfoL1YcAY=
X-Received: by 2002:a1c:49c1:: with SMTP id w184mr24245992wma.46.1592929490533;
 Tue, 23 Jun 2020 09:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200619164132.1648-1-ignat@cloudflare.com> <20200619165548.GA24779@redhat.com>
 <alpine.LRH.2.02.2006191429060.23991@file01.intranet.prod.int.rdu2.redhat.com>
 <20200620012332.GA25340@gondor.apana.org.au> <20200623153352.GA19783@redhat.com>
In-Reply-To: <20200623153352.GA19783@redhat.com>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Tue, 23 Jun 2020 17:24:39 +0100
Message-ID: <CALrw=nEjCdg8BuTFT81+tCDtuxgwy05FKZAdvk3oq+pauW0nDA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] dm-crypt excessive overhead
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Mikulas Patocka <mpatocka@redhat.com>,
        "David S. Miller" <davem@davemloft.net>, agk@redhat.com,
        dm-devel@redhat.com, dm-crypt@saout.de,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 4:34 PM Mike Snitzer <snitzer@redhat.com> wrote:
>
> On Fri, Jun 19 2020 at  9:23pm -0400,
> Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> > On Fri, Jun 19, 2020 at 02:39:39PM -0400, Mikulas Patocka wrote:
> > >
> > > I'm looking at this and I'd like to know why does the crypto API fail in
> > > hard-irq context and why does it work in tasklet context. What's the exact
> > > reason behind this?
> >
> > You're not supposed to do any real work in IRQ handlers.  All
> > the substantial work should be postponed to softirq context.
> >
> > Why do you need to do work in hard IRQ context?
>
> Ignat, think you may have missed Herbert's question?
>
> My understanding is that you're doing work in hard IRQ context (via
> tasklet) precisely to avoid overhead of putting to a workqueue?  Did
> you try using a workqueue and it didn't work adequately?  If so, do you
> have a handle on why that is?  E.g. was it due to increased latency? or
> IO completion occurring on different cpus that submitted (are you
> leaning heavily on blk-mq's ability to pin IO completion to same cpu as
> IO was submitted?)
>
> I'm fishing here but I'd just like to tease out the details for _why_
> you need to do work from hard IRQ via tasklet so that I can potentially
> defend it if needed.

I may be misunderstanding the terminology, but tasklets execute in
soft IRQ, don't they? What we care about is to execute the decryption
as fast as possible, but we can't do it in a hard IRQ context (that
is, the interrupt context where other interrupts are disabled). As far
as I understand, tasklets are executed right after the hard IRQ
context, but with interrupts enabled - which is the first safe-ish
place to do more lengthy processing without the risk of missing an
interrupt.

Workqueues instead of tasklets - is the way how it is mostly
implemented now. But that creates additional IO latency, most probably
due to the fact that we're introducing CPU scheduling latency into the
overall read IO latency. This is confirmed by the fact that our busier
production systems have much worse and more important - spiky and
unstable p99 read latency, which somewhat correlates to high CPU
scheduling latency reported by metrics.

So, by inlining crypto or using a tasklet we're effectively
prioritising IO encryption/decryption. What we want to avoid is mixing
unpredicted additional latency from an unrelated subsystem (CPU
scheduler), because our expectation is that the total latency should
be real HW io latency + crypto operation latency (which is usually
quite stable).

I hope this makes sense.

>
> Thanks,
> Mike
>
