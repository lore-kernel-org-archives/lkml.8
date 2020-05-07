Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490D7C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27A682078C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgEGIgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 04:36:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:41749 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgEGIgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 04:36:14 -0400
IronPort-SDR: xD1A086EIud7GAW+cI/RxH4k5eqAi4VUWrx5VCYKYWAumiQuR68kd/viLISXtkUrfiMKLHd7Bp
 JUpuuWlMEvtQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 01:36:14 -0700
IronPort-SDR: jtxaYoRtPoSRyOaA6O6slb2ICn9ccV5NNbOJMxw+e12rQ2MLF3np6cfh1NtovaR+RpFCd8QUPL
 7p7YHS0EFieg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,363,1583222400"; 
   d="scan'208";a="284908332"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 07 May 2020 01:36:14 -0700
Received: from [10.249.225.10] (abudanko-mobl.ccr.corp.intel.com [10.249.225.10])
        by linux.intel.com (Postfix) with ESMTP id 50CA958048A;
        Thu,  7 May 2020 01:36:12 -0700 (PDT)
Subject: Re: [PATCH v2 11/11] perf docs: extend record mode docs with info on
 --ctl-fd[-ack] options
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <d582cc3d-2302-c7e2-70d3-bc7ab6f628c3@linux.intel.com>
 <e7d6ffe1-0166-e98a-9693-a944107b9f0e@linux.intel.com>
 <20200506202719.GJ9893@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <c3cc9eed-f93f-d118-104f-b4843b849d02@linux.intel.com>
Date:   Thu, 7 May 2020 11:36:11 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506202719.GJ9893@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.05.2020 23:27, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 06, 2020 at 09:30:50PM +0300, Alexey Budankov escreveu:
>>
>> Extend perf-record.txt file with --ctl-fd[-ack] options description.
>> Document possible usage model introduced by --ctl-fd[-ack] options
>> by providing example bash shell script.
> 
> Ditto, combine this patch with the one that introduces these options.

Addressed in v3.

~Alexey
