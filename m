Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02766C33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 04:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE440214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 04:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OxFJ5+uP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387626AbgAMEdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 23:33:51 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33584 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387540AbgAMEdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 23:33:51 -0500
Received: by mail-ot1-f65.google.com with SMTP id b18so7816419otp.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 20:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0SADaU9gu70a2Bm0Kanw0/QkZVrOHiIb+3LRKLBcUWk=;
        b=OxFJ5+uPpMQkwvT9Qje5xmITqR1pEl3memtQG8Of66iLLXIir/M+praEuySJUPpWqx
         B7k8EbjZfdkqQtjY7IOgRq/+bLOoJw0+Spj1+UCP9x0BoGO+r6hPIyQ9fl/tDsd1miBa
         RD7OyyUJkbYPcTYY11AR32jO97qb5LBnOc6cysWfFY761YIxTiErD/jyiKNnNneKy8Ek
         VJ8n3eNNluAdNyiiQrPSN050ayi1RvZbWNM07Dwfo+GwlQrh4LBz2p+loFt7Ezh9PzS5
         hRO1OvgiH8Xrlt5JLkPpxi2yPu9JEOjmeygncihU08HnpWE6Bz4mej+gZFrOGt7W+9CS
         eUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0SADaU9gu70a2Bm0Kanw0/QkZVrOHiIb+3LRKLBcUWk=;
        b=dZ3hqufn/hUBOuAMi/2vlpM2A7trHZEdHvzMOPPPDbpVGmOjEmOGp1/Vkf2eZgbd0f
         TegEmRDVMYTYKpz6F7K6FU4nsqGltctdjglVZYXGAOFbGy9rZaM8Jrf2BxBwZTSdzvP4
         UsFXbtpfeTYiJ9bG+jaD6PSCy5/NHeSIu0ThbvIizMRiwqdlRUgqh2i+tBUCvsBIvr2j
         Gx22o+KZcp6XrJxoQV5h8diQUk63cpNAxHH4oYF939l55bTu/yg4Ot/Ta2lOQE1fBx2f
         u0VnHowgD4z4PZRl+D7daDitHLgVQbbJVM1eE3MXQ95B2uFNyXop2maMb7rtp9Y0YlDu
         bPzQ==
X-Gm-Message-State: APjAAAWJen2/FMIvgI9RiqQj74wHjWWpTMXHZrJbaKvKmtLb+2vkA/Zf
        yhbqgW+u5/N8HIb6U/FwsrNNhN3wBch1gLZRtgiioeGmU18=
X-Google-Smtp-Source: APXvYqzKKJLKVTUSZcp0sj2AT+aiCvmTg5KUl6YAuMPe9/ClQhmL25Wu+pX1UtlR8rzIUjHdZZAxcUMMWVH9uWU1+Sw=
X-Received: by 2002:a9d:2c68:: with SMTP id f95mr12075160otb.33.1578890030841;
 Sun, 12 Jan 2020 20:33:50 -0800 (PST)
MIME-Version: 1.0
References: <a367af4d-7267-2e94-74dc-2a2aac204080@ghiti.fr>
 <20191018105657.4584ec67@canb.auug.org.au> <20191028110257.6d6dba6e@canb.auug.org.au>
 <mhng-0daa1a90-2bed-4b2e-833e-02cd9c0aa73f@palmerdabbelt-glaptop> <d5d59f54-e391-3659-d4c0-eada50f88187@ghiti.fr>
In-Reply-To: <d5d59f54-e391-3659-d4c0-eada50f88187@ghiti.fr>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 13 Jan 2020 12:33:40 +0800
Message-ID: <CANXhq0pn+Nq6T5dNyJiB6xvmqTnPSzo8sVfqHhGyWUURY+1ydg@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the bpf-next tree
To:     Alexandre Ghiti <alexandre@ghiti.fr>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, daniel@iogearbox.net,
        ast@kernel.org, netdev@vger.kernel.org, linux-next@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2020 at 10:31 PM Alexandre Ghiti <alexandre@ghiti.fr> wrote:
>
>
> On 1/10/20 7:20 PM, Palmer Dabbelt wrote:
> > On Fri, 10 Jan 2020 14:28:17 PST (-0800), alexandre@ghiti.fr wrote:
> >> Hi guys,
> >>
> >> On 10/27/19 8:02 PM, Stephen Rothwell wrote:
> >>> Hi all,
> >>>
> >>> On Fri, 18 Oct 2019 10:56:57 +1100 Stephen Rothwell
> >>> <sfr@canb.auug.org.au> wrote:
> >>>> Hi all,
> >>>>
> >>>> After merging the bpf-next tree, today's linux-next build (powerpc
> >>>> ppc64_defconfig) produced this warning:
> >>>>
> >>>> WARNING: 2 bad relocations
> >>>> c000000001998a48 R_PPC64_ADDR64 _binary__btf_vmlinux_bin_start
> >>>> c000000001998a50 R_PPC64_ADDR64 _binary__btf_vmlinux_bin_end
> >>>>
> >>>> Introduced by commit
> >>>>
> >>>>    8580ac9404f6 ("bpf: Process in-kernel BTF")
> >>> This warning now appears in the net-next tree build.
> >>>
> >>>
> >> I bump that thread up because Zong also noticed that 2 new
> >> relocations for
> >> those symbols appeared in my riscv relocatable kernel branch following
> >> that commit.
> >>
> >> I also noticed 2 new relocations R_AARCH64_ABS64 appearing in arm64
> >> kernel.
> >>
> >> Those 2 weak undefined symbols have existed since commit
> >> 341dfcf8d78e ("btf: expose BTF info through sysfs") but this is the fact
> >> to declare those symbols into btf.c that produced those relocations.
> >>
> >> I'm not sure what this all means, but this is not something I expected
> >> for riscv for
> >> a kernel linked with -shared/-fpie. Maybe should we just leave them to
> >> zero ?
> >>
> >> I think that deserves a deeper look if someone understands all this
> >> better than I do.
> >
> > Can you give me a pointer to your tree and how to build a relocatable
> > kernel?
> > Weak undefined symbols have the absolute value 0,
>
>
> So according to you the 2 new relocations R_RISCV_64 are normal and
> should not
> be modified at runtime right ?
>
>
> > but the kernel is linked at
> > an address such that 0 can't be reached by normal means.  When I added
> > support
> > to binutils for this I did it in a way that required almost no code --
> > essetially I just stopped dissallowing x0 as a possible base register
> > for PCREL
> > relocations, which results in 0 always being accessible.  I just
> > wanted to get
> > the kernel to build again, so I didn't worry about chasing around all the
> > addressing modes.  The PIC/PIE support generates different relocations
> > and I
> > wouldn't be surprised if I just missed one (or more likely all) of them.
> >
> > It's probably a simple fix, though I feel like every time I say that
> > about the
> > linker I end up spending a month in there...
>
> You can find it here:
>
> https://github.com/AlexGhiti/riscv-linux/tree/int/alex/riscv_relocatable_v1
>
> Zong fixed the bug introduced by those 2 new relocations and everything
> works
> like a charm, so I'm not sure you have to dig in the linker :)
>

I'm not quite familiar with btf, so I have no idea why there are two
weak symbols be added in 8580ac9404f6 ("bpf: Process in-kernel BTF")
as well, According on relocation mechanism, maybe it is unnecessary to
handle weak undefined symbol at this time, because there is no
substantive help to relocate the absolute value 0. I just simply
ignore the non-relative relocation types to make processing can go
forward, and it works for me based on v5.5-rc5.

> Alex
>
