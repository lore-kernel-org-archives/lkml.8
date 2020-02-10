Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E0BC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0717720863
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XK+RKBY3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgBJP0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:26:10 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49561 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727363AbgBJP0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581348368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qNp6vQy5x2EVOfpL+WRRgMWjTTljcT3l8LtZST/yKsQ=;
        b=XK+RKBY34Rrr1we655BTGlILXrtpnaub5eHX5Pj+3piyEXTi0adnDPe+XkX7snDmdMZRCx
        DmwwMsOx2nq2ugX7YYC1tHkwJ3TlHaGgs36nzl8GwN6xw5GWuSjYZnB1TQ+Sg84DWEsW1B
        ddTM18vZOmMyYlVrV55btbF4QmzjERg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-CDF6RXG6OuaDZCW4gLABOw-1; Mon, 10 Feb 2020 10:25:49 -0500
X-MC-Unique: CDF6RXG6OuaDZCW4gLABOw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B55B8010FA;
        Mon, 10 Feb 2020 15:25:41 +0000 (UTC)
Received: from krava (unknown [10.43.17.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 62D8460BF1;
        Mon, 10 Feb 2020 15:25:39 +0000 (UTC)
Date:   Mon, 10 Feb 2020 16:25:37 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 2/4] perf tools: Mark ksymbol dsos with kernel type
Message-ID: <20200210152537.GA28110@krava>
References: <20200210143218.24948-1-jolsa@kernel.org>
 <20200210143218.24948-3-jolsa@kernel.org>
 <20200210151759.GB25639@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210151759.GB25639@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 12:17:59PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Feb 10, 2020 at 03:32:16PM +0100, Jiri Olsa escreveu:
> > We add ksymbol map into machine->kmaps, so it needs to be
> > created as 'struct kmap', which is dependent on its dso
> > having kernel type.
> > 
> > Reported-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> > Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/machine.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index e3e5490f6de5..0a43dc83d7b2 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -727,8 +727,14 @@ static int machine__process_ksymbol_register(struct machine *machine,
> >  	struct map *map = maps__find(&machine->kmaps, event->ksymbol.addr);
> >  
> >  	if (!map) {
> > -		map = dso__new_map(event->ksymbol.name);
> > -		if (!map)
> > +		struct dso *dso = dso__new(event->ksymbol.name);
> > +
> > +		if (dso) {
> > +			dso->kernel = DSO_TYPE_KERNEL;
> > +			map = map__new2(0, dso);
> > +		}
> > +
> > +		if (!dso || !map)
> 
> We leak dso if map creation fails?

yep :-\ will post v2

thanks,
jirka

> 
> 
> - Arnaldo
> 
> >  			return -ENOMEM;
> >  
> >  		map->start = event->ksymbol.addr;
> > -- 
> > 2.24.1
> > 
> 
> -- 
> 
> - Arnaldo
> 

