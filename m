Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F3AC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 01:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D280205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 01:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583888457;
	bh=WGmn9XbX98c+gTv43PciiVyTFBGe2hdoDYrb8BxgOLs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=G7mbblQ+zXT1ImFyIlA4drw4sE5ti/Qv4oXx2TmRZUNIvWUpICF7EJaeFmK0oaf3k
	 D2Mywgu3VI2SYNvYzZX/ibXe/3yTobYNcNky5E7YbnQRS7iPOqmxDS4qEvv5hRKupS
	 qMUIJSTS1QCzpnYkHBqq/prcsB1OUToemq/NRgBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgCKBA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 21:00:56 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:47467 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbgCKBA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 21:00:56 -0400
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 02B10l05031935
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:00:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 02B10l05031935
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1583888448;
        bh=KUzkZz+40uH/FoOvp/tZz+GQMOBtVLpt7fPLrvD4dT0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ffFBxNixEWpPLRQvp9jyB0fRgorDhjPhXSwGuCqO95NmlfDgzYweJqbNtHWhfNs+f
         G0M+0qbkk/Cx47CHAKhm86BHZL629y8ZnJU2UJTZIS37qyrMLf8BjZhWwlzcJ9FFpi
         BG6DMS3Kc5PWvveWfF0i0MEAPz4KdqCMHsG/wctCAEddjre8kNbtVzWc3OZhVpJ0yW
         tQyDDb078hM+8cd35X1ERzHi2y9cPXra+oH+AMxDJ7R9po4avpKbyTPhJ0jwC32ukk
         +1Z7g10Ol2xxaHwLywKAs6bOCKBvGw2QFmg/D8h4GLq+p8xZ8bFjhMRiL5prVCnKb0
         83WjCKDoTitQA==
X-Nifty-SrcIP: [209.85.221.174]
Received: by mail-vk1-f174.google.com with SMTP id q8so64323vka.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 18:00:48 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1quN6HDuTdOVl+w5BcFs4pqbWfQARjVikjKTsEAqPMtclagW+3
        ncEf+0rm8dpRDs5PVUn69x0EXa3Q0hydisSzmZk=
X-Google-Smtp-Source: ADFU+vuTbEtm/O3NPmJLiQkkiej5z+7jrqg6qV6ldniovJgwOKtJaQGYnbjHbhQDl5YtFsBc+4idYviNKLxtuSCAV5Y=
X-Received: by 2002:a1f:2f4c:: with SMTP id v73mr576209vkv.12.1583888447027;
 Tue, 10 Mar 2020 18:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200306160206.5609-1-jeyu@kernel.org> <CAK7LNARZ4VgaCa_TiDBG-99amBGTTXTQMs9LsK3nO4k+y-5KDQ@mail.gmail.com>
 <20200309095914.GA18870@linux-8ccs.fritz.box> <CAK7LNARf9CzZ8dcK5O5vxUoncpDdpzSZctd0YuKeWyfDG_cdwA@mail.gmail.com>
 <20200309103935.GB18870@linux-8ccs.fritz.box> <CAK7LNARpJ-FAvCUEH9rrNCiqx5LwRHmWospvRnT-ERQoEGjK-Q@mail.gmail.com>
 <20200309105812.GC18870@linux-8ccs.fritz.box> <CAK7LNAQqMGSkX4Coe+f49SbXT_jkG_Mm4XZ3EJei0_K7SEaLhg@mail.gmail.com>
 <20200310113158.GA4865@linux-8ccs.fritz.box> <20200310155516.GC22995@intel.com>
