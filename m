Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D885CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 16:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1A09207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 16:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590683319;
	bh=LhqhtSC62DAR0q5esK0Nn10J6iR+qryXxFBC6MdsPfA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=SXbWdZVWQxvKQY8xh7mvop1mLaEY64u+cj5wXo8BrmV7TjCUWbnV1X4P9m3Tcv9hA
	 y1CNrMq+kXSHdgdppFJf/jNB1b9IFaioWGWPN7nRTI9MMeXRgaIBxshQlBL43cvhum
	 uAHjLvs13ppZeXVEOoY1WPy7CHxScxSWNqlzF3pw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405036AbgE1Q2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 12:28:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404986AbgE1Q2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 12:28:35 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FD302071A;
        Thu, 28 May 2020 16:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590683314;
        bh=LhqhtSC62DAR0q5esK0Nn10J6iR+qryXxFBC6MdsPfA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sQZE7iYW38p55QIfyS3Tamq+5JECSCsqlGVvUmjzTTDIzotzRb+T6AZNPpFU0W1Hk
         y6m7PSvb8e6WpA9iAcrpxHpZ+SgpUn2P1qypB3jqL+okFbQCMb1JjhwhyW6/GowpRO
         gMNlmBIgfalEPer6ZLoBSb6WeIDN5FNbTUkY6q4c=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8920835228F0; Thu, 28 May 2020 09:28:34 -0700 (PDT)
Date:   Thu, 28 May 2020 09:28:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rcu:dev.2020.05.26a 56/72] refperf.c:undefined reference to
 `__umoddi3'
Message-ID: <20200528162834.GJ2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202005280819.lJ4qjCcP%lkp@intel.com>
 <CAMuHMdUsD=xGa97tHmHZhohHiEqn5eD0QaOEwGNW7DGibkhB+g@mail.gmail.com>
 <20200528135141.GE2869@paulmck-ThinkPad-P72>
 <CAMuHMdXJOeQuA0+iT27vKAB+pNdrBBzvrfVTV=+cjm9r8=GwVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXJOeQuA0+iT27vKAB+pNdrBBzvrfVTV=+cjm9r8=GwVQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 05:31:33PM +0200, Geert Uytterhoeven wrote:
> Hi Paul,
> 
> On Thu, May 28, 2020 at 3:51 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > On Thu, May 28, 2020 at 09:04:38AM +0200, Geert Uytterhoeven wrote:
> > > On Thu, May 28, 2020 at 5:26 AM kbuild test robot <lkp@intel.com> wrote:
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.05.26a
> > > > head:   63fdce1252f16032c9e1eb7244bb674ba4f84855
> > > > commit: bd5b16d6c88da451a46d068a25fafad8e83d14a6 [56/72] refperf: Allow decimal nanoseconds
> > > > config: m68k-allyesconfig (attached as .config)
> > > > compiler: m68k-linux-gcc (GCC) 9.3.0
> > > > reproduce (this is a W=1 build):
> > > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > > >         chmod +x ~/bin/make.cross
> > > >         git checkout bd5b16d6c88da451a46d068a25fafad8e83d14a6
> > > >         # save the attached .config to linux build tree
> > > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k
> > > >
> > > > If you fix the issue, kindly add following tag as appropriate
> > > > Reported-by: kbuild test robot <lkp@intel.com>
> > > >
> > > > All errors (new ones prefixed by >>, old ones prefixed by <<):
> > > >
> > > > m68k-linux-ld: kernel/rcu/refperf.o: in function `main_func':
> > > > >> refperf.c:(.text+0x762): undefined reference to `__umoddi3'
> > > > >> m68k-linux-ld: refperf.c:(.text+0x8f2): undefined reference to `__udivdi3'
> > > > m68k-linux-ld: refperf.c:(.text+0x97c): undefined reference to `__udivdi3'
> > >
> > > | --- a/kernel/rcu/refperf.c
> > > | +++ b/kernel/rcu/refperf.c
> > > | @@ -375,7 +375,7 @@ static int main_func(void *arg)
> > > |                 if (torture_must_stop())
> > > |                         goto end;
> > > |
> > > | -               reader_tasks[exp].result_avg =
> > > process_durations(exp) / ((exp + 1) * loops);
> > > | +               reader_tasks[exp].result_avg = 1000 *
> > > process_durations(exp) / ((exp + 1) * loops);
> > >
> > > div64_ul() for 64-by-unsigned-long division
> >
> > Ah, thank you for the explanation!
> >
> > This is just a performance-test module intended for SMP systems, so
> > I don't see much point in making it work on m68k, which looks to be
> > UP-only.  But it is clearly useful to prevent the test bots from building
> > refperf on m68k.  So one approach would be for me to make its Kconfig
> > option depend on SMP.  Another would be to make it depend on 64BIT.
> > Still another would be to make it depend on !M68K.
> >
> > I could potentially dump out the numbers in picoseconds, then
> > do the averaging and other division operations in userspace,
> > but that is strange enough to cause more trouble than it is worth.
> > (An rcu_read_lock()/rcu_read_unlock() pair takes -how- long???)  Though if
> > there was some point in running this on m68k, it might be worth it (with
> > "PICOSECONDS" in all caps or some such), but in this case it is not.
> > But this would probably require more data to be dumped to allow userspace
> > to do the operations, increasing the probability of lost printk()s.  :-/
> >
> > Left to myself, I would take the easy way out and make this depend
> > on 64BIT.
> >
> > But you must have run into this situation before.  Any thoughts?
> 
> Oh, this is not just on m68k. I expect the build bots to start complaining
> about other 32-bit platforms, too, like i386 and arm32 ;-)
> 
> While restricting this to 64BIT will fix the issue, are you sure people
> on 32-bit SMP platforms don't want to run this code?

In the unlikely event that they do, we can go from there.

> So I'd go for div64_ul() and do_div().

OK, I will bite...  Plus my feeble web search failed to satisfy my
idle curiosity on this point.  ;-)

Why can't these 32-bit SMP platforms supply the API that the compiler
expects, so that normal C-language arithmetic just works?

							Thanx, Paul

> > > |         }
> > > |
> > > |         // Print the average of all experiments
> > > | @@ -386,7 +386,7 @@ static int main_func(void *arg)
> > > |         strcat(buf, "Threads\tTime(ns)\n");
> > > |
> > > |         for (exp = 0; exp < nreaders; exp++) {
> > > | -               sprintf(buf1, "%d\t%llu\n", exp + 1,
> > > reader_tasks[exp].result_avg);
> > > | +               sprintf(buf1, "%d\t%llu.%03d\n", exp + 1,
> > > reader_tasks[exp].result_avg / 1000,
> > > (int)(reader_tasks[exp].result_avg % 1000));
> > >
> > > do_div() for 64-by-32 division/modulo
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
