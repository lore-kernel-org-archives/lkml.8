Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F030C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 04:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A17C206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 04:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDCp65Qb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgCME66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 00:58:58 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37498 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCME65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 00:58:57 -0400
Received: by mail-qk1-f196.google.com with SMTP id z25so5625923qkj.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 21:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gvcwP0UHoMVWXeJ3fuuNvnd4efF/A4Bf6yHUFZnfpGE=;
        b=pDCp65Qbjnurw1GSLd6o/SFMfSlTuamCqWHClGCldw6SMjcr7Bre0kgL5c+tXB9zBQ
         dOJJ7iOq6kGoZpGbpqofVdvRB1zfFDlViBPlwUixNUrUL0vBasTcGq/3SFkRugNWor75
         STTJ79QPMhfzawYYwOdS2W0HIiCHdrEZvUBHPrYhbi52CZhBFiPe+0w6n1jIK3iPnxtj
         /sEBK9x/CNCW7jdeMwPMdEyOBI9P2VDRmc6WUuW89qKi+IAayT/7+iIH/i9JURBA2IZR
         Oii1J3EstPM/ECss/V2LZ32zMQpvHJzre/NYv/i3PHTYZHawSst2nuY96UsIdgAmJ1zH
         DNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=gvcwP0UHoMVWXeJ3fuuNvnd4efF/A4Bf6yHUFZnfpGE=;
        b=gQBccvhUjJyeK2Te8A5t7AtNBUBL6nDaoaIaWIVsNwqeBjiRjurtNVoRaYanCEK7xP
         SOgiedhg093sq+o1pBB3YtAT/6gcv3a9/nQG6WZfKwL3yQvZa8ghwCldmo4opYvQ+dCP
         rK7uB7I3+XIP5tf9bTYrHdTJxcgmjmkL92XUIEr5wemfh+rE4rWLC+gzTjnPAyq/JoqF
         VOZDb2dwlvyMsANfyRvmCaLJpfIEa2mk45mG9jq8WvJA8cJiFZ6zXkaSE9ftZHGOOCpS
         ihNyKifWsaWMl9vKJh3iL08eOh3soxkk/+mguthBimly4UuaBEbt5NUzDGOAgK6pZA7z
         Kozg==
X-Gm-Message-State: ANhLgQ3V852JVSq9WUFJyxbYl4hfxO69+GEwskoeUeGT+dF0IlxLbKVs
        gY/Kn4qEIhOwX/3wSyHoFlc=
X-Google-Smtp-Source: ADFU+vsSGRbOKJuy/I04Kmv9tCAf6Mmti/3xNA80YDRdvrWzzIfjF2XoXWsAww7p74JjyWpI36EFlA==
X-Received: by 2002:a37:884:: with SMTP id 126mr10844838qki.72.1584075536075;
        Thu, 12 Mar 2020 21:58:56 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id i28sm29954855qtc.57.2020.03.12.21.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 21:58:55 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 13 Mar 2020 00:58:54 -0400
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
Message-ID: <20200313045853.GA1172167@rani.riverdale.lan>
References: <20200311214601.18141-1-hdegoede@redhat.com>
 <20200311214601.18141-3-hdegoede@redhat.com>
 <20200312001006.GA170175@rani.riverdale.lan>
 <3d58e77d-41e5-7927-fe84-4c058015e469@redhat.com>
 <20200312114225.GB15619@zn.tnic>
 <899f366e-385d-bafa-9051-4e93dc9ba321@redhat.com>
 <20200312125032.GC15619@zn.tnic>
 <20200313044235.GA1159234@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200313044235.GA1159234@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 12:42:36AM -0400, Arvind Sankar wrote:
> On Thu, Mar 12, 2020 at 01:50:39PM +0100, Borislav Petkov wrote:
> > On Thu, Mar 12, 2020 at 12:58:24PM +0100, Hans de Goede wrote:
> > > My version of this patch has already been tested this way. It is
> > 
> > Tested with kexec maybe but if the 0day bot keeps finding breakage, that
> > ain't good enough.
> > 
> > > 1. Things are already broken, my patch just exposes the brokenness
> > > of some configs, it is not actually breaking things (well it breaks
> > > the build, changing a silent brokenness into an obvious one).
> > 
> > As I already explained, that is not good enough.
> > 
> > > 2. I send out the first version of this patch on 7 October 2019, it
> > > has not seen any reaction until now. So I'm sending out new versions
> > > quickly now that this issue is finally getting some attention...
> > 
> > And that is never the right approach.
> > 
> > Maintainers are busy as hell so !urgent stuff gets to wait. Spamming
> > them with more patchsets does not help - fixing stuff properly does.
> > 
> > So, to sum up: if Arvind's approach is the better one, then we should do
> > that and s390 should be fixed this way too. And all tested. And we will
> > remove the hurry element from it all since it has not been noticed so
> > far so it is not urgent and we can take our time and fix it properly.
> > 
> > Ok?
> > 
> > Thx.
> > 
> > -- 
> > Regards/Gruss,
> >     Boris.
> > 
> > https://people.kernel.org/tglx/notes-about-netiquette
> 
> If I could try to summarize the situation here:
> - the purgatory requires filtering out certain CFLAGS/other settings set
>   for the generic kernel in order to work correctly
> - the patch proposed by Hans de Goede will detect missing filters at
>   build time rather than when kexec is executed
> - the filtering is currently not perfect as demonstrated by issues that
>   0day bot is finding -- but the patchset will find these problems at
>   build time rather than runtime
> - there might be a slight optimization as proposed by me [1] but it
>   might have problems as in [2] even if it seems to work
> 
> I think the patch as of v5 [0] is useful right now, to catch CFLAGS
> additions that aren't currently being filtered correctly. The real
> problem is that there exist CFLAGS that should be used for all source
> files in the kernel, and there are CFLAGS (eg tracing, stack check etc)
> that should only be used for the kernel proper. For special
> compilations, such as boot stubs, vdso's, purgatory we should have the
> generic CFLAGS but not the kernel-proper CFLAGS. The issue currently is
> that these special compilations need to filter out all the flags added
> for kernel-proper, and this is a moving target as more tracing/sanity
> flags get added.  Neither the solution of simply re-initializing CFLAGS
> (which will miss generic CFLAGS) nor trying to filter out CFLAGS (which
> will miss new kernel-proper CFLAGS) works very well. I think ideally
> splitting these into independent variables, i.e. BASE_FLAGS that can be
> used for everything, and KERNEL_FLAGS only to be used for the kernel
> proper is likely eventually the better solution, rather than conflating
> both into KBUILD_CFLAGS.
> 
> But to move forward incrementally, patch v5 is probably the cleanest. My
> suggestion in [1] I'm thinking is changing things significantly for
> kexec, by changing the purgatory from a relocatable object file into an
> actual executable, and might have knock-on implications that need to be
> reviewed and tested carefully before it can be merged, as shown by [2].
> 
> [0] https://lore.kernel.org/lkml/20200312114951.56009-1-hdegoede@redhat.com/
> [1] https://lore.kernel.org/lkml/20200312001006.GA170175@rani.riverdale.lan/
> [2] https://lore.kernel.org/lkml/20200312182322.GA506594@rani.riverdale.lan/

Cc Nick Desaulniers, Nathan Chancellor, Ard Biesheuvel, who've all been
involved in these issue of trying to decide whether to filter out CFLAGS
or recreate them from scratch in various places.
