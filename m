Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E82FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3991720709
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407269AbgFYVhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 17:37:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:19238 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403961AbgFYVhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 17:37:13 -0400
IronPort-SDR: wZzgOCCSU9HONFG6Ay41YdLmcva6n7OOXmYZ/PvUgcQrBBT78/9SeexGrcjN2HyYvN0D39kOGg
 YDkp/6QsoW6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="133493436"
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="133493436"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 14:37:13 -0700
IronPort-SDR: ZYE4sOE06IOvTvItpR8GtoR8eyOVVzhAYghfwYSFdFMybDF5U6/sjPX2HGzPeVw6MVrlkPSe1y
 kUwKb40kmF+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="265464116"
Received: from jproldan-mobl.ger.corp.intel.com (HELO localhost) ([10.252.49.123])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jun 2020 14:37:06 -0700
Date:   Fri, 26 Jun 2020 00:37:05 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Don Porter <porter@cs.unc.edu>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        bp@alien8.de, luto@kernel.org, hpa@zytor.com,
        dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
Message-ID: <20200625213705.GF20341@linux.intel.com>
References: <e9a0a521-104b-5c3a-a689-78f878e73d31@cs.unc.edu>
 <7A3EBAB0-B3B3-4CB7-AA6A-FDF29D03E30D@amacapital.net>
 <20200529152756.GA7452@invisiblethingslab.com>
 <ef8bbdff-e891-bee3-677d-3606474ecc10@cs.unc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef8bbdff-e891-bee3-677d-3606474ecc10@cs.unc.edu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 11:27:28AM -0400, Don Porter wrote:
> On 5/29/20 11:27 AM, Wojtek Porczyk wrote:
> > On Thu, May 28, 2020 at 11:38:01AM -0700, Andy Lutomirski wrote:
> > > One useful test for the actual kernel patches would be to run your SGX
> > > workload on a loaded core.  That is, do something like taskset -c
> > > 0 graphene_thing and, simultaneously, write a trivial infinite loop program
> > > and run that under taskset -c 0 as well. For good measure, you could have
> > > perf top or perf record running at the same time.  Look for kernel errors,
> > > but also look for any evidence of your workload malfunctioning.
> > 
> > We currently run as part of CI several workloads[1], among them LTP tests[2],
> > and sometimes it's not pretty, because we encounter stability problems in
> > Graphene+SGX even without the patchset. We'll pick some stable subset and
> > will let know. Right now we'll have to retool CI for custom kernels, which
> > will take some back and forth with uni's admins.
> > 
> > [1] https://github.com/oscarlab/graphene/tree/master/Examples
> > [2] https://github.com/oscarlab/graphene/tree/master/LibOS/shim/test/ltp
> > 
> 
> Following up: we have been running a patched 5.7 kernel with v12 of this
> series on one of our CI workers.  As Wojtek mentions, infrastructure and
> other orthogonal issues took some time.
> 
> We have run our complete SGX testing pipelines successfully several times
> with no issues: no errors in Graphene or suspicious kernel messages.
> 
> I also did Andy's suggested test:
> * Graphene running nginx pinned to core 0
> * infinite loop on core 0
> * perf top running
> * Exercised with non-SGX apache bench several times (~10 minutes of testing
> time) also from core 0
> 
> Again, no apparent issues, nothing in dmesg.  I ran a similar setup with our
> SGX-specific Graphene (PAL) unit tests.  Same story: everything looks good.
> 
> Let us know if we can be of any more help here.
> 
> Thanks,
> Don

Can unmodified Graphene-SGX used with these changes?

/Jarkko
