Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6515C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 01:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7C872082F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 01:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgFQBBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 21:01:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:27658 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgFQBBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 21:01:13 -0400
IronPort-SDR: TYIXCx1HDAMZXZJ9mHA3gTzW8BgL6qf3oseZvSP8YLU8L9CXn3/z+inXF4/S2P6bJ8sxyMNT58
 11RhYNhgimyQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 18:01:12 -0700
IronPort-SDR: 4xmHLeeM4gwaZR8yzRYjs+5Xw0SsdV0eHjEsOYfsEa7KORRVKn5dwyYvVJB3P6hTmg3ksaNVCH
 KkQMj2J6roDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,520,1583222400"; 
   d="scan'208";a="450051692"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by orsmga005.jf.intel.com with ESMTP; 16 Jun 2020 18:01:09 -0700
Date:   Wed, 17 Jun 2020 09:00:51 +0800
From:   Rong Chen <rong.a.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>, kernel test robot <lkp@intel.com>,
        kbuild-all@lists.01.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [kbuild-all] Re: [PATCH] compiler_attributes.h: Support
 no_sanitize_undefined check with GCC 4
Message-ID: <20200617010051.GS5653@shao2-debian>
References: <202006160328.6MfJNuqX%lkp@intel.com>
 <20200615231529.GA119644@google.com>
 <20200616131921.GV2531@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200616131921.GV2531@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 03:19:21PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 16, 2020 at 01:15:29AM +0200, Marco Elver wrote:
> > UBSAN is supported since GCC 4.9, which unfortunately did not yet have
> > __has_attribute(). To work around, the __GCC4_has_attribute workaround
> > requires defining which compiler version supports the given attribute.
> > 
> > In the case of no_sanitize_undefined, it is the first version that
> > supports UBSAN, which is GCC 4.9.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> > 
> > Doing a 'make W=1' with GCC 4.9 and the provided config fixes the build
> > robot's report.
> > 
> > Peter: Feel free to either squash this patch into the one adding
> > __no_sanitize_undefined or apply on top.
> 
> Yeah, argh! So I only saw this thread now, even though I'd already
> pushed out x86/entry to tip last night due to getting:
> 
> 301805 N + Jun 16 kernel test rob (5.8K) [peterz-queue:x86/entry] BUILD SUCCESS 8e8bb06d199a5aa7a534aa3b3fc0abbbc11ca438
> 
> Why that thing is claiming SUCCESS when it introduces a build error I
> don't know.
> 


Hi Peter,

Sorry for the misunderstanding, some folks complained that it's too
noisy when there're only new warnings in a "BUILD REGRESSION" report,
so we changed to use "BUILD SUCCESS" if there's no new build error. To
avoid misunderstanding, we'll change build complete report title to
"BUILD SUCCESS WITH WARNING" for new warnings.

Best Regards,
Rong Chen
