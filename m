Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44675C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A97206E9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585893500;
	bh=7gcqDIZM2nvAfzK//P3VgUEssxiK6FFUW3QDvlcXYWI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jyQZDF5GDNaww/FPuLy6/cvYd+RpCoIZO9v86t7Nbg43GKo9hR2oEsyH17iIGr972
	 0a1HUQZe8+VxtzKC7YS3+eBcdReNfaO8OVy46g18gxCPmD9yosn+ptwlWtIyt/oHUi
	 8sq2XWqR2P6Ay6boV7B8h3IlDLSzSWsUG6HKMGAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732784AbgDCF6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 01:58:17 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:27849 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729349AbgDCF6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 01:58:17 -0400
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 0335vv2M032130;
        Fri, 3 Apr 2020 14:57:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 0335vv2M032130
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1585893478;
        bh=EauiOmcsg1tATmXp9SYcg/opN412JjjoRaNrMk4wkYs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MiT2I4Gf6yQXBlahGR2e51hcMDifnvDtlga+cJRwgxBLgXU0mhFNs7VMIVDh6kxSm
         4To1F1uko7JHV6uArqU+/D+UYb8ZdTgt9X+547QQuNbbncB7PreNnS5Q/xueFsLEQD
         q5ydCw1TzTVDvPohS0w/g9HXskG5BR83LDJ0bqw2YDtEIJCp95VDAcz9KEMPD77bRz
         awraRmyCo/h9SJxZFrFUxkPsr7yi78yJQBOxo94CZ/Pl1GiR1FkcQIQGANRF7/BUug
         zG4lJhyRX6ltUL3sotpDEgatJvqCFIXi/jjqpQizu6xE8KiKpWJQkGeGiWodxtUj6v
         PPCQPSQcfYGkQ==
X-Nifty-SrcIP: [209.85.221.173]
Received: by mail-vk1-f173.google.com with SMTP id b187so1687502vkh.12;
        Thu, 02 Apr 2020 22:57:57 -0700 (PDT)
X-Gm-Message-State: AGi0Pubc5qycHO9lkQwDF47hRA4DPBiCutym0/kAc/Qn5uw4gzjxkqKS
        GCG5qAYtL75P6J9bE8C3ReZBsLtvH1dxMEBs6mQ=
X-Google-Smtp-Source: APiQypJlUG8LSYIid8JBWOaho2mXzKabqwJpGDBTp1vS3AtKoLS0qgKztRjzYQLbJ4xGsI7r0wGmvCzN5JFFwIWOBds=
X-Received: by 2002:a1f:3649:: with SMTP id d70mr4923181vka.12.1585893476720;
 Thu, 02 Apr 2020 22:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200220110807.32534-1-masahiroy@kernel.org> <CAK7LNARHBfp=gkVO9q3pC9o_w9PgNW=5AP95s1MR1tHLJV=0fg@mail.gmail.com>
In-Reply-To: <CAK7LNARHBfp=gkVO9q3pC9o_w9PgNW=5AP95s1MR1tHLJV=0fg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 3 Apr 2020 14:57:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQuOF-DcA7v3Uy-7hdVeT5hDuatGg6FY9TgG10T3OBr0w@mail.gmail.com>
Message-ID: <CAK7LNAQuOF-DcA7v3Uy-7hdVeT5hDuatGg6FY9TgG10T3OBr0w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sparc,x86: vdso: remove meaningless undefining CONFIG_OPTIMIZE_INLINING
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 4:20 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Hi Andrew,
>
> Ping.
> Could you pick up this series?
>
>
> Thanks.
>
>
> On Thu, Feb 20, 2020 at 8:08 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > The code, #undef CONFIG_OPTIMIZE_INLINING, is not working as expected
> > because <linux/compiler_types.h> is parsed before vclock_gettime.c
> > since 28128c61e08e ("kconfig.h: Include compiler types to avoid missed
> > struct attributes").
> >
> > Since then, <linux/compiler_types.h> is included really early by
> > using the '-include' option. So, you cannot negate the decision of
> > <linux/compiler_types.h> in this way.
> >
> > You can confirm it by checking the pre-processed code, like this:
> >
> >   $ make arch/x86/entry/vdso/vdso32/vclock_gettime.i
> >
> > There is no difference with/without CONFIG_CC_OPTIMIZE_FOR_SIZE.
> >
> > It is about two years since 28128c61e08e. Nobody has reported a
> > problem (or, nobody has even noticed the fact that this code is not
> > working).
> >
> > It is ugly and unreliable to attempt to undefine a CONFIG option from
> > C files, and anyway the inlining heuristic is up to the compiler.
> >
> > Just remove the broken code.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>



I think adding the patch author to Cc:
is strange.



The footer of 6290b47e9aa282c11f38390931b06402c553dbc4
looks like this.


    Link: http://lkml.kernel.org/r/20200220110807.32534-1-masahiroy@kernel.org
    Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
    Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
    Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
    Cc: Arnd Bergmann <arnd@arndb.de>
    Cc: Ingo Molnar <mingo@redhat.com>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: Masahiro Yamada <masahiroy@kernel.org>
    Cc: Borislav Petkov <bp@alien8.de>
    Cc: "H. Peter Anvin" <hpa@zytor.com>
    Cc: David Miller <davem@davemloft.net>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>



"Cc: Masahiro Yamada <masahiroy@kernel.org>"
is unneeded since I am the author.



-- 
Best Regards
Masahiro Yamada
