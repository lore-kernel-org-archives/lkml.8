Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEC4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB63820643
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589468510;
	bh=R1T/vmvwwNTrikwodjjN+Hsr7qyr3/jAir0fcjlAId8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ehIAeHSN4UpTj4QO6iIXn6FVwxKLQEs85C7XgwzkMpgRCsHw6xIHT/ZDiIPm5LAW/
	 DTjIaqdwn8ghGza7EuKWJpgLYGjk0ZnPsZTdVqv5rPqsW8wvg4mDhuQTFq7axMLSw2
	 2z9ETnNI/LgEOiz4SR/xMxmnZkEkNXvfN3GMvmy0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgENPB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 11:01:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbgENPBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 11:01:24 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57F3E205CB;
        Thu, 14 May 2020 15:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589468484;
        bh=R1T/vmvwwNTrikwodjjN+Hsr7qyr3/jAir0fcjlAId8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W9wWS/DuC253QiJZHyyXgZtdyzL4jjwYXy+l5WtrxmxKTApA9vfRh3puW7Us25uL5
         2rUX8rtd0c6+RQg/vePl4zT7LT7haQHJoJNLSHzVgyLe2tFkkM3tJWyjkdE7QuJgna
         Ol2FAhB+RkG5wprlvlAgnIHC1V5BBAy1mX6IfK8c=
Date:   Thu, 14 May 2020 10:06:01 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH perf/core] perf intel-pt: Fix clang build failure in
 intel_pt_synth_pebs_sample
Message-ID: <20200514150601.GS4897@embeddedor>
References: <20200513234738.GA21211@embeddedor>
 <20200514131030.GL5583@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514131030.GL5583@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 10:10:30AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 13, 2020 at 06:47:38PM -0500, Gustavo A. R. Silva escreveu:
> > Fix the following build failure generated with command 
> > $ make CC=clang HOSTCC=clang -C tools/ perf:
> > 
> > util/intel-pt.c:1802:24: error: field 'br_stack' with variable sized type 'struct branch_stack' not at the end of a struct or class is a GNU extension [-Werror,-Wgnu-variable-sized-type-not-at-end]
> >                         struct branch_stack br_stack;
> >                                             ^
> > 1 error generated.
> > 
> > Fix this by reordering the members of struct br.
> 
> Yeah, I noticed that as far back as with ubuntu 16.04's clang:
> 
> clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
> 
> util/intel-pt.c:1802:24: error: field 'br_stack' with variable sized type 'struct branch_stack' not at the end of a struct or class is a GNU
>       extension [-Werror,-Wgnu-variable-sized-type-not-at-end]
>                         struct branch_stack br_stack;
>                                             ^
> 1 error generated.
> 
> 
> Will fold this with the bug introducing the problem to avoid bisection
> problems.
> 

I agree. Also, the commit hash of the "Fixes" tag only applies to the
perf/core branch and, I guess that might create confusion.

Thanks
--
Gustavo
