Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAA8C34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 06:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E2721D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 06:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vyb9pxu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgBRGSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 01:18:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53185 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726017AbgBRGSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 01:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582006711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IKUFr2PkbZa7//VHtKNQtSxQ+QCmfN2OXSxqABuzNUk=;
        b=Vyb9pxu9GEci5k0fdwvZvKfcFH1xONqU7XuJghj6Aq2Uj3A/6IgOn74lKP/yn2DYt1arSN
        CuG2b9fO1Ckcy9SOeJoTu4749pZ1QtxOSHdufqG6DVF3nrnfJ3SHMDY2goFjbFgeGSdVrG
        NHu+9H542S+fl2ja01kPevwDiVIuGLY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-mea6cz8AOJKO30X_APmxfQ-1; Tue, 18 Feb 2020 01:18:27 -0500
X-MC-Unique: mea6cz8AOJKO30X_APmxfQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D84AD477;
        Tue, 18 Feb 2020 06:18:25 +0000 (UTC)
Received: from krava (ovpn-204-91.brq.redhat.com [10.40.204.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DE132863CC;
        Tue, 18 Feb 2020 06:18:20 +0000 (UTC)
Date:   Tue, 18 Feb 2020 07:14:22 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4] perf stat: Show percore counts in per CPU output
Message-ID: <20200218061422.GA384398@krava>
References: <20200214080452.26402-1-yao.jin@linux.intel.com>
 <20200216225407.GB157041@krava>
 <d79a1bbe-bca5-0420-0480-1d508d2a038c@linux.intel.com>
 <20200217110629.GD157041@krava>
 <9c16e98e-aa9e-8879-0690-990a5dcda303@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c16e98e-aa9e-8879-0690-990a5dcda303@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 09:02:52AM +0800, Jin, Yao wrote:

SNIP

> > > > 
> > > > thanks,
> > > > jirka
> > > > 
> > > 
> > > I have a simple fix for this misalignment issue.
> > > 
> > > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > > index bc31fccc0057..95b29c9cba36 100644
> > > --- a/tools/perf/util/stat-display.c
> > > +++ b/tools/perf/util/stat-display.c
> > > @@ -114,11 +114,11 @@ static void aggr_printout(struct perf_stat_config
> > > *config,
> > >                          fprintf(config->output, "S%d-D%d-C%*d%s",
> > >                                  cpu_map__id_to_socket(id),
> > >                                  cpu_map__id_to_die(id),
> > > -                               config->csv_output ? 0 : -5,
> > > +                               config->csv_output ? 0 : -3,
> > >                                  cpu_map__id_to_cpu(id), config->csv_sep);
> > >                  } else {
> > > -                       fprintf(config->output, "CPU%*d%s ",
> > > -                               config->csv_output ? 0 : -5,
> > > +                       fprintf(config->output, "CPU%*d%s",
> > > +                               config->csv_output ? 0 : -7,
> > >                                  evsel__cpus(evsel)->map[id],
> > >                                  config->csv_sep);
> > 
> > I guess that's ok, will that work with higher (3 digit) cpu numbers?
> > 
> > jirka
> > 
> 
> Yes, it works with hundreds of CPU. I have tested with that case.
> 
> BTW, do you need me to post a separate patch or you will add this fix in
> your patch series?

please send separate patch

thanks,
jirka

