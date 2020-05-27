Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544E4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B24420787
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DimA/hyo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgE0G1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbgE0G1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:27:01 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B00C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:27:00 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id k18so24787696ion.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=UaQWC80bUQjBJzc1DayNRE/WdGTjwPnpDlHQt30J1Qg=;
        b=DimA/hyoueYC7BmZmiD49l88h+/5JhgPL+ls7+Qbz2z5d9zHwxY7L/AhmGvhNErWy/
         mz4ljIz+OjbnadbD/IG72IyWf8ldryGcGBKmTcv0ZF55xB5j/XhuB9f57/ga51ak8mov
         XGazcvH07XbpMvH6Sc4AGfKXMcTBzuaDAgDpZg9f1xRQSOb8uhGuEJpXE5yFCdi2KhwL
         OgqJ3+md7zGSvezgWg8/74vqprrbduoOp8xetvV3MVc3yZyWDILxFEuAIXJKLX0FK9+g
         98gIcev75v2M9Gf7Vsoyer0HnNb8sWT15mDT3pKth0lodLofzHeZhYliVoNhvuRSTatN
         gLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=UaQWC80bUQjBJzc1DayNRE/WdGTjwPnpDlHQt30J1Qg=;
        b=d60C/tITHGBJ81SV3NE5U86JW8zmvymIuHIpnjrGnCeBUhqohRHoJks+ohXSXo9tkt
         XaETYJd7SrHveMA6M1kY7ydMM9t7SwQE4NmQu5r62ieQV6XdYg0MHCAg40JcUkizDWYu
         g7IemyTsa9siDgmQN4frxFxb6EdmOSVELJqILI0c7GuwREJGDk1KcFu6N95a+uvXfikP
         z0ieA9obGtvnHj1nrt/O8LddAuNdLkQFnCgymgcm3UpR3YdqKyEalQuU2vX1QjtvATo8
         MnXQaWrHP5ayoXoU7meWrjRI6I4KAOjdweOAz/Ue+A0OWqZvtKYoM9U9mQH5MLZZSj2I
         0j8g==
X-Gm-Message-State: AOAM533Vqvdy0t8XnPrias/Kl0/Jq3ItjFrdXGV1oTggag8lFzmmBZgc
        gupfc0lVP+oL/K2YOXn0xPD2J86FixZnLrGUmUU=
X-Google-Smtp-Source: ABdhPJzMFmPUQ83CprWqGnFetJUvDyvcgHHxQ9QWsxQBAnbG1NAFex3RdKAi7jGYMDQuuUkgByjKd2jVxu9OqO9Gsbc=
X-Received: by 2002:a6b:750c:: with SMTP id l12mr20476776ioh.66.1590560819743;
 Tue, 26 May 2020 23:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200524212816.243139-1-nivedita@alum.mit.edu>
 <20200525225918.1624470-1-nivedita@alum.mit.edu> <CA+icZUVa8FhhwHgXn1o_hFmgqFG6-KE1F+qvkdCzQjmSSSDWDw@mail.gmail.com>
 <CAMj1kXHVFgRsbssJQD2C0GZnOgG=rMYbPGJQtiKhSw6sZj5PaA@mail.gmail.com>
 <CA+icZUWyFDgieQswvfhWemzymDh_UiVqH2uH52a+0otcr2Pd4w@mail.gmail.com>
 <CA+icZUVKRZPFX_Q8RRJnFsHrkM5VbiWUEam+6O5XSzgNaqAzPg@mail.gmail.com>
 <20200526144748.GA2190602@rani.riverdale.lan> <CA+icZUUY7a5XGwcQQ511OeoTjOzWbrgF8BZdTrLDK09QWG4hwQ@mail.gmail.com>
 <20200526153636.GD2190602@rani.riverdale.lan>
In-Reply-To: <20200526153636.GD2190602@rani.riverdale.lan>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 27 May 2020 08:26:50 +0200
Message-ID: <CA+icZUVTW=KTRko9Ks5LBx4mcdHhtLsXgyk1_CK2aLt0V4PhPg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] x86/boot: Remove runtime relocations from
 compressed kernel
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 5:36 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Tue, May 26, 2020 at 04:50:38PM +0200, Sedat Dilek wrote:
> > On Tue, May 26, 2020 at 4:47 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Tue, May 26, 2020 at 02:44:29PM +0200, Sedat Dilek wrote:
> > > >
> > > > Are those diffs correct when using "x86/boot: Correct relocation
> > > > destination on old linkers"?
> > > >
> > >
> > > It looks ok, but that patch (and even marking the other symbols .hidden)
> > > should be unnecessary after this series.
> >
> > You mean _bss, _ebss and _end?
> >
> > - Sedat -
>
> Yes. Those .hidden markings are there to ensure that when relocations
> are generated (as they are currently), they're generated as
> R_386_RELATIVE (which uses B+A calculation, with A being the link-time
> virtual address of the symbol, and stored in the relocation field)
> rather than R_386_32 (which uses S+A calculation, and so doesn't work
> without runtime processing). After this patchset there aren't any
> relocations, so while the .hidden markings won't hurt, they won't be
> necessary either.
>

Do you plan a change on this?

- Sedat -
