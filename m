Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5F8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 21:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77FA02086A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 21:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="DtMjrfPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgGVVGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 17:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgGVVGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 17:06:08 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82317C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 14:06:08 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so3284623wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 14:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pUykGa+mtQ5qLEJzpM6lTm4DyeH44yHQyhTxXONta+M=;
        b=DtMjrfPK33UpsHV7ieVtBoXhLIYg/jlJtL/BwT+t06XPoZuxolm3MZwCr//MnlAhv7
         olpqshFL30eLQy1W2/XqwGp6TQ4RerXlU6stdyUroQWPo3+FNPAxh8fnNdtX7F+nvEDT
         VJ2MTsTfnTkK/RixP0LCc4xF2mzNoGq5Ig8To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pUykGa+mtQ5qLEJzpM6lTm4DyeH44yHQyhTxXONta+M=;
        b=j59DKc/z7gACmBPZG2UjZXD9dUzbF/kMEA+lox5T8Va8P6RqrP27XzoxFi0lneWaFC
         19rA2V/7ARIHO9QyPjxQm2/7AoPgI7XzVtEp/xknCo+ri/MPWdgj7s6qZznWsIJOIZ+g
         hUGIgBsM6BUKFRng5KwNmDd9Sng+rWmtaOBzqLPqwxXcpAQJOXseXhkaQSUvFBiVxE+3
         97Ovqi4bvcoCg6PhcttveHGZXDeOmgM2paGR8Un8JcyZ68HOJn2YUlXKd/dyUb1BOKU8
         5lBG0h40rnLhu6TXQOpHDcpiBm/oQgiiSzeZoTNlCCsCW1yfWpV/SGhnAxo/srdIxMBy
         zYGw==
X-Gm-Message-State: AOAM533NIwrOb3DIgaoyY7I1+rJSX7ImRs6Rh+wIdSzhlmMeI/Pc6xVD
        PUJXIjUBQEWbw6NTgNqvIUc2hzQAm3j/m6ERWxJe
X-Google-Smtp-Source: ABdhPJwhNpZUdU/OnWtik2XTzTS4UMH8jcwWO9Hxmgqgvl3smhQmAYatCRp4hQfaVCyVsPrlT6KIYfciVm1lrAWgeu4=
X-Received: by 2002:a1c:dc02:: with SMTP id t2mr1223465wmg.55.1595451967050;
 Wed, 22 Jul 2020 14:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a34sT2bQbkZUjaxaShzCkn+s35pXxS0UNhqGFu+t2hZYw@mail.gmail.com>
 <mhng-820ebe55-b4a3-4ab3-b848-6d3551b43091@palmerdabbelt-glaptop1> <CAK8P3a2VHXDLK6iba=NxSQ-t=9P7LSwzwx3XrK=N=M+qoX_oeQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2VHXDLK6iba=NxSQ-t=9P7LSwzwx3XrK=N=M+qoX_oeQ@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 22 Jul 2020 14:05:55 -0700
Message-ID: <CAOnJCULmX+vUcpEmBd5w7xjtZSFk=Ju2V=wBJCOXHQ8m9yG9-Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] riscv: Move kernel mapping to vmalloc zone
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Atish Patra <Atish.Patra@wdc.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Linux-MM <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
        Zong Li <zong.li@sifive.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 1:23 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Jul 22, 2020 at 9:52 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > On Wed, 22 Jul 2020 02:43:50 PDT (-0700), Arnd Bergmann wrote:
> > > On Tue, Jul 21, 2020 at 9:06 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > > The eventual goal is to have a split of 3840MB for either user or linear map
> > > plus and 256MB for vmalloc, including the kernel. Switching between linear
> > > and user has a noticeable runtime overhead, but it relaxes both the limits
> > > for user memory and lowmem, and it provides a somewhat stronger
> > > address space isolation.
> >
> > Ya, I think we decided not to do that, at least for now.  I guess the right
> > answer there will depend on what 32-bit systems look like, and since we don't
> > have any I'm inclined to just stick to the fast option.
>
> Makes sense. Actually on 32-bit Arm we see fewer large-memory
> configurations in new machines than we had in the past before 64-bit
> machines were widely available at low cost, so I expect not to see a
> lot new hardware with more than 1GB of DDR3 (two 256Mbit x16 chips)
> for cost reasons, and rv32 is likely going to be similar, so you may never
> really see a need for highmem or the above hack to increase the
> size of the linear mapping.
>
> I just noticed that rv32 allows 2GB of lowmem rather than just the usual
> 768MB or 1GB, at the expense of addressable user memory. This seems
> like an unusual choice, but I also don't see any reason to change this
> or make it more flexible unless actual users appear.
>

I am a bit confused here. As per my understanding, RV32 supports 1GB
of lowmem only
as the page offset is set to 0xC0000000. The config option
MAXPHYSMEM_2GB is misleading
as RV32 actually allows 1GB of physical memory only. Any memory blocks beyond
DRAM + 1GB are removed in setup_bootmem. IMHO, The current config
should clarify that.

Moreover, we should add 2G split under a separate configuration if we
want to support that.

>        Arnd
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
