Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA76C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A444204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589822572;
	bh=uD0Ot9gejUvOcXUkmhI8Z3n6VciPijprZIk48OmsN0c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Hhsr7oCRzNv32QyWWd/mXE4u5EJpSUrDHPTMFo+CikKiRljXl7AN1oI2aEldYUcrr
	 0eolcMJdrkk717uVyLLNsgePloe6eJigRBFuaJ7rxv7alQjBlgC0j9LNKge2O5DVqc
	 GLA+bjpVpNs9oGF8ytoPygx9OWnIC7i50gNQexGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgERRWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgERRWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:22:51 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEF0C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 10:22:50 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id g1so10718432ljk.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 10:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qu8M66lDUKLK1WzpQWJe9igp01pFB46NWxsyvCKG6oY=;
        b=WAxyrolK30XZ/8MijRphoQ1WbKWVbqxz0H4gA/Jy0pDcY9RRDe21Oan+4qDj9RDWUv
         LcWGp75Zyqhpcfrh+DYhLDfC9L9hFBI3p+iU/zxywhL1G6tidYQ6GLIuGqXlUMc5RKDx
         2NX8Xzg6Xu2UUpMC93lzFHkjXofk5Qof537hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qu8M66lDUKLK1WzpQWJe9igp01pFB46NWxsyvCKG6oY=;
        b=QgJT0+COzxQwr3uWPV4+f2iHO02dYKVPmBKOVSShVjlqK8reDyDjJiqeRHL731sGU5
         2R2qRdan/L2x37IdSCNbiTKaz4HRHrRhDXNiDGcsA+wp2zIXlJjJHMRnjlksPZ9J0K/S
         y3U9GrCB2s4r9YJOWg6J/x9WiBZoFclfqqIbYS16wlTgIYhn75RMrIEJhsPwN+SHkMTM
         eHgvEFTkTi44+DLaDfvVOhi0zgDDGSlrmXAM+k/6y28y7yU0hw7wiVMJbZgXPcoCtBTG
         QGa5fbgW55DRAQNRWiulG1dpAUe4Lzi6Ae+4mFQNWqvnuWoGaFP6HIPgq15sCM122p71
         Ze6w==
X-Gm-Message-State: AOAM5306mlIFyqRIMo/k33JwT0CdeF6Iya+SpT8VdCsmyCFHf/uP1lp7
        ySUUHUJteNYkAkdlBCkC6F6uiCLLN/4=
X-Google-Smtp-Source: ABdhPJxnQdwnZy7+HR04PEeVWkkyqeHx6SWKAuDmE3bMVIYFM3MVT9FsQ81J0wyZR07Cji71FGc74w==
X-Received: by 2002:a2e:9743:: with SMTP id f3mr4459056ljj.205.1589822568390;
        Mon, 18 May 2020 10:22:48 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id g6sm5982657ljj.78.2020.05.18.10.22.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 10:22:47 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 82so8792000lfh.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 10:22:46 -0700 (PDT)
X-Received: by 2002:a05:6512:62:: with SMTP id i2mr3417039lfo.152.1589822566461;
 Mon, 18 May 2020 10:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200501094010.17694-1-john.ogness@linutronix.de>
 <20200501094010.17694-3-john.ogness@linutronix.de> <87v9ktcs3q.fsf@vostro.fn.ogness.net>
In-Reply-To: <87v9ktcs3q.fsf@vostro.fn.ogness.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 May 2020 10:22:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=whSLRiNxehLiuX+ZfHsu8Kpj7R1Sdr3zA7==SMW0zh3ug@mail.gmail.com>
Message-ID: <CAHk-=whSLRiNxehLiuX+ZfHsu8Kpj7R1Sdr3zA7==SMW0zh3ug@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] printk: add lockless buffer
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 6:04 AM John Ogness <john.ogness@linutronix.de> wrote:
>
> The cmpxchg() needs to be moved out of the while condition so that a
> continue can be used as intended. Patch below.

This seems pointless and wrong (patch edited to remove the '-' lines
so that you see the end result):

>                 smp_mb(); /* LMM(data_push_tail:C) */
>
> +               if (atomic_long_try_cmpxchg_relaxed(&data_ring->tail_lpos,
> +                               &tail_lpos,
> +                               next_lpos)) { /* LMM(data_push_tail:D) */
> +                       break;
> +               }

Doing an "smp_mb()" followed by a "cmpxchg_relaxed" seems all kinds of
odd and pointless, and is very much non-optimal on x86 for example.,

Just remove the smp_mb(), and use the non-relaxed form of cmpxchg.
It's defined to be fully ordered if it succeeds (and if the cmpxchg
doesn't succeed, it's a no-op and the memory barrier shouldn't make
any difference).

Otherwise you'll do two memory ordering operations on x86 (and
probably some other architectures), since the cmpxchg is always
ordered on x86 and there exists no "relaxed" form of it.

                  Linus
