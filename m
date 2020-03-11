Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6CCC2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 20:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4475C2074F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 20:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="UUiKGu5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgCKU0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 16:26:04 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36269 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgCKU0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 16:26:04 -0400
Received: by mail-ed1-f65.google.com with SMTP id a13so4553363edh.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 13:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DbTh+HzDRmbol/brf2Mct+vvzxsLUOHUL6QMb/ty3HU=;
        b=UUiKGu5EPr78Pn+3KQj38QX9DK4KTjmnuLbJ5lII4Hv5XnhiUHBz5sTOlnpB99w4e1
         YeEcIp+MkGNqvtzuctEgV06pzNoB5mzfwCcopvik40a5yoFTDhpxMHxF6lDKNGerH5sh
         RpUkVFYJqhMX/YfySjsyLD5cMJZUjc/GjUEUPNbSyWctJZTQSsShH0ckZAsqZtwb3acp
         AHhvZcu6rzUfZnqmkuRztl7CX7FHjXX6Pkh9BJKY6/Tq/kqR9IMZ//uXs5xtSy5wMbTw
         ArupMpt+XaLOfAmuRI31WqjbMx6TS+KTUa+iqOy8rFDOzzmusfrlkR36BuGVxMRjnsEe
         7AFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DbTh+HzDRmbol/brf2Mct+vvzxsLUOHUL6QMb/ty3HU=;
        b=iqaf3i4ImTmaPUkfHzJq0sGrfgasw9iBGQvkrRN95bbwpr3vZ2SZJkLixtR2Laz0VH
         n8glNedP42c03r73zh03dlj3OF1Ku1q8s8MXrTzTX6HpdGtxU2Nn8bSdYpkzC2/rB1KU
         AB7u/8FPI8HzutlgUZ/sWDg9zdEWvEIEKhogNYgBRrqUXtKoy779F3GPbo3r3oSfozsE
         YWqegbFeJJ7CrGouZpU2in/jHRthumj61WQIcMCyAF8fi6B/LwEqjuT6DiWfF0K+9kfW
         NiNhdE7qUQZsF/ltGgHYz85iLhH2ngG0h28NRILE9u/2TOkY77nsKasSM7k+OkAC58Zs
         WZdg==
X-Gm-Message-State: ANhLgQ1NysRUnT9krnm43GvIFXnMwG6twPbi0dt04DnyxhvByN6TH5gu
        eNSpOtCkfz3X9nm/5INxgvCXQDQvKqd7QbXLn0exqwHFsDw=
X-Google-Smtp-Source: ADFU+vtZgy9rbvur9oyxw2hAg+JfmEnwrsMTWKzUdp8i6MPEif/I6HCCNM8P+ERm14SX2rlXyYPfJgvBBhg93cG2208=
X-Received: by 2002:a05:6402:306d:: with SMTP id bs13mr4889134edb.3.1583958362366;
 Wed, 11 Mar 2020 13:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200311123848.118638-1-shile.zhang@linux.alibaba.com>
 <CA+CK2bBdim9dEYsRJ+3HNg4+FsTM0185q54PU=gNKGPAWDpcNA@mail.gmail.com> <bd155ed2-e0a6-bdc6-3a44-2d4bbeb1886b@virtuozzo.com>
In-Reply-To: <bd155ed2-e0a6-bdc6-3a44-2d4bbeb1886b@virtuozzo.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 11 Mar 2020 16:25:51 -0400
Message-ID: <CA+CK2bD5J2ZWHF3UX0b4oH5zYSLCqKfgHZMoPXg-PJAxfeN0oQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm: fix tick timer stall during deferred page init
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 4:17 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> Hi, Pasha,
>
> On 11.03.2020 20:45, Pavel Tatashin wrote:
> > On Wed, Mar 11, 2020 at 8:39 AM Shile Zhang
> > <shile.zhang@linux.alibaba.com> wrote:
> >>
> >> When 'CONFIG_DEFERRED_STRUCT_PAGE_INIT' is set, 'pgdatinit' kthread will
> >> initialise the deferred pages with local interrupts disabled. It is
> >> introduced by commit 3a2d7fa8a3d5 ("mm: disable interrupts while
> >> initializing deferred pages").
> >>
> >> On machine with NCPUS <= 2, the 'pgdatinit' kthread could be bound to
> >> the boot CPU, which could caused the tick timer long time stall, system
> >> jiffies not be updated in time.
> >>
> >> The dmesg shown that:
> >>
> >>     [    0.197975] node 0 initialised, 32170688 pages in 1ms
> >>
> >> Obviously, 1ms is unreasonable.
> >>
> >> Now, fix it by restore in the pending interrupts for every 32*1204 pages
> >> (128MB) initialized, give the chance to update the systemd jiffies.
> >> The reasonable demsg shown likes:
> >>
> >>     [    1.069306] node 0 initialised, 32203456 pages in 894ms
> >
> > Sorry for joining late to this thread. I wonder if we could use
> > sched_clock() to print this statistics. Or not to print statistics at
> > all?
>
> This won't work for all cases since sched_clock() may fall back to jiffies-based
> implementation, which gives wrong result, when interrupts are disabled.
>
> And a bigger problem is not a statistics, but it's advancing jiffies. Some parallel
> thread may expect jiffies are incrementing, and this will be a surprise for that
> another component.
>
> So, this fix is more about modularity and about not introduction a new corner case.

Makes sense.

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>

Thank you,
Pasha
