Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D83BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEF3B2084C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593783923;
	bh=hm3Moh7xHMlFJvAAJ9OOz3vc20Ys5RgWmTwwcOCFC4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vt9foSMSuPpz2EumTcBXJt+4UN2mA+gT/6If1xf6Vze3GNeQ1kHBkH1/qDSCwWODq
	 ynGSmxc3Qzfcbg3z5Sglcv2zQ+as+HVAZYeqqfmUrqmTG7A0o2RzXkYfeY8/g/D7qw
	 UcR6MVkmpOx4sfGkz5ZcvyoEElHyz690ATI8C5dI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgGCNpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 09:45:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbgGCNpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 09:45:22 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F10320826;
        Fri,  3 Jul 2020 13:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593783921;
        bh=hm3Moh7xHMlFJvAAJ9OOz3vc20Ys5RgWmTwwcOCFC4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jXGop+ok38hzk7QdHVtN0HtuYUcBxp395jqRjI6yYNHKdC+4CWmuGgM/jDbgpN9Jb
         W8jI0RaxPNXsAVQjw4meJCfSpmnZKWUDAz0s6BGZTviRf3Bj6gz9BVpSXym2hRmjxY
         wDg8LS8/YBKzPcDpvmj/ZuNSE3rC2tNhpPiJD9F0=
Date:   Fri, 3 Jul 2020 14:45:16 +0100
From:   Will Deacon <will@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Alexandru Elisei <alexandru.elisei@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, Julien Thierry <julien.thierry@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, maz@kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, catalin.marinas@arm.com,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v5 3/7] arm64: perf: Remove PMU locking
Message-ID: <20200703134515.GF18953@willie-the-truck>
References: <20200617113851.607706-1-alexandru.elisei@arm.com>
 <20200617113851.607706-4-alexandru.elisei@arm.com>
 <159242503203.62212.1690942414916053920@swboyd.mtv.corp.google.com>
 <bc265120-0d48-bcab-a58e-3b94f8c540ce@arm.com>
 <159255539947.62212.6059916295459835174@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159255539947.62212.6059916295459835174@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 01:29:59AM -0700, Stephen Boyd wrote:
> Quoting Alexandru Elisei (2020-06-18 03:51:31)
> > The armv8pmu_{start,stop}() functions are called from the irq handler, so we're
> > safe from preemption in this case. They are also called via
> > pmu->pmu_{enable,disable} callbacks, and I didn't find an explicit contract
> > regarding preemption in include/linux/perf_event.h. I've checked the other call
> > sites, and I didn't find any instances where they are called with preemption
> > enabled, which makes sense as we don't want to disable the PMU on a another CPU by
> > accident.
> 
> If they're all callbacks then it's overkill to add this. Presumably it
> is better to enforce this wherever the callbacks are called from so as
> to not litter the callee with random cant_sleep() calls. Probably best
> to ignore my suggestion.
> 
> > 
> > I would be inclined to add cant_sleep() calls to armv8pmu_{start,stop}(). In the
> > previous iteration, there were WARN_ONs in these functions, and Will said [1] they
> > can be removed because they are per-CPU operations. Will, what do you think about
> > adding the lockdep assertions?
> > 
> > [1] https://www.spinics.net/lists/arm-kernel/msg745161.html
> > 
> 
> If I read it correctly Will is saying the same thing in that thread.

Right, in the cases where perf core already relies on things not being
preemptible, we don't need to add extra checks.

Will
