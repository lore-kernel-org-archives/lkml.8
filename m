Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46825C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 148792078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594385788;
	bh=2UUua3qgzzBHbKum+Illo/Afn1kWl3g1hfBtYCm5K84=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=0pW96+ODExqJcWmpxKcLhXwBP4Eq3m740gj4lARm9hYnMKBNDrFhIthDgHNkz33JG
	 PQTHGFBJM23caQmE4qpWGdWrBLk01EbPRGodzhXQriw3ua0EU2cLA3dzHocNdI9BPY
	 yhB4Pr1lo8Smy90cP9+pQIbQwFQ58JK0UPQnRh2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgGJM41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 08:56:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbgGJM40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 08:56:26 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C110320720;
        Fri, 10 Jul 2020 12:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594385785;
        bh=2UUua3qgzzBHbKum+Illo/Afn1kWl3g1hfBtYCm5K84=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iEfOi5PBhiZra3tebUjeaBxteXstOfjtJUVtfwCIcl95pCp4PnQiSNtNyS6u4cZ3p
         9nNgEo1/UqC0QIGd91RZRAtDOvflsKZGq18WkWSJncn4zTM6rxLo0ZW30sLatpap4R
         MBek6RlI/vd6sMFgtnMwd4QJj+UnQLEIj6MsNRwo=
Date:   Fri, 10 Jul 2020 21:56:21 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andi Kleen <andi@firstfloor.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 4/4] perf-probe: Warn if the target function is GNU
 Indirect function
Message-Id: <20200710215621.eca829d202b912b74bec276c@kernel.org>
In-Reply-To: <20200710115540.GC22500@kernel.org>
References: <159428201109.56570.3802208017109058146.stgit@devnote2>
        <159428205174.56570.17588311835868886287.stgit@devnote2>
        <20200709143654.pw2maoxivsjho6op@two.firstfloor.org>
        <20200710123008.3af0e5ea78a9ff95d36a29d8@kernel.org>
        <20200710115540.GC22500@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jul 2020 08:55:40 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Fri, Jul 10, 2020 at 12:30:08PM +0900, Masami Hiramatsu escreveu:
> > On Thu, 9 Jul 2020 07:36:54 -0700
> > Andi Kleen <andi@firstfloor.org> wrote:
> > 
> > > > diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> > > > index 1e95a336862c..671176d39569 100644
> > > > --- a/tools/perf/util/probe-event.c
> > > > +++ b/tools/perf/util/probe-event.c
> > > > @@ -379,6 +379,11 @@ static int find_alternative_probe_point(struct debuginfo *dinfo,
> > > >  			address = sym->start;
> > > >  		else
> > > >  			address = map->unmap_ip(map, sym->start) - map->reloc;
> > > > +		if (sym->type == STT_GNU_IFUNC) {
> > > > +			pr_warning("Warning: The probe address (0x%lx) is in a GNU indirect function.\n"
> > > > +				"This may not work as you expected unless you intend to probe the indirect function.\n",
> > > 
> > > I would say something like this.
> > > 
> > > Consider identifying the final function used at run time and set the
> > > probe directly on that.
> > > 
> > > I think that's more useful to the user.
> > 
> > Hmm, would you mean the default function which may be used for the symbol?
> 
> Humm, I think he means that the user must somehow, knowing details
> involved in picking the final function, probe that one instead of the
> IFUNC one, right Andi?

Ah, I got it. OK, I'll update the message :)

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
