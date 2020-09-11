Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286CAC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 01:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA0E421582
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 01:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgIKBnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 21:43:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:57258 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbgIKBno (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 21:43:44 -0400
IronPort-SDR: XSzgBZW5V9IIRierAjySOeltqqwLasXV/YBfNvEaXOTKM15kY7dJa8gvMTF1vz4Sk3A47o2i3n
 dyZqCMr533aw==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="146394393"
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; 
   d="scan'208";a="146394393"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 18:43:43 -0700
IronPort-SDR: 1UAOJnmT7mr9WY71DgEaFg4LW3kenJm2CsS+cSCJdJdSe687HbrrsMW7yfR8O0O801liiLvrE0
 4+8JpgfyE+oQ==
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; 
   d="scan'208";a="481129842"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 18:43:40 -0700
Subject: Re: [PATCH v5 0/7] perf: Stream comparison
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200907041606.14500-1-yao.jin@linux.intel.com>
 <20200910092237.GE1627030@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <ac5f770a-75f7-b4a7-bffe-6ff5bbad48c5@linux.intel.com>
Date:   Fri, 11 Sep 2020 09:43:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200910092237.GE1627030@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 9/10/2020 5:22 PM, Jiri Olsa wrote:
> On Mon, Sep 07, 2020 at 12:15:59PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>>                        main div.c:39
>>
>> [ Hot streams in new perf data only ]
>>
>> hot chain 1:
>>                                                       cycles: 4, hits: 4.54%
>>                                                   --------------------------
>>                                                                main div.c:42
>>                                                        compute_flag div.c:28
>>
>> hot chain 2:
>>                                                       cycles: 5, hits: 3.51%
>>                                                   --------------------------
>>                                                                main div.c:39
>>                                                                main div.c:44
>>                                                                main div.c:42
>>                                                        compute_flag div.c:28
>>
>>   v5:
>>   ---
>>   1. Remove enum stream_type
>>   2. Rebase to perf/core
> 
> hi,
> which commit did you base on? I can't apply on current perf/core
> 
> thanks,
> jirka
> 

Let me rebase the patchset again.

Thanks
Jin Yao
