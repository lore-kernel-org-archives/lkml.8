Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D714BC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B045E20748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594381422;
	bh=5jcdvmxdzuS8au/dYCdnb38PExsciucKDn1UmbzwNlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QhE8XKyv9wS+NR1IFXTWUyReSdUFaVh2QjLA2waPIYiR/UJaLGCC8bQQ686UnoSix
	 xhVFy/Nb3CnmI69bM56p8PnrWzOlfWdVvFxNMQe+AMs0Gkau15A+AxGyHMxwXpnS8N
	 MSmp2ZGXwmpvkZtwte1PAQfhCcmvEUhFi1LnQWdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgGJLnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:43:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbgGJLnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 07:43:41 -0400
Received: from quaco.ghostprotocols.net (unknown [179.179.81.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4388A20748;
        Fri, 10 Jul 2020 11:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594381420;
        bh=5jcdvmxdzuS8au/dYCdnb38PExsciucKDn1UmbzwNlA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I2kHl9POXKnZPeHMbMfXjnnyYAZsq5aS8WrmhXttAKJ+H2GYCK5g4Whl3vojm51Q0
         +gfvP1Bq8RfpN5KWs/uX4Mvikl9mmjqxvQ5/oDguf/I6Ep5i25i27W5gQEVDtwfmFo
         op9jInWewhfdPKVGhDYxqg1tBtPNtk8D1uiOIUns=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 01953405FF; Fri, 10 Jul 2020 08:43:37 -0300 (-03)
Date:   Fri, 10 Jul 2020 08:43:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 00/15] perf/x86: Add perf text poke events
Message-ID: <20200710114337.GB22500@kernel.org>
References: <20200512121922.8997-1-adrian.hunter@intel.com>
 <bee04840-143c-18bb-df82-5aa58d70730e@intel.com>
 <20200520014001.GF28228@kernel.org>
 <20200520155634.GQ317569@hirez.programming.kicks-ass.net>
 <20200527154716.GC16490@kernel.org>
 <20200527155436.GA706460@hirez.programming.kicks-ass.net>
 <79ca46d6-5d7c-7729-b51e-f9a447abe2a2@intel.com>
 <20200708123423.GL1320@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708123423.GL1320@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 08, 2020 at 09:34:23AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Jul 08, 2020 at 02:55:36PM +0300, Adrian Hunter escreveu:
> > On 27/05/20 6:54 pm, Peter Zijlstra wrote:
> > > On Wed, May 27, 2020 at 12:47:16PM -0300, Arnaldo Carvalho de Melo wrote:
> > >> Em Wed, May 20, 2020 at 05:56:34PM +0200, Peter Zijlstra escreveu:
> > >>> On Tue, May 19, 2020 at 10:40:01PM -0300, Arnaldo Carvalho de Melo wrote:
> > >>>> PeterZ, from what we discussed for the next merge Window, perhaps we
> > >>>> should route the kernel bits via the tip tree while I will push the
> > >>>> tooling bits on my 5.8 merge request to Linus, Ok?
> > >>>
> > >>> Sure, I can take the kernel bits. Thanks!
> > >>
> > >> So, I'm going thru the userpace bits and stopped at the patch copying
> > >> include/uapi/linux/perf_events.h to
> > >> tools/include/uapi/linux/perf_events.h to get the text_poke
> > >> perf_event_attr bit, looked at tip/ and this hasn't landed there yet,
> > >> any issues with the kernel bits?
> > > 
> > > Nah, I was waiting on the 0day robot, but its broken *again* :-(
> > > 
> > > Let me go move things along manually.
> > > 
> > 
> > Hi
> > 
> > The kernel patches are in tip and the remaining tools patches still apply.
> > Remaining patches 11-15 are:
> > 
> >       perf tools: Add support for PERF_RECORD_TEXT_POKE
> >       perf tools: Add support for PERF_RECORD_KSYMBOL_TYPE_OOL
> >       perf intel-pt: Add support for text poke events
> >       perf script: Add option --show-text-poke-events
> >       perf script: Show text poke address symbol
> 
> Sure, I'll merge those now that the kernel support is in tip, thanks for
> the reminder,

Done, now I need to build a kernel from tip/perf/core and test with the
tooling from acme/perf/core, will do later today.

So far what I have is in my repo at the tmp.perf/core branch, if anyone
wants to test before I do test it with the kernel with these features
and the usual container build tests.

- Arnaldo
