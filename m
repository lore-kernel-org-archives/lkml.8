Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07968C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9719206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgBLPPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:15:45 -0500
Received: from mga05.intel.com ([192.55.52.43]:30081 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727458AbgBLPPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:15:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 07:15:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,433,1574150400"; 
   d="scan'208";a="313430830"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 12 Feb 2020 07:15:43 -0800
Received: from [10.251.28.99] (kliang2-mobl.ccr.corp.intel.com [10.251.28.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 0E5075803DA;
        Wed, 12 Feb 2020 07:15:42 -0800 (PST)
Subject: Re: [LKP] Re: [perf x86] b77491648e: will-it-scale.per_process_ops
 -2.1% regression
To:     "Chen, Rong A" <rong.a.chen@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Cc:     Roman Sudarikov <roman.sudarikov@linux.intel.com>,
        0day robot <lkp@intel.com>,
        Alexander Antonov <alexander.antonov@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200205123110.GN12867@shao2-debian>
 <87tv44danp.fsf@linux.intel.com>
 <782f409a-ff90-831c-56a0-abb3c31ab8d8@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <c92cd67f-c2bd-7c5b-7668-7a2d64d2f8c5@linux.intel.com>
Date:   Wed, 12 Feb 2020 10:15:41 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <782f409a-ff90-831c-56a0-abb3c31ab8d8@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/12/2020 5:56 AM, Chen, Rong A wrote:
> 
> 
> On 2/6/2020 4:47 AM, Andi Kleen wrote:
>> kernel test robot <rong.a.chen@intel.com> writes:
>>
>>> Greeting,
>>>
>>> FYI, we noticed a -2.1% regression of will-it-scale.per_process_ops 
>>> due to commit:
>>>
>>>
>>> commit: b77491648e6eb2f26b6edf5eaea859adc17f4dcc ("perf x86: 
>>> Infrastructure for exposing an Uncore unit to PMON mapping")
>>> https://github.com/0day-ci/linux/commits/roman-sudarikov-linux-intel-com/perf-x86-Exposing-IO-stack-to-IO-PMON-mapping-through-sysfs/20200118-075508 
>>>
>> Seems to be spurious bisect. I don't think that commit could change
>> anything performance related.
> 
> Hi Andi,
> 
> I commented out some lines in arch/x86/events/intel/uncore.c and 
> will-it-scale.per_process_ops increased.
> 
> commit:
>    v5.4
>    b77491648e ("perf x86: Infrastructure for exposing an Uncore unit to 
> PMON mapping")
>    f33fe1b258 ("test")
> 
> 
>              v5.4  b77491648e6eb2f26b6edf5eae 
> f33fe1b258b2a4b2fc97600b2b  testcase/testparams/testbox
> ----------------  -------------------------- -------------------------- 
> ---------------------------
>           %stddev      change         %stddev      change %stddev
>               \          |                \          | \
>       47983                       47004 47647 
> will-it-scale/performance-process-100%-signal1-ucode=0xb000038/lkp-bdw-ep6
>       47983                       47004 47647        GEO-MEAN 
> will-it-scale.per_process_ops
> 
> diff --git a/arch/x86/events/intel/uncore.c 
> b/arch/x86/events/intel/uncore.c
> index 55201bfde2c84c..0dc9c455423d99 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -887,7 +887,7 @@ static int uncore_pmu_register(struct 
> intel_uncore_pmu *pmu)
>                  pmu->pmu.attr_groups = pmu->type->attr_groups;
>          }
> 
> -       pmu->pmu.attr_update = attr_update;
> +       // pmu->pmu.attr_update = attr_update;
> 
>          if (pmu->type->num_boxes == 1) {
>                  if (strlen(pmu->type->name) > 0)
> @@ -903,7 +903,7 @@ static int uncore_pmu_register(struct 
> intel_uncore_pmu *pmu)
>           * Exposing mapping of Uncore units to corresponding Uncore PMUs
>           * through /sys/devices/uncore_<type>_<idx>/mapping
>           */
> -       uncore_platform_mapping(pmu->type);
> +       // uncore_platform_mapping(pmu->type);

The patch is for SKX uncore. The test machine looks like a BDX.
So the mapping_group should always be invisible.
The attr_update should not update.
I think there should be no performance impact.

static void uncore_platform_mapping(struct intel_uncore_type *t)
{
	if (t->get_topology && t->set_mapping &&
	    !t->get_topology(t, max_dies) && !t->set_mapping(t, max_dies))
		mapping_group.is_visible = NULL;
	else
		mapping_group.is_visible = not_visible;
}

Kan

> 
>          ret = perf_pmu_register(&pmu->pmu, pmu->name, -1);
>          if (!ret)
> 
> Best Regards,
> Rong Chen
> 
>>
>> -Andi
>> _______________________________________________
>> LKP mailing list -- lkp@lists.01.org
>> To unsubscribe send an email to lkp-leave@lists.01.org
> 
