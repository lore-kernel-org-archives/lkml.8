Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2C8C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 05:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB814206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 05:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wi9Tr9pE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgCMFP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 01:15:27 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34820 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgCMFP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 01:15:27 -0400
Received: by mail-qt1-f193.google.com with SMTP id v15so6578903qto.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 22:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bOaIANfcFIltH2ZraJZwMCEBbnf6PS30AO1gqgKPpzE=;
        b=Wi9Tr9pEoD60E7cuCxTfcbsMKLnS3OplDUH6FujkZGlU6s4CuBe5Z2x0uob74c2VaC
         wLpYlW22+5WFeHXd+Acnm9MDtQ5541u/Jlt7kkJ3yFLycUyPTr0yQwDopTR98Rl8glsd
         NCZ9KpQVvYpZzdRihGas7fXwpuYTnP26dUc1FtWH5ywtZFNnkhElX+viQ77cdJ5tKedr
         ZwX+LhJ04jYaFBr6V/hwiP9X+kA/hblZhd+0uZhcdRRxMbZDEXggVByec84C25rYw6BQ
         onzQnmNWefS0u8s1MfVfA/JsbTgOm6H01Rk7ewNSg9nku3KUwFTkikeasv7xAk1kDiNZ
         jCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bOaIANfcFIltH2ZraJZwMCEBbnf6PS30AO1gqgKPpzE=;
        b=Exm72ujYQhN+KsWbupgCbmekGZPiAlghVI/wkLAVJzyI88Vo/mZKs7dAiThQEzAujP
         U1u/pkvKf4YnFlloBR7cDFu7MfggNqLGFOzsfMtpxLUCyvxqZ2+sb0Z0DFzMYHgk+H1A
         RD0X5B/LzY18AaJau2a51HiqSRvSOBv8exjoi+DxlM8ExYchMUzpnGNm2xRChNR6TJp1
         AqMf/p4tZ4z1bLx4hMW9bUZerPJRta7dyXed7IBLejkCWCe7SDkV6+kuJTZVUMc3NKR3
         iOqk1EoPW3riH9Ca9IkpX8OfBl65H/ALwaacaX7za5njDIpwMyNJVK32v/mptGXctotC
         fjZg==
X-Gm-Message-State: ANhLgQ2FGJLem8Q9bGEshuwKu/8b83kTnzNR2n5BJpKBPExbOuLTxxIL
        YzFSo5gRk1I0jI4sgE+XZcA=
X-Google-Smtp-Source: ADFU+vs5JNbLujw3IScsYOjz7BzzXWpU76OPeQNCoNbQDKRcqycJ85NAW0Wt5wvO/HkQ8BTgpCEpWQ==
X-Received: by 2002:ac8:7319:: with SMTP id x25mr3125265qto.96.1584076525253;
        Thu, 12 Mar 2020 22:15:25 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d22sm9434074qte.93.2020.03.12.22.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 22:15:24 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 13 Mar 2020 01:15:23 -0400
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Borislav Petkov <bp@alien8.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v4 2/2] x86/purgatory: Make sure we fail the build if
 purgatory.ro has missing symbols
Message-ID: <20200313051522.GA1177634@rani.riverdale.lan>
References: <20200311214601.18141-1-hdegoede@redhat.com>
 <20200311214601.18141-3-hdegoede@redhat.com>
 <20200312001006.GA170175@rani.riverdale.lan>
 <3d58e77d-41e5-7927-fe84-4c058015e469@redhat.com>
 <20200312114225.GB15619@zn.tnic>
 <899f366e-385d-bafa-9051-4e93dc9ba321@redhat.com>
 <20200312125032.GC15619@zn.tnic>
 <20200313044235.GA1159234@rani.riverdale.lan>
 <20200313045853.GA1172167@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200313045853.GA1172167@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 12:58:54AM -0400, Arvind Sankar wrote:
