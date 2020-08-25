Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798D2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 11:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D4562068E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 11:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbgHYLfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 07:35:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:22554 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgHYLfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 07:35:09 -0400
IronPort-SDR: U5aAOU9Dlzwvyup0XJJS6/hkJ8i+AtdfBqCQ2NyWom1NSmw6v+uWD50zukLvLWdSPHh+yJdG0t
 LfydBSaOnerA==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="135636757"
X-IronPort-AV: E=Sophos;i="5.76,352,1592895600"; 
   d="scan'208";a="135636757"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 04:35:08 -0700
IronPort-SDR: tQyRPfHqHTOmI/TbRlFigDMZSpBPcpM/C6j7QxHXoZ4cJoSe6mHkDnzJd8zNcgfpnOVdUUmbsk
 YPrSgcJ225aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,352,1592895600"; 
   d="scan'208";a="328839686"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 25 Aug 2020 04:35:02 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kAX3d-00BJMC-Pw; Tue, 25 Aug 2020 14:24:05 +0300
Date:   Tue, 25 Aug 2020 14:24:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v1] sched/topology: Make compiler happy about unused
 constant definitions
Message-ID: <20200825112405.GU1891694@smile.fi.intel.com>
References: <20200824153902.57875-1-andriy.shevchenko@linux.intel.com>
 <jhjeenwdl7u.mognet@arm.com>
 <20200825082636.GQ1891694@smile.fi.intel.com>
 <jhjd03fdrn3.mognet@arm.com>
 <jhjblizdofu.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jhjblizdofu.mognet@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 11:12:21AM +0100, Valentin Schneider wrote:
> On 25/08/20 10:03, Valentin Schneider wrote:
> > On 25/08/20 09:26, Andy Shevchenko wrote:
> >> On Mon, Aug 24, 2020 at 06:09:41PM +0100, Valentin Schneider wrote:
> >>> On 24/08/20 16:39, Andy Shevchenko wrote:
> >>> > Compilation of almost each file ends up with
> >>> >
> >>> >  In file included from .../include/linux/energy_model.h:10,
> >>> >                 from .../include/linux/device.h:16,
> >>> >                 from .../drivers/spi/spi.c:8:
> >>> >  .../include/linux/sched/topology.h:30:27: warning: ‘SD_DEGENERATE_GROUPS_MASK’ defined but not used [-Wunused-const-variable=]
> >>> >     30 | static const unsigned int SD_DEGENERATE_GROUPS_MASK =
> >>> >        |                           ^~~~~~~~~~~~~~~~~~~~~~~~~
> >>> >  ...
> >>> >
> >>> > Make compiler happy by annotating the static constants with __maybwe_unused.
> 
> > Sorry, that's what I get for trying to be too succinct; what I tried to say
> > was that SD_DEGENERATE_GROUPS_MASK should very much be used for SMP. If the
> > build is !SMP, it shouldn't even be defined, IOW I'm perplexed as to where
> > this is coming from.
> 
> So I see how having this as a constvar rather than a constexpr is somewhat
> daft (we get an instance per compilation unit), but none of my compilers
> seem to complain (even with W=1). AFAIA the kernelbot didn't catch any of
> it either.
> 
> Out of curiosity, what's your compiler & compiler version?

% gcc --version
gcc (Debian 10.2.0-5) 10.2.0

% make O=... W=1 C=1 CF=-D__CHECK_ENDIAN__ -j64

> Alternatively we can make this a "proper" constant expression with the
> below.

It doesn't fix another static const in the same file, though that one requires
DEBUG_SCHED to be enabled.

Do you want me to split this fix and fix only the other case?

> ---
> 
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 2d59ca77103e..b1331c4c48e9 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -27,9 +27,11 @@ enum {
> 
>  /* Generate a mask of SD flags with the SDF_NEEDS_GROUPS metaflag */
>  #define SD_FLAG(name, mflags) (name * !!((mflags) & SDF_NEEDS_GROUPS)) |
> -static const unsigned int SD_DEGENERATE_GROUPS_MASK =
> +enum {
> +	SD_DEGENERATE_GROUPS_MASK =
>  #include <linux/sched/sd_flags.h>
> -0;
> +0
> +};
>  #undef SD_FLAG
> 
>  #ifdef CONFIG_SCHED_DEBUG

-- 
With Best Regards,
Andy Shevchenko


