Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2585C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 02:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 892C820747
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 02:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592101333;
	bh=0JAkCDc+ufxK2P5Y8kYrWkcegiagKbGnUTQPJQBz3mU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HUbPCbEv4VU7UFg2cdjn3WtCCiLS9pHf2GRUbjSGeDh2C4MHBCbYWZp886Gwo0WhG
	 LrjzvHPs2Hn2UD9InuRKUQJQ6iQMe3xKZfuY6XjPaMl4uL0/LBD2eHg7tjWVhbXpVq
	 OZoFFYJ17LLHsHKPbYPh+XhVFqzeYrUVtyY8H6hY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgFNCWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 22:22:12 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:61901 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgFNCWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 22:22:11 -0400
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 05E2Lisg007515
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 11:21:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 05E2Lisg007515
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1592101305;
        bh=bkNCBeYotHt6hVdWI79jzm0i1HG49lYkucSsQujnZdg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HXd0hnmBeVbbUiw4gdx7RDZm/Krurd3oGeP5v6lHp+nbqMh8fqXdiYdYRaXlGEX68
         hHiF0VErRYszXXO7FsCvPz/dGwKZOvSwfcFMPYv1lLjPr/TM86ydzdhsHykb+MTeyk
         EUF5aRwM/15s8Iz3lhxRC9CDpcYxl7m3kSiLrvzClAIWMBLa8Ar47lirOCOu1UzEY7
         lYS1o84xy9Edwcrq0GjO1u14k7X/j3b9po5GYeSsjyLyrzmSopctdIHFKXhowfYt28
         u0HjDXlarLQ8t3xG7p4JdHo0gwJ26n04e6EDJlEK15Z8UHIWAoYv3YH+2sWEAFeM+0
         k2qY7nAmbe8uw==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id q2so7474920vsr.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 19:21:44 -0700 (PDT)
X-Gm-Message-State: AOAM530FDGUh51X8pq1gB5NkZ8LscY0KK4fe4zOVVYfUP7ZgQ4r7xPB9
        kin2JQHGJIS6EZlv0zKj2gBF/yJJiBdbAOOkVyM=
X-Google-Smtp-Source: ABdhPJw0pKuVRnI8PJdW3xi+AUeEJ5GVhq6sIqa6FZMzXuj9FcPx+YAkrXR0B6NS1V1p5je4bZcdVvwSda40fuABke4=
X-Received: by 2002:a67:2d42:: with SMTP id t63mr14751077vst.181.1592101303358;
 Sat, 13 Jun 2020 19:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnddAjiXDKA8fp3n2NN+R=Syp2N5DHbp1j=VRzM1dNnRw@mail.gmail.com>
 <20200611220339.3971675-1-nivedita@alum.mit.edu> <CAKwvOdksFqf11-sdLrvNe4wrRvyAB2mVfwKU4KkNsapSnN_tRw@mail.gmail.com>
In-Reply-To: <CAKwvOdksFqf11-sdLrvNe4wrRvyAB2mVfwKU4KkNsapSnN_tRw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 14 Jun 2020 11:21:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQAZ3PFvvj7M_AYZKo4uwui1DaJyjebWLmpnp-ism_=mQ@mail.gmail.com>
Message-ID: <CAK7LNAQAZ3PFvvj7M_AYZKo4uwui1DaJyjebWLmpnp-ism_=mQ@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: Improve compressed debug info support detection
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Fangrui Song <maskray@google.com>,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 8:39 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Jun 11, 2020 at 3:03 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > Commit
> >   10e68b02c861 ("Makefile: support compressed debug info")
> > added support for compressed debug sections.
> >
> > Support is detected by checking
> > - does the compiler support -gz=zlib
> > - does the assembler support --compressed-debug-sections=zlib
> > - does the linker support --compressed-debug-sections=zlib
> >
> > However, the gcc driver's support for this option is somewhat
> > convoluted. The driver's builtin specs are set based on the version of
> > binutils that it was configured with. It reports an error if the
> > configure-time linker/assembler (i.e., not necessarily the actual
> > assembler that will be run) do not support the option, but only if the
> > assembler (or linker) is actually invoked when -gz=zlib is passed.
> >
> > The cc-option check in scripts/Kconfig.include does not invoke the
> > assembler, so the gcc driver reports success even if it does not support
> > the option being passed to the assembler.
> >
> > Because the as-option check passes the option directly to the assembler
> > via -Wa,--compressed-debug-sections=zlib, the gcc driver does not see
> > this option and will never report an error.
>
> Thanks for expanding on the failure.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>


Applied to linux-kbuild/fixes.
Thanks.





-- 
Best Regards
Masahiro Yamada
