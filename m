Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06C5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D6F720709
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407309AbgFYVk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 17:40:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:38747 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406260AbgFYVk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 17:40:58 -0400
IronPort-SDR: TqsVJQ710ygnsZq2JBDMqDjJ45dY/LOLDJtZMEvndI5Cbn1kpjg5gfd83NlF5lSQUc7LoPvko4
 VaEeZo2bjI5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="210179206"
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="210179206"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 14:40:58 -0700
IronPort-SDR: rTsQ9s3TJyNy/6hX2yepi1qKLXFBt48BRME8ZBw7LL3kNnBGaptxxqCEu2+/bGLWCZGVgGaFOp
 ASKGVX0IWvyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="265464934"
Received: from jproldan-mobl.ger.corp.intel.com (HELO localhost) ([10.252.49.123])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jun 2020 14:40:52 -0700
Date:   Fri, 26 Jun 2020 00:40:50 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Don Porter <porter@cs.unc.edu>
Cc:     Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        bp@alien8.de, luto@kernel.org, hpa@zytor.com,
        dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
Message-ID: <20200625214050.GG20341@linux.intel.com>
References: <7eb45e02-03bf-0af0-c915-794bf49d66d7@cs.unc.edu>
 <87h7w7qy18.fsf@nanos.tec.linutronix.de>
 <c5fffcd1-c262-7046-a047-67de2bbccd78@cs.unc.edu>
 <87d06opd3a.fsf@nanos.tec.linutronix.de>
 <e9a0a521-104b-5c3a-a689-78f878e73d31@cs.unc.edu>
 <20200528191910.GC2147934@linux.intel.com>
 <20200528194157.GB1407771@sasha-vm>
 <20200529030715.GA6182@linux.intel.com>
 <20200529031016.GB6182@linux.intel.com>
 <d0db9590-5c0f-d41c-906f-c5cd0981f138@cs.unc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0db9590-5c0f-d41c-906f-c5cd0981f138@cs.unc.edu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 11:30:54AM -0400, Don Porter wrote:
> We are merging the changes to Graphene to run a patched 5.7 kernel with
> these patches, so it should work for you (or anyone else) once all of the
> changes are merged.  I'd be happy to talk, perhaps off this thread, about
> how we can help you with any other SGX-related kernel testing in the future,
> or issues with running Graphene.
> 
> -Don

This is great to hear. And thanks for the proposal. I'll get back to
you once I have had time to knock the ice myself a bit.

My main interest is not the upstreaming process that we are going
through right now, but more like post-upstreaming when the code needs to
be thrown at with arbitrary workloads. I think this will be a perfect
tool maturizing the code over time.

/Jarkko
