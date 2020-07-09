Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34907C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1896E207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgGISOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:14:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:55994 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbgGISOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:14:22 -0400
IronPort-SDR: PyMEWeA7NzssZmOeKHCRKmZjhc9Lg4zfvSn+qCpS8WiQgPcB6/JQ4I9DhTHNmdMcVJlCPN1STL
 vfyFGKl/WB8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="232939657"
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="232939657"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 11:14:21 -0700
IronPort-SDR: mFl7tvzao2b3S+WOOm7EWaDgKCEOqP556h7rRjXy2n17GoOlSWUOaMw7fqxanx3U7Jnj7m54xx
 2CgmiOdsFUdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="458000250"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by orsmga005.jf.intel.com with ESMTP; 09 Jul 2020 11:14:20 -0700
Subject: Re: [PATCH 05/11] perf intel-pt: Use itrace error flags to suppress
 some errors
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <20200709173628.5613-1-adrian.hunter@intel.com>
 <20200709173628.5613-6-adrian.hunter@intel.com>
 <20200709175046.GA1126680@tassilo.jf.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3271e2cf-490b-5391-19e0-e1b019bfba1f@intel.com>
Date:   Thu, 9 Jul 2020 21:13:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200709175046.GA1126680@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/07/20 8:50 pm, Andi Kleen wrote:
> On Thu, Jul 09, 2020 at 08:36:22PM +0300, Adrian Hunter wrote:
>> The itrace "e" option may be followed by a number which has the
>> following effect for Intel PT:
>> 	1	Suppress overflow events
>> 	2	Suppress trace data lost events
>> The values may be combined by bitwise OR'ing them.
>>
>> Suppressing those errors can be useful for testing and debugging
>> because they are not due to decoding.
> 
> I suspect it will be useful to more than just decoding and debugging.
> 
> But the number is not a nice user interface.
> 
> How about e[....] 
> 
> like e[ol] 

Do you mean literally square-brackets? If you were really unlucky you might
get pathname expansion with that.

> 
> Also it's a bit unusual that this disables instead of enables, but ok.
> 
> -Andi
> 

