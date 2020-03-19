Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F407C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C153208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgCSOEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:04:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:38060 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgCSOEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:04:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 959CDAE63;
        Thu, 19 Mar 2020 14:04:18 +0000 (UTC)
Date:   Thu, 19 Mar 2020 15:04:16 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Nayna Jain <nayna@linux.ibm.com>,
        Eric Richter <erichte@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Michael Neuling <mikey@neuling.org>,
        Gustavo Luiz Duarte <gustavold@linux.ibm.com>,
        Allison Randal <allison@lohutok.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-fsdevel @ vger . kernel . org --in-reply-to=" 
        <20200225173541.1549955-1-npiggin@gmail.com>
Subject: Re: [PATCH v11 4/8] powerpc/perf: consolidate valid_user_sp
Message-ID: <20200319140416.GK25468@kitsune.suse.cz>
References: <cover.1584613649.git.msuchanek@suse.de>
 <1b612025371bb9f2bcce72c700c809ae29e57392.1584613649.git.msuchanek@suse.de>
 <CAHp75VcMkPeJ6exroipnxvf-7g-C8QbVm0bAnp=rk505_nxySw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcMkPeJ6exroipnxvf-7g-C8QbVm0bAnp=rk505_nxySw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 03:35:03PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 19, 2020 at 1:54 PM Michal Suchanek <msuchanek@suse.de> wrote:
> >
> > Merge the 32bit and 64bit version.
> >
> > Halve the check constants on 32bit.
> >
> > Use STACK_TOP since it is defined.
> >
> > Passing is_64 is now redundant since is_32bit_task() is used to
> > determine which callchain variant should be used. Use STACK_TOP and
> > is_32bit_task() directly.
> >
> > This removes a page from the valid 32bit area on 64bit:
> >  #define TASK_SIZE_USER32 (0x0000000100000000UL - (1 * PAGE_SIZE))
> >  #define STACK_TOP_USER32 TASK_SIZE_USER32
> 
> ...
> 
> > +static inline int valid_user_sp(unsigned long sp)
> > +{
> > +       bool is_64 = !is_32bit_task();
> > +
> > +       if (!sp || (sp & (is_64 ? 7 : 3)) || sp > STACK_TOP - (is_64 ? 32 : 16))
> > +               return 0;
> > +       return 1;
> > +}
> 
> Perhaps better to read
> 
>   if (!sp)
>     return 0;
> 
>   if (is_32bit_task()) {
>     if (sp & 0x03)
>       return 0;
>     if (sp > STACK_TOP - 16)
>       return 0;
>   } else {
>     ...
>   }
> 
>   return 1;
> 
> Other possibility:
> 
>   unsigned long align = is_32bit_task() ? 3 : 7;
>   unsigned long top = STACK_TOP - (is_32bit_task() ? 16 : 32);
> 
>   return !(!sp || (sp & align) || sp > top);
Sounds reasonale.

Thanks

Michal
> 
> -- 
> With Best Regards,
> Andy Shevchenko
