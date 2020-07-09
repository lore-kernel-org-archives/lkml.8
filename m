Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2508C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 12:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A63AB2076A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 12:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgGIMqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 08:46:33 -0400
Received: from foss.arm.com ([217.140.110.172]:56332 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgGIMqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 08:46:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BD421045;
        Thu,  9 Jul 2020 05:46:32 -0700 (PDT)
Received: from localhost (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1B093F71E;
        Thu,  9 Jul 2020 05:46:31 -0700 (PDT)
Date:   Thu, 9 Jul 2020 13:46:30 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: topology: Don't support AMU without cpufreq
Message-ID: <20200709124630.GB15342@arm.com>
References: <a710fc4e4e0f1d2e561320130b99bcb5167d73b4.1594277563.git.viresh.kumar@linaro.org>
 <20200709101734.GB5623@arm.com>
 <20200709104048.emwuquj2qkyascb3@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709104048.emwuquj2qkyascb3@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

On Thursday 09 Jul 2020 at 16:10:48 (+0530), Viresh Kumar wrote:
[..]
> > I agree that this happening is a cornercase and a reason for which
> > cpufreq_get_hw_max_freq() was made weak. If some platform has entirely
> > firmware driven frequency control, but it enables CONFIG_CPU_FREQ
> > (as is the default) and it defines its own cpufreq_get_hw_max_freq(),
> > it could benefit from AMU use.
> > 
> > So I did believe it was best for these checks to be decoupled, for this
> > reason, and potential other reasons in the future, involving more
> > decoupling from cpufreq.
> > 
> > I do have code in progress to clean the overall interaction between
> > cpufreq and AMUs, started at [1]. Bear with me on this, it is all
> > connected :).
> 
> Of course I missed few things here.
> 
> - I didn't realize that cpufreq_get_hw_max_freq() is defined weak :(
> 
>   I understand that we want to support everything that is possible,
>   but there is no need to support cases which we may never have
>   actually. We have seen code going in the kernel, which no one ever
>   ends up using.
> 
>   Do we see a case in near future where someone is going to override
>   this weak implementation ? If we don't have an actual target for it
>   at the moment, then we should probably remove the weak attribute and
>   simplify the code.
> 

I saw this case during FVP testing, although I acknowledge the 'virtual'
part of that platform [1]. But allowing this does enable AMU testing on
an AEM FVP.

While I completely understand the reasoning behind avoiding to introduce
large changes for small corner-case gains, the arguments for this
support was:
 - (1) AMUs are a new feature and it will take some time until we see the
   real usecases. That's always the case with early support for a
   feature - we want to add it early to enable its use and testing, but
   it will take some time to establish the true usecases.
 - (2) It literally needed 2 lines of code + the weak cpufreq function
   to support this.

> - I understood earlier that, we don't pick up AMU support unless all
>   CPUs of a policy are supported by AMUs, but forgot that later while
>   writing the patch. What is the thing with AMUs? Why would some
>   platform add it only for some CPUs out of a policy ? Do we have such
>   platforms already or in queue ?
> 

Given that I can't guarantee what hardware will or won't do, and given
that AMUs are an optional feature, I controlled the only thing I could:
the software :). By not making assumptions about the hardware, I ensured
that the code does not break the interaction between cpufreq use or AMU
use for frequency invariance.

This will be nicer in the new code as the control will be at CPU level,
rather than policy level.

[1]
https://developer.arm.com/tools-and-software/simulation-models/fixed-virtual-platforms

Regards,
Ionela.

> Lets discuss more after we have settled on the first point here.
> 
> Thanks for review Ionela.
> 
> -- 
> viresh
