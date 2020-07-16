Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD35C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 20:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C315206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 20:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbgGPUN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 16:13:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:57825 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728788AbgGPUN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 16:13:27 -0400
IronPort-SDR: toPVT0M45iPCCadNNsANJ7lJiaqisHTjDvMiApWhFAAyGZg+BIUeRi4r8LOt45VI6Yw+fwn/07
 8jVltA/3anGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="214214451"
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="214214451"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 13:13:26 -0700
IronPort-SDR: fqjbAsFcqXqHhyz4Ik6CS/yPTPtMpP9HdDCtL+5XDmAJF+f4N+jIuG6NAA+IjvsraVzZ7zwVzm
 q1ZfLMKcWH8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="308761731"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga004.fm.intel.com with ESMTP; 16 Jul 2020 13:13:26 -0700
Date:   Thu, 16 Jul 2020 13:13:26 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/split_lock: Enumerate split lock feature on Sapphire
 Rapids
Message-ID: <20200716201325.GB66451@romley-ivt3.sc.intel.com>
References: <1593208534-33721-1-git-send-email-fenghua.yu@intel.com>
 <20200716193659.GA66451@romley-ivt3.sc.intel.com>
 <20200716195010.GV10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716195010.GV10769@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter,

On Thu, Jul 16, 2020 at 09:50:10PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 16, 2020 at 12:37:00PM -0700, Fenghua Yu wrote:
> > Hi, Thomas, Boris, Ingo,
> > 
> > On Fri, Jun 26, 2020 at 02:55:34PM -0700, Fenghua Yu wrote:
> The only comment I have is that us needing it is ludicrous :/ What's the
> bloody point of having it 'enumerated' if you then still have to use FMS
> lists.
> 
> There's nowhere near enough cursing in the comment that goes with that
> list.

Tony answered Thomas' similar question at
https://lore.kernel.org/lkml/20200416223335.GA23759@agluck-desk2.amr.corp.intel.com/

Is that sufficient enough to answer your question?

Thanks.

-Fenghua
