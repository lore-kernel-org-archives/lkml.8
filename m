Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53380C54FC9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 03:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 340C722209
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 03:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgDTDE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 23:04:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:37199 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbgDTDE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 23:04:58 -0400
IronPort-SDR: cKOUMm93oephk6d/KizPVf8oz3V3p3NatxHjUjTIGJqkNK5DhyJbl+DA51B8Itek0Tw5OaMqrX
 wZG5wbAJ45CA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2020 20:04:57 -0700
IronPort-SDR: 0aKYO64MEi9ETNwxvLiKShf2uVoHsv6E1K5LcORKxl04J2uhq5k9dxV7H9TweCAp+1CCK8OVXd
 y7oCQREJNISg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,405,1580803200"; 
   d="scan'208";a="258201028"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga006.jf.intel.com with ESMTP; 19 Apr 2020 20:04:57 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 452223019B6; Sun, 19 Apr 2020 20:04:57 -0700 (PDT)
Date:   Sun, 19 Apr 2020 20:04:57 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 11/16] perf intel-pt: Add support for synthesizing
 callchains for regular events
Message-ID: <20200420030457.GA608746@tassilo.jf.intel.com>
References: <20200401101613.6201-1-adrian.hunter@intel.com>
 <20200401101613.6201-12-adrian.hunter@intel.com>
 <20200416151443.GA2650@kernel.org>
 <5b8f28f5-968f-bfff-68af-ed0350a90765@intel.com>
 <20200417213704.GB21512@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417213704.GB21512@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Andi? My concern is that if this is the optimal solution for a good
> subset of the machines out there, then we need to make it easy to use,
> even transparent, if possible and safe to take that path.

I'm not sure it's that great in the general case.  A PT call graph
would need a full PT recording from start to end.

The problem with full PT recording is that it doesn't really work for a
lot of workloads, because for anything doing enough computation the CPU
just generates too much data and you end up with a lot of gaps in the
trace when the perf record flushing cannot keep up.

Also even if it worked you might end up with far too much data that
will take a long time to process.

So I suspect it wouldn't work often enough to be generally useful.

For the leader sample case we just want to use some non PT method
to get the call graph.

-Andi
