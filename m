Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B30C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1480120863
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K9XNUJGr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbgCCPuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 10:50:06 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33286 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbgCCPuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 10:50:06 -0500
Received: by mail-ed1-f66.google.com with SMTP id c62so5051436edf.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 07:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wUChkrPr5ljfTasjojcfSOHYLssa67n/JsN8CgfdAHE=;
        b=K9XNUJGroYRdDR1ux6pXF7oQJcGzvpLxnCKPCsX26C0Tu9hC5HuWWrFU7srbEOJOL+
         Jk8ookxlAbji14BsL73PDTTF5eIJrpdAnDiCpyDiRGGvFozH6M+B80Uy/Fe1JxlrrsXH
         GRW1RIhoPUEdNvwHY5SmG3qe3uwWBJBypBRAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wUChkrPr5ljfTasjojcfSOHYLssa67n/JsN8CgfdAHE=;
        b=bE3rvOgReC7Pnazg18WSyBuAi7XKoRWf90DiLjPc1LDuC/suX5Lr8CLtuJLUY0SbV+
         YSjQe3gc6dMEBt15lYpkpGcw4XXzC5omE9lPb2X9O0043JGcY95fQFYKsqTKd02N4CML
         qjTiiR+sIJXbrY0RVsKS6iUYsPEJriqhkbdbZmnELoeeabFXEL2XtXMZr74DKdGbElox
         fmJlZHjJiOxOvrAzWvnf26uofVujjr9V3bAvB9eSoD9HgUdXqxGXPLnuWw5MPaHTooJQ
         PtFuR3kbIfoNsWVhdAMi/HbjbAc/K+W6bDX9CkgSY++NjD55xjBiVLjNWLOeNVW6EhV/
         PPKQ==
X-Gm-Message-State: ANhLgQ0qz38K6TnCCuGtkUS40ZgH37w/EKICcKII0nlQofJ9UUHDJXSN
        QbamiKulJN6sMXzW9RAt/BO++4/6rT8=
X-Google-Smtp-Source: ADFU+vttVDtv0P1qbkp8LSK1MIUDonbRRILAUFZjRU0G2DJCROkyT5D8i8vNxsgrcCbKymyDzXFwOQ==
X-Received: by 2002:a05:6402:c02:: with SMTP id co2mr2678858edb.72.1583250604338;
        Tue, 03 Mar 2020 07:50:04 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id m6sm1050164ejb.51.2020.03.03.07.50.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 07:50:04 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id a25so2662611wmm.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 07:50:04 -0800 (PST)
X-Received: by 2002:a7b:c416:: with SMTP id k22mr4837344wmi.88.1583250223087;
 Tue, 03 Mar 2020 07:43:43 -0800 (PST)
MIME-Version: 1.0
References: <20200228000105.165012-1-thgarnie@chromium.org>
 <202003022100.54CEEE60F@keescook> <20200303095514.GA2596@hirez.programming.kicks-ass.net>
In-Reply-To: <20200303095514.GA2596@hirez.programming.kicks-ass.net>
From:   Thomas Garnier <thgarnie@chromium.org>
Date:   Tue, 3 Mar 2020 07:43:31 -0800
X-Gmail-Original-Message-ID: <CAJcbSZH1oON2VC2U8HjfC-6=M-xn5eU+JxHG2575iMpVoheKdA@mail.gmail.com>
Message-ID: <CAJcbSZH1oON2VC2U8HjfC-6=M-xn5eU+JxHG2575iMpVoheKdA@mail.gmail.com>
Subject: Re: [PATCH v11 00/11] x86: PIE support to extend KASLR randomization
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Allison Randal <allison@lohutok.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 3, 2020 at 1:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Mar 02, 2020 at 09:02:15PM -0800, Kees Cook wrote:
> > On Thu, Feb 27, 2020 at 04:00:45PM -0800, Thomas Garnier wrote:
> > > Minor changes based on feedback and rebase from v10.
> > >
> > > Splitting the previous serie in two. This part contains assembly code
> > > changes required for PIE but without any direct dependencies with the
> > > rest of the patchset.
> > >
> > > Note: Using objtool to detect non-compliant PIE relocations is not yet
> > > possible as this patchset only includes the simplest PIE changes.
> > > Additional changes are needed in kvm, xen and percpu code.
> > >
> > > Changes:
> > >  - patch v11 (assembly);
> > >    - Fix comments on x86/entry/64.
> > >    - Remove KASLR PIE explanation on all commits.
> > >    - Add note on objtool not being possible at this stage of the patchset.
> >
> > This moves us closer to PIE in a clean first step. I think these patches
> > look good to go, and unblock the work in kvm, xen, and percpu code. Can
> > one of the x86 maintainers pick this series up?
>
> But,... do we still need this in the light of that fine-grained kaslr
> stuff?
>
> What is the actual value of this PIE crud in the face of that?

If I remember well, it makes it easier/better but I haven't seen a
recent update on that. Is that accurate Kees?
