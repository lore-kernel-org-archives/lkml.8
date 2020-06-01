Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14029C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EECE720776
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgFAQbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 12:31:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:52179 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgFAQbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 12:31:34 -0400
IronPort-SDR: WDrkQNQ2wXYPdbJ1VTWNmY+Pmc2zIORyEr9Xg/pLexEHXX127tR+YXmwvSm8Z5uC9d8PrfBeJf
 joQV+VHg4MOg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 09:31:34 -0700
IronPort-SDR: +H+uyDnAdfr8cJDrP055+A8lC6iSk1E+zH3WH4J/KfBmnxC9E6j7NkSanmzaGV1Ka3l1ePegPW
 qTH2sYsquYew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,461,1583222400"; 
   d="scan'208";a="347092955"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.157]) ([10.237.72.157])
  by orsmga001.jf.intel.com with ESMTP; 01 Jun 2020 09:31:31 -0700
Subject: Re: [PATCH v5 13/13] perf record: introduce --ctl-fd[-ack] options
To:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <e5cac8dd-7aa4-ec7c-671c-07756907acba@linux.intel.com>
 <8ffc9f9f-af58-deea-428b-f8a69004e3cb@linux.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <923c40c7-7c0b-9fad-314d-69e7acbee201@intel.com>
Date:   Mon, 1 Jun 2020 19:30:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <8ffc9f9f-af58-deea-428b-f8a69004e3cb@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/06/20 7:05 pm, Alexey Budankov wrote:
> 
> Introduce --ctl-fd[-ack] options to pass open file descriptors numbers
> from command line. Extend perf-record.txt file with --ctl-fd[-ack]
> options description. Document possible usage model introduced by
> --ctl-fd[-ack] options by providing example bash shell script.

Hi

I am interested in using this also for taking snapshots.

Did you consider using a single option, or allowing either a file descriptor
or a pathname, or including also the event default of "disabled".

e.g. add "--control" and support all of:

--control
--control 11
--control 11,15
--control 11,15,disabled
--control 11,,disabled
--control /tmp/my-perf.fifo
--control /tmp/my-perf.fifo,/tmp/my-perf-ack.fifo
--control /tmp/my-perf.fifo,/tmp/my-perf-ack.fifo,disabled
--control /tmp/my-perf.fifo,,disabled

Regards
Adrian
