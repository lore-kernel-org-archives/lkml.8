Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82036C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51FED20B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgFZVZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:25:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:16227 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgFZVZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:25:24 -0400
IronPort-SDR: Id6tboUeVENaONH1yWA0QrxL/HOb+H1ahk48vjUq2QibOdOEW6CDMveC8iLWMPqYtGSKo7Rt3x
 93L2dz17T5nA==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="143707224"
X-IronPort-AV: E=Sophos;i="5.75,285,1589266800"; 
   d="scan'208";a="143707224"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 14:25:23 -0700
IronPort-SDR: xHcxh5gqImhpjYC8RI6bSw8oeHyOx36iaJIWK9DXgbkSE/zRIqIQ3PFb+CA9tE/yo6tyNXIVr0
 b7SAG03MGm/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,285,1589266800"; 
   d="scan'208";a="479948560"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga006.fm.intel.com with ESMTP; 26 Jun 2020 14:25:22 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id D2E91301B9F; Fri, 26 Jun 2020 14:25:22 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:25:22 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [RFC 00/10] perf tools: Add support to reuse metric
Message-ID: <20200626212522.GF818054@tassilo.jf.intel.com>
References: <20200626194720.2915044-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626194720.2915044-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 09:47:10PM +0200, Jiri Olsa wrote:
> hi,
> this patchset is adding the support to reused metric in another 
> metric. The metric needs to be referenced by 'metric:' prefix.

Why is the prefix needed? 

Could just look it up without prefix.

-Andi
