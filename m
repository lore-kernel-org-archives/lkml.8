Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05750C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95072073E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LQVkXCgl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgCXQW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:22:59 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:32801 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727466AbgCXQW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:22:58 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id f6c0b006
        for <linux-kernel@vger.kernel.org>;
        Tue, 24 Mar 2020 16:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :in-reply-to:references:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=6YBBMLagXJVMqR/kaf/lmuS3UsY=; b=LQVkXC
        glYiCoYlBRH3u23tCa6olWZS7oAMxrf1EUJ+4ZoHoLWz8grcWGtHZpXznAGG3OXh
        E2D9gbUCtdNrubKdmsqq6+DOCsqUZSoTFxbUh92cMvCZC7b433lgV0SlINg4w706
        AR+ehAVpO56b4v6RhY6uNbXgJol5JMu8km+JJqFCPfOCT2S3ziA4IQ2j4b413mr5
        9tPYtGE1RaZmtD7gmttl68sQ/AtmoB3zygkRbCONU2qQM4wprUncCqDJXlpbWhDk
        MtbQpUQ7BXvztsgN8N2tdczqMok0xKogXoXB+w5f7g5cPCUAKhC8Kl1shj5buDwq
        ypbEOF6J64/VSUng==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d49e114d (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 24 Mar 2020 16:15:47 +0000 (UTC)
Received: by mail-il1-f177.google.com with SMTP id a6so4909197ilr.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 09:22:55 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1gJ7O6zjucP010xRqXEALHuNGrD8rSKUkPXm2hiTtx9x2/EG35
        MysMQAW67Zi0nCBwZMdfjKeqWpPx8TOGbqGfyHk=
X-Google-Smtp-Source: ADFU+vsFqqnmJTTiKkfZMCoa9Z/xdvD9PtcGU+NpmWceFZznLHpkFt0cyYRjSU0HCaD4eZZu95pqLX7r7lbOgQwivk8=
X-Received: by 2002:a92:cc8c:: with SMTP id x12mr27831745ilo.224.1585066974850;
 Tue, 24 Mar 2020 09:22:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6e02:4c4:0:0:0:0 with HTTP; Tue, 24 Mar 2020 09:22:53
 -0700 (PDT)
In-Reply-To: <20200324091437.GB22931@zn.tnic>
References: <20200113161310.GA191743@rani.riverdale.lan> <20200113195337.604646-1-nivedita@alum.mit.edu>
 <202001131750.C1B8468@keescook> <20200114165135.GK31032@zn.tnic>
 <20200115002131.GA3258770@rani.riverdale.lan> <20200115122458.GB20975@zn.tnic>
 <20200316160259.GN26126@zn.tnic> <20200323204454.GA2611336@zx2c4.com>
 <202003231350.7D35351@keescook> <CAK7LNARMBkc666kZ9jOG9sSThzA69JvKi++WZXMtCP9ddyqcBw@mail.gmail.com>
 <20200324091437.GB22931@zn.tnic>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 24 Mar 2020 10:22:53 -0600
X-Gmail-Original-Message-ID: <CAHmME9q2VuhN+Dhi-nzuJKPjXo8dZq013cZ-0x0t9StZFXCAJQ@mail.gmail.com>
Message-ID: <CAHmME9q2VuhN+Dhi-nzuJKPjXo8dZq013cZ-0x0t9StZFXCAJQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation/changes: Raise minimum supported binutils
 version to 2.23
To:     Borislav Petkov <bp@alien8.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        torvalds@linux-foundation.org, Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Michael Matz <matz@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/20, Borislav Petkov <bp@alien8.de> wrote:
> On Tue, Mar 24, 2020 at 06:02:02PM +0900, Masahiro Yamada wrote:
>> Borislav,
>>
>> When I forwarded this patch, I fixed up one more line.
>> (changes.rst duplicates the same information...)
>>
>> Please see this. I hope this should be OK.
>> https://lore.kernel.org/patchwork/patch/1214519/
>
> Thanks.
>
> However, I wanted to queue this patch *after* 5.7-rc1 and so that it
> lands in 5.8

Both Kees and I were pretty positive yesterday about getting this done
in 5.7, now. I don't think that filing these away in some subsystem
tree will actually result in any more bugs being shaken out, than if
we just do this at the very very beginning of the 5.7 cycle.
