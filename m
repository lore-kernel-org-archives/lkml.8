Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FF3C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 02:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05164207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 02:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgHQCc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 22:32:56 -0400
Received: from mga03.intel.com ([134.134.136.65]:25270 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgHQCcz (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 22:32:55 -0400
IronPort-SDR: gGh+2HWZES1Q5wjo7EWOvdEcDjoaYG4XX5TC2KwbtgtvbyKKjKFo1Mp9I5USSkfUGUR/C97+e6
 WsmEF4jLwTog==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="154601723"
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="154601723"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2020 19:32:55 -0700
IronPort-SDR: yR653rNF2cnbdtHCzlVrDuXp2u7FAbIuJ45Hw0G1vq2PBC5BBSoj4TaNdRkhDwFLk7QwDvWgn9
 gSvhf7S7IiZw==
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="496858335"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2020 19:32:52 -0700
Subject: Re: [PATCH v3] perf parse-events: Set exclude_guest=1 for user-space
 counting
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        like.xu@linux.intel.com
References: <20200814012120.16647-1-yao.jin@linux.intel.com>
 <20200814124722.GG13995@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <b061052d-592d-67d7-045f-481974b0687a@linux.intel.com>
Date:   Mon, 17 Aug 2020 10:32:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200814124722.GG13995@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 8/14/2020 8:47 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Aug 14, 2020 at 09:21:20AM +0800, Jin Yao escreveu:
>> Currently if we run 'perf record -e cycles:u', exclude_guest=0.
>>
>> But it doesn't make sense in most cases that we request for
>> user-space counting but we also get the guest report.
>>
>> Of course, we also need to consider perf kvm usage case that
>> authorized perf users on the host may only want to count guest
>> user space events. For example,
>>
>> perf kvm --guest record -e cycles:u
> Ok, probably this works, but what if I want to record guest user samples
> without using 'perf kvm'?
> 
> Can we have a 'U' modifier, perhaps, for that?
> 
> I.e.
> 
> perf record -e cycles:uU would not set exclude_host not exclude_guest,
> cycles:u excludes guest user, cycles:U excludes host user, would that be
> possible?
> 
> Anyway, I think that with what we have, your patch makes sense, having a
> way to, without using 'perf kvm' still be able to sample the guest can
> be done on top. of this.
> 
> Xu, can we get your Reviewed-by if this addresses your concerns?
> 
> - Arnaldo
>   

Do you suggest we will create a new modifier 'U' as a follow-up patch?

cycles:u - Count host user space but it doesn't count the guest user space (exclude_host = 0, 
exclude_guest = 1, exclude_kernel = 1, exclude_user = 0, exclude_hv = 1)

cycles:U - Count the guest user space but it doesn't count the host user space (exclude_host = 1, 
exclude_guest = 0, exclude_kernel = 1, exclude_user = 0, exclude_hv = 1)

Is above understanding correct?

Thanks
Jin Yao
