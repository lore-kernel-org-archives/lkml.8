Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB121C54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B67CA20730
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LfIPGwGQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbgELNgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 09:36:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42794 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729568AbgELNgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 09:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589290577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zhd4EclVoiE+Xr9KIfrEkpLY2xHNwgQDIDz5FfT0LGI=;
        b=LfIPGwGQ+Zq1R8W+uYuU/3TRSivleNFfQyq3KLQP6uf5BeegdAUlI/WLPRhFSmwTU+KnUo
        IzrK1UifZnPs/dWA2iWBj/zEmWUGGD/dR/T73cyJx7+H4BBQRMVuzX3KpCk56Z0J7015ZS
        +t0Fvye1zvn+aiG1qblEbOJ5hY0y6+A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-OLYvPviWN6yOc43l2QVwWg-1; Tue, 12 May 2020 09:36:13 -0400
X-MC-Unique: OLYvPviWN6yOc43l2QVwWg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D7C8106BF7E;
        Tue, 12 May 2020 13:36:12 +0000 (UTC)
Received: from krava (unknown [10.40.194.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1C8E553E3B;
        Tue, 12 May 2020 13:36:09 +0000 (UTC)
Date:   Tue, 12 May 2020 15:36:09 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH perf/urgent] perf tools: Fix is_bpf_image function logic
Message-ID: <20200512133609.GA3158213@krava>
References: <20200512122310.3154754-1-jolsa@kernel.org>
 <20200512133223.GI28888@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512133223.GI28888@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 10:32:23AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, May 12, 2020 at 02:23:10PM +0200, Jiri Olsa escreveu:
> > Adrian reported that is_bpf_image is not working the way it was
> > intended - passing on trampolines and dispatcher names. Instead
> > it returned true for all the bpf names.
> > 
> > The reason even this logic worked properly is that all bpf objects,
> > even trampolines and dispatcher, were assigned DSO_BINARY_TYPE__BPF_IMAGE
> > binary_type.
> > 
> > The later for bpf_prog objects, the binary_type was fixed in bpf load event
> > processing, which is executed after the ksymbol code.
> > 
> > Fixing the is_bpf_image logic, so it properly recognizes trampoline
> > and dispatcher objects.
> 
> This is not applying on top of torvalds/master, not tip/perf/urgent, and

right.. it's on top of your's perf/core.. I can rebase on perf/urgent

> you forgot to add the Fixes: line, lemme try to find this...

oops, sorry

Fixes: 3c29d4483e85 ("perf annotate: Add basic support for bpf_image")

jirka

> 
> - Arnaldo
>  
> > Reported-by: Adrian Hunter <adrian.hunter@intel.com>
> > Signed-off-by: Jiri Olsa <jolsa@redhat.com>
> > ---
> >  tools/perf/util/machine.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index 8ed2135893bb..d5384807372b 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -738,8 +738,8 @@ int machine__process_switch_event(struct machine *machine __maybe_unused,
> >  
> >  static int is_bpf_image(const char *name)
> >  {
> > -	return strncmp(name, "bpf_trampoline_", sizeof("bpf_trampoline_") - 1) ||
> > -	       strncmp(name, "bpf_dispatcher_", sizeof("bpf_dispatcher_") - 1);
> > +	return strncmp(name, "bpf_trampoline_", sizeof("bpf_trampoline_") - 1) == 0 ||
> > +	       strncmp(name, "bpf_dispatcher_", sizeof("bpf_dispatcher_") - 1) == 0;
> >  }
> >  
> >  static int machine__process_ksymbol_register(struct machine *machine,
> > -- 
> > 2.25.4
> > 
> 
> -- 
> 
> - Arnaldo
> 

