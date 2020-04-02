Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA26C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42463206CC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389002AbgDBPFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:05:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:19458 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388689AbgDBPFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:05:44 -0400
IronPort-SDR: bplhHxejOUx0jlR47C3Wri94wEyF5sQL5MUSmpYKTy4qXdhlnHLG42+l4tyhEO3Ry/Lsa/OjYD
 wMtnFS7IvtNA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 08:05:23 -0700
IronPort-SDR: ix4IEz8v9JNwCMgTlBSNAyg9umVrwDzw5qM3A+26Po3jktTes5A8OyP7qaI3TfkYsUHQSsEbGK
 IDbrietrD2PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,336,1580803200"; 
   d="scan'208";a="450959393"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 02 Apr 2020 08:05:22 -0700
Received: from [10.249.226.252] (abudanko-mobl.ccr.corp.intel.com [10.249.226.252])
        by linux.intel.com (Postfix) with ESMTP id 9DAE058077B;
        Thu,  2 Apr 2020 08:05:20 -0700 (PDT)
Subject: Re: [PATCH v1 3/8] perf stat: introduce control descriptors and
 --ctl-fd[-ack] options
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <825a5132-b58d-c0b6-b050-5a6040386ec7@linux.intel.com>
 <98dfb3ce-dab9-3747-8748-fbf2777f69ba@linux.intel.com>
 <20200402141758.GP2518490@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <d222ab4d-f217-dc84-51c1-b9c8a5a13d93@linux.intel.com>
Date:   Thu, 2 Apr 2020 18:05:19 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402141758.GP2518490@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.04.2020 17:17, Jiri Olsa wrote:
> On Fri, Mar 27, 2020 at 11:47:40AM +0300, Alexey Budankov wrote:
>>
>> Introduce control file descriptors and --ctl-fd[-ack] options to pass
>> control descriptors from command line. Extend --delay option with -1
>> value to start collection in paused mode to be resumed later by resume
>> command provided via control file descriptor.
> 
> could you please separate those 2 changes?  also for record change

Accepted, as for stat as for record mode.

~Alexey

