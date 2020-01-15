Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A691BC33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 01:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7977524671
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 01:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579052688;
	bh=Kb60c+Ph6Xb3zTH4YTbTK97b3A343HQWGskvykn7uYA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=0pc0jcB2digH3FtaeRQAINyfeGp/S5JU3wSVzKGn5yrGcmHLoCGwg9DwqEBgF4QV1
	 jKRsU9US1NaYAJgOJ/YiErUurAmshv+CN8jxo9Xy+fJaJaMZIF+n+ERca3VA/17fTn
	 B+C0AQGi7HHMKXk8Q1vTRpm7I6OJbRBfu8OEqnhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgAOBor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 20:44:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:36554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728848AbgAOBor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 20:44:47 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 164F924658;
        Wed, 15 Jan 2020 01:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579052686;
        bh=Kb60c+Ph6Xb3zTH4YTbTK97b3A343HQWGskvykn7uYA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L7YBp12LMyR3nr6OUPHZrr8S9mwi+kjRL8XwxLA+v9JnDO3m5GOCsAia4oZGVCZIk
         HdrFCCG5VUZSfvEahY28v0/Vn2ZZrdybrS6kIs6xk5Uu8k0nfelfMqGlWbAMBiedKc
         kwXxo0cHDPHCHWDE3huBLTMoevMufb4M01P9Q8TQ=
Date:   Wed, 15 Jan 2020 10:44:41 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Namhyung Kim <namhyung@kernel.org>,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdl?= =?ISO-2022-JP?B?bnNlbg==?= 
        <thoiland@redhat.com>, Jean-Tsung Hsiao <jhsiao@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing/uprobe: Fix double perf_event linking on
 multiprobe uprobe
Message-Id: <20200115104441.ad401c7e2870b05bd60f359f@kernel.org>
In-Reply-To: <20200114133246.20b96d09@gandalf.local.home>
References: <157862073931.1800.3800576241181489174.stgit@devnote2>
        <20200114173535.GA4769@kernel.org>
        <20200114124404.50a1c396@gandalf.local.home>
        <20200114174503.GB4769@kernel.org>
        <20200114133246.20b96d09@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020 13:32:46 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 14 Jan 2020 14:45:03 -0300
> Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> 
> > Em Tue, Jan 14, 2020 at 12:44:04PM -0500, Steven Rostedt escreveu:
> > > On Tue, 14 Jan 2020 14:35:35 -0300
> > > Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > >   
> > > > If you don't mind I can put it into my next perf/urgent pull req to
> > > > Ingo/Thomas,  
> > > 
> > > I was going to pull this into my urgent tree when my tests finish with
> > > my for-next code.
> > > 
> > > I have one or two other patches I need to apply to urgent as well, so
> > > it's not an issue for me to take this.  
> > 
> > Go ahead, I still need some more time for my tests with the other
> > patches, please just collect my Tested-by,
> >
> 
> Will do!
> 
> This also needs to run through my test suite which will take 13
> hours more (after my previous one finishes, which took more than 13
> because of all the patches I was testing).

Thanks Steve and Arnaldo!

This may not take a long time to be tested but requires perf to
enable multiple perf event.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