> On Fri, Mar 13, 2020 at 12:42:36AM -0400, Arvind Sankar wrote:
> > On Thu, Mar 12, 2020 at 01:50:39PM +0100, Borislav Petkov wrote:
> > > On Thu, Mar 12, 2020 at 12:58:24PM +0100, Hans de Goede wrote:
> > > > My version of this patch has already been tested this way. It is
> > > 
> > > Tested with kexec maybe but if the 0day bot keeps finding breakage, that
> > > ain't good enough.
> > > 
> > > > 1. Things are already broken, my patch just exposes the brokenness
> > > > of some configs, it is not actually breaking things (well it breaks
> > > > the build, changing a silent brokenness into an obvious one).
> > > 
> > > As I already explained, that is not good enough.
> > > 
> > > > 2. I send out the first version of this patch on 7 October 2019, it
> > > > has not seen any reaction until now. So I'm sending out new versions
> > > > quickly now that this issue is finally getting some attention...
> > > 
> > > And that is never the right approach.
> > > 
> > > Maintainers are busy as hell so !urgent stuff gets to wait. Spamming
> > > them with more patchsets does not help - fixing stuff properly does.
> > > 
> > > So, to sum up: if Arvind's approach is the better one, then we should do
> > > that and s390 should be fixed this way too. And all tested. And we will
> > > remove the hurry element from it all since it has not been noticed so
> > > far so it is not urgent and we can take our time and fix it properly.
> > > 
> > > Ok?
> > > 
> > > Thx.
> > > 
> > > -- 
> > > Regards/Gruss,
> > >     Boris.
> > > 
> > > https://people.kernel.org/tglx/notes-about-netiquette
> > 
> > If I could try to summarize the situation here:
> > - the purgatory requires filtering out certain CFLAGS/other settings set
> >   for the generic kernel in order to work correctly
> > - the patch proposed by Hans de Goede will detect missing filters at
> >   build time rather than when kexec is executed
> > - the filtering is currently not perfect as demonstrated by issues that
> >   0day bot is finding -- but the patchset will find these problems at
> >   build time rather than runtime
> > - there might be a slight optimization as proposed by me [1] but it
> >   might have problems as in [2] even if it seems to work
> > 
> > I think the patch as of v5 [0] is useful right now, to catch CFLAGS
> > additions that aren't currently being filtered correctly. The real
> > problem is that there exist CFLAGS that should be used for all source
> > files in the kernel, and there are CFLAGS (eg tracing, stack check etc)
> > that should only be used for the kernel proper. For special
> > compilations, such as boot stubs, vdso's, purgatory we should have the
> > generic CFLAGS but not the kernel-proper CFLAGS. The issue currently is
> > that these special compilations need to filter out all the flags added
> > for kernel-proper, and this is a moving target as more tracing/sanity
> > flags get added.  Neither the solution of simply re-initializing CFLAGS
> > (which will miss generic CFLAGS) nor trying to filter out CFLAGS (which
> > will miss new kernel-proper CFLAGS) works very well. I think ideally
> > splitting these into independent variables, i.e. BASE_FLAGS that can be
> > used for everything, and KERNEL_FLAGS only to be used for the kernel
> > proper is likely eventually the better solution, rather than conflating
> > both into KBUILD_CFLAGS.
> > 
> > But to move forward incrementally, patch v5 is probably the cleanest. My
> > suggestion in [1] I'm thinking is changing things significantly for
> > kexec, by changing the purgatory from a relocatable object file into an
> > actual executable, and might have knock-on implications that need to be
> > reviewed and tested carefully before it can be merged, as shown by [2].
> > 
> > [0] https://lore.kernel.org/lkml/20200312114951.56009-1-hdegoede@redhat.com/
> > [1] https://lore.kernel.org/lkml/20200312001006.GA170175@rani.riverdale.lan/
> > [2] https://lore.kernel.org/lkml/20200312182322.GA506594@rani.riverdale.lan/
> 
> Cc Nick Desaulniers, Nathan Chancellor, Ard Biesheuvel, who've all been
> involved in these issue of trying to decide whether to filter out CFLAGS
> or recreate them from scratch in various places.

And just to add, I've personally been involved in two patches to unbreak
the purgatory because of changes that broke it only at runtime, not
build time, which would both have been caught by Hans's patchset.

[1] ca14c996afe7 ("x86/purgatory: Disable the stackleak GCC plugin for the purgatory")
[2] bec500777089 ("lib/string: Make memzero_explicit() inline instead of external")
