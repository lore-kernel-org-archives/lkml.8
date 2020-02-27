Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18C3C4BA37
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 02:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72DDE24670
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 02:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582769427;
	bh=4TGbWFlb9eTmYavHQrRR7TlW2bK12n9BSdFbsu7RxTM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ySg1By0ieiZCmgM/4pHmzJ81miCDv01rfQRwyX9rIabncaBsyogq65gEMoxgAPNVz
	 2Kqip9KU3P1l2mSpHjtit89B6hr0Qez4Q62caZZpnuHX6a8ltMWUzIDAeQFFZQjS7H
	 Nt5ZPt+dCPhnG7tIXQqUjTpeL/D05FxcEyGC3aew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgB0CK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 21:10:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:36048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728178AbgB0CK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 21:10:26 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C95DB24650;
        Thu, 27 Feb 2020 02:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582769425;
        bh=4TGbWFlb9eTmYavHQrRR7TlW2bK12n9BSdFbsu7RxTM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AUDGnGUk3IasFzMYsELzN30dhiYuwHtsgzarpY0O+UJ4tDitHWo8NunYJzrXmepHy
         MNwew2+cFM7VI6WJ0BK+HZiVPNmPp6iwoUtWLGSdVElSB4Q1cKnnBojIKnhLou/mCI
         1CdFLN/gHddBO1T/ACjCA8VOzyJn62YDlMZ7+3zA=
Date:   Thu, 27 Feb 2020 11:10:19 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Luigi Rizzo <lrizzo@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        naveen.n.rao@linux.ibm.com, ardb@kernel.org,
        Luigi Rizzo <rizzo@iet.unipi.it>,
        Paolo Abeni <pabeni@redhat.com>, giuseppe.lettieri@unipi.it,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>, mingo@redhat.com,
        acme@kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 1/2] kstats: kernel metric collector
Message-Id: <20200227111019.8fd6f57819282a08ced3ce35@kernel.org>
In-Reply-To: <CAMOZA0LU_mGPre9gsJSZeG19fUjLWb+6xuG8-2yv5gJRHwWzqQ@mail.gmail.com>
References: <20200226134637.31670-1-lrizzo@google.com>
        <20200226134637.31670-2-lrizzo@google.com>
        <20200226161941.GZ18400@hirez.programming.kicks-ass.net>
        <CAMOZA0LU_mGPre9gsJSZeG19fUjLWb+6xuG8-2yv5gJRHwWzqQ@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luigi,

On Wed, 26 Feb 2020 11:31:01 -0800
Luigi Rizzo <lrizzo@google.com> wrote:

> On Wed, Feb 26, 2020 at 8:19 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Feb 26, 2020 at 05:46:36AM -0800, Luigi Rizzo wrote:
> > > kstats is a helper to accumulate in-kernel metrics (timestamps, sizes,
> > > etc.) and show distributions through debugfs.
> > > Set CONFIG_KSTATS=m or y to enable it.
> > >
> > > Creating a metric takes one line of code (and one to destroy it):
> > >
> > >   struct kstats *key = kstats_new("foo", 3 /* frac_bits */);
> > >   ...
> > >   kstats_delete(key);
> > >
> > > The following line records a u64 sample:
> > >
> > >   kstats_record(key, value);
> > >
> > > kstats_record() is cheap (5ns hot cache, 250ns cold cache). Samples are
> > > accumulated in a per-cpu array with 2^frac_bits slots for each power
> > > of 2. Using frac_bits = 3 gives about 30 slots per decade.
> >
> > So I think everybody + dog has written code like this, although I never
> > bothered with the log2 based buckets myself. Nor have I ever bothered
> > with doing a debugfs interface.
> 
> the above is perhaps one excellent argument to why it may deserve to be in:
> so that people don't need to write the measurement code time and again,
> or, as I have done myself multiple times, use some inferior hack (racy
> counter, coarse buckets) or give up measuring things and rely on guessing.
> 
> > I find it very hard to convince myself something like this deserves to
> > live upstream, vs. remaining in the local debug/hack toolbox.
> >
> > Tracing has an aggregator (histogram), you can dump the raw deltas, or
> > you can hack up a custom aggregator in a few lines, or you do BPF if
> > you're so inclined.
> 
> And this is possibly another good argument: sometimes the systems where it
> would be interesting to collect data are not accessible to the developers with
> skills to write the monitoring code and run a modified kernel.

Would you mean the histogram requires more skills to use it?
I think Peter's point is that there is already an "ability" and "interface"
to do that in kenrel. If you think that is not easy to use, can you modify
existing features or add a user tool to use it easier?

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
