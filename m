Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6ADC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 807C820786
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597858261;
	bh=l0KFEp2dDJCxx7pF7ESctcMNER5x8l1jMFgx6UM7GHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lzMdZHkIS5f9HrVKVGWOSxUVHOlL4rhfJe4pFz70RQ0ekNmKlrWhQe3ZXiL4l5zIw
	 DuulejAif4VYNLauMQ8vGMu1w6Xwhn41+ua05XpcMAv2l6WuZV4zjLtch8+aZ0dmlQ
	 UAr/F6kp+MVvjcnZe/GuQN1WkGuVO0fm5b6I937E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgHSRbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:31:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgHSRa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 13:30:56 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E80CA206FA;
        Wed, 19 Aug 2020 17:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597858255;
        bh=l0KFEp2dDJCxx7pF7ESctcMNER5x8l1jMFgx6UM7GHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qiz+7emYTNAzRzu0cndsEYJKOjF4i1zowG9c1JBxr7ipBO2QyTlrN7cha9WCWYe5R
         Dt9GqNsmon013InJOCcQvTA+CtORr5WDRoMt5iViJ0A9g7YGDtujAWvDe2Cbxn+IVh
         WNlNP5CHVkz3PCWYgIqwBIQfVvfN15CYfRiYkxZU=
Date:   Wed, 19 Aug 2020 18:30:50 +0100
From:   Will Deacon <will@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     John Garry <john.garry@huawei.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] MAINTAINERS: Add entries for CoreSight and Arm SPE
Message-ID: <20200819173050.GA18091@willie-the-truck>
References: <20200817193140.3659956-1-mathieu.poirier@linaro.org>
 <ede047ea-ad6a-1f7e-d597-b47bc87271c3@huawei.com>
 <CANLsYkw2aBJmrHV+8_bDUtgD-Jfvndqz2kOfNNcBBMM+vztkug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkw2aBJmrHV+8_bDUtgD-Jfvndqz2kOfNNcBBMM+vztkug@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 11:01:38AM -0600, Mathieu Poirier wrote:
> On Tue, 18 Aug 2020 at 11:56, John Garry <john.garry@huawei.com> wrote:
> > On 17/08/2020 20:31, Mathieu Poirier wrote:
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 4e2698cc7e23..f9bb76baeec9 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -13427,8 +13427,18 @@ F:   tools/perf/
> > >   PERFORMANCE EVENTS SUBSYSTEM ARM64 PMU EVENTS
> > >   R:  John Garry <john.garry@huawei.com>
> > >   R:  Will Deacon <will@kernel.org>
> > > +R:   Mathieu Poirier <mathieu.poirier@linaro.org>
> > > +R:   Leo Yan <leo.yan@linaro.org>
> > >   L:  linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > >   S:  Supported
> > > +F:   tools/build/feature/test-libopencsd.c
> > > +F:   tools/perf/arch/arm/util/auxtrace.c
> > > +F:   tools/perf/arch/arm/util/cs-etm.*
> > > +F:   tools/perf/arch/arm/util/pmu.c
> > > +F:   tools/perf/arch/arm64/util/arm-spe.c
> > > +F:   tools/perf/util/arm-spe.h
> > > +F:   tools/perf/util/cs-etm-decoder/*
> > > +F:   tools/perf/util/cs-etm.*
> >
> > But from the previous discussion, I thought that we wanted an entry to
> > cover all tools/perf/arch/arm64/ and other related folders. Or was it
> > just put all special interest parts (like SPE support) under one entry
> > and leave the other arm/arm64 parts to be caught by "PERFORMANCE EVENTS
> > SUBSYSTEM" entry?
> 
> I do not have the time to maintain anything outside of coresight -
> listing individual files as I did removes any ambiguity on that front.
> I'm happy to add tools/perf/arch/arm and tools/perf/arch/arm64/ if you
> agree to maintain them.  In that case you will have to be more
> specific about the "other related folders" you are referring to above.

None of us have time for this, hence why I think putting us all in one entry
with all of the files listed there makes the most sense; then people do
whatever they can and try to help each other out based on how much time they
have. I think that's much better than fine-grained maintainership where a
given file has a single point of failure.

So I think it should include:

  tools/perf/arch/arm64/
  tools/pmu-events/arch/arm64/

along with the SPE and Coresight files.

Arnaldo would still handle the patches, so this is really about giving us a
chance to review incoming patches without having to fish them out from the
lists.

Will
