Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41A3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD6D1207D4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbgGBMVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 08:21:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728730AbgGBMVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:21:42 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33E8D207D4;
        Thu,  2 Jul 2020 12:21:42 +0000 (UTC)
Date:   Thu, 2 Jul 2020 08:21:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        John Warthog9 Hawley <warthog9@kernel.org>
Subject: Re: [for-next][PATCH 7/8] ktest.pl: Add the log of last test in
 email on failure
Message-ID: <20200702082140.347c0b81@oasis.local.home>
In-Reply-To: <20200702074235.GB1076415@kroah.com>
References: <20200701231717.757834010@goodmis.org>
        <20200701231756.619246244@goodmis.org>
        <20200702074235.GB1076415@kroah.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jul 2020 09:42:35 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> >      doprint "\n\n";
> > +
> > +    if (defined($opt{"LOG_FILE"})) {
> > +	$test_log_start = tell(LOG);
> > +    }  
> 
> Nit, the mix of spaces and tabs in this file is always annoying to me,
> but it's your code...
> 

It's the default way emacs does Perl code. I call it "oyster mode".

I like to keep it that way as it reminds me that this is Perl and not C. ;-)


> > +
> >      doprint "RUNNING TEST $i of $opt{NUM_TESTS}$name with option $test_type $run_type$installme\n\n";
> >  
> >      if (defined($pre_test)) {
> > @@ -4461,6 +4496,7 @@ if ($email_when_finished) {
> >  }
> >  
> >  if (defined($opt{"LOG_FILE"})) {
> > +
> >      print "\n See $opt{LOG_FILE} for the record of results.\n\n";
> >      close LOG;
> >  }  
> 
> Extra blank line?

Will nuke. (Left over from having a debug print in there).

> 
> Anyway, looks sane to me
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Awesome. Thanks for looking this over!

-- Steve
