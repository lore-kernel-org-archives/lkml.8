Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773B1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C1C220899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590618850;
	bh=AgURYOQvcSU7gwwyLb4Yx3TUegvGbvSQJC75WUqar18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jjSltqwVm1Lz0E+BfFnMobRgLMrQrimyPPgO/BoDkY5HiohOJ6hSzUGY9IyH7zvrB
	 ndHDK7XBp3IYGtVBwFQne0ud0mdXY76Wf19BaMvpah1L1oWqOWVAtLWvZGB1oeME+h
	 v5FV/1pz907SVkw4vKNfyMqiLp1Xne926ucAuPzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgE0WeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 18:34:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgE0WeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 18:34:08 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9A3720707;
        Wed, 27 May 2020 22:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590618848;
        bh=AgURYOQvcSU7gwwyLb4Yx3TUegvGbvSQJC75WUqar18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kzmHP8vcv+k0eSvGdDZylqnOQVXzdycRyCbaBoT5GthUb52OOqJOW3S5v71UhlUvr
         AUTSejMNjgYAHj/eiU87AQH7t4AHhRYjn1Z/lICs/NYUKGxqg1dA69svaVpMBqZ+mk
         HPyI8eT4d7xbZLgGcB72LnTRjvPUyYv+v1b9c54c=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C761340AFD; Wed, 27 May 2020 19:34:05 -0300 (-03)
Date:   Wed, 27 May 2020 19:34:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nick Gasson <nick.gasson@arm.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] perf jvmti: Fix demangling Java symbols
Message-ID: <20200527223405.GE16490@kernel.org>
References: <20200427061520.24905-1-nick.gasson@arm.com>
 <20200427061520.24905-4-nick.gasson@arm.com>
 <20200527142057.GF14219@kernel.org>
 <20200527162300.GD16490@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527162300.GD16490@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 27, 2020 at 01:23:00PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, May 27, 2020 at 11:20:57AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Apr 27, 2020 at 02:15:16PM +0800, Nick Gasson escreveu:
> > > For a Java method signature like:
> > > 
> > >     Ljava/lang/AbstractStringBuilder;appendChars(Ljava/lang/String;II)V
> > > 
> > > The demangler produces:
> > > 
> > >     void class java.lang.AbstractStringBuilder.appendChars(class java.lang., shorttring., int, int)
> > > 
> > > The arguments should be (java.lang.String, int, int) but the demangler
> > > interprets the "S" in String as the type code for "short". Correct this
> > > and two other minor things:
> > > 
> > > - There is no "bool" type in Java, should be "boolean".
> > > 
> > > - The demangler prepends "class" to every Java class name. This is not
> > >   standard Java syntax and it wastes a lot of horizontal space if the
> > >   signature is long. Remove this as there isn't any ambiguity between
> > >   class names and primitives.
> > > 
> > > Also added a test case.
> > 
> > So, I took this and split into a patch for the new 'perf test java' and
> > then the fix, so that we can see the problem being detected and then
> > apply the fix and see it fixed, the last patch in this series thus
> > became:
> 
> This is in my tmp.perf/core branch pending a round of testing, after
> that it'll move to perf/core on its way to 5.8, thanks.

All tests passed, moved to perf/core.

- Arnaldo
