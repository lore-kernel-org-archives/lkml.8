Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3886C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7551C2080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mj5DUC60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgAJPE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 10:04:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46035 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728167AbgAJPEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 10:04:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578668662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zpRs+t3MnBquJOXxU7DLw4h9hLZJR04RmfH2UeDCZ2w=;
        b=Mj5DUC60G6wm7gMuAzjujeUPCS6yyssSlFzqlYPQ833QkECPIjhyi1LoM748DNTD5HQvrH
        h8xKFb6d+u/+Y0z/XQTNUxoC7GwhcI0JXJt/KVqbGz7EPZRgW6/nXcuic6ITlKNVcx/gb8
        lMBr5yZuxxb9DJrqnzNpQm5FsYrCsqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-fmVMeFvvMLOECcXhOOR0wA-1; Fri, 10 Jan 2020 10:04:19 -0500
X-MC-Unique: fmVMeFvvMLOECcXhOOR0wA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8CC4107ACC5;
        Fri, 10 Jan 2020 15:04:16 +0000 (UTC)
Received: from krava (ovpn-205-164.brq.redhat.com [10.40.205.164])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E9F628088C;
        Fri, 10 Jan 2020 15:04:12 +0000 (UTC)
Date:   Fri, 10 Jan 2020 16:04:10 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v4 1/2] perf parse: Refactor struct perf_evsel_config_term
Message-ID: <20200110150410.GG82989@krava>
References: <20200108142010.11269-1-leo.yan@linaro.org>
 <CANLsYkzv2Di-qeU1Q3M4Ro21hQ09eE26FBjeP1A9uSsA_W2Uww@mail.gmail.com>
 <20200109050753.GA24741@leoy-ThinkPad-X240s>
 <20200109163424.GA5721@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109163424.GA5721@xps15>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 09:34:24AM -0700, Mathieu Poirier wrote:

SNIP

> 
> If we are to deal with all flields of the union, I think it should be as below:
> 
>         union {
>                 bool            cfg_bool;
>                 int             cfg_int;
>                 unsigned long   cfg_ulong;
>                 u32             cfg_u32;
>                 char            *cfg_str;
>         } val;
> 
> But just dealing with the "char *" as below would also be fine with me:
> 
>         union {
>                 u64           period;
>                 u64           freq;
>                 bool          time;
>                 u64           stack_user;
>                 int           max_stack;
>                 bool          inherit;
>                 bool          overwrite;
>                 unsigned long max_events;
>                 bool          percore;
>                 bool          aux_output;
>                 u32           aux_sample_size;
>                 u64           cfg_chg;
>                 u64           num;
>                 char          *str;
>         } val;
> 
> > 
> > struct perf_evsel_config_term {
> >         struct list_head      list;
> >         enum evsel_term_type  type;
> >         union {
> >                 u64           period;
> >                 u64           freq;
> >                 bool          time;
> >                 char          *callgraph;
> >                 char          *drv_cfg;
> >                 u64           stack_user;
> >                 int           max_stack;
> >                 bool          inherit;
> >                 bool          overwrite;
> >                 char          *branch;
> >                 unsigned long max_events;
> >                 bool          percore;
> >                 bool          aux_output;
> >                 u32           aux_sample_size;
> >                 u64           cfg_chg;
> > +               u64           num;
> > +               char          *str;
> >         } val;
> >         bool weak;
> > };
> > 
> > > I will let Jiri make the
> > > final call but if we are to proceed this way I think we should have a
> > > member per type to avoid casting issues.
> > 
> > Yeah, let's see what's Jiri thinking.
> > 
> > Just note, with this change, I don't see any casting warning or errors
> > when built perf on arm64/arm32.
> 
> At this time you may not, but they will happen and it will be very hard to
> debug.

hi,
sry for late reply..

I think ;-) we should either add all different types to the union
or just add 'str' pointer to handle strings correctly.. which seems
better, because it's less changes and there's no real issue that
would need that other bigger change

jirka

