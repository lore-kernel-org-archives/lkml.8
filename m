Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D809C2BB84
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FFF32080A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="zRJZs7oU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbgIGRzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:55:53 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:54687 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728837AbgIGLWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:22:09 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 4f628d7c
        for <linux-kernel@vger.kernel.org>;
        Mon, 7 Sep 2020 10:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=UWABFLx4gijMUsV+BmYYHu/Lcyw=; b=zRJZs7
        oUMaeEeScrwICugCBu1YfRUqkHjvT9emNZcAU4XVOzOjeraNLMtz5kFGpMSMAf8b
        O3/Sj0ahXeIQXG8VX2uTzElWBs3vMwcPR4lSZWYpke0oYmRYAWu/VUbRPcwlCHQB
        MFnxdc9F2Ow4gEuOuva1SKu3GLz/Zv0xQgOFoN0QIhZ7a7L+jZejrSbaVaqxQhPv
        GG5YIdGszkQhZWKoocLKwkDZAv+Owza8XiX/f/eD20oe82eQXpaTwgEia0njOGIF
        P6mQtoXgdAQIxpHwt2Y2fYkPv9VIS880A9CRn89eBeSX1xk4Qne6ddFoGR/0z3O3
        dRQx8bhiUhnlGPlA==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 17d29926 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 7 Sep 2020 10:46:41 +0000 (UTC)
Received: by mail-io1-f43.google.com with SMTP id j2so13554902ioj.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 04:15:26 -0700 (PDT)
X-Gm-Message-State: AOAM533VBFfVNMotymTlW9/NiH7ojRgjNaHo/o3QqeFTeflCvze73uaQ
        MANHzBkdLrFkvkG3b0y/G4pQNAvafuHb5gn1Abg=
X-Google-Smtp-Source: ABdhPJyeFLoaajrODlKEvO+90b9i+K33pKDViCCGLoXZQUODeyEISoEN1nSxxIuPRrxQSeaoo4TqQyFCyOGfGqoNxIU=
X-Received: by 2002:a6b:b98a:: with SMTP id j132mr16900984iof.67.1599477325901;
 Mon, 07 Sep 2020 04:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200907094843.1949-1-Jason@zx2c4.com> <20200907100647.GB10657@zn.tnic>
 <CAHmME9o_Odo97K7QXKO=konVE-UxR7iBCE5S8uAJgc=kJ2EgsA@mail.gmail.com> <20200907111109.GB16029@zn.tnic>
In-Reply-To: <20200907111109.GB16029@zn.tnic>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 7 Sep 2020 13:15:14 +0200
X-Gmail-Original-Message-ID: <CAHmME9pR5Z+G5Z-+-11Hr2gO+SXY6oVoDF+p0Ox7V1oHNVsBvg@mail.gmail.com>
Message-ID: <CAHmME9pR5Z+G5Z-+-11Hr2gO+SXY6oVoDF+p0Ox7V1oHNVsBvg@mail.gmail.com>
Subject: Re: [PATCH] x86/msr: do not warn on writes to OC_MAILBOX
To:     Borislav Petkov <bp@alien8.de>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        kitsunyan <kitsunyan@airmail.cc>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 7, 2020 at 1:11 PM Borislav Petkov <bp@alien8.de> wrote:
>
> Hi,
>
> On Mon, Sep 07, 2020 at 12:46:35PM +0200, Jason A. Donenfeld wrote:
> > Are you sure that intel-undervolt using OC_MAILBOX from userspace is
> > actually a "misuse"? Should the kernel or kernel drivers actually be
> > involved with the task of underclocking? This seems pretty squarely in
> > the realm of "hobbyists poking and prodding at their CPUs" rather than
> > something made for a kernel driver, right?
>
> The only thing I'm sure is that *if* it makes sense for any driver to
> control something in the hardware over MSRs, it should *not* poke at
> naked MSRs but use a proper interface.
>
> I'd leave it to the people who actually need this interface, to explain
> why they do.
>
> > Also, what was the justification for whitelisting
> > MSR_IA32_ENERGY_PERF_BIAS?
>
> That's:
>
> tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
>
> Once that thing gets converted to a proper interface too, that MSR goes
> off the allowlist too.

Gotcha. So your perspective is that the goal is actually to have no
list at all in the end, because all MSR writes should go through sysfs
interfaces and such, always? I certainly like that goal -- it'd make a
whole lot of CPU functionality a lot more discoverable and easier to
tinker with. In practice, it seems like that's a hard goal to
accomplish, with different MSRs having different semantics and
meanings of different bit offsets, and a great deal of them aren't
actually publicly documented by Intel. Were you hoping to just handle
these piece by piece, and eventually Linux will have a decent
compendium of MSRs? That sure would be nice. Is Intel on board with
that plan?

Jason
