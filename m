Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35CFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 14:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2EED20716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 14:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580309071;
	bh=KVTVlsCwX0svxszmvdyFRjFYpaLIQusEz0BKnDft2Rg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=u+K7gGVVT9+HKtjARL2/htU4UVSyJOV81q74GtN/4xlvB2cQrO0IupOYPayQeDp8x
	 St5Dx81TeGeuHldsz8mmh1PZTDrC96DcSP8nfkm7zZTz7ZeLK19Og6ALkdlHN6poKj
	 JATfT1Go6Km7OHY4bQmodI22fhR13OJTDvMu6I30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgA2Ooa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 09:44:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:36640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgA2Ooa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 09:44:30 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AAE6206F0;
        Wed, 29 Jan 2020 14:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580309069;
        bh=KVTVlsCwX0svxszmvdyFRjFYpaLIQusEz0BKnDft2Rg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=M0ODqQfbKAnr5zFA39OHRozdkp79dR+0yIJ27i62Ip8NeypwVhphpfsx8fTbrwINB
         VgFD6ohequlhPGg7by37uyUp+3BEEhOStPMLwa7uO1BSbkCawiHLviLIDCGEPktwVg
         PX0wFgcO9qO1RtOeHdhjUx4g7jIocLL/Nzb+GfQ8=
Message-ID: <1580309067.2312.1.camel@kernel.org>
Subject: Re: [PATCH v2 4/4] tracing: Add new testcases for hist trigger
 parsing errors
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 29 Jan 2020 08:44:27 -0600
In-Reply-To: <20200129092200.2200db5e@gandalf.local.home>
References: <cover.1561743018.git.zanussi@kernel.org>
         <62ec58d9aca661cde46ba678e32a938427945e9e.1561743018.git.zanussi@kernel.org>
         <20200129092200.2200db5e@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Wed, 2020-01-29 at 09:22 -0500, Steven Rostedt wrote:
> On Fri, 28 Jun 2019 12:40:23 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > Add a testcase ensuring that the tracing error_log correctly
> > displays
> > hist trigger parsing errors.
> 
> Hi Tom,
> 
> I noticed that I never applied these patches (just did), but I also
> notice that this test case fails.
> 
> Can you have a look on my ftrace/core branch:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-
> trace.git
> 

All the trigger testcases are passing for me, including this one:

  # ./ftracetest test.d/trigger/trigger-hist-syntax-errors.tc 
=== Ftrace unit tests ===
[1] event trigger - test histogram parser errors	[PASS]


# of passed:  1
# of failed:  0
# of unresolved:  0
# of untested:  0
# of unsupported:  0
# of xfailed:  0
# of undefined(test bug):  0


Tom


> Thanks,
> 
> -- Steve
> 
> > 
> > Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> > Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  .../test.d/trigger/trigger-hist-syntax-errors.tc   | 32
> > ++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >  create mode 100644
> > tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-syntax-
> > errors.tc
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-
> > hist-syntax-errors.tc
> > b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-
> > syntax-errors.tc
> > new file mode 100644
> > index 000000000000..d44087a2f3d1
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-
> > syntax-errors.tc
> > @@ -0,0 +1,32 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +# description: event trigger - test histogram parser errors
> > +
> > +if [ ! -f set_event -o ! -d events/kmem ]; then
> > +    echo "event tracing is not supported"
> > +    exit_unsupported
> > +fi
> > +
> > +if [ ! -f events/kmem/kmalloc/trigger ]; then
> > +    echo "event trigger is not supported"
> > +    exit_unsupported
> > +fi
> > +
> > +if [ ! -f events/kmem/kmalloc/hist ]; then
> > +    echo "hist trigger is not supported"
> > +    exit_unsupported
> > +fi
> > +
> > +[ -f error_log ] || exit_unsupported
> > +
> > +check_error() { # command-with-error-pos-by-^
> > +    ftrace_errlog_check 'hist:kmem:kmalloc' "$1"
> > 'events/kmem/kmalloc/trigger'
> > +}
> > +
> > +check_error
> > 'hist:keys=common_pid:vals=bytes_req:sort=common_pid,^junk'	
> > # INVALID_SORT_FIELD
> > +check_error 'hist:keys=common_pid:vals=bytes_req:^sort='		
> > # EMPTY_ASSIGNMENT
> > +check_error
> > 'hist:keys=common_pid:vals=bytes_req:^sort=common_pid,'	#
> > EMPTY_SORT_FIELD
> > +check_error
> > 'hist:keys=common_pid:vals=bytes_req:sort=common_pid.^junk'	
> > # INVALID_SORT_MODIFIER
> > +check_error
> > 'hist:keys=common_pid:vals=bytes_req,bytes_alloc:^sort=common_pid,b
> > ytes_req,bytes_alloc'	# TOO_MANY_SORT_FIELDS
> > +
> > +exit 0
> 
> 
