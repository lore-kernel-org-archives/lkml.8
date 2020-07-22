Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0513AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1C0F20825
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595455866;
	bh=rrD1MaIcckKimmVcrd51dA0aWUpllFClYsv/eT1nyCw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dDfo+AN3mf6bZHqEtf1czryYExxNQQ/+ut1QxnoQ3i6KYMqfCP+n13VwwR17QrJKf
	 8dYT77rUWL5+c1AzBMfWuliH/wNKSCXIdy5stH4WdR4CtewrDdO6X5RaHJX47kCKJt
	 yA4hrCBESDabJd+rZ+bwFxirni5/gCDwPEryYbJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732998AbgGVWLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 18:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgGVWLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 18:11:05 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8921DC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 15:11:04 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id u12so2213426lff.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 15:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mKcnks++BVJckGT27RdKRDX4KPgvtTbjBQBJPx6EVtE=;
        b=HfjxMSNXOBFs72NZQwzgLB+n1HTdUhb2cUmrKtKW+8eiwn4OoCtnYZdYaBLyuKrcQk
         UfOFr2okT+3ozHOJ2IfVHuWgMZEiY+vOc8DmYBkD/QLBRZQfVAs94sB2DMASW5ElGu2q
         P25unJrMLZmaAUjrKbNr8RMGKLunq02CX9d4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mKcnks++BVJckGT27RdKRDX4KPgvtTbjBQBJPx6EVtE=;
        b=Jf+e5iFKL5zj4MqLUaAmMLorS76CiFnrJw1SUPZwlxkhaet9Pauj4FHrlFIRmKWACJ
         Q7ShBZTef0lSL7nlG+OTP29KolTlpx8A5BpYCPBCtVqcUpDDoL38M8IoRxi3RfXcFlmG
         kcmMfhNzDROIZEoGaYWlGOR3r//CJx91ZfEiVJEZ/kTh37hIq1D4vDC4WkOLDmJZKv8k
         nctOblvJdABifkUsSvFIYbdxUgqb1YVcsU6/d1K/AQcjE7bau/9S/fp1rAclnGNgjjcU
         q97WhBSfY+ebeNdMl/zkFJB+akSMGqnJ7grxyvE5k+uKhckJHNtVg05Uv6xHIKh+szV+
         Cpqg==
X-Gm-Message-State: AOAM530gmuoWAH5INaXlBvsYtA/ctE9TJei1xuIm8KwqATgB9n2e0oGZ
        HRE+EG8awONpc9FipgJB9lWaPtM+5K4=
X-Google-Smtp-Source: ABdhPJxosU6FFBca4Dy+IoqpqG0yo77BQOCFrM+6ZRl7XhjF/jxsCAkYPKSmF/NQPqcgGZ2345Sivw==
X-Received: by 2002:a05:6512:74b:: with SMTP id c11mr654342lfs.119.1595455862650;
        Wed, 22 Jul 2020 15:11:02 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 2sm893935lfr.48.2020.07.22.15.11.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 15:11:01 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id b30so2185137lfj.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 15:11:01 -0700 (PDT)
X-Received: by 2002:ac2:58d5:: with SMTP id u21mr673351lfo.31.1595455860915;
 Wed, 22 Jul 2020 15:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200721063258.17140-1-mhocko@kernel.org> <CAHk-=whewL14RgwLZTXcNAnrDPt0H+sRJS6iDq0oGb6zwaBMxg@mail.gmail.com>
 <CAHk-=whb0=rjc1WR+F_r_syw5Ld4=ebuNJmmpaPEzfjZRD5Y-w@mail.gmail.com> <alpine.LSU.2.11.2007221359450.1017@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2007221359450.1017@eggly.anvils>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Jul 2020 15:10:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=vuc6sdu0m9nYd3gb8x5Xgnc6=TH=DTOy7qU96rZ9nw@mail.gmail.com>
Message-ID: <CAHk-=wi=vuc6sdu0m9nYd3gb8x5Xgnc6=TH=DTOy7qU96rZ9nw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
To:     Hugh Dickins <hughd@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 2:29 PM Hugh Dickins <hughd@google.com> wrote:
>
> -#define PAGE_WAIT_TABLE_BITS 8
> +#define PAGE_WAIT_TABLE_BITS 10

Well, that seems harmless even on small machines.

> +       bool first_time = true;
>         bool thrashing = false;
>         bool delayacct = false;
>         unsigned long pflags;
> @@ -1134,7 +1135,12 @@ static inline int wait_on_page_bit_commo
>                 spin_lock_irq(&q->lock);
>
>                 if (likely(list_empty(&wait->entry))) {
> -                       __add_wait_queue_entry_tail(q, wait);
> +                       if (first_time) {
> +                               __add_wait_queue_entry_tail(q, wait);
> +                               first_time = false;
> +                       } else {
> +                               __add_wait_queue(q, wait);
> +                       }
>                         SetPageWaiters(page);
>                 }

This seems very hacky.

And in fact, looking closer, I'd say that there are more serious problems here.

Look at that WQ_FLAG_EXCLUSIVE thing: non-exclusive waits should
always go at the head (because they're not going to steal the bit,
they just want to know when it got cleared), and exclusive waits
should always go at the tail (because of fairness).

But that's not at all what we do.

Your patch adds even more confusion to this nasty area.

And your third one:

> +               if (ret)
> +                       woken++;
>
> -               if (bookmark && (++cnt > WAITQUEUE_WALK_BREAK_CNT) &&
> +               if (bookmark && (++cnt > WAITQUEUE_WALK_BREAK_CNT) && woken &&

I've got two reactions to this

 (a) we should not need a new "woken" variable, we should just set a
high bit of "cnt" and make WAITQUEUE_WALK_BREAK_CNT contain that high
bit

     (Tune "high bit" to whatever you want: it could be either the
_real_ high bit of the variable, or it could be something like "128",
which would mean that you'd break out after 128 non-waking entries).

 (b) Ugh, what hackery and magic behavior regardless

I'm really starting to hate that wait_on_page_bit_common() function.

See a few weeks ago how the function looks buggy to begin with

  https://lore.kernel.org/lkml/CAHk-=wjJA2Z3kUFb-5s=6+n0qbTs8ELqKFt9B3pH85a8fGD73w@mail.gmail.com/

and that never got resolved either (but probably never happens in practice).

              Linus
