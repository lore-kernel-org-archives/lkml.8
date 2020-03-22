Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D13C1975A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 23:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2EE2072D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 23:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgCVXSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 19:18:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:35541 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgCVXSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 19:18:22 -0400
IronPort-SDR: TQmMScp9Lc6nPGSoJh6N9ub3Q3PuDAKbvk2VSA9yjNxC2pWT1ckNUCQR+4FFY39HI+VuKPOSTe
 AVLVk9Mtf3rw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2020 16:18:21 -0700
IronPort-SDR: rTUNOvwITZGPd+WKcrPOiG/4qSYfi49vqmF1tMqSlVcd6PiUnkHrD1obms4uZeXb6/i8ctSt9f
 WeOfho2Kw0lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,294,1580803200"; 
   d="scan'208";a="447223183"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga006.fm.intel.com with ESMTP; 22 Mar 2020 16:18:20 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id CA321301779; Sun, 22 Mar 2020 16:18:20 -0700 (PDT)
Date:   Sun, 22 Mar 2020 16:18:20 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] perf test x86: address multiplexing in rdpmc test
Message-ID: <20200322231820.GB267978@tassilo.jf.intel.com>
References: <20200321173710.127770-1-irogers@google.com>
 <20200322101848.GF2452@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200322101848.GF2452@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Here's something a little better. Much of it copied from linux/math64.h
> and asm/div64.h.

Not sure what the point is of micro optimizing a unit test?

This is never run in production.

-Andi

