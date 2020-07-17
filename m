Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED41C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 12:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3820A20717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 12:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594989280;
	bh=33tjZQH1C4xO/jHnWjoKMYBh6IKIV2OgfAuYgQAMOA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Qd4LDTCs8sQDSewKes1NR3qro3CUcyE3bjZ01VlLarLcB7jJ79GA5OkzDEj5CBLQW
	 UApes6feDzMQ8dl1EkI38qSoFGfFJHUfwwP46jFUaIRKHEiezuwCPh4K83KN6ENQqs
	 Z8z/1umyPuQ05BOfAkLdCwsCITLtg6UaMkXJ7JgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgGQMei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 08:34:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgGQMei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 08:34:38 -0400
Received: from quaco.ghostprotocols.net (179.176.12.94.dynamic.adsl.gvt.net.br [179.176.12.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9457206BE;
        Fri, 17 Jul 2020 12:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594989278;
        bh=33tjZQH1C4xO/jHnWjoKMYBh6IKIV2OgfAuYgQAMOA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ajmTmmG928Wru9EYzGoaDRLYHvtvENN3tmjKPD5ncu1wGTRMze7CtoXRHIyKjiiMG
         tJOK+Rrl/00fx5OwmoCQy8a21jDRDlxmD9JP0UrDNYrnqx2EWbAvXc8QJRiaeaFg8E
         pibEGdnRzF+ZEFIXFZAvn+j6mZl6V6dI/QEeLEco=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 364B740482; Fri, 17 Jul 2020 09:34:35 -0300 (-03)
Date:   Fri, 17 Jul 2020 09:34:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     acme@redhat.com, jolsa@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] libsubcmd: Fix OPT_CALLBACK_SET()
Message-ID: <20200717123435.GC77866@kernel.org>
References: <20200619133412.50705-1-ravi.bangoria@linux.ibm.com>
 <3b15af42-bfb2-07dd-8bb2-df9cd6b32a34@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b15af42-bfb2-07dd-8bb2-df9cd6b32a34@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 17, 2020 at 09:10:45AM +0530, Ravi Bangoria escreveu:
> Hi Arnaldo,
> 
> Can you please consider this trivial fix.

Trivial but important, sorry for taking so long, applied to perf/urgent,
aimed at v5.8,

- Arnaldo
 
> Ravi
> 
> On 6/19/20 7:04 PM, Ravi Bangoria wrote:
> > Any option macro with _SET suffix should set opt->set variable which
> > is not happening for OPT_CALLBACK_SET(). This is causing issues with
> > perf record --switch-output-event. Fix that.
> > 
> > Before:
> >    # ./perf record --overwrite -e sched:*switch,syscalls:sys_enter_mmap \
> >             --switch-output-event syscalls:sys_enter_mmap
> >    ^C[ perf record: Woken up 1 times to write data ]
> >    [ perf record: Captured and wrote 0.297 MB perf.data (657 samples) ]
> > 
> > After:
> > 
> >    $ ./perf record --overwrite -e sched:*switch,syscalls:sys_enter_mmap \
> >            --switch-output-event syscalls:sys_enter_mmap
> >    [ perf record: dump data: Woken up 1 times ]
> >    [ perf record: Dump perf.data.2020061918144542 ]
> >    [ perf record: dump data: Woken up 1 times ]
> >    [ perf record: Dump perf.data.2020061918144608 ]
> >    [ perf record: dump data: Woken up 1 times ]
> >    [ perf record: Dump perf.data.2020061918144660 ]
> >    ^C[ perf record: dump data: Woken up 1 times ]
> >    [ perf record: Dump perf.data.2020061918144784 ]
> >    [ perf record: Woken up 0 times to write data ]
> >    [ perf record: Dump perf.data.2020061918144803 ]
> >    [ perf record: Captured and wrote 0.419 MB perf.data.<timestamp> ]
> > 
> > Fixes: 636eb4d001b1 ("libsubcmd: Introduce OPT_CALLBACK_SET()")
> > Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> > ---
> >   tools/lib/subcmd/parse-options.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
> > index dbb9efbf718a..39ebf6192016 100644
> > --- a/tools/lib/subcmd/parse-options.c
> > +++ b/tools/lib/subcmd/parse-options.c
> > @@ -237,6 +237,9 @@ static int get_value(struct parse_opt_ctx_t *p,
> >   		return err;
> >   	case OPTION_CALLBACK:
> > +		if (opt->set)
> > +			*(bool *)opt->set = true;
> > +
> >   		if (unset)
> >   			return (*opt->callback)(opt, NULL, 1) ? (-1) : 0;
> >   		if (opt->flags & PARSE_OPT_NOARG)
> > 

-- 

- Arnaldo
