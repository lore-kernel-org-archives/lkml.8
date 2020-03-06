Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91865C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 18:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B3220637
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 18:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCFSjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 13:39:45 -0500
Received: from smtprelay0235.hostedemail.com ([216.40.44.235]:51492 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726083AbgCFSjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 13:39:45 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id B38C5837F24A;
        Fri,  6 Mar 2020 18:39:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: iron74_8edbf580f4f45
X-Filterd-Recvd-Size: 4410
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Fri,  6 Mar 2020 18:39:41 +0000 (UTC)
Message-ID: <442b7ace85a414c6a01040368f05d6d219f86536.camel@perches.com>
Subject: Re: [PATCH] sched/cputime: silence a -Wunused-function warning
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>, Qian Cai <cai@lca.pw>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        bsegall@google.com, mgorman@suse.de,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Date:   Fri, 06 Mar 2020 10:38:06 -0800
In-Reply-To: <a7503afc9d561ae9c7116b97c7a960d7ad5cbff9.camel@perches.com>
References: <1583509304-28508-1-git-send-email-cai@lca.pw>
         <CAKwvOd=V44ksbiffN5UYw-oVfTK_wdeP59ipWANkOUS_zavxew@mail.gmail.com>
         <a7503afc9d561ae9c7116b97c7a960d7ad5cbff9.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-03-06 at 09:25 -0800, Joe Perches wrote:
> On Fri, 2020-03-06 at 09:13 -0800, Nick Desaulniers wrote:
> > On Fri, Mar 6, 2020 at 7:42 AM Qian Cai <cai@lca.pw> wrote:
> > > account_other_time() is only used when CONFIG_IRQ_TIME_ACCOUNTING=y (in
> > > irqtime_account_process_tick()) or CONFIG_VIRT_CPU_ACCOUNTING_GEN=y (in
> > > get_vtime_delta()). When both are off, it will generate a compilation
> > > warning from Clang,
> > > 
> > > kernel/sched/cputime.c:255:19: warning: unused function
> > > 'account_other_time' [-Wunused-function]
> > > static inline u64 account_other_time(u64 max)
> > > 
> > > Rather than wrapping around this function with a macro expression,
> > > 
> > >  if defined(CONFIG_IRQ_TIME_ACCOUNTING) || \
> > >     defined(CONFIG_VIRT_CPU_ACCOUNTING_GEN)
> > > 
> > > just use __maybe_unused for this small function which seems like a good
> > > trade-off.
> > 
> > Generally, I'm not a fan of __maybe_unused.  It is a tool in the
> > toolbox for solving this issue, but it's my least favorite.  Should
> > the call sites be eliminated, this may mask an unused and entirely
> > dead function from being removed.  Preprocessor guards based on config
> > give more context into *why* a particular function may be unused.
> > 
> > So let's take a look at the call sites of account_other_time().  Looks
> > like irqtime_account_process_tick() (guarded by
> > CONFIG_IRQ_TIME_ACCOUNTING) and get_vtime_delta() (guarded by
> > CONFIG_VIRT_CPU_ACCOUNTING_GEN).  If it were one config guard, then I
> > would prefer to move the definition to be within the same guard, just
> > before the function definition that calls it, but we have a more
> > complicated case here.
> > 
> > The next thing I'd check to see is if there's a dependency between
> > configs.  In this case, both CONFIG_IRQ_TIME_ACCOUNTING and
> > CONFIG_VIRT_CPU_ACCOUNTING_GEN are defined in init/Kconfig.  In this
> > case there's also no dependency between configs, so specifying one
> > doesn't imply the other; so guarding on one of the two configs is also
> > not an option.
> > 
> > So, as much as I'm not a fan of __maybe_unused, it is indeed the
> > simplest option.  Though, I'd still prefer the ifdef you describe
> > instead, maybe the maintainers can provide guidance/preference?
> 
> Another option might be to move static inline functions
> where possible to an #include file (like sched.h) but the
> same possible dead function issue would still exist.

Turns out there are hundreds of unused static inline
functions in kernel .h files.

A trivial script to find some of them (with likely
false positives as some might actually be used via ##
token pasting mechanisms).

(and there's almost certainly a better way to do this
 too as it takes a _very_ long time to run)

$ grep-2.5.4 -rP --include=*.h '^[ \t]*static\s+inline\s+(?:\w+\s+){1,3}\w+[ \t]*\(' * | \
  grep -P -oh '\w+\s*\(' | \
  sort | uniq -c | sort -n | grep -P '^\s+1\b' | \
  sed -r -e 's/^\s+1\s+//' -e 's/\(//' | \
  while read line ; do \
    echo -n "$line: " ; git grep -w $line | wc -l ; \
  done | \
  grep ": 1$"


