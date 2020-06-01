Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F008FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C273A20772
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CT3UeKoN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgFAPuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:50:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46437 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726075AbgFAPuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591026603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NqOcnjNE+5hs7yBW7yDmir/UvkLGzJBTtDVzFEoriY8=;
        b=CT3UeKoN1x+F0iIQuFrEsSnNYDpLmr/LQg4lvTRQ8ND6JSgDsoLdE6D0Vpogd44YJYmaXD
        kzS6ABQZFCf/3YwiO3tQ/5oUGq220lpWG/bUrKWEnDRWvxkR5Vos9g+tfXbbAReMXMZ4AF
        1XgeKsAlN7ZCLVU5efbNHjLwHUbKd0U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-5rB6ecYNOIu2DOZ0yjz4Tw-1; Mon, 01 Jun 2020 11:49:59 -0400
X-MC-Unique: 5rB6ecYNOIu2DOZ0yjz4Tw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8B1F872FE1;
        Mon,  1 Jun 2020 15:49:57 +0000 (UTC)
Received: from krava (unknown [10.40.192.36])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0340A5D9C9;
        Mon,  1 Jun 2020 15:49:54 +0000 (UTC)
Date:   Mon, 1 Jun 2020 17:49:53 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 13/14] perf tests: Add parse metric test for ipc metric
Message-ID: <20200601154953.GE1031432@krava>
References: <20200524224219.234847-1-jolsa@kernel.org>
 <20200524224219.234847-14-jolsa@kernel.org>
 <CAP-5=fVmCZZhHfHU8EFcKDvs8555cuTfyH3VpW_k-oX42S1svg@mail.gmail.com>
 <20200601150843.GL31795@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601150843.GL31795@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 12:08:43PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jun 01, 2020 at 12:55:44AM -0700, Ian Rogers escreveu:
> > On Sun, May 24, 2020 at 3:43 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > Adding new test that process metrics code and checks
> > > the expected results. Starting with easy ipc metric.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > 
> > Acked-by: Ian Rogers <irogers@google.com>
> > 
> > I wonder if there's a better organization with testing in
> > pmu-events.c, expr.c and now parse-metric.c.
> 
> This is on a patchkit that has some other stuff to be reworked, so
> please collect the Acked-by when you submit v2, ok Jiri?

yep, will do

jirka