In-Reply-To: <20200310155516.GC22995@intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 11 Mar 2020 10:00:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQM1WF1rk5H+26J87-jC4ghYvdEs1UQSNy+C87myS94DQ@mail.gmail.com>
Message-ID: <CAK7LNAQM1WF1rk5H+26J87-jC4ghYvdEs1UQSNy+C87myS94DQ@mail.gmail.com>
Subject: Re: [LKP] Re: [PATCH v3 1/2] modpost: rework and consolidate logging interface
To:     Philip Li <philip.li@intel.com>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Matthias Maennich <maennich@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkp@01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 12:56 AM Philip Li <philip.li@intel.com> wrote:
>
> On Tue, Mar 10, 2020 at 12:32:00PM +0100, Jessica Yu wrote:
> > +++ Masahiro Yamada [09/03/20 20:03 +0900]:
> > > On Mon, Mar 9, 2020 at 7:58 PM Jessica Yu <jeyu@kernel.org> wrote:
> > > >
> > > > +++ Masahiro Yamada [09/03/20 19:49 +0900]:
> > > > >On Mon, Mar 9, 2020 at 7:39 PM Jessica Yu <jeyu@kernel.org> wrote:
> > > > >>
> > > > >> Ah, sorry, I mean the kbuild 0-day bot errors. I am just realizing
> > > > >> the 0-day bot emails are not CC'd to lkml. Here is the error I got
> > > > >> from the bot:
> > > > >>
> > > > >> ---
> > > > >>
> > > > >> I love your patch! Yet something to improve:
> > > > >>
> > > > >> [auto build test ERROR on linus/master]
> > > > >> [also build test ERROR on v5.6-rc4 next-20200306]
> > > > >> [if your patch is applied to the wrong git tree, please drop us a note to help
> > > > >> improve the system. BTW, we also suggest to use '--base' option to specify the
> > > > >> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> > > > >>
> > > > >> url:    https://github.com/0day-ci/linux/commits/Jessica-Yu/modpost-rework-and-consolidate-logging-interface/20200307-052346
> > > > >> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 30fe0d07fd7b27d41d9b31a224052cc4e910947a
> > > > >> config: sh-randconfig-a001-20200306 (attached as .config)
> > > > >> compiler: sh4-linux-gcc (GCC) 7.5.0
> > > > >> reproduce:
> > > > >>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > > > >>         chmod +x ~/bin/make.cross
> > > > >>         # save the attached .config to linux build tree
> > > > >>         GCC_VERSION=7.5.0 make.cross ARCH=sh
> > > > >>
> > > > >> If you fix the issue, kindly add following tag
> > > > >> Reported-by: kbuild test robot <lkp@intel.com>
> > > > >>
> > > > >> All errors (new ones prefixed by >>):
> > > > >>
> > > > >> >> ERROR: modpost: "adc_single" [arch/sh/boards/mach-hp6xx/hp6xx_apm.ko] undefined!
> > > > >
> > > > >
> > > > >Indeed, this one is odd.
> > > > >I have no idea...
> > > >
> > > > I've pushed the patches to a branch to let the kbuild bot run through its
> > > > build tests again, and if I have extra time today I will try to
> > > > reproduce this and let you know the results.
> > > >
> > > > Thanks,
> > > >
> > > > Jessica
> > >
> > >
> > > Ah, Now I see.
> > >
> > >
> > > Because you added "modpost:" prefix.
> > >
> > >
> > >
> > > The previous error message:
> > >
> > > ERROR: "adc_single" [arch/sh/boards/mach-hp6xx/hp6xx_apm.ko] undefined!
> > >
> > >
> > > The new error message:
> > >
> > > ERROR: modpost: "adc_single" [arch/sh/boards/mach-hp6xx/hp6xx_apm.ko] undefined!
> > >
> > >
> > >
> > > So, the bot assumed it was a new error.
> >
> > Nice catch! Hm, I suppose we need to let the LKP folks know about the
> > change in error message. CC'd LKP mailing list.
> Thanks for the info, we will look into this to handle the
> changed error.
>
> >
> > Jessica
> > _______________________________________________
> > LKP mailing list -- lkp@lists.01.org
> > To unsubscribe send an email to lkp-leave@lists.01.org



Could you improve the report by adding more context?

Currently, only new errors/warnings are shown by '>>'.


If fixed ones had been shown by '<<',
we would have easily noticed that
this was just a matter of message format.

<< ERROR: "adc_single" [arch/sh/boards/mach-hp6xx/hp6xx_apm.ko] undefined!
>> ERROR: modpost: "adc_single" [arch/sh/boards/mach-hp6xx/hp6xx_apm.ko] undefined!




-- 
Best Regards
Masahiro Yamada
