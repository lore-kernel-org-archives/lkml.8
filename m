Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6341FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 19:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B69D20810
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 19:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592336366;
	bh=Xy6OqRUCqFwqYeR610bNt54TVmb+uhKNUrgS6dl3UV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NGwl/bYYL+lSe4klINqOebEuM89Z13Q67/yHtzOooRzHYMq8Ot4C1VlMOL2NoN3S6
	 Dnmjs7SZ6DsO74TSw8r68rJoADXxOkAEsP7L0hRTzfxL605wsjKcsWZvL3O5pSJ8cv
	 A9AhlMAX8si+GzzdjPpv5I1nf7VKcTjWWzhWNoCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbgFPTjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 15:39:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730792AbgFPTjX (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 15:39:23 -0400
Received: from quaco.ghostprotocols.net (unknown [179.162.131.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 756D820810;
        Tue, 16 Jun 2020 19:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592336362;
        bh=Xy6OqRUCqFwqYeR610bNt54TVmb+uhKNUrgS6dl3UV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NF5YuhrllIfDNymltrHZ+1Vv+srN2zQip0oBZKujCkgwDBxEivG8lSt+8J/Jvm1Qm
         vKq0YRP+kyaiR/C6pG8CmLJqX3H9pTbmYG7LbI1ePOaigi0raGDbHupOopK7SCOmNi
         0OHyqOW6UrF3bSjjEAwrFH0kYTLaov2CrbRu7vFQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 76EF040AFD; Tue, 16 Jun 2020 16:38:56 -0300 (-03)
Date:   Tue, 16 Jun 2020 16:38:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <Linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>, kan.liang@intel.com,
        "Jin, Yao" <yao.jin@intel.com>
Subject: Re: [PATCH 0/2] Update CascadelakeX and SkylakeX events list
Message-ID: <20200616193856.GC6393@kernel.org>
References: <20200603021818.27028-1-yao.jin@linux.intel.com>
 <911b4132-d1a1-f3c4-a2ed-2fcfe9a28fc6@linux.intel.com>
 <CAP-5=fW3OCuVkQ8csYfHXj5c_pCSY5-6vDrj2r=MNDZmpo0f8g@mail.gmail.com>
 <c7edd282-f58a-4efe-5961-6c1369b6b77b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7edd282-f58a-4efe-5961-6c1369b6b77b@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 16, 2020 at 02:27:40PM +0800, Jin, Yao escreveu:
> On 6/16/2020 2:16 PM, Ian Rogers wrote:
> > On Mon, Jun 15, 2020 at 6:00 PM Jin, Yao <yao.jin@linux.intel.com> wrote:
> > > Can I get an ACK for this patchset?
> > > On 6/3/2020 10:18 AM, Jin Yao wrote:
> > > > This patchset updates CascadelakeX events to v1.08 and
> > > > updates SkylakeX events to v1.21.

> > > > The events have been tested on CascadelakeX and SkylakeX
> > > > servers with latest perf/core branch.

> > could you rebase this on Arnaldo's tmp.perf/core tree?
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=tmp.perf/core
> > I tried using git am but get:
> > Applying: perf vendor events: Update CascadelakeX events to v1.08
> > error: patch fragment without header at line 279: @@ -213,14 +220,14 @@
> > error: could not build fake ancestor
> > Patch failed at 0001 perf vendor events: Update CascadelakeX events to v1.08
> > 
> > Thanks,
> > Ian
> > 
> 
> The patchset are applied OK on perf/core branch.
> 
> As far as I understand, the patch for posting should be based on perf/core branch, is it right?

Sorry, I've been testing with using tmp.perf/core as a way to more
quickly make available what I've processed, before I test it thoroughly
both with container builds and with manual testing, so the bleeding edge
is there, perf/core becoming a bit more stable, as I'll try not to
rebase it like before.

- Arnaldo
