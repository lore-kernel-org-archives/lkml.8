Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E62C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E648207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406263AbgE1TTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:19:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:42100 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405596AbgE1TTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:19:19 -0400
IronPort-SDR: 9beMskLDrBnv9zTRO0fyo5YNu+oh5B+fVcaIOwX7TpKHSOU6RoZbWmKZHkmpd8OzzjIml8psUr
 mRIZLj23nRBw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 12:19:18 -0700
IronPort-SDR: rYxDEesOM5+HpYuOiYxDoBMxJa241T34T363LDDQv41MwgTvB1xQcu+kixQR7ANse9fBmli7tS
 QoMPJO31GvrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; 
   d="scan'208";a="292105760"
Received: from jtitox-mobl.ger.corp.intel.com (HELO localhost) ([10.252.56.171])
  by fmsmga004.fm.intel.com with ESMTP; 28 May 2020 12:19:12 -0700
Date:   Thu, 28 May 2020 22:19:10 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Don Porter <porter@cs.unc.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        bp@alien8.de, luto@kernel.org, hpa@zytor.com,
        dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
Message-ID: <20200528191910.GC2147934@linux.intel.com>
References: <c566b89cc3ef6c164160cc56a820abac3fd70839.camel@linux.intel.com>
 <20200518153407.GA499505@tassilo.jf.intel.com>
 <371e6a92cad25cbe7a8489785efa7d3457ecef3b.camel@linux.intel.com>
 <87v9ksvoaq.fsf@nanos.tec.linutronix.de>
 <20200519164853.GA19706@linux.intel.com>
 <7eb45e02-03bf-0af0-c915-794bf49d66d7@cs.unc.edu>
 <87h7w7qy18.fsf@nanos.tec.linutronix.de>
 <c5fffcd1-c262-7046-a047-67de2bbccd78@cs.unc.edu>
 <87d06opd3a.fsf@nanos.tec.linutronix.de>
 <e9a0a521-104b-5c3a-a689-78f878e73d31@cs.unc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9a0a521-104b-5c3a-a689-78f878e73d31@cs.unc.edu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 01:40:16PM -0400, Don Porter wrote:
> Hi Thomas,
> 
> On 5/28/20 6:29 AM, Thomas Gleixner wrote:
> > > Until recently, we were doing proof-of-concept research, not product
> > > development, and there are limited hours in the day.  I also hasten to
> > > say that the product of research is an article, the software artifact
> > > serves as documentation of the experiment.  In contrast, the product of
> > > software development is software.  It takes significant time and effort
> > > to convert one to the other.  Upstreaming code is of little scientific
> > > interest.  But things have changed for our project; we had no users in
> > > 2015 and we are now un-cutting corners that are appropriate for research
> > > but inappropriate for production.  For a research artifact with an
> > > audience that knew the risks, we shipped a module because it was easier
> > > to maintain and install than a kernel patch.
> > 
> > I understand that and with a big fat warning and documentation from
> > start I wouldn't have complained so vehemently.
> 
> This is a fair point.  We will fix this ASAP, and I will be more careful
> about this going forward.

Are you going to experiment with this patch set and Graphene? Just
sanity checking so that I don't unnecessarily do duplicate work.

I ignored most of the discussion since I came here only with the
motivation of testing Graphene together with this patch set. I'm
assuming that motivation is always good no matter which angle you come
from. Thus, I might have missed the part I'm asking.

/Jarkko
