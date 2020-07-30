Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394F6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 00:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EF982075D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 00:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CjZeOFae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgG3AN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 20:13:28 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:24877 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgG3AN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 20:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1596068007; x=1627604007;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=sI99ASFOpAizx/017vNG8t+8unNbilMwdFtd7ktWwNI=;
  b=CjZeOFaeNhlBHlJUuOFp1qZa7770KIFw2XjNLzf69rfxgH6sEShOo9/1
   TycdtgKKRGidwFxh+xn9Lu0k75r3/EznyTyyR4xnx9Erk5kLXCW4RHEZM
   7M/l0HLSBShbZ43oThXT45HQmXq4chMTt2uPTX0W9h2LWNkbRuS0q+ic2
   c=;
IronPort-SDR: YB+60HzVqX3P8qq7WfcqIW5Cpu+lDqk7BquDe8xVzzb5joWUr+VOxyep7nZ4qTlbXSIGZ7+/F/
 WrTq24b9csMA==
X-IronPort-AV: E=Sophos;i="5.75,412,1589241600"; 
   d="scan'208";a="55915251"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-62350142.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 30 Jul 2020 00:13:18 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-62350142.us-east-1.amazon.com (Postfix) with ESMTPS id 3DB1AA25C4;
        Thu, 30 Jul 2020 00:13:13 +0000 (UTC)
Received: from EX13D01UWA002.ant.amazon.com (10.43.160.74) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 30 Jul 2020 00:13:13 +0000
Received: from f8ffc2228008.ant.amazon.com (10.43.161.203) by
 EX13d01UWA002.ant.amazon.com (10.43.160.74) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 30 Jul 2020 00:13:10 +0000
Subject: Re: [PATCH v2 4/5] prctl: Hook L1D flushing in via prctl
To:     Tom Lendacky <thomas.lendacky@amd.com>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
CC:     <jpoimboe@redhat.com>, <tony.luck@intel.com>,
        <keescook@chromium.org>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        <torvalds@linux-foundation.org>, <mingo@kernel.org>
References: <20200729001103.6450-1-sblbir@amazon.com>
 <20200729001103.6450-5-sblbir@amazon.com>
 <982c1d40-aac1-df0c-c3b7-2699dc0b9b6f@amd.com>
From:   "Singh, Balbir" <sblbir@amazon.com>
Message-ID: <33b99d83-f2de-6984-c3d6-a44960aac828@amazon.com>
Date:   Thu, 30 Jul 2020 10:13:09 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <982c1d40-aac1-df0c-c3b7-2699dc0b9b6f@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.203]
X-ClientProxiedBy: EX13D40UWA003.ant.amazon.com (10.43.160.29) To
 EX13d01UWA002.ant.amazon.com (10.43.160.74)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/7/20 11:14 pm, Tom Lendacky wrote:
> 
> 
> On 7/28/20 7:11 PM, Balbir Singh wrote:
>> Use the existing PR_GET/SET_SPECULATION_CTRL API to expose the L1D
>> flush capability. For L1D flushing PR_SPEC_FORCE_DISABLE and
>> PR_SPEC_DISABLE_NOEXEC are not supported.
>>
>> There is also no seccomp integration for the feature.
>>
>> Signed-off-by: Balbir Singh <sblbir@amazon.com>
>> ---
>>  arch/x86/kernel/cpu/bugs.c | 54 ++++++++++++++++++++++++++++++++++++++
>>  arch/x86/mm/tlb.c          | 25 +++++++++++++++++-
>>  include/uapi/linux/prctl.h |  1 +
>>  3 files changed, 79 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
>> index 0b71970d2d3d..935ea88313ab 100644
>> --- a/arch/x86/kernel/cpu/bugs.c
>> +++ b/arch/x86/kernel/cpu/bugs.c
>> @@ -295,6 +295,13 @@ enum taa_mitigations {
>>       TAA_MITIGATION_TSX_DISABLED,
>>  };
>>
>> +enum l1d_flush_out_mitigations {
>> +     L1D_FLUSH_OUT_OFF,
>> +     L1D_FLUSH_OUT_ON,
>> +};
>> +
>> +static enum l1d_flush_out_mitigations l1d_flush_out_mitigation __ro_after_init = L1D_FLUSH_OUT_ON;
>> +
>>  /* Default mitigation for TAA-affected CPUs */
>>  static enum taa_mitigations taa_mitigation __ro_after_init = TAA_MITIGATION_VERW;
>>  static bool taa_nosmt __ro_after_init;
>> @@ -378,6 +385,18 @@ static void __init taa_select_mitigation(void)
>>       pr_info("%s\n", taa_strings[taa_mitigation]);
>>  }
>>
>> +static int __init l1d_flush_out_parse_cmdline(char *str)
>> +{
>> +     if (!boot_cpu_has_bug(X86_BUG_L1TF))
>> +             return 0;
> 
> Shouldn't this set the l1d_flush_out_mitigation to L1D_FLUSH_OUT_OFF since
> it is set to L1D_FLUSH_OUT_ON by default? Or does it not matter because
> the enable_l1d_flush_for_task() will return -EINVAL if the cpu doesn't
> have the L1TF bug?
>
> I guess it depends on what you want l1d_flush_out_prctl_set() and
> l1d_flush_out_prctl_get() to return in this case.
> 

Exactly! We want to differentiate between force disabled and not applicable.


Thanks for the review,
Balbir Singh.
