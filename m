Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898F1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A857206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390308AbgE2DHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 23:07:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:31221 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388995AbgE2DHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 23:07:24 -0400
IronPort-SDR: 1jaDAuDHW+m/6ZhTACgeZmyA/H5o+qirJxAcI7KWtepVxvRbVKwbwU1bG2XFKoxgLoHqr2kqiv
 6UMzyywQWAhw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 20:07:22 -0700
IronPort-SDR: PXJWubHD+el8TpiOoc9RTLD3jc6/9puBjQMTCNdo+xX+rU3NhHks6NDyWlkKGbLbi3oKwXqspD
 2h8qtc3pdjZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,447,1583222400"; 
   d="scan'208";a="271076377"
Received: from pratuszn-mobl.ger.corp.intel.com (HELO localhost) ([10.252.58.65])
  by orsmga006.jf.intel.com with ESMTP; 28 May 2020 20:07:16 -0700
Date:   Fri, 29 May 2020 06:07:15 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Don Porter <porter@cs.unc.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        bp@alien8.de, luto@kernel.org, hpa@zytor.com,
        dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
Message-ID: <20200529030715.GA6182@linux.intel.com>
References: <371e6a92cad25cbe7a8489785efa7d3457ecef3b.camel@linux.intel.com>
 <87v9ksvoaq.fsf@nanos.tec.linutronix.de>
 <20200519164853.GA19706@linux.intel.com>
 <7eb45e02-03bf-0af0-c915-794bf49d66d7@cs.unc.edu>
 <87h7w7qy18.fsf@nanos.tec.linutronix.de>
 <c5fffcd1-c262-7046-a047-67de2bbccd78@cs.unc.edu>
 <87d06opd3a.fsf@nanos.tec.linutronix.de>
 <e9a0a521-104b-5c3a-a689-78f878e73d31@cs.unc.edu>
 <20200528191910.GC2147934@linux.intel.com>
 <20200528194157.GB1407771@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528194157.GB1407771@sasha-vm>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 03:41:57PM -0400, Sasha Levin wrote:
> On Thu, May 28, 2020 at 10:19:10PM +0300, Jarkko Sakkinen wrote:
> > On Thu, May 28, 2020 at 01:40:16PM -0400, Don Porter wrote:
> > > Hi Thomas,
> > > 
> > > On 5/28/20 6:29 AM, Thomas Gleixner wrote:
> > > > > Until recently, we were doing proof-of-concept research, not product
> > > > > development, and there are limited hours in the day.  I also hasten to
> > > > > say that the product of research is an article, the software artifact
> > > > > serves as documentation of the experiment.  In contrast, the product of
> > > > > software development is software.  It takes significant time and effort
> > > > > to convert one to the other.  Upstreaming code is of little scientific
> > > > > interest.  But things have changed for our project; we had no users in
> > > > > 2015 and we are now un-cutting corners that are appropriate for research
> > > > > but inappropriate for production.  For a research artifact with an
> > > > > audience that knew the risks, we shipped a module because it was easier
> > > > > to maintain and install than a kernel patch.
> > > >
> > > > I understand that and with a big fat warning and documentation from
> > > > start I wouldn't have complained so vehemently.
> > > 
> > > This is a fair point.  We will fix this ASAP, and I will be more careful
> > > about this going forward.
> > 
> > Are you going to experiment with this patch set and Graphene? Just
> > sanity checking so that I don't unnecessarily do duplicate work.
> > 
> > I ignored most of the discussion since I came here only with the
> > motivation of testing Graphene together with this patch set. I'm
> > assuming that motivation is always good no matter which angle you come
> > from. Thus, I might have missed the part I'm asking.
> 
> This series was heavily tested with Graphene-like workloads.

Is there something then readily available to test such workload with SGX
enabled? Or should I go patching Graphene? Not sure what I should take
from that comment :-)

For me the main point is that I need a tool to create arbitrary work
loads and run them inside enclave, once the SGX support reaches the
upstream. It's not just about testing this particular series.

The reason why I've been passive with this work so far is that I've been
busy combining updating of SGX series for over two years and maintaining
work. Now is the first time when I have time for this.

Actually I found this by searching lore.kernel.org whether anything has
happend with this. Have had a bullet in my backlog for ages.

/Jarkko
