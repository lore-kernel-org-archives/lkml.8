Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC35FC352A3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 02:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70492082F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 02:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgBNCGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 21:06:35 -0500
Received: from smtprelay0174.hostedemail.com ([216.40.44.174]:60624 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727955AbgBNCGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 21:06:34 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id CD9F01802297C;
        Fri, 14 Feb 2020 02:06:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: trees78_905cfe3f6200e
X-Filterd-Recvd-Size: 3084
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Fri, 14 Feb 2020 02:06:31 +0000 (UTC)
Message-ID: <cb37f342635b045639d877034c9f6d175b5d80cd.camel@perches.com>
Subject: Re: [PATCH] sched/fair: Replace zero-length array with
 flexible-array member
From:   Joe Perches <joe@perches.com>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Date:   Thu, 13 Feb 2020 18:05:13 -0800
In-Reply-To: <1d420ee4-7078-26d9-83ad-eb5f12106116@arm.com>
References: <20200213151951.GA32363@embeddedor>
         <20200213164518.GI14914@hirez.programming.kicks-ass.net>
         <9d516501-2624-f915-32be-13ba6f881019@embeddedor.com>
         <20200213170639.GK14914@hirez.programming.kicks-ass.net>
         <c7df22d3f248c784e8960841c79fe2836d7ea8ab.camel@perches.com>
         <1d420ee4-7078-26d9-83ad-eb5f12106116@arm.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-02-14 at 00:25 +0000, Valentin Schneider wrote:
> On 13/02/2020 22:02, Joe Perches wrote:
> > That might be a somewhat difficult thing to add to checkpatch
> > as it is effectively a per-line scanner:
> > 
> > Try something like:
> > 
> > $ git grep -P -A1 '^\s*(?!return)(\w+\s+){1,3}\w+\[0\];' -- '*.[ch]'
> > 
> > and look at the results.
> > 
> > In checkpatch that could be something like:
> > 
> > 	if ($line =~ /^.\s*$Type\s+$Ident\s*\[\s*0\s*\]\s*;/) {
> > 		warn...
> > 	}
> > 
> 
> So FWIW I felt like doing some coccinelle and ended up with this:
> 
> This patches up valid ZLAs:
>   $ spatch -D patch zero_length_array.cocci kernel/sched/fair.c
> 
> This prints out the location of invalid ZLAs:
>   $ spatch -D report zero_length_array.cocci kernel/sched/fair.c
> 
> ---
> virtual patch
> virtual report
> 
> @valid_zla depends on patch@
> identifier struct_name;
> type T;
> identifier zla;
> position pos;
> @@
> struct struct_name {
>        ...
>        T zla@pos
> - [0];
> + [];
> };
> 
> @invalid_zla depends on report@
> identifier struct_name;
> type T1;
> identifier zla;
> type T2;
> identifier tail;
> position pos;
> @@
> struct struct_name {
>        ...
>        T1 zla[0]@pos;
>        T2 tail;
>        ...
> };
> 
> @script:python depends on invalid_zla@
> pos << invalid_zla.pos;
> @@
> coccilib.report.print_report(pos[0], "Invalid ZLA!");
> ---

Nice.
It would miss a few forms like:

	typedef struct tagfoo {
		...
		type t[0];
	} foo;

and

	struct {
		...
		type t[0];
	} foo;

and

	struct foo {
		...
		type t[0];
	} *foo;

etc...


