Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015AAC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF9382073A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgEGIeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 04:34:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:41693 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgEGIep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 04:34:45 -0400
IronPort-SDR: ZOjFHcneeW/zn0M6qGsWF9D8DM8rev6HmsSy4RYUIUpkv4gCqrrfd6AvKrMAecHqUuFGSNBXhf
 a80b5bye3NOQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 01:34:45 -0700
IronPort-SDR: hscRpsOvlqljYfPCs+fK73OGpi7d+Z0MWQPANUjIb5IS6GpAQvb1l8KFBauYozsXYX5Rz+VjVI
 A5113zLn5uUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,363,1583222400"; 
   d="scan'208";a="296458146"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 07 May 2020 01:34:44 -0700
Received: from [10.249.225.10] (abudanko-mobl.ccr.corp.intel.com [10.249.225.10])
        by linux.intel.com (Postfix) with ESMTP id D744F58048A;
        Thu,  7 May 2020 01:34:42 -0700 (PDT)
Subject: Re: [PATCH v2 04/11] perf stat: extend -D,--delay option with -1
 value
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <d582cc3d-2302-c7e2-70d3-bc7ab6f628c3@linux.intel.com>
 <df2ffd5b-dcd6-40ea-8053-74feef07724f@linux.intel.com>
 <20200506201227.GE9893@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <785b3ab2-6264-d21c-a49f-adaa626728b9@linux.intel.com>
Date:   Thu, 7 May 2020 11:34:41 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506201227.GE9893@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.05.2020 23:12, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 06, 2020 at 09:20:54PM +0300, Alexey Budankov escreveu:
>>
>> Extend -D,--delay option with -1 value to start monitoring with
>> events disabled to be enabled later by enable command provided
>> via control file descriptor.
>  
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/builtin-stat.c | 18 ++++++++++++++----
>>  tools/perf/util/evlist.h  |  3 +++
>>  tools/perf/util/stat.h    |  2 +-
> 
> You forgot to update tools/perf/Documentation/perf-stat.h

Good catch. Addressed in v3.  Thanks!

~Alexey
