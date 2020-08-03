Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49170C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 242482064B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596459279;
	bh=dihwWGji4Y3Y13Cgm2yhUQVzGNJHEX8GTUBbBPPyhcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=08KNaJl6Wh1cssRJcBKE6G4+c50eyq73I0QPx4a4NwUQzJJhU0g2/7Jwhhd/eFFwH
	 L5CTIYJQjOTrt0sHQlabW8A6NgwKa8hp7/M3wmSm+vwKUJgdpMrka6V2ymgd392hzh
	 x8AkUxrormBEQv6YLy84DXr7szAYziaS8gIr1MfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgHCMyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:54:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:54464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbgHCMy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:54:26 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.178.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 182972076E;
        Mon,  3 Aug 2020 12:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596459265;
        bh=dihwWGji4Y3Y13Cgm2yhUQVzGNJHEX8GTUBbBPPyhcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w7TREd4IbYq7l0UxsLtO8kgFlvfhMT8W+tx+WnVzcLNuxp+McskB4AKpd5fJworgn
         0Mj7uRL9fn+wrAjKQuP2ZpzbdoJPjMzLaW4Ir7eVns/SEAwdi2FKjHpkSmra8Xnw/k
         vi5s3Mss4pT2FkcD3HysYfHCLIoqp+aZ8LPdLjDc=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D615540C7C; Mon,  3 Aug 2020 09:54:23 -0300 (-03)
Date:   Mon, 3 Aug 2020 09:54:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] perf pmu: Improve CPU core PMU HW event list
 ordering
Message-ID: <20200803125423.GA3440834@kernel.org>
References: <1592384514-119954-1-git-send-email-john.garry@huawei.com>
 <1592384514-119954-3-git-send-email-john.garry@huawei.com>
 <CAM9d7cgqJzQJ7GfL6Q3VgARd1=rrkRYqOqSivZww-LOo+DvKFA@mail.gmail.com>
 <20200617121549.GA31085@kernel.org>
 <74303789-6c06-574d-674b-202cf84a2018@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74303789-6c06-574d-674b-202cf84a2018@huawei.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 03, 2020 at 09:00:06AM +0100, John Garry escreveu:
> On 17/06/2020 13:15, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Jun 17, 2020 at 08:31:02PM +0900, Namhyung Kim escreveu:
> > > On Wed, Jun 17, 2020 at 6:06 PM John Garry <john.garry@huawei.com> wrote:
> > > > For perf list, the CPU core PMU HW event ordering is such that not all
> > > > events may will be listed adjacent - consider this example:
> > > >    cstate_pkg/c6-residency/                           [Kernel PMU event]
> > > >    cstate_pkg/c7-residency/                           [Kernel PMU event]

> > > > Signed-off-by: John Garry <john.garry@huawei.com>

> > > Acked-by: Namhyung Kim <namhyung@kernel.org>

> > Thanks a lot, applied.
 
> I'm struggling to understand which branch we should base our development on.
> I don't see these patches in perf/core or linux-next. I saw someone
> mentioned tmp.perf/core as a baseline, but I can't see that branch in
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
> 
> Please let me know - it would be useful for any dev during the merge window.

So, I'm now pushing things directly to Linus, but just the tooling part,
the branch to do development on is:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core

At some point I think we'll have a git/perf-tools/perf-tools.git, just
like tip, but for now, please use the one above.

My perf/core in the past was rebaseable, I did changes in it after
publishing, trying to have solid bisectability, since I process patch by
patch doing tests on it when we noticed problems, prior to pushing to
Ingo for tip.

Now I am making perf/core non-rebaseable, I push things there
periodically, tagging what is there with the test results, see:

  https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tag/?h=perf-tools-tests-2020-07-17
  https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tag/?h=perf-tools-tests-2020-07-02

I'll try and tag today's state of that tree, which I did tests already
but since v5.8 was released, I merged it there and will retest and tag
the test results.

The tmp.perf/core one is an experiment in making what I have in my local
tree available for more bleeding edge things that are being done, say in
that metrics effort, etc, but I think I'll stop that, since, as your
message shows, it is causing confusion.

I did this because these tests take quite some time and sometimes I have
to fix things and restart it, rinse, repeat.

So please use:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core

I'll further automate all this so that we have a more regular cadence of
updates to perf/core, say every two days or so.

If you have changes that touch both the kernel and userspace, the kernel
bits need to go via tip, the tooling via the perf tree, that for now
(well, it has been like that for quite a long time) is my tree.

Arch specific kernel bits have been going via the arch trees for quite a
while, I think.

- Arnaldo
