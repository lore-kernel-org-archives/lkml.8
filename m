Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7353BC2D0A8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3195120795
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="KWuSlcwl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgIDQPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 12:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgIDQPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:15:09 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10B1C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 09:15:08 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z4so7301705wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 09:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V3rhhfTC3l11VUo1+dStci1vsiRgGk779RrN04Aw6ww=;
        b=KWuSlcwlEEIgRnaQ1WlxG7B4FBZs+NwIYXlSdFTYNkwYPg1WNTwTF406wwqN20WeaF
         7JWuP1bS4LIpQBOBJOiSsNYHql3mV5FqrjzVVgvfvr4MKbFQr38KvuX/00CIZU0/NHCT
         /5oZFJrOsFfjWNVwGCv5UOzmLED/gKnV8L49ZLJiFGxKL+DFWWs7K20vOWIoDC+GEW3p
         OBjbR46qzgDYwRIx2orihI2qwHGWIKAmIbVrtNhAIcjNNOHfbUnCZUy9IToOMz5W5gvX
         gqk4lKKWBn83Lppc0LU63aKg0T/VwYeZoLpMW8UXdpBOvewdiC8iAmTmaZrgB7sLRJmw
         Xong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V3rhhfTC3l11VUo1+dStci1vsiRgGk779RrN04Aw6ww=;
        b=WYUP2kyBZPs+HLdzVPungA1uvD/aUws3oyZzlirVWL1mBePwXaNRh+pRVJFfFHni3i
         KabNBoGyyb0pwtHfc7qONM/+auK8Cie8fW/iYBpdxO9NwvhF1ay/6KgHed9bDwcCHc6O
         qofMVbo6AAyjIEnqowDoPVwJJ2Cc7fG9jQVRrY/4Kek8koXtFnYY6h+c0y/pRxixEEVw
         44Dy6lWXGsquUwHeLGJtlh2hNhnGmJMhg0AR41CJG/OfJm204Yxwory42QAsmnPhtaiG
         2zFgkpw9X+d+Vn32ytsQWg8JF/1DGuLJ1s5rVOBXDh80KdZ37+8MPYu2AZTqCIy75YGr
         apgg==
X-Gm-Message-State: AOAM5339hhTA0wHl8dCl8+4vMI236Y92cHw0K/9oNlyI3jSmJvPGpJ9v
        S9tXBkly/l2KGRirBUtKAwHY03MJH7wQCe8WEWsSOw==
X-Google-Smtp-Source: ABdhPJyTjkbkcOYlZniTIPZKGH4vrbJxcDP6sLxfF955OpkJa9HBW167QvGRn2KnMyPnFWoHc5CUScPP/8ZhDfq0CMA=
X-Received: by 2002:adf:f552:: with SMTP id j18mr9032487wrp.128.1599236107381;
 Fri, 04 Sep 2020 09:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-32c8d053-acbd-4c72-b41d-8d6042ac639d@palmerdabbelt-glaptop1>
 <CAHk-=wi_tf4qsiBj5UD0GG3wz8Hi5NrHzqdrx+CwtfAY+_UiGg@mail.gmail.com>
 <20200904083109.GA9182@infradead.org> <CAAhSdy3S8FfMAWih_VoBHw0xd-7c=urzuJ+PPdug9iX_pWyTsQ@mail.gmail.com>
 <20200904094617.GA27846@infradead.org> <CAAhSdy2x0ROqoTzzZRZgKCTL99WPy-8e4CQ921sf-=GQDm_gxA@mail.gmail.com>
 <f1be6ee1-0802-82ca-ffdb-4c294925cd9a@kylinos.com.cn> <20200904130044.GA7842@infradead.org>
 <CAAhSdy2N8L015z0-RirjXLjdzt+OrCtzzKzivsMeQXoH9Nc8Cw@mail.gmail.com> <20200904160335.GA23669@infradead.org>
In-Reply-To: <20200904160335.GA23669@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 4 Sep 2020 21:44:55 +0530
Message-ID: <CAAhSdy2RqZg82Q0+ChRKV6h+Ot90q2Qea9h5s=42SEa3Px4gLg@mail.gmail.com>
Subject: Re: [GIT PULL] RISC-V Fixes for 5.9-rc2
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 4, 2020 at 9:33 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Sep 04, 2020 at 07:26:41PM +0530, Anup Patel wrote:
> > On Fri, Sep 4, 2020 at 6:30 PM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > On Fri, Sep 04, 2020 at 08:58:25PM +0800, Qiu Wenbo wrote:
> > > > I can confirm this patch also breaks K210 support. It seems that
> > > > csr_read(CSR_TIME) will trigger an illegal instruction exception on K210.
> > >
> > > CSR_TIME is trapped by just about every implementation I know (which is
> > > explicitly allowed by the spec).  That is why we should never use it
> > > from common M-mode code.
> >
> > Finally, I was able to replicate this issue by manually hacking QEMU to
> > not emulatie TIME CSR for virt machine.
> >
> > It seems this issue is only seen on older QEMU and Kendrtye K210.
>
> You'd also see it when running nommu on Sifivie or just about any
> hardware.  Whoever implement the TIME CSR for qemu made a mistake IMHO
> as it doesn't match how most real hardware behaves.

There are quite a few RISCV systems who implement TIME CSR in
hardware due to performance gains (10+ %).

The QEMU virt machine does not represent real-world HW so we
should emulate all possible HW optimizations in QEMU virt machine.

On other hand, the QEMU sifive_u machine correctly matches the
real-world SiFive Unleashed in-context of TIME CSR and other HW
features.

IMHO, we need nommu defconfig for SiFive Unleashed so that we
can try NoMMU kernel on both QEMU virt and QEMU sifive_u machine.

Regards,
Anup
