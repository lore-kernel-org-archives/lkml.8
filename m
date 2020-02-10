Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35457C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED97520838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcGXIHax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgBJT6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 14:58:09 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46250 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJT6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 14:58:08 -0500
Received: by mail-qt1-f193.google.com with SMTP id e21so2116694qtp.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 11:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l0K3AGZnUpPQoJYK68VQgpnmDC4xCgITd/YqgZYJNHM=;
        b=lcGXIHaxb5MuFQZOhwUJbPdB7FmQHTSkZCkmXIac0N7+fiQhPvB7VcnpkJSZBJuqJQ
         a4QkgUp9kIvMQq7npx5k2r/Berh/3JzSeJ/WTWbz7dBiXUn4SWUvbTgQrPmg2hCZ6NA9
         HX5Dk511006lsnbRKuvXkD5cWRPd7MYPGutatqey0f/8ZVEklgUK+AqfAt+zc2ojyUNS
         dS6zBsUkeA53Kn62/jSz4Y3blv/StIzMGW0cEc2uZyop4P4xHJQM9tI0fkQSaPYUW6uu
         pzmQwZO5fTE1cilL/BJmw1s33j8oBuNlSiczbKersfrmig1MmV9wu3suwY3tJbnq+OT2
         QWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l0K3AGZnUpPQoJYK68VQgpnmDC4xCgITd/YqgZYJNHM=;
        b=WOqNPlpLbWHpUYJHIzRb71mh+n5j/V5z1AklFiEjD68iBgmjYSGSm8heRxI8X36ePe
         gdICFhjvVmZnOY6D+RBLu866KWrmnyC7dxbrxDZ8IV7sQtrylXI0OiRm5vTDPnhiihY5
         n8h9CpHdk0Jp4uAhbskyi9X6ewk82soGlGvr2vhnAegjB1SKWcc1/LoE0MXSK/uBwp2q
         7n9J2q/g+QlAV5r+t1dZOhy3Yr/EpewfSPSGe9EgbbpGBi2lSADGXsqmMR7qhXuVou2C
         BoLnUpgt2A0KbR7B1fwJihZ/2ksunpR3P+1pvSKjEHfIeNIh0OM44MiJp6lcj0WiBIaJ
         12Gg==
X-Gm-Message-State: APjAAAWqA4vw16rN38Mon4W2Hg3UMfciTUXkZwSm/xvdrrtL4fu7c2qe
        hZyWgP+cJopJueGIqkcCAL3WoTP6
X-Google-Smtp-Source: APXvYqweQzA//xW0XLoPVgTBwQEljcQMRtEnPLtazc7Xke+0SmuWvhHgGINGtepVJfXcXaXlnQYy7Q==
X-Received: by 2002:ac8:718e:: with SMTP id w14mr11610795qto.266.1581364687866;
        Mon, 10 Feb 2020 11:58:07 -0800 (PST)
Received: from quaco.ghostprotocols.net ([177.195.209.0])
        by smtp.gmail.com with ESMTPSA id 73sm699829qtg.40.2020.02.10.11.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 11:58:07 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 16C9F40A7D; Mon, 10 Feb 2020 16:58:01 -0300 (-03)
Date:   Mon, 10 Feb 2020 16:58:01 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 2/4] perf tools: Mark ksymbol dsos with kernel type
Message-ID: <20200210195801.GF3416@kernel.org>
References: <20200210143218.24948-1-jolsa@kernel.org>
 <20200210143218.24948-3-jolsa@kernel.org>
 <20200210151759.GB25639@kernel.org>
 <20200210152537.GA28110@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210152537.GA28110@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 10, 2020 at 04:25:37PM +0100, Jiri Olsa escreveu:
> On Mon, Feb 10, 2020 at 12:17:59PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Feb 10, 2020 at 03:32:16PM +0100, Jiri Olsa escreveu:
> > > We add ksymbol map into machine->kmaps, so it needs to be
> > > created as 'struct kmap', which is dependent on its dso
> > > having kernel type.
> > > 
> > > Reported-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> > > Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/perf/util/machine.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > > index e3e5490f6de5..0a43dc83d7b2 100644
> > > --- a/tools/perf/util/machine.c
> > > +++ b/tools/perf/util/machine.c
> > > @@ -727,8 +727,14 @@ static int machine__process_ksymbol_register(struct machine *machine,
> > >  	struct map *map = maps__find(&machine->kmaps, event->ksymbol.addr);
> > >  
> > >  	if (!map) {
> > > -		map = dso__new_map(event->ksymbol.name);
> > > -		if (!map)
> > > +		struct dso *dso = dso__new(event->ksymbol.name);
> > > +
> > > +		if (dso) {
> > > +			dso->kernel = DSO_TYPE_KERNEL;
> > > +			map = map__new2(0, dso);
> > > +		}
> > > +
> > > +		if (!dso || !map)
> > 
> > We leak dso if map creation fails?
> 
> yep :-\ will post v2

Please collect Kim's Tested-by then,

- Arnaldo
 
> thanks,
> jirka
> 
> > 
> > 
> > - Arnaldo
> > 
> > >  			return -ENOMEM;
> > >  
> > >  		map->start = event->ksymbol.addr;
> > > -- 
> > > 2.24.1
> > > 
> > 
> > -- 
> > 
> > - Arnaldo
> > 
> 

-- 

- Arnaldo
