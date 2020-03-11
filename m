Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CA1C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B698820873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgCKM1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 08:27:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:56820 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728996AbgCKM1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:27:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 05:27:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,540,1574150400"; 
   d="scan'208";a="415547856"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by orsmga005.jf.intel.com with ESMTP; 11 Mar 2020 05:27:26 -0700
Date:   Wed, 11 Mar 2020 20:26:09 +0800
From:   Philip Li <philip.li@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Matthias Maennich <maennich@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkp@01.org
Subject: Re: [LKP] Re: [PATCH v3 1/2] modpost: rework and consolidate logging
 interface
Message-ID: <20200311122609.GL1463@intel.com>
References: <CAK7LNARZ4VgaCa_TiDBG-99amBGTTXTQMs9LsK3nO4k+y-5KDQ@mail.gmail.com>
 <20200309095914.GA18870@linux-8ccs.fritz.box>
 <CAK7LNARf9CzZ8dcK5O5vxUoncpDdpzSZctd0YuKeWyfDG_cdwA@mail.gmail.com>
 <20200309103935.GB18870@linux-8ccs.fritz.box>
 <CAK7LNARpJ-FAvCUEH9rrNCiqx5LwRHmWospvRnT-ERQoEGjK-Q@mail.gmail.com>
 <20200309105812.GC18870@linux-8ccs.fritz.box>
 <CAK7LNAQqMGSkX4Coe+f49SbXT_jkG_Mm4XZ3EJei0_K7SEaLhg@mail.gmail.com>
 <20200310113158.GA4865@linux-8ccs.fritz.box>
 <20200310155516.GC22995@intel.com>
 <CAK7LNAQM1WF1rk5H+26J87-jC4ghYvdEs1UQSNy+C87myS94DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQM1WF1rk5H+26J87-jC4ghYvdEs1UQSNy+C87myS94DQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 10:00:11AM +0900, Masahiro Yamada wrote:
> On Wed, Mar 11, 2020 at 12:56 AM Philip Li <philip.li@intel.com> wrote:
> >
> > On Tue, Mar 10, 2020 at 12:32:00PM +0100, Jessica Yu wrote:
> > > +++ Masahiro Yamada [09/03/20 20:03 +0900]:
> > > > On Mon, Mar 9, 2020 at 7:58 PM Jessica Yu <jeyu@kernel.org> wrote:
> > > > >
> > > > > +++ Masahiro Yamada [09/03/20 19:49 +0900]:
> > > > > >On Mon, Mar 9, 2020 at 7:39 PM Jessica Yu <jeyu@kernel.org> wrote:
> > > > > >>
> > > > > >> Ah, sorry, I mean the kbuild 0-day bot errors. I am just realizing
> > > > > >> the 0-day bot emails are not CC'd to lkml. Here is the error I got
> > > > > >> from the bot:
> > > > > >>
> > > > > >> ---
> > > > > >>
> > > > > >> I love your patch! Yet something to improve:
> > > > > >>
> > > > > >> [auto build test ERROR on linus/master]
> > > > > >> [also build test ERROR on v5.6-rc4 next-20200306]
> > > > > >> [if your patch is applied to the wrong git tree, please drop us a note to help
> > > > > >> improve the system. BTW, we also suggest to use '--base' option to specify the
> > > > > >> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> > > > > >>
> > > > > >> url:    https://github.com/0day-ci/linux/commits/Jessica-Yu/modpost-rework-and-consolidate-logging-interface/20200307-052346
> > > > > >> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 30fe0d07fd7b27d41d9b31a224052cc4e910947a
> > > > > >> config: sh-randconfig-a001-20200306 (attached as .config)
> > > > > >> compiler: sh4-linux-gcc (GCC) 7.5.0
> > > > > >> reproduce:
> > > > > >>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > > > > >>         chmod +x ~/bin/make.cross
> > > > > >>         # save the attached .config to linux build tree
> > > > > >>         GCC_VERSION=7.5.0 make.cross ARCH=sh
> > > > > >>
> > > > > >> If you fix the issue, kindly add following tag
> > > > > >> Reported-by: kbuild test robot <lkp@intel.com>
> > > > > >>
> > > > > >> All errors (new ones prefixed by >>):
> > > > > >>
> > > > > >> >> ERROR: modpost: "adc_single" [arch/sh/boards/mach-hp6xx/hp6xx_apm.ko] undefined!
> > > > > >
> > > > > >
> > > > > >Indeed, this one is odd.
> > > > > >I have no idea...
> > > > >
> > > > > I've pushed the patches to a branch to let the kbuild bot run through its
> > > > > build tests again, and if I have extra time today I will try to
> > > > > reproduce this and let you know the results.
> > > > >
> > > > > Thanks,
> > > > >
> > > > > Jessica
> > > >
> > > >
> > > > Ah, Now I see.
> > > >
> > > >
> > > > Because you added "modpost:" prefix.
> > > >
> > > >
> > > >
> > > > The previous error message:
> > > >
> > > > ERROR: "adc_single" [arch/sh/boards/mach-hp6xx/hp6xx_apm.ko] undefined!
> > > >
> > > >
> > > > The new error message:
> > > >
> > > > ERROR: modpost: "adc_single" [arch/sh/boards/mach-hp6xx/hp6xx_apm.ko] undefined!
> > > >
> > > >
> > > >
> > > > So, the bot assumed it was a new error.
> > >
> > > Nice catch! Hm, I suppose we need to let the LKP folks know about the
> > > change in error message. CC'd LKP mailing list.
> > Thanks for the info, we will look into this to handle the
> > changed error.
> >
> > >
> > > Jessica
> > > _______________________________________________
> > > LKP mailing list -- lkp@lists.01.org
> > > To unsubscribe send an email to lkp-leave@lists.01.org
> 
> 
> 
> Could you improve the report by adding more context?
> 
> Currently, only new errors/warnings are shown by '>>'.
> 
> 
> If fixed ones had been shown by '<<',
> we would have easily noticed that
> this was just a matter of message format.
thanks for the suggestion, we will think of this, though
it may not be a quick implemention for current code base :-)

> 
> << ERROR: "adc_single" [arch/sh/boards/mach-hp6xx/hp6xx_apm.ko] undefined!
> >> ERROR: modpost: "adc_single" [arch/sh/boards/mach-hp6xx/hp6xx_apm.ko] undefined!
> 
> 
> 
> 
> -- 
> Best Regards
> Masahiro Yamada
