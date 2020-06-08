Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE91C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9ED0206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U3EfLuu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387463AbgFHQtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 12:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387453AbgFHQtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 12:49:17 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A0DC08C5C3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 09:49:15 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id y5so16057644qtd.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 09:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4cSXd/WEBOMmjBzHT5V64B0CdBFXvfK/YmpOS865C/E=;
        b=U3EfLuu7JaLkGMY8hL5QIb1XxjOTvGLy8smtkMre6qK5eYxBLb2UL/zFO2wglyhsMu
         UvezhXn9mhrv0A7/FhCf8JnkEJTlV1VLNsipBdO/UsRGBq7OU4cvXBok03qi61RIPwYY
         cPFbpx7piIlTZzGtkW8/4i7sum2DbqS2EbzkDwEB3fJwkusvralu/xdeCEm1jeCCTR5I
         hgQLAlzmiNsYiwK8xuG6S/FSqj9OtLCIfPL3Ux2nlm4a+ru9sgaOfJjtOfYfH4CFwTEx
         mqp0KagzuygvTokeurbn2I3y+aupyDOmqHa0WNO3I2RH1aXp9uX80NDRvqN3aNVp0vHm
         OWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4cSXd/WEBOMmjBzHT5V64B0CdBFXvfK/YmpOS865C/E=;
        b=tr+VB8ryNYPmZO7YDof6hOV0N010/o1UksQx3JS8snWE7jCnyqE/iUpfEuX0t0dQOU
         3ATgJUow6dNF1xpMaNBb24EEZ4CBgtTmTiXmsZWMnJPKCtKghHJR9fCPk6d8e9mbZR1R
         nN1LOL4KEzSrivLcQHZ17uoymR0bD6n947oZKVw2GOR3hfqB7IJldPiV4QJNEN9orNoV
         Ef18b9zP0gSrjmrRGKALKcJ7slVgP6J6sV2RlYEOZ2nS9hl+Wa6LjgJrdIudkJ9bOOAw
         7BPOpkU9qlLVd79XfPNdpXDACcYC600cSxMUJsg+hA7offC9CQPmH5O3cInv1+LKHNnV
         HTpQ==
X-Gm-Message-State: AOAM5333p7FbRBzxzn4uHGlrZjxRhT52gRymsOFTgy4We5uVLYqr9Hey
        6VSoKsTBWLZiIHlysZGlOQ5oMms=
X-Google-Smtp-Source: ABdhPJw3SF/yeOWoX1y6fxdX9jvAKFUnJPCziJIZcvXIyleiG6G/g3vMRpIR6CTI4d5n5FeYtiZMXjs=
X-Received: by 2002:a0c:f991:: with SMTP id t17mr23459051qvn.123.1591634954981;
 Mon, 08 Jun 2020 09:49:14 -0700 (PDT)
Date:   Mon, 8 Jun 2020 09:49:13 -0700
In-Reply-To: <CAADnVQL3iBoem4T6CxYeZRCJwS7qRwjjbW+8ip5r3-LCt_eRXQ@mail.gmail.com>
Message-Id: <20200608164913.GA142074@google.com>
Mime-Version: 1.0
References: <20200424064338.538313-1-hch@lst.de> <20200424064338.538313-6-hch@lst.de>
 <1fc7ce08-26a7-59ff-e580-4e6c22554752@oracle.com> <20200608065120.GA17859@lst.de>
 <c0f216d1-edc1-68e6-7f3e-c00e33452707@oracle.com> <20200608130503.GA22898@lst.de>
 <CAADnVQL3iBoem4T6CxYeZRCJwS7qRwjjbW+8ip5r3-LCt_eRXQ@mail.gmail.com>
Subject: Re: WARNING: CPU: 1 PID: 52 at mm/page_alloc.c:4826
 __alloc_pages_nodemask (Re: [PATCH 5/5] sysctl: pass kernel pointers to ->proc_handler)
From:   sdf@google.com
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        Andrey Ignatov <rdna@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08, Alexei Starovoitov wrote:
> On Mon, Jun 8, 2020 at 6:05 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Mon, Jun 08, 2020 at 09:45:49AM +0200, Vegard Nossum wrote:
> > > Just a test case.
> > >
> > > Allowing the kernel to allocate an unbounded amount of memory on  
> behalf
> > > of userspace is an easy DOS.
> > >
> > > All the length checks were already in there, e.g.
> > >
> > >  static int cmm_timeout_handler(struct ctl_table *ctl, int write,
> > >                               void __user *buffer, size_t *lenp,  
> loff_t
> > > *ppos)
> > >  {
> > >         char buf[64], *p;
> > > [...]
> > >                 len = min(*lenp, sizeof(buf));
> > >                 if (copy_from_user(buf, buffer, len))
> > >                         return -EFAULT;
> >
> > Doesn't help if we don't know the exact limit yet.  But we can put
> > some arbitrary but reasonable limit like KMALLOC_MAX_SIZE on the
> > sysctls and see if this sticks.

> adding Stanislav. I think he's looking into this already.
Yeah, I'm looking at it from the get/setsockopt point of view.
I'm currently trying to bypass allocating a buffer if it's greater
than PAGE_SIZE.
I suppose for sysctls we should try to do something similar?
