Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36078C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0FB520849
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589936109;
	bh=/WRbqgr69Owc1uGYRjM9oJ4jDke4SdZIBLYILg0ZDDE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=V/Q4bu1ZUs18UipXLjWx15wkPXp9C9rnL0Zl6dhfzviP+hxf1Fbbd6cLeiIHQk1Mn
	 +te7rr81EpHSj4gk5ikOreW+E1NTilwVWZcfU9V1UdMdlKm2rpjszHPsT5d445hS2d
	 ykfvcKylxct5vI6C8aL7d5hQAal04cwZot7oGsQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgETAzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 20:55:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgETAzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:55:07 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3E3720884
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 00:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589936107;
        bh=/WRbqgr69Owc1uGYRjM9oJ4jDke4SdZIBLYILg0ZDDE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t0hfJFzWfq/w6UG6MnwL6b5jOzIYBCpP8UsZY6guk3UyHqpOX4JVfHwqCChgE5Z0b
         aHx0UuiSn6eMFx/rpB9pmUo3L+vycvQoTUOUDprwE0psWvSLlvvyMO8+Cp4PP+Lhu4
         QVzlwQQWs2Ab7sfaLmg1OdWQcoMjgXfvWXECEulU=
Received: by mail-wm1-f45.google.com with SMTP id m12so1023862wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:55:06 -0700 (PDT)
X-Gm-Message-State: AOAM532SdIYq8BNu123SEkBAUgTL6FWIlQG114PqXDaNQG6CphYp8TVH
        Nb+vd6htdGNTs2+7y0CKe9aaQRh9llvFIkBkpLrMnw==
X-Google-Smtp-Source: ABdhPJwJwaCkZlr2MYt/p3ZTG0yXTRqUNAusJOoe+xukvCPr154ovSOsR0VY7ftqzBayRhK/FUuhHMe64IUxXED3Qhk=
X-Received: by 2002:a05:600c:2299:: with SMTP id 25mr2053994wmf.138.1589936105183;
 Tue, 19 May 2020 17:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200519143815.cpsd2xfx2kl3khsq@wrt> <2330FAB4-A6CE-49E7-921C-B7D55763BDED@codeweavers.com>
 <20200519194320.GA25138@ranerica-svr.sc.intel.com>
In-Reply-To: <20200519194320.GA25138@ranerica-svr.sc.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 May 2020 17:54:53 -0700
X-Gmail-Original-Message-ID: <CALCETrXxYjrMoenqyxEoBmcitHY22tfpJQAzvS=iF_5+SEZa4w@mail.gmail.com>
Message-ID: <CALCETrXxYjrMoenqyxEoBmcitHY22tfpJQAzvS=iF_5+SEZa4w@mail.gmail.com>
Subject: Re: umip: AMD Ryzen 3900X, pagefault after emulate SLDT/SIDT instruction
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Brendan Shanks <bshanks@codeweavers.com>,
        Andreas Rammhold <andi@notmuch.email>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jason Yan <yanaijie@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 12:43 PM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> On Tue, May 19, 2020 at 11:56:40AM -0700, Brendan Shanks wrote:
> >
> > > On May 19, 2020, at 7:38 AM, Andreas Rammhold <andi@notmuch.email> wr=
ote:
> > >
> > > Hi,
> > >
> > > I've been running into a weird problem with UMIP on a current Ryzen
> > > 3900x with kernel 5.6.11 where a process receives a page fault after =
the
> > > kernel handled the SLDT (or SIDT) instruction (emulation).
> > >
> > > The program I am running is run through WINE in 32bit mode and tries =
to
> > > figure out if it is running in a VMWare machine by comparing the resu=
lts
> > > of SLDT against well known constants (basically as shown in the
> > > [example] linked below).
> > >
> > > In dmesg I see the following log lines:
> > >> [99970.004756] umip: Program.exe[3080] ip:4373fb sp:32f3e0: SIDT ins=
truction cannot be used by applications.
> > >> [99970.004757] umip: Program.exe[3080] ip:4373fb sp:32f3e0: For now,=
 expensive software emulation returns the result.
> > >> [99970.004758] umip: Program.exe[3080] ip:437415 sp:32f3e0: SLDT ins=
truction cannot be used by applications.
> > >
> > > Following that the process terminates with a page fault:
> > >> Unhandled exception: page fault on read access to 0xffffffff in 32-b=
it code (0x0000000000437415).
> > >
> > > Assembly at that address:
> > >> 0x0000000000437415: sldt    0xffffffe8(%ebp)
> > >
> > > Running the same executable on the exact same kernel (and userland) b=
ut
> > > on a Intel i7-8565U doesn't crash at this point. I am guessing the
> > > emulation is supposed to do something different on AMD CPUs?
>
> I am surprised you don't see it on the Intel processor. Maybe it does
> not have UMIP. Do you see umip when you do
>
> $ grep umip /proc/cpuinfo
>
> ?
> > >
> > > On the Ryzen the code executes successfully after setting CONFIG_X86_=
UMIP=3Dn.
> >
> > Hi Andreas,
> >
> > The problem is that the kernel does not emulate/spoof the SLDT instruct=
ion, only SGDT, SIDT, and SMSW.
> > SLDT and STR weren't thought to be commonly used, so emulation/spoofing=
 wasn=E2=80=99t added.
> > In the last few months I have seen reports of one or two (32-bit) Windo=
ws games that use SLDT though.
> > Can you share more information about the application you=E2=80=99re run=
ning?
> >
> > Maybe the best path is to add kernel emulation/spoofing for SLDT and ST=
R on 32 and 64-bit, just to cover all the cases. It should be a pretty simp=
le patch, I=E2=80=99ll start working on it.
>
> I have a patch for this already that I wrote for testing purposes:
>
> https://github.com/ricardon/tip/commit/1692889cb3f8accb523d44b682458e234b=
93be50
>
> Perhaps it can be used as a starting point? Not sure what the spoofing
> value should be, though. Perhaps 0?

Possibly SLDT should return nonzero if there's an LDT.

--Andy
