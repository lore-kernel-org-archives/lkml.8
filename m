Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D26DC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 12:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0629E206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 12:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KM9w+Hnw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgD1M3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 08:29:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57316 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726682AbgD1M3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 08:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588076980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oUqwe0qNnN6d6+hP/NwlPV2/GYq5zB2TAyoaYG1OVtw=;
        b=KM9w+Hnw7jWrow/Ep4oAlxrsTKj18zwPHe4b35czmt6TYY+7xkISChfWDufRfqUx7sB0Hd
        cJGFx2c6pAD1CYZDGtXYZhh390YqZGVXVhtS/S6XOSldU8+oe6cXokV1sXnH+q5SoXExYR
        NJsGbyTvLKmaIz+kX9x8rJtjJQTrpi8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-uUNP38blPseBQUbtLsMSTw-1; Tue, 28 Apr 2020 08:29:38 -0400
X-MC-Unique: uUNP38blPseBQUbtLsMSTw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E67AE464;
        Tue, 28 Apr 2020 12:29:36 +0000 (UTC)
Received: from sandy.ghostprotocols.net (unknown [10.3.128.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CCA15D98C;
        Tue, 28 Apr 2020 12:29:35 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 236861C6; Tue, 28 Apr 2020 09:29:31 -0300 (BRT)
Date:   Tue, 28 Apr 2020 09:29:31 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, mingo@elte.hu,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Liang, Kan" <kan.liang@intel.com>
Subject: Re: [PATCH] perf/script: remove extraneous newline in
 perf_sample__fprintf_regs()
Message-ID: <20200428122931.GA2122@redhat.com>
References: <20200418231908.152212-1-eranian@google.com>
 <CABPqkBRLHx6dbMMcGv4fi-7+Suez29n0qxUCK=g+Fn41iwZBfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBRLHx6dbMMcGv4fi-7+Suez29n0qxUCK=g+Fn41iwZBfw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 27, 2020 at 02:43:28PM -0700, Stephane Eranian escreveu:
> On Sat, Apr 18, 2020 at 4:19 PM Stephane Eranian <eranian@google.com> wrote:
> >
> > When printing iregs, there was a double newline printed because
> > perf_sample__fprintf_regs() was printing its own and then at the
> > end of all fields, perf script was adding one.
> > This was causing blank line in the output:
> >
> > Before:
> > $ perf script -Fip,iregs
> >            401b8d ABI:2    DX:0x100    SI:0x4a8340    DI:0x4a9340
> >
> >            401b8d ABI:2    DX:0x100    SI:0x4a9340    DI:0x4a8340
> >
> >            401b8d ABI:2    DX:0x100    SI:0x4a8340    DI:0x4a9340
> >
> >            401b8d ABI:2    DX:0x100    SI:0x4a9340    DI:0x4a8340
> >
> > After:
> > $ perf script -Fip,iregs
> >            401b8d ABI:2    DX:0x100    SI:0x4a8340    DI:0x4a9340
> >            401b8d ABI:2    DX:0x100    SI:0x4a9340    DI:0x4a8340
> >            401b8d ABI:2    DX:0x100    SI:0x4a8340    DI:0x4a9340
> >
> > Signed-off-by: Stephane Eranian <eranian@google.com>
> 
> 
> Ping?

I'll process this one today.

Thanks for the reminder,

- Arnaldo
 
> >
> > ---
> >  tools/perf/builtin-script.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index 1f57a7ecdf3d0..0c0b6e807d06e 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -604,8 +604,6 @@ static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t mask,
> >                 printed += fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name(r), val);
> >         }
> >
> > -       fprintf(fp, "\n");
> > -
> >         return printed;
> >  }
> >
> > --
> > 2.26.1.301.g55bc3eb7cb9-goog
> >

