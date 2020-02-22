Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E15C35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 23:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA9C2064C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 23:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GKgquhT9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgBVXUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 18:20:53 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33982 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbgBVXUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 18:20:53 -0500
Received: by mail-pl1-f195.google.com with SMTP id j7so2448449plt.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 15:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SCgyQ9eHHbv+RMv6VChalN/zKk5dTdLe/epnyzLq5Ig=;
        b=GKgquhT9Rz+XgDRPEE1q4VXGPcr5n3heGESRTbtAd9yWqkSYrtuaGs+BY4KW4QfHv8
         MEWJZe8IctQI537D4k54tWKkjQQiv6Yhn4P7nv5Nhs7jknhYJGgjYkZHH6kJcpwPb8Ui
         29s2MQROlgaW1Ib5lSAZlYWuReeDIczG8bE//m9Vx4qLl01/mrD91NaaMwel2YwlQzdG
         MSsCiGz/yTwRxw2Yf0B5Wam21cY28Eg/eAiThDOfdalFDtL/cip8HzGalpgxCU2zoBhd
         sMUeyi+p76lE4G99vOgd/RBZ4fO+kRErv3cuJ3fGRRPYMsomyBUMUSQ+uZ4xMaDrdnwS
         mQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SCgyQ9eHHbv+RMv6VChalN/zKk5dTdLe/epnyzLq5Ig=;
        b=pliwbpDv+b4MtWB29C8WEkw/8TSmxMooh6pJ05bqyjFsgiFd0vrsvxFSebhKWd6RaG
         l1A/k3M6GraW+ihH1ce6RKpq1l7u6L90UL9Umk0VEps/0pvayEqi2eDJKPrFtbY3cM9+
         5xULczYoEa+u3WNfullH7WrLXoqrwI4AOh2X/eWQSxmeibbOWfLbR6OWcLVO6mYFyvS1
         ThMm7a4jpFrMEpyZOnDow5xkcyOPcbV/Qd2GCjLgbooRAXg+eojPYA961uqQ0IG2+EyO
         sXLfD54F/6Fkawe6coTyGUuWenDS5GZmb7qbje4IuwduAnpapLInwR3puQnbYYk7w/Qf
         DMNA==
X-Gm-Message-State: APjAAAUDYkDrprAgHxj+h4d3mxhSoqY5DBFBhUaOMK1K4ztPuiV++zao
        d9gOU0h0mucIOaAlsBc852e2ESndS/0H+/xVR9H2Rw==
X-Google-Smtp-Source: APXvYqwFkH1IlvX4pdPt4b1cJaXQJtxu15PiIdSPtAgVWnUX8v1sA+jVqcxWk2ETNI7Ft+FiY0YFaw5ntn729ItGTc4=
X-Received: by 2002:a17:90a:3745:: with SMTP id u63mr11356233pjb.123.1582413652237;
 Sat, 22 Feb 2020 15:20:52 -0800 (PST)
MIME-Version: 1.0
References: <20200109150218.16544-1-nivedita@alum.mit.edu> <20200109150218.16544-2-nivedita@alum.mit.edu>
 <20200222050845.GA19912@ubuntu-m2-xlarge-x86> <20200222065521.GA11284@zn.tnic>
 <20200222070218.GA27571@ubuntu-m2-xlarge-x86> <20200222072144.asqaxlv364s6ezbv@google.com>
 <20200222074254.GB11284@zn.tnic> <20200222162225.GA3326744@rani.riverdale.lan>
In-Reply-To: <20200222162225.GA3326744@rani.riverdale.lan>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Sat, 22 Feb 2020 15:20:39 -0800
Message-ID: <CAKwvOdnvMS21s9gLp5nUpDAOu=c7-iWYuKTeFUq+PMhsJOKUgw@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/boot/compressed: Remove unnecessary sections from bzImage
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Fangrui Song <maskray@google.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michael Matz <matz@suse.de>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 8:22 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Sat, Feb 22, 2020 at 08:42:54AM +0100, Borislav Petkov wrote:
> > On Fri, Feb 21, 2020 at 11:21:44PM -0800, Fangrui Song wrote:
> > > In GNU ld, it seems that .shstrtab .symtab and .strtab are special
> > > cased. Neither the input section description *(.shstrtab) nor *(*)
> > > discards .shstrtab . I feel that this is a weird case (probably even a bug)
> > > that lld should not implement.
> >
> > Ok, forget what the tools do for a second: why is .shstrtab special and
> > why would one want to keep it?
> >
> > Because one still wants to know what the section names of an object are
> > or other tools need it or why?
> >
> > Thx.
> >
> > --
> > Regards/Gruss,
> >     Boris.
> >
> > https://people.kernel.org/tglx/notes-about-netiquette
>
> .shstrtab is required by the ELF specification. The e_shstrndx field in
> the ELF header is the index of .shstrtab, and each section in the
> section table is required to have an sh_name that points into the
> .shstrtab.

Yeah, I can see it both ways.  That `*` doesn't glob all remaining
sections is surprising to me, but bfd seems to be "extra helpful" in
not discarding sections that are required via ELF spec.

Kees is working on a series to just be explicit about what sections
are ordered where, and what's discarded, which should better handle
incompatibilities between linkers in regards to orphan section
placement and "what does `*` mean."  Kees, that series can't come soon
enough. ;) (I think it's intended to help "fine grain" (per function)
KASLR).  More comments in the other thread.

Taken from the Zen of Python, but in regards to sections in linker
scripts, "explicit is better than implicit."
-- 
Thanks,
~Nick Desaulniers
