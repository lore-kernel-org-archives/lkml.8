Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B149FC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 13:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3132073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 13:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgBLNLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 08:11:08 -0500
Received: from mga11.intel.com ([192.55.52.93]:2442 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgBLNLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 08:11:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 05:11:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="347513465"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by fmsmga001.fm.intel.com with ESMTP; 12 Feb 2020 05:11:05 -0800
Subject: Re: [PATCH v4 0/4] perf tools: Add support for some spe events and
 precise ip
To:     Jiri Olsa <jolsa@redhat.com>, James Clark <james.clark@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nd@arm.com
References: <20200210122509.GA2005279@krava>
 <20200211140445.21986-1-james.clark@arm.com> <20200212122425.GA194466@krava>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <abac26ad-2b27-0bc7-d1d6-9a92ece3718e@intel.com>
Date:   Wed, 12 Feb 2020 15:10:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212122425.GA194466@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/20 2:24 pm, Jiri Olsa wrote:
> On Tue, Feb 11, 2020 at 02:04:41PM +0000, James Clark wrote:
>> Hi Jirka,
>>
>> Oops. I've removed all the changes to evlist.c and evsel.h
> 
> hi,
> it looks ok from my POV, but I don't follow auxtrace that much
> 
> Adrian,
> it's changing some generic bits of the auxtrace framework,
> could you please check?

Sure, in the next few days.

> 
> thanks,
> jirka
> 
>>
>>
>> James
>>
>> Tan Xiaojun (4):
>>   perf tools: Move arm-spe-pkt-decoder.h/c to the new dir
>>   perf tools: Add support for "report" for some spe events
>>   perf report: Add SPE options to --itrace argument
>>   perf tools: Support "branch-misses:pp" on arm64
>>
>>  tools/perf/Documentation/itrace.txt           |   5 +-
>>  tools/perf/arch/arm/util/auxtrace.c           |  38 +
>>  tools/perf/builtin-record.c                   |   5 +
>>  tools/perf/util/Build                         |   2 +-
>>  tools/perf/util/arm-spe-decoder/Build         |   1 +
>>  .../util/arm-spe-decoder/arm-spe-decoder.c    | 225 ++++++
>>  .../util/arm-spe-decoder/arm-spe-decoder.h    |  66 ++
>>  .../arm-spe-pkt-decoder.c                     |   0
>>  .../arm-spe-pkt-decoder.h                     |   2 +
>>  tools/perf/util/arm-spe.c                     | 756 +++++++++++++++++-
>>  tools/perf/util/arm-spe.h                     |   3 +
>>  tools/perf/util/auxtrace.c                    |  13 +
>>  tools/perf/util/auxtrace.h                    |  14 +-
>>  13 files changed, 1089 insertions(+), 41 deletions(-)
>>  create mode 100644 tools/perf/util/arm-spe-decoder/Build
>>  create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
>>  create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
>>  rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.c (100%)
>>  rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.h (96%)
>>
>> -- 
>> 2.17.1
>>
> 

