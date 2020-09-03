Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8FCC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D30720709
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599164502;
	bh=UoIEfhIyl4OAI6bsMc7p6eZhEujXdhGQoSbRhzREwZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Or5Y1OSYMTdQM5/Tcs0pGC7bJajAJfdBJzEQVPpytxpJe0wnEJP2K+qz3ZQLGz04P
	 2rOiaoHzKopkUP4T6uxl7+aTPaTInzEbOWFFkLGlUuVeIuyk8yQuUFEOi1hKr8SH/f
	 HuQw+rxWeCW+zawVp2gV/qIV2oRsGkuMmiJMzfKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbgICUVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:21:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbgICUVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:21:39 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 555B2206C0;
        Thu,  3 Sep 2020 20:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599164499;
        bh=UoIEfhIyl4OAI6bsMc7p6eZhEujXdhGQoSbRhzREwZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xjmIDOvRUD6Z4zAIKcq0Z6X9ocA94+R9CrsyoBlQ7sUWr0/O3nB8A+w3g4osuTLBG
         DaifKosCX4n3rh+S3HQo1orw/wVq4Lf11tazhU5GH17RdduwvORbGKg0FbC5jlUqRR
         V3l9trshCLksw452S1YyagxLlDBprto2hlp6lv68=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 51E4D40D3D; Thu,  3 Sep 2020 17:21:37 -0300 (-03)
Date:   Thu, 3 Sep 2020 17:21:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 4/6] perf tools: Add FIFO file names as alternative
 options to --control
Message-ID: <20200903202137.GO3495158@kernel.org>
References: <20200901200655.GC470123@krava>
 <20200902105707.11491-1-adrian.hunter@intel.com>
 <97818947-ed04-1b53-c71a-f00732141ca7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97818947-ed04-1b53-c71a-f00732141ca7@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 02, 2020 at 08:03:08PM +0300, Alexey Budankov escreveu:
> 
> On 02.09.2020 13:57, Adrian Hunter wrote:
> > Enable the --control option to accept file names as an alternative to
> > file descriptors.
> > 
> > Example:
> > 
> >  $ mkfifo perf.control
> >  $ mkfifo perf.ack
> >  $ cat perf.ack &
> >  [1] 6808
> >  $ perf record --control fifo:perf.control,perf.ack -- sleep 300 &
> >  [2] 6810
> >  $ echo disable > perf.control
> >  $ Events disabled
> >  ack
> > 
> >  $ echo enable > perf.control
> >  $ Events enabled
> >  ack
> > 
> >  $ echo disable > perf.control
> >  $ Events disabled
> >  ack
> > 
> >  $ kill %2
> >  [ perf record: Woken up 4 times to write data ]
> >  $ [ perf record: Captured and wrote 0.018 MB perf.data (7 samples) ]
> > 
> >  [1]-  Done                    cat perf.ack
> >  [2]+  Terminated              perf record --control fifo:perf.control,perf.ack -- sleep 300
> >  $
> > 
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > Acked-by: Jiri Olsa <jolsa@redhat.com>

Its great when things come with the exact sequence of commands to
test, the output, etc, keep it that way, please.

Thanks, tested, applied,

- Arnaldo
