Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4721C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C41E2082F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgGBBvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 21:51:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:42368 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727846AbgGBBvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 21:51:00 -0400
IronPort-SDR: 3Pyn5B6GoHPLJCvhPn/N8sNuHQn7CSgAvGajAE5WyOqeNu8GimxCWqw5TBSTmkNxYKmZ2j8mSH
 NqP96IvgyFKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="164811782"
X-IronPort-AV: E=Sophos;i="5.75,302,1589266800"; 
   d="scan'208";a="164811782"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 18:50:53 -0700
IronPort-SDR: 7ngpAIGWRv/c5y+XeTgGVcInhOKwoTmi+67M1QB8Tw3pjutP15zyhmwFOu2rhmUAgVbnAbsJD8
 uY9q9DH4/oxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,302,1589266800"; 
   d="scan'208";a="304071198"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by fmsmga004.fm.intel.com with ESMTP; 01 Jul 2020 18:50:52 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kbusch@kernel.org>, <dan.j.williams@intel.com>
Subject: Re: [RFC][PATCH 3/8] mm/vmscan: Attempt to migrate page in lieu of discard
References: <20200629234503.749E5340@viggo.jf.intel.com>
        <20200629234509.8F89C4EF@viggo.jf.intel.com>
        <alpine.DEB.2.22.394.2006301732010.1644114@chino.kir.corp.google.com>
        <039a5704-4468-f662-d660-668071842ca3@linux.alibaba.com>
        <alpine.DEB.2.22.394.2006302208460.1685201@chino.kir.corp.google.com>
        <87h7urlioe.fsf@yhuang-dev.intel.com>
        <8182ede7-88ce-b891-d100-8c036130797e@intel.com>
        <alpine.DEB.2.23.453.2007011248580.1908531@chino.kir.corp.google.com>
Date:   Thu, 02 Jul 2020 09:50:51 +0800
In-Reply-To: <alpine.DEB.2.23.453.2007011248580.1908531@chino.kir.corp.google.com>
        (David Rientjes's message of "Wed, 1 Jul 2020 12:50:23 -0700")
Message-ID: <87v9j6k7lw.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Rientjes <rientjes@google.com> writes:

> On Wed, 1 Jul 2020, Dave Hansen wrote:
>
>> Even if they don't allocate directly from PMEM, is it OK for such an app
>> to get its cold data migrated to PMEM?  That's a much more subtle
>> question and I suspect the kernel isn't going to have a single answer
>> for it.  I suspect we'll need a cpuset-level knob to turn auto-demotion
>> on or off.
>> 
>
> I think the answer is whether the app's cold data can be reclaimed, 
> otherwise migration to PMEM is likely better in terms of performance.  So 
> any such app today should just be mlocking its cold data if it can't 
> handle overhead from reclaim?

Yes.  That's a way to solve the problem.  A cpuset-level knob may be
more flexible, because you don't need to change the application source
code.

Best Regards,
Huang, Ying
