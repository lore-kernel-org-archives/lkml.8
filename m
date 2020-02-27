Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4398C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81EC32469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ABgRUbLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgB0NRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:17:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40077 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729090AbgB0NRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:17:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582809424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3DHw6j0fMHGLbvixYXnIHzTwqUAL4vvKhMrgIIeGFfs=;
        b=ABgRUbLz+2f0mNpojbaqYjYPbwFzA2vZKocmSnF71MQgSwkTynlz/XwaIqx5xk/cKhSmYj
        28ATKaETrbWVkCQ2gaECflPIedmBRlZ/JTKr2TEVB+kc2SLB1bj5wi5lAPKHZIfy+mj1J+
        2I0lzBIZUkltM/523EPl9izq90qG8Kc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-nSQy_L9bPYSSCZxasZRikQ-1; Thu, 27 Feb 2020 08:16:56 -0500
X-MC-Unique: nSQy_L9bPYSSCZxasZRikQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE550DBB0;
        Thu, 27 Feb 2020 13:16:53 +0000 (UTC)
Received: from krava (unknown [10.43.17.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 50F258B779;
        Thu, 27 Feb 2020 13:16:51 +0000 (UTC)
Date:   Thu, 27 Feb 2020 14:16:48 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        xieyisheng1@huawei.com, alexey.budankov@linux.intel.com,
        treeze.taeung@gmail.com, adrian.hunter@intel.com,
        tmricht@linux.ibm.com, namhyung@kernel.org, irogers@google.com,
        songliubraving@fb.com, yao.jin@linux.intel.com,
        changbin.du@intel.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] perf annotate/config: More fixes
Message-ID: <20200227131648.GF34774@krava>
References: <20200213064306.160480-1-ravi.bangoria@linux.ibm.com>
 <20200216211549.GA157041@krava>
 <20200227130846.GA9899@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227130846.GA9899@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 10:08:46AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sun, Feb 16, 2020 at 10:15:49PM +0100, Jiri Olsa escreveu:
> > On Thu, Feb 13, 2020 at 12:12:58PM +0530, Ravi Bangoria wrote:
> > > These are the additional set of fixes on top of previous series:
> > > http://lore.kernel.org/r/20200204045233.474937-1-ravi.bangoria@linux.ibm.com
> > > 
> > > Note for the last patch:
> > > I couldn't understand what intel-pt.cache-divisor is really used for.
> > > Adrian, can you please help.
> > > 
> > > Ravi Bangoria (8):
> > >   perf annotate/tui: Re-render title bar after switching back from
> > >     script browser
> > >   perf annotate: Fix --show-total-period for tui/stdio2
> > >   perf annotate: Fix --show-nr-samples for tui/stdio2
> > >   perf config: Introduce perf_config_u8()
> > >   perf annotate: Make perf config effective
> > >   perf annotate: Prefer cmdline option over default config
> > >   perf annotate: Fix perf config option description
> > >   perf config: Document missing config options
> > 
> > nice, I guess this all worked in the past but got broken because
> > we don't have any tests for annotation code.. any chance you could
> 
> I'm going thru them, can I take that "nice" as an Acked-by? Have you
> gone thru those patches?

nope, I just real fast checked on them.. I expected more discussion on tests ;-)

but as Ravi wrote, it could take some time

jirka

> 
> - Arnaldo
> 
> > think of some way to test annotations?
>  
> > perhaps some shell script, or prepare all the needed data for annotation
> > manualy.. sort of like we did in tests/hists_*.c
> > 
> > thanks,
> > jirka
> > 
> > > 
> > >  tools/perf/Documentation/perf-config.txt | 74 +++++++++++++++++++-
> > >  tools/perf/builtin-annotate.c            |  4 +-
> > >  tools/perf/builtin-report.c              |  2 +-
> > >  tools/perf/builtin-top.c                 |  2 +-
> > >  tools/perf/ui/browsers/annotate.c        | 19 +++--
> > >  tools/perf/util/annotate.c               | 89 +++++++++---------------
> > >  tools/perf/util/annotate.h               |  6 +-
> > >  tools/perf/util/config.c                 | 12 ++++
> > >  tools/perf/util/config.h                 |  1 +
> > >  9 files changed, 134 insertions(+), 75 deletions(-)
> > > 
> > > -- 
> > > 2.24.1
> > > 
> > 
> 
> -- 
> 
> - Arnaldo
> 

