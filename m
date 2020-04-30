Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B166AC83002
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 05:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F14B2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 05:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgD3FgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 01:36:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:65297 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbgD3FgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 01:36:20 -0400
IronPort-SDR: cPUwJOQ9mo+AS2B5Nyq5tF1VhpkhtnrLa4TXhuItDPO3LOS25cw9BCZi9/s4vG1qE6nKzgktdt
 mggMwc7MpzQg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 22:36:20 -0700
IronPort-SDR: ZAfYG74UdpEVjt8SyDRd9msNumJYrFAQDvKGPw2LJlORo3IQexl0vdRIVCDjCeVKI3TcMupULz
 x5ovC4Tu6EFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,334,1583222400"; 
   d="scan'208";a="249650465"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.157]) ([10.237.72.157])
  by fmsmga008.fm.intel.com with ESMTP; 29 Apr 2020 22:36:18 -0700
Subject: Re: [PATCH 8/9] perf intel-pt: Update documentation about itrace G
 and L options
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <20200429150751.12570-1-adrian.hunter@intel.com>
 <20200429150751.12570-9-adrian.hunter@intel.com>
 <20200429230356.GB874567@tassilo.jf.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <0938999b-00c0-25cf-9a87-a7abc1cbac1c@intel.com>
Date:   Thu, 30 Apr 2020 08:36:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429230356.GB874567@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/20 2:03 am, Andi Kleen wrote:
>> +One caveat with the G and L options is that they work poorly with "Large PEBS".
>> +Large PEBS means PEBS records will be accumulated by hardware and the written
>> +into the event buffer in one go.  That reduces interrupts, but can give very
>> +late timestamps.  Because the Intel PT trace is synchronized by timestamps,
> 
> Are you refering to Broadwell here?

I was testing on Coffee Lake

> 
> On Skylake/Goldmont the PEBS event contains the TSC and the time stamp reported by
> perf should report the time the event was sampled based on that TSC. 
> Or is that not working for some reason?

I guess it is not working like that, but perf tools would probably need
special rules to sort the events because the they would break the rules of
PERF_RECORD_FINISHED_ROUND, wouldn't they?

