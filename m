Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DD8C4BA09
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 03:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C6821744
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 03:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbgBZDEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 22:04:07 -0500
Received: from mga07.intel.com ([134.134.136.100]:56379 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727880AbgBZDEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 22:04:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 19:04:06 -0800
X-IronPort-AV: E=Sophos;i="5.70,486,1574150400"; 
   d="scan'208";a="231248041"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.238.4.82]) ([10.238.4.82])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 25 Feb 2020 19:04:05 -0800
Subject: Re: [PATCH] KVM: x86: Adjust counter sample period after a wrmsr
To:     Eric Hankland <ehankland@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <20200222023413.78202-1-ehankland@google.com>
 <9adcb973-7b60-71dd-636d-1e451e664c55@redhat.com>
 <0c66eae3-8983-0632-6d39-fd335620b76a@linux.intel.com>
 <CAOyeoRX8kXD4nHGCLk=pV2EHS4t9wykV5tYDfgKkTLBcN5=GGw@mail.gmail.com>
From:   Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <8b48666a-c6a8-6dce-d784-424f5c447576@linux.intel.com>
Date:   Wed, 26 Feb 2020 11:04:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAOyeoRX8kXD4nHGCLk=pV2EHS4t9wykV5tYDfgKkTLBcN5=GGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/2/25 8:08, Eric Hankland wrote:
> Hi Like -
> 
> Thanks for the feedback - is your recommendation to do the read and
> period change at the same time and only take the lock once or is there
> another way around this while still handling writes correctly?

For non-running counters(the most common situation), we have too many
chances to reflect their new periods. In this case, calling
perf_event_period() in the trap of counter msr is redundant and burdensome.

A better way is to check if this counter is running via
pmc_speculative_in_use (), and if so,
just trigger kvm_make_request(KVM_REQ_PMU, pmc->vcpu).

Thanks,
Like Xu

> 
> Eric
> 

