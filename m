Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C065CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2840206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgFEUj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 16:39:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:31691 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728376AbgFEUj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 16:39:26 -0400
IronPort-SDR: C6N3o2Df/S3Jbb66JdD37jc8MkWGX+IuAl3oGO6nNKZWw8GracfwGFtSwP6OyccHNjaOSyTiD7
 CPPEPKVXfOnQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 13:39:24 -0700
IronPort-SDR: mMHfSGaNjB1lAnSCJxl6bzjfq1ylYaaDzEZIH9nx2nk9UDKNN9rIc28nHpU1HutrqIVGfxL8jh
 IO3g1tFu9b7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,477,1583222400"; 
   d="scan'208";a="258812835"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga007.jf.intel.com with ESMTP; 05 Jun 2020 13:39:24 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id B2AEE30178A; Fri,  5 Jun 2020 13:39:24 -0700 (PDT)
Date:   Fri, 5 Jun 2020 13:39:24 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     alexander.antonov@linux.intel.com, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, bgregg@netflix.com, kan.liang@linux.intel.com,
        lkp@intel.com
Subject: Re: [PATCH v10 0/3] perf x86: Exposing IO stack to IO PMON mapping
 through sysfs
Message-ID: <20200605203924.GH691017@tassilo.jf.intel.com>
References: <20200601083543.30011-1-alexander.antonov@linux.intel.com>
 <20200605175314.GQ2750@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605175314.GQ2750@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 07:53:14PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 01, 2020 at 11:35:40AM +0300, alexander.antonov@linux.intel.com wrote:
> 
> Didn't GregKH have comments on earlier versions of these patches? I
> don't see him on Cc anymore. Were all his comments addressed?

I believe Greg's comments were addressed.

-Andi

