Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C369C35666
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 19:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231B9206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 19:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNNXXxqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgBWTun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 14:50:43 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46682 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726302AbgBWTun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 14:50:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582487442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U8eq1n3gQqch57lo0n117yUjHnihEzgqQnlaVCwPMcg=;
        b=eNNXXxqmHePLRUFFTwNkEoztHl4NSMR9Goz6dwae8btwrb5PqsiRvJJRXHt0t3kP4I6Izd
        ITctBziCg8KGC8bgC3ULvsHrn25buJjR99mKmlzcNrakXC36XDYSIWlUv846sGgH5UG+7h
        UkMaUTYG9cusWxRkaPeElg17ExgU7nw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-AIrBgFPWP8SzqsiF3TFd2w-1; Sun, 23 Feb 2020 14:50:38 -0500
X-MC-Unique: AIrBgFPWP8SzqsiF3TFd2w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5864D107ACC5;
        Sun, 23 Feb 2020 19:50:36 +0000 (UTC)
Received: from krava (ovpn-204-19.brq.redhat.com [10.40.204.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 71ED65C21B;
        Sun, 23 Feb 2020 19:50:33 +0000 (UTC)
Date:   Sun, 23 Feb 2020 20:50:30 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 2/2] perf annotate: Support interactive annotation of
 code without symbols
Message-ID: <20200223195030.GB16664@krava>
References: <20200221024608.1847-1-yao.jin@linux.intel.com>
 <20200221024608.1847-3-yao.jin@linux.intel.com>
 <20200221144531.GA657629@krava>
 <6bb8c073-4a10-8e49-05dc-819b671a875d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bb8c073-4a10-8e49-05dc-819b671a875d@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 07:37:49AM +0800, Jin, Yao wrote:
> 
> 
> On 2/21/2020 10:45 PM, Jiri Olsa wrote:
> > On Fri, Feb 21, 2020 at 10:46:08AM +0800, Jin Yao wrote:
> > 
> > SNIP
> > 
> > > 
> > > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > > ---
> > >   tools/perf/ui/browsers/hists.c | 51 +++++++++++++++++++++++++++++-----
> > >   tools/perf/util/annotate.h     |  2 ++
> > >   2 files changed, 46 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> > > index f36dee499320..5144528b2931 100644
> > > --- a/tools/perf/ui/browsers/hists.c
> > > +++ b/tools/perf/ui/browsers/hists.c
> > > @@ -2465,13 +2465,47 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
> > >   	return 0;
> > >   }
> > > +static struct symbol *new_annotate_sym(u64 addr, struct map *map,
> > > +				       struct annotation_options *opts)
> > > +{
> > > +	struct symbol *sym;
> > > +	struct annotated_source *src;
> > > +	char name[64];
> > > +
> > > +	snprintf(name, sizeof(name), "%-#.*lx", BITS_PER_LONG / 4, addr);
> > > +
> > > +	sym = symbol__new(addr,
> > > +			  opts->annotate_dummy_len ?
> > > +			  opts->annotate_dummy_len : ANNOTATION_DUMMY_LEN,
> > 
> > I can't see annotate_dummy_len being set anywhere..
> > 
> 
> Yes, annotate_dummy_len is not set in this patch. Currently we just use the
> default value. While maybe in future we will provide a perf report option or
> set it in perf config. Now I just leave an interface here.

if that's just 'maybe in future we will provide' then please keep just the
ANNOTATION_DUMMY_LEN, the abandoned opts->annotate_dummy_len var is confusing 

thanks,
jirka

