Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481D5C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FEF52078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594382146;
	bh=2o/LA/3PfUUOILRSqwl1JI7DuPhYAX0BoJ0FuutNQjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qDhqwBHyjuC8KPodg4Twq4x+/CPrs36Kuh3sAlPH+hJ5Ck4/Ec3bpXwDYZBsk8LPa
	 RNpdWIFhAI86wmI4NrVrUfnGnZEYl90YhaJJSp3QrrVKEUCfM0+2D7HVbRumpAzkyF
	 0jx3yF/XzHf8+bE5K24/PkpSye4WesNWeUhjj/Pk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgGJLzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:55:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgGJLzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 07:55:43 -0400
Received: from quaco.ghostprotocols.net (unknown [179.179.81.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E726C20748;
        Fri, 10 Jul 2020 11:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594382143;
        bh=2o/LA/3PfUUOILRSqwl1JI7DuPhYAX0BoJ0FuutNQjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0siQs8omIeCqV1ZmiT+As2/L+WGGQVFkkcAyVjTeSdY8CCi2unz4/BpB5b89g2VuJ
         5sZScH7PUULx74ZvtTxmw1MLT2s1zL+tsxejpv1u/otsQSmUd+H7SIMqv6p3lEijIj
         U9F5LA6gmnQ0GdqhgBn03T0JSrFf1kXqKgsnZDxE=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 213DE405FF; Fri, 10 Jul 2020 08:55:40 -0300 (-03)
Date:   Fri, 10 Jul 2020 08:55:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andi Kleen <andi@firstfloor.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 4/4] perf-probe: Warn if the target function is GNU
 Indirect function
Message-ID: <20200710115540.GC22500@kernel.org>
References: <159428201109.56570.3802208017109058146.stgit@devnote2>
 <159428205174.56570.17588311835868886287.stgit@devnote2>
 <20200709143654.pw2maoxivsjho6op@two.firstfloor.org>
 <20200710123008.3af0e5ea78a9ff95d36a29d8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710123008.3af0e5ea78a9ff95d36a29d8@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 10, 2020 at 12:30:08PM +0900, Masami Hiramatsu escreveu:
> On Thu, 9 Jul 2020 07:36:54 -0700
> Andi Kleen <andi@firstfloor.org> wrote:
> 
> > > diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> > > index 1e95a336862c..671176d39569 100644
> > > --- a/tools/perf/util/probe-event.c
> > > +++ b/tools/perf/util/probe-event.c
> > > @@ -379,6 +379,11 @@ static int find_alternative_probe_point(struct debuginfo *dinfo,
> > >  			address = sym->start;
> > >  		else
> > >  			address = map->unmap_ip(map, sym->start) - map->reloc;
> > > +		if (sym->type == STT_GNU_IFUNC) {
> > > +			pr_warning("Warning: The probe address (0x%lx) is in a GNU indirect function.\n"
> > > +				"This may not work as you expected unless you intend to probe the indirect function.\n",
> > 
> > I would say something like this.
> > 
> > Consider identifying the final function used at run time and set the
> > probe directly on that.
> > 
> > I think that's more useful to the user.
> 
> Hmm, would you mean the default function which may be used for the symbol?

Humm, I think he means that the user must somehow, knowing details
involved in picking the final function, probe that one instead of the
IFUNC one, right Andi?

- Arnaldo

> Let me check how we can find it.
