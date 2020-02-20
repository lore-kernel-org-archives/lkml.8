Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602F6C11D0A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32FD3208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OTm36WjV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgBTOvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:51:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47589 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727705AbgBTOvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 09:51:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582210295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DB3P7vdAYjoAi869m4yzbBnWq2u+p0yaiGICWG9KAUA=;
        b=OTm36WjVyDlMpuMPruwjzN7iPwq2ffuodfdJd2r18nJdOQRREIENDQqVpG6x2fIRwpHIxE
        LdOwGeFO7/Zn8s92WxLhURlZ5HqeH+/SPjpEMBHMK82tyKJyfgZzJGHgAd6itbSlelqhhj
        e0JUIg2sy2d+Ah2aTlylHywEZJDTang=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-POOatf21PcC75W18DL_G3Q-1; Thu, 20 Feb 2020 09:51:31 -0500
X-MC-Unique: POOatf21PcC75W18DL_G3Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0121800D48;
        Thu, 20 Feb 2020 14:51:28 +0000 (UTC)
Received: from krava (unknown [10.43.17.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CD5DA5DA76;
        Thu, 20 Feb 2020 14:51:26 +0000 (UTC)
Date:   Thu, 20 Feb 2020 15:51:24 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 0/2] perf report: Support annotation of code without
 symbols
Message-ID: <20200220145124.GD586895@krava>
References: <20200220005902.8952-1-yao.jin@linux.intel.com>
 <20200220115629.GC565976@krava>
 <ca3fa091-f407-51e2-d617-90a842b36295@linux.intel.com>
 <20200220120655.GA586895@krava>
 <1fc1c4f5-ca94-ebd7-fae0-28765070662f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fc1c4f5-ca94-ebd7-fae0-28765070662f@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 10:42:11PM +0800, Jin, Yao wrote:
> 
> 
> On 2/20/2020 8:06 PM, Jiri Olsa wrote:
> > On Thu, Feb 20, 2020 at 08:03:18PM +0800, Jin, Yao wrote:
> > > 
> > > 
> > > On 2/20/2020 7:56 PM, Jiri Olsa wrote:
> > > > On Thu, Feb 20, 2020 at 08:59:00AM +0800, Jin Yao wrote:
> > > > > For perf report on stripped binaries it is currently impossible to do
> > > > > annotation. The annotation state is all tied to symbols, but there are
> > > > > either no symbols, or symbols are not covering all the code.
> > > > > 
> > > > > We should support the annotation functionality even without symbols.
> > > > > 
> > > > > The first patch uses al_addr to print because it's easy to dump
> > > > > the instructions from this address in binary for branch mode.
> > > > > 
> > > > > The second patch supports the annotation on stripped binary.
> > > > > 
> > > > > Jin Yao (2):
> > > > >     perf util: Print al_addr when symbol is not found
> > > > >     perf annotate: Support interactive annotation of code without symbols
> > > > 
> > > > looks good, but I'm getting crash when annotating unresolved kernel address:
> > > > 
> > > > jirka
> > > > 
> > > > 
> > > 
> > > Thanks for reporting the issue.
> > > 
> > > I guess you are trying the "0xffffffff81c00ae7", let me try to reproduce
> > > this issue.
> > 
> > yes, I also checked and it did not happen before
> > 
> > jirka
> > 
> 
> Hi Jiri,
> 
> Can you try this fix?
> 
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> index ff5711899234..5144528b2931 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -2497,7 +2497,7 @@ add_annotate_opt(struct hist_browser *browser,
>                  struct map_symbol *ms,
>                  u64 addr)
>  {
> -       if (ms->map->dso->annotate_warned)
> +       if (!ms->map || !ms->map->dso || ms->map->dso->annotate_warned)
>                 return 0;
> 
>         if (!ms->sym) {
> 
> It's tested OK at my side.

yep, the crash is gone

thanks,
jirka

