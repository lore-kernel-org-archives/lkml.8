Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BFCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C1FE20810
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RS+6uh+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgFANJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 09:09:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43409 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725847AbgFANJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 09:09:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591016952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KzHgXWHspuQEJI3LKwbO2G6H775oaaq7DDcWfGgvAr0=;
        b=RS+6uh+RL/5PHGK0tvEgZ4Q+Acz69iZIzeDIZzrv9AvzU85JWL6vul/t0yTBx1k3odoMoi
        YOKbp9aLNBbJOUGj8HysQvoF/V5Fj6j77fsGtVWZe3vdfiYrzwB0NWAus0Yl0sWPR33hRN
        3CeibuKAZOSzUY4EjW6PUwcfA/AC6Ek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-UoCTVfo2Nw-kLOse5i0izQ-1; Mon, 01 Jun 2020 09:09:10 -0400
X-MC-Unique: UoCTVfo2Nw-kLOse5i0izQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F28568015D2;
        Mon,  1 Jun 2020 13:09:08 +0000 (UTC)
Received: from krava (unknown [10.40.192.36])
        by smtp.corp.redhat.com (Postfix) with SMTP id 69C0C1002394;
        Mon,  1 Jun 2020 13:09:06 +0000 (UTC)
Date:   Mon, 1 Jun 2020 15:09:05 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 13/14] perf tests: Add parse metric test for ipc metric
Message-ID: <20200601130905.GA1031432@krava>
References: <20200524224219.234847-1-jolsa@kernel.org>
 <20200524224219.234847-14-jolsa@kernel.org>
 <CAP-5=fVmCZZhHfHU8EFcKDvs8555cuTfyH3VpW_k-oX42S1svg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVmCZZhHfHU8EFcKDvs8555cuTfyH3VpW_k-oX42S1svg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 12:55:44AM -0700, Ian Rogers wrote:
> On Sun, May 24, 2020 at 3:43 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding new test that process metrics code and checks
> > the expected results. Starting with easy ipc metric.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Acked-by: Ian Rogers <irogers@google.com>
> 
> I wonder if there's a better organization with testing in
> pmu-events.c, expr.c and now parse-metric.c.

hum, so 
 - expr.c is testing core interface,
 - parse-metric is testing specific metric processing from
   parsing to final ratio
 - pmu-events.c is testing pmu events aliases and parsing of
   all the metrics

pmu-events.c is testing both pmu events and metrics,
but I think it fits in the way it's done together

jirka

