Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C648AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A17752065F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgGVNTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 09:19:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:35853 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbgGVNTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 09:19:06 -0400
IronPort-SDR: oSyA1SIRynK1KaoawLzHMyokwcvTHTxTpjOeIAKL10QYq0wwi6+6iPwXjg60ARHpwFOta3eqO+
 /ljUP1dUOFag==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="151647978"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="151647978"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 06:19:05 -0700
IronPort-SDR: ACgWfQ4BZfoggtLmdHtSbbnDIdYMzBpHlpVk1auW2DlzEBCuGRW+I9qbjpipeipPLxQ7jrO2td
 dmw1eDD40mWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="462450536"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 22 Jul 2020 06:19:05 -0700
Received: from [10.249.230.82] (abudanko-mobl.ccr.corp.intel.com [10.249.230.82])
        by linux.intel.com (Postfix) with ESMTP id B08015802E4;
        Wed, 22 Jul 2020 06:19:01 -0700 (PDT)
Subject: Re: [PATCH v12 11/15] perf stat: implement control commands handling
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <8d91c3a0-3db4-0a7a-ae13-299adb444bd6@linux.intel.com>
 <3cb8a826-145f-81f4-fcb2-fa20045c6957@linux.intel.com>
 <20200722125624.GM77866@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <2529e951-3ef9-763b-f3d8-ca36038503d5@linux.intel.com>
Date:   Wed, 22 Jul 2020 16:18:59 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722125624.GM77866@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22.07.2020 15:56, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jul 17, 2020 at 10:05:06AM +0300, Alexey Budankov escreveu:
>>
>> Implement handling of 'enable' and 'disable' control commands coming
>> from control file descriptor. If poll event splits initiated timeout
>> interval then the reminder is calculated and still waited in the
>> following evlist__poll() call.
> 
> So the cover letter is not preserved in the git history, only going from
> the Link tag to the patch series to then lookup the cover letter and
> then find examples of each feature, I'll now have to do that and collect
> the parts that are needed to test this specific feature implemented in
> this specific patch, add the command here so that we can test patch by
> patch, please next time try to have the testing steps in each patch.

Accepted. Will be providing possible test steps as a part of description
for relevant patches.

Thanks,
Alexei
