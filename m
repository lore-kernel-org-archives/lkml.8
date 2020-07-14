Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89299C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FBFF22507
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgGNPxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 11:53:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:57895 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgGNPxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 11:53:31 -0400
IronPort-SDR: VvCBuF0OZ52mHEv+wrAy3r6aEnt1k2qSIvMGI6BPjrxOZF+sWJS11RzVvtcjrfCHkxfZSn4s4r
 mCp3oaGloe4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="137077656"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="137077656"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 08:53:31 -0700
IronPort-SDR: WZVGLL1ziRlPW+ZennXDtJSdE+2w4xYuEfsgU7lnu10+pOwG927EJTDwg8HxQMrzOWP+G/2hds
 5IXneuQzw6WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="390514587"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 14 Jul 2020 08:53:30 -0700
Received: from [10.249.230.149] (abudanko-mobl.ccr.corp.intel.com [10.249.230.149])
        by linux.intel.com (Postfix) with ESMTP id E0621580583;
        Tue, 14 Jul 2020 08:53:27 -0700 (PDT)
Subject: Re: [PATCH v11 00/15] perf: support enable and disable commands in
 stat and record modes
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
References: <037d737f-0ada-a9f0-9686-f7521ca6fbc3@linux.intel.com>
 <CAM9d7cgv1dbLMmtUYWXEvoSUC_NQuBpJ9JRBn3tXJ+S5PX+8TQ@mail.gmail.com>
 <20200714151634.GA43671@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <aaec7646-a032-7457-4283-50037d83ec88@linux.intel.com>
Date:   Tue, 14 Jul 2020 18:53:26 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200714151634.GA43671@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14.07.2020 18:16, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jul 14, 2020 at 09:05:10PM +0900, Namhyung Kim escreveu:
>> Hello,
>>
>> On Tue, Jul 14, 2020 at 5:37 PM Alexey Budankov
>> <alexey.budankov@linux.intel.com> wrote:
>>>
>>>
>>> Changes in v11:
>>> - added comments to struct ctl_fd
>>> - explicitly coded data_size decrement
>>
>> Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> So, I think v10 had Jiri's Acked-by, right? Or was it a reviewed-by?
> Please next time collect those, helps with reviewing, Jiri?

Right, v10 has got Acked-by Jiri Olsa [1]. 
I should have already learned this lesson on CAP_PERFMON patches
so will try my best to get this done thus far.

Thanks,
Alexei

[1] https://lore.kernel.org/lkml/20200712211204.GA156308@krava/
