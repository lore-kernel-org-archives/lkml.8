Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6114C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B1120656
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgCFTMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 14:12:16 -0500
Received: from smtprelay0138.hostedemail.com ([216.40.44.138]:58410 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727065AbgCFTML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 14:12:11 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id F3F49182CED5B;
        Fri,  6 Mar 2020 19:12:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shelf13_870d94afc7347
X-Filterd-Recvd-Size: 2547
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri,  6 Mar 2020 19:12:07 +0000 (UTC)
Message-ID: <4ec4c6915c23545a9d45f37df9ab4eb6a422b234.camel@perches.com>
Subject: Re: [PATCH] sched/cputime: silence a -Wunused-function warning
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Qian Cai <cai@lca.pw>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>, mgorman@suse.de,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Date:   Fri, 06 Mar 2020 11:10:32 -0800
In-Reply-To: <CAKwvOdmdaDL4bhJc+7Xms=f4YXDw-Rr+WQAknd0Jv6UWOBUcEA@mail.gmail.com>
References: <1583509304-28508-1-git-send-email-cai@lca.pw>
         <CAKwvOd=V44ksbiffN5UYw-oVfTK_wdeP59ipWANkOUS_zavxew@mail.gmail.com>
         <a7503afc9d561ae9c7116b97c7a960d7ad5cbff9.camel@perches.com>
         <442b7ace85a414c6a01040368f05d6d219f86536.camel@perches.com>
         <CAKwvOdmdaDL4bhJc+7Xms=f4YXDw-Rr+WQAknd0Jv6UWOBUcEA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-03-06 at 11:02 -0800, Nick Desaulniers wrote:
> On Fri, Mar 6, 2020 at 10:39 AM Joe Perches <joe@perches.com> wrote:
[]
> > Turns out there are hundreds of unused static inline
> > functions in kernel .h files.
> > 
> > A trivial script to find some of them (with likely
> > false positives as some might actually be used via ##
> > token pasting mechanisms).
> > 
> > (and there's almost certainly a better way to do this
> >  too as it takes a _very_ long time to run)
> > 
> > $ grep-2.5.4 -rP --include=*.h '^[ \t]*static\s+inline\s+(?:\w+\s+){1,3}\w+[ \t]*\(' * | \
> >   grep -P -oh '\w+\s*\(' | \
> >   sort | uniq -c | sort -n | grep -P '^\s+1\b' | \
> >   sed -r -e 's/^\s+1\s+//' -e 's/\(//' | \
> >   while read line ; do \
> >     echo -n "$line: " ; git grep -w $line | wc -l ; \
> >   done | \
> >   grep ": 1$"
> 
> Please start sending patches to remove them and I'll review.  If this
> is a good amount of work, I have newbies that are looking to
> contribute and can help.

That's not a task I care to take on.

I could run the script and post the results through
if you can not.



