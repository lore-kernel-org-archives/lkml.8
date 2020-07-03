Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40463C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 16:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C84B2070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 16:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HFayUcis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgGCQGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 12:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgGCQGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 12:06:19 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3BEC061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 09:06:18 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d10so12804331pls.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 09:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1ANmHIkdhdbmMC6rHqZfoECsaO4JBHol4C5IBX2IizU=;
        b=HFayUcisMm2FSwyAwm0jeH6EfqgecuoZbEcpmQ1Tlhse6FsJi3EYaivE6krp6xloYC
         HNwYLi+KdsnWJXNYUEit4+y3jxwfa6ADt35ntvBQuFY8YgJpnvQUhT0Hn3z+FYbxxtY8
         x5vkr++TRvWMgNpIeFUFkdmHedpTth2iV5nGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1ANmHIkdhdbmMC6rHqZfoECsaO4JBHol4C5IBX2IizU=;
        b=ESmE5CRQWOOu3eFdatWezQu9trScHDpJY2v1VLKdI7bn90cIQE/J6fd1/aW8cCiEKz
         w7RohjzYt0tCky4K7lGnsii/TnHzQDevdrodcYDsvNG3asz7ZynrAbCGntbQKDE4O93J
         zyEGrCaseTmCzRXSOLVesMeZsomLgG/68/8rs0J/bkAa5qnCiekpNbSzgZSW/JospC/e
         HOX55sFb+9HsjKQ/2rECHOBZ3tIZ4lUZ2gAH/L2aOVlwlSrd1RtpcpQgFke1oOvCrlxt
         OAgnCUATeqWsG/2tjYrErxmBAKOH4vpGXrzWIQ7Ur2LF0Q3t65QIQqPK6Xrak6G1WBN0
         Orug==
X-Gm-Message-State: AOAM532RgG3KpYEaDHAzsHSPgOXMK9N1oyzIgFA7u1Mhe+pvgSyxn8bE
        ozQlGojijUO5FzlVCH2wqPtNmQ==
X-Google-Smtp-Source: ABdhPJzATCY0zlQlITPUb7+6GxTEQaf1nenGBcqRrCt6ggE605rMppNlg9nKT69BxpP1eotrxfRjVw==
X-Received: by 2002:a17:90a:2465:: with SMTP id h92mr8378801pje.26.1593792378394;
        Fri, 03 Jul 2020 09:06:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y7sm11482823pgk.93.2020.07.03.09.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 09:06:17 -0700 (PDT)
Date:   Fri, 3 Jul 2020 09:06:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Terrell <nickrterrell@gmail.com>,
        Nick Terrell <terrelln@fb.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        linux-kernel@vger.kernel.org, Norbert Lange <nolange79@gmail.com>,
        Chris Mason <clm@fb.com>, linux-kbuild@vger.kernel.org,
        x86@kernel.org, gregkh@linuxfoundation.org,
        Petr Malat <oss@malat.biz>, Kernel Team <Kernel-team@fb.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Patrick Williams <patrickw3@fb.com>, rmikey@fb.com,
        mingo@kernel.org, Patrick Williams <patrick@stwcx.xyz>
Subject: Re: Kernel compression benchmarks
Message-ID: <202007030855.ED7AABDF@keescook>
References: <1588791882.08g1378g67.none.ref@localhost>
 <1588791882.08g1378g67.none@localhost>
 <202007020818.87EA89106@keescook>
 <CA+icZUUBAzBNwqThSF=YS1zg9EVCuSZ-XDc5Pu3NrO6R3Fi2Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUUBAzBNwqThSF=YS1zg9EVCuSZ-XDc5Pu3NrO6R3Fi2Zw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 10:15:20AM +0200, Sedat Dilek wrote:
> On Thu, Jul 2, 2020 at 5:18 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, Jul 01, 2020 at 10:35:48AM -0400, Alex Xu (Hello71) wrote:
> > > ZSTD compression patches have been sent in a number of times over the
> > > past few years. Every time, someone asks for benchmarks. Every time,
> > > someone is concerned about compression time. Sometimes, someone provides
> > > benchmarks.
> >
> > Where's the latest series for this, btw? I thought it had landed. :P It
> > seemed like it was done.
> >
> 
> Hi,
> 
> Again, I would like to see this upstream, too.
> 
> Last I asked for a rebase against Linux v5.8-rc1 or later.
> 
> Beyond above adaptations, the latest series "zstd-v5" of Nick T.s
> patchset needs some addition of zstd to the patch (see [1]):
> 
> commit 8dfb61dcbaceb19a5ded5e9c9dcf8d05acc32294
> "kbuild: add variables for compression tools"
> 
> NOTE:
> "zstd-v5" was against Linux-next 20200408 or download the series from
> patchwork LKML which applies cleanly against Linux v5.7 - last is what
> I did.
> 
> There was a follow-up to the above patch (see [2]):
> 
> commit e4a42c82e943b97ce124539fcd7a47445b43fa0d
> "kbuild: fix broken builds because of GZIP,BZIP2,LZOP variables"

Okay, cool. Yes, now is the right time to send an updated series based
on v5.8-rc2 with any outstanding adjusted/fixes made.

It seems v5 is here?
https://lore.kernel.org/lkml/20200408215711.137639-1-nickrterrell@gmail.com/

That wasn't sent "to" a maintainer, so it likely went unnoticed by either
akpm or the x86 maintainers. I think this should likely go via the x86
tree.

> Nevertheless, this is the kernel-side of doing - user-space like for
> example Debian's initramfs-tools needs adaptations (see [3]).

Right, but the kernel needs to implement the support first. :)

> @Kees: Can you aid Nick T. to get this upstream? You know the
> processes a bit better than me.

Sure; Nick, can you please rebase and handle any issues from v5? With
the result, send a v6 as you did for v5 before, but I would make your
"to" be:

Borislav Petkov <bp@alien8.de>
Thomas Gleixner <tglx@linutronix.de>

and keep the CC as you had it.

-- 
Kees Cook
