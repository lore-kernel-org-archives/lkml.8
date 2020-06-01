Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A38DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76449206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgFARLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:11:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:53453 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbgFARLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:11:39 -0400
IronPort-SDR: ttTRT2ljj0FgjBczPK3ZyGZ/gNjv1b4Kf/nV2VMZHK7xT+4X/KGqWNeRzDp7lvMFgxPR2DQM2t
 EsBMNVQKBMpA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 10:11:39 -0700
IronPort-SDR: 2rLKlOXH2ekdU0Onp4tiYH3sULLl4DFKuHqm+VvYp8mnzqjwJh6POHFBwHce4Q6h6X4pqqUFYx
 d/HvaZ/iQqZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,461,1583222400"; 
   d="scan'208";a="470391260"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 01 Jun 2020 10:11:38 -0700
Received: from [10.249.230.65] (abudanko-mobl.ccr.corp.intel.com [10.249.230.65])
        by linux.intel.com (Postfix) with ESMTP id BE08E580646;
        Mon,  1 Jun 2020 10:11:36 -0700 (PDT)
Subject: Re: [PATCH v5 13/13] perf record: introduce --ctl-fd[-ack] options
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <e5cac8dd-7aa4-ec7c-671c-07756907acba@linux.intel.com>
 <8ffc9f9f-af58-deea-428b-f8a69004e3cb@linux.intel.com>
 <923c40c7-7c0b-9fad-314d-69e7acbee201@intel.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <937c8cc1-b4c2-8531-3fa4-d0ad9df6a65f@linux.intel.com>
Date:   Mon, 1 Jun 2020 20:11:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <923c40c7-7c0b-9fad-314d-69e7acbee201@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Adrian,

On 01.06.2020 19:30, Adrian Hunter wrote:
> On 1/06/20 7:05 pm, Alexey Budankov wrote:
>>
>> Introduce --ctl-fd[-ack] options to pass open file descriptors numbers
>> from command line. Extend perf-record.txt file with --ctl-fd[-ack]
>> options description. Document possible usage model introduced by
>> --ctl-fd[-ack] options by providing example bash shell script.
> 
> Hi
> 
> I am interested in using this also for taking snapshots.

Good to hear from you.

> 
> Did you consider using a single option, or allowing either a file descriptor

Single option use case is already possible like --ctl-fd <NUM_1>.
Synchronization messages can be provided via --ctl-fd-ack <NUM_2>.

> or a pathname, or including also the event default of "disabled".

For my cases conversion of pathnames into open fds belongs to external
controlling process e.g. like in the examples provided in the patch set.
Not sure about "event default of 'disabled'"

> 
> e.g. add "--control" and support all of:
> 
> --control
> --control 11
> --control 11,15
> --control 11,15,disabled
> --control 11,,disabled
> --control /tmp/my-perf.fifo
> --control /tmp/my-perf.fifo,/tmp/my-perf-ack.fifo
> --control /tmp/my-perf.fifo,/tmp/my-perf-ack.fifo,disabled
> --control /tmp/my-perf.fifo,,disabled
> 
> Regards
> Adrian
> 

Regards,
Alexey

