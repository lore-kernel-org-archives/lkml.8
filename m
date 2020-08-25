Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E5DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 11:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B9252075B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 11:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbgHYLaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 07:30:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:48544 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729873AbgHYLai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 07:30:38 -0400
IronPort-SDR: WX8L3KV96ku79Nf9r4h+0gDv4sDZnI2239qdytptwsvQwBBxiExiZmRUx4VMiP4mvqf9dSBgRc
 okg/8tTv2W3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="217639210"
X-IronPort-AV: E=Sophos;i="5.76,352,1592895600"; 
   d="scan'208";a="217639210"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 04:30:37 -0700
IronPort-SDR: Cw0zsvQfZWTy6EChTIs8JaO7TilN2bRjltLXo2WJL0jzvCmFUz+oCdjpLnEw336Pr3U/zyDNpK
 JYTaCE6Pwr3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,352,1592895600"; 
   d="scan'208";a="328838992"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 25 Aug 2020 04:30:35 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kAX9t-00BJQG-6Z; Tue, 25 Aug 2020 14:30:33 +0300
Date:   Tue, 25 Aug 2020 14:30:33 +0300
From:   'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v1] sched/topology: Make compiler happy about unused
 constant definitions
Message-ID: <20200825113033.GW1891694@smile.fi.intel.com>
References: <20200824153902.57875-1-andriy.shevchenko@linux.intel.com>
 <jhjeenwdl7u.mognet@arm.com>
 <20200825082636.GQ1891694@smile.fi.intel.com>
 <8dbf0f1e60c848f0abafd5fa0490ff70@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8dbf0f1e60c848f0abafd5fa0490ff70@AcuMS.aculab.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 10:23:05AM +0000, David Laight wrote:
> From: Andy Shevchenko
> > Sent: 25 August 2020 09:27
> > On Mon, Aug 24, 2020 at 06:09:41PM +0100, Valentin Schneider wrote:
> > > On 24/08/20 16:39, Andy Shevchenko wrote:
> > > > Compilation of almost each file ends up with
> > > >
> > > >  In file included from .../include/linux/energy_model.h:10,
> > > >                 from .../include/linux/device.h:16,
> > > >                 from .../drivers/spi/spi.c:8:
> > > >  .../include/linux/sched/topology.h:30:27: warning: ‘SD_DEGENERATE_GROUPS_MASK’ defined but not
> > used [-Wunused-const-variable=]
> > > >     30 | static const unsigned int SD_DEGENERATE_GROUPS_MASK =
> > > >        |                           ^~~~~~~~~~~~~~~~~~~~~~~~~
> > > >  ...
> > > >
> > > > Make compiler happy by annotating the static constants with __maybwe_unused.
> > > >
> > >
> > > That should see some use as long as the build is for SMP. This whole region
> > > is guarded by #ifdef CONFIG_SMP, so an !SMP build shouldn't trigger this.
> > 
> > Isn't SMP is default for most of the kernel builds?
> > And honestly I didn't get the purpose of this comment.
> 
> The real fix is to not use 'static const' in C.
> IIRC it is still a memory location (that can be patched) not
> a compile time constant.

Yep. The topology.h can be rather split to topology.c with exported symbols
(exported or just visible for linker, depends on the case).

-- 
With Best Regards,
Andy Shevchenko


