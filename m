Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7B3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 576382078D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhKd6Ea+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbgGGPYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729353AbgGGPYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:24:03 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B41C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 08:24:03 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 80so38478917qko.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 08:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Txgzoid44mqUrO9velpnvNnz2jII+44h3kdWBj9Cc4=;
        b=DhKd6Ea+KrKdh3mxPFxa58dg9l3ChgyupBfwMp6hpUaKFKyTmjRsMo9nBZYfcGRz+E
         RNnS00Snbrv9MRHdVkLMxAr3D4nQCFXxCZEdS0Au2PYimd2d9l0cyT0gij1BO+CuH2ms
         PLEtRAafi8TyWezJn8Rt6xLQQ0vwZUZF1T+JpURMgO1AUUp6bNUf9mTmr7YgZ6wdw1Lv
         EfDpvFqSCcnTJtlNskKECRHBaC8pHDhMmErXmMPxlfM99Ezh82KTZZnJR3hXZyweB8Cf
         CUHYjR+QOLll2iVMY6cH6H2Tibx+OYd3ql4ciOg2spcnO+c7LfUc4H5bKbiV8jFISjOZ
         ZI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Txgzoid44mqUrO9velpnvNnz2jII+44h3kdWBj9Cc4=;
        b=WEDpgwkN3HuD4Ksc/EXkB5z/GR+nmazGsDg1LLFI4PJNU/4N54DTa3GnMoro0JQ7OJ
         RgXCp5eTulN5ZqbMqy+BQpFSBcoCJ4xkvgP4ycf+dUqe/F/TNPnvnuVL+ifmdXkolkOl
         sh1dHDMiQMFahFzD672QcMIlmCKf0fmDF7pNUJgLTfTS/fkZq42Oc73OhJwYczZ+1FAF
         OiGNWOKpwoHpAQPc2139RJbZUbiFW+zhGrat2ZqNOvvudkQXo8xSImjoojNYwREoYLQ0
         AK9zMsfojQ2kySuNjoyXQ4ybHPngz1zA5/xxKBpM1dgd8M8PoQ/NKPTAb50O6fQIauHO
         I+0A==
X-Gm-Message-State: AOAM532d8jTBKarHDUaF2t3/BsHznjZBNzGdkfkoNdhcQZMzB65BURAi
        96Dk18FppdhhNZAzDOXJugIpwck2qRwbPCqH718=
X-Google-Smtp-Source: ABdhPJwbplgzxlBYHXfTN2xECGmsIRTvhHTgN5d35KPNchNTQmeaGxVUXVAUD6N02REyY+wBPKN9gY1hZ/mjUn/jjVI=
X-Received: by 2002:a37:4289:: with SMTP id p131mr22832369qka.28.1594135442792;
 Tue, 07 Jul 2020 08:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <1593678728-128358-1-git-send-email-xlpang@linux.alibaba.com>
 <CAOJsxLErUqY=eBEaj0G3iRAY-YuyyLnxOnBLTP6SkCjhq1On2g@mail.gmail.com> <7374a9fd-460b-1a51-1ab4-25170337e5f2@linux.alibaba.com>
In-Reply-To: <7374a9fd-460b-1a51-1ab4-25170337e5f2@linux.alibaba.com>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Tue, 7 Jul 2020 18:23:46 +0300
Message-ID: <CAOJsxLFnY=4v6UQigyiZKTMTQXKakVOKf6KA+bCkMe-XVY6sqA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/slub: Introduce two counters for the partial objects
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

(Sorry for the delay, I missed your response.)

On Fri, Jul 3, 2020 at 12:38 PM xunlei <xlpang@linux.alibaba.com> wrote:
>
> On 2020/7/2 PM 7:59, Pekka Enberg wrote:
> > On Thu, Jul 2, 2020 at 11:32 AM Xunlei Pang <xlpang@linux.alibaba.com> wrote:
> >> The node list_lock in count_partial() spend long time iterating
> >> in case of large amount of partial page lists, which can cause
> >> thunder herd effect to the list_lock contention, e.g. it cause
> >> business response-time jitters when accessing "/proc/slabinfo"
> >> in our production environments.
> >
> > Would you have any numbers to share to quantify this jitter? I have no
>
> We have HSF RT(High-speed Service Framework Response-Time) monitors, the
> RT figures fluctuated randomly, then we deployed a tool detecting "irq
> off" and "preempt off" to dump the culprit's calltrace, capturing the
> list_lock cost up to 100ms with irq off issued by "ss", this also caused
> network timeouts.

Thanks for the follow up. This sounds like a good enough motivation
for this patch, but please include it in the changelog.

> > objections to this approach, but I think the original design
> > deliberately made reading "/proc/slabinfo" more expensive to avoid
> > atomic operations in the allocation/deallocation paths. It would be
> > good to understand what is the gain of this approach before we switch
> > to it. Maybe even run some slab-related benchmark (not sure if there's
> > something better than hackbench these days) to see if the overhead of
> > this approach shows up.
>
> I thought that before, but most atomic operations are serialized by the
> list_lock. Another possible way is to hold list_lock in __slab_free(),
> then these two counters can be changed from atomic to long.
>
> I also have no idea what's the standard SLUB benchmark for the
> regression test, any specific suggestion?

I don't know what people use these days. When I did benchmarking in
the past, hackbench and netperf were known to be slab-allocation
intensive macro-benchmarks. Christoph also had some SLUB
micro-benchmarks, but I don't think we ever merged them into the tree.

- Pekka
