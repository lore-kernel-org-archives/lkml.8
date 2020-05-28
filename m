Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2CBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D117A2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390705AbgE1OC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:02:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:23319 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390540AbgE1OC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:02:26 -0400
IronPort-SDR: h6bPnYEg5gBrlQDEHGc3TbOt2Tox5kxXA3y7CErvfLI3kTNyuckYwdaKcuPmOMbgKnc41C8ie5
 Zjydsylj0HtQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 07:02:26 -0700
IronPort-SDR: FecJ5r7Uq94DHHhmghjJ99Hvb8ZmtORb1/VYFUzXzQZYhvqyvxiHHpVDK/trA5Xr61fSY10z0b
 2Rj89oBj22nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,444,1583222400"; 
   d="scan'208";a="292004382"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga004.fm.intel.com with ESMTP; 28 May 2020 07:02:26 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 0B799301C60; Thu, 28 May 2020 07:02:26 -0700 (PDT)
Date:   Thu, 28 May 2020 07:02:26 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     David Laight <David.Laight@aculab.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 3/3] perf/x86/intel/uncore: Validate MMIO address
 before accessing
Message-ID: <20200528140226.GI611145@tassilo.jf.intel.com>
References: <1590671727-99311-1-git-send-email-kan.liang@linux.intel.com>
 <1590671727-99311-3-git-send-email-kan.liang@linux.intel.com>
 <de3b847eddd143998997d70a1ba161b8@AcuMS.aculab.com>
 <79403443-e893-da26-ee6d-1fd7f252bbfe@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79403443-e893-da26-ee6d-1fd7f252bbfe@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +
> > > +	pr_warn_once("perf uncore: Access invalid address of %s.\n",
> > > +		     box->pmu->type->name);
> > 
> > Pretty hard to debug without the invalid offset.
> > 
> 
> I will dump the box->io_addr and offset for debugging.

Please don't overengineer.

-Andi
