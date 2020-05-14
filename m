Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE3AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4DF6206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yjrk1yjf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgENUjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 16:39:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41233 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726200AbgENUjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 16:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589488792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3m6Ftq3TuCCuypkHO0wr59mhrXpVR2PIMdXqJPW1u7s=;
        b=Yjrk1yjf3OQZhahO8gfxMXRdTiCRF/pV1ipQYaSBpyGkabgDKe/qS3ssZ63VbQsBCjQOVk
        ey2AICXrl3+g86pwPihM2r2MOqv7j8t7Q+Y0acLMW74fM7XGE+mWrX2MqsRaghqsVEn7pX
        jG6/d4x8FefUrXZCkjfO7WDmotHvwJA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401--k3l99i0OaeoHi668YuToQ-1; Thu, 14 May 2020 16:39:50 -0400
X-MC-Unique: -k3l99i0OaeoHi668YuToQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 056D81005510;
        Thu, 14 May 2020 20:39:47 +0000 (UTC)
Received: from treble (ovpn-117-14.rdu2.redhat.com [10.10.117.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 813A15D9D7;
        Thu, 14 May 2020 20:39:45 +0000 (UTC)
Date:   Thu, 14 May 2020 15:39:42 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, mgorman@techsingularity.net,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] tools/perf-bench: Add basic syscall benchmark
Message-ID: <20200514203942.v2dbjeqrdpuucx5h@treble>
References: <20190307185253.28432-1-dave@stgolabs.net>
 <20190307191157.GB32240@kernel.org>
 <20190308181747.l36zqz2avtivrr3c@linux-r8p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190308181747.l36zqz2avtivrr3c@linux-r8p5>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 10:17:47AM -0800, Davidlohr Bueso wrote:
> On Thu, 07 Mar 2019, Arnaldo Carvalho de Melo wrote:
> > You forgot to update tools/perf/Documentation/perf-bench.txt, and please
> > take a look at tools/perf/util/pmu.c convert_scale() to see how to save
> > the current locale, set the one you want, then restore the previous one,
> > so that at the end of this benchmark the environment is back to where it
> > was.
> 
> Here's an updated version with the corresponding docs, but I removed the
> setlocale() - doesn't seem worth it; I hope Mel has no strong objection.
> 
> Thanks.
> 
> -------8<----------------------------------------------------------
> [PATCH v2] tools/perf-bench: Add basic syscall benchmark
> 
> The usefulness of having a standard way of testing syscall performance
> has come up from time to time[0]. Furthermore, some of our testing
> machinery (such as 'mmtests') already makes use of a simplified version
> of the microbenchmark. This patch mainly takes the same idea to measure
> syscall throughput compatible with 'perf-bench' via getppid(2), yet
> without any of the additional template stuff from Ingo's version (based
> on numa.c). The code is identical to what mmtests uses.
> 
> [0] https://lore.kernel.org/lkml/20160201074156.GA27156@gmail.com/
> 
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>

It would be nice to see this merged.  I posted something very similar
back in 2016.

-- 
Josh

