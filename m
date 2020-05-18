Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7C3C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AA8620756
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgERWqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 18:46:08 -0400
Received: from mga04.intel.com ([192.55.52.120]:10098 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728509AbgERWqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 18:46:05 -0400
IronPort-SDR: 5ibcpdW13Ve3t7Lswf56Y6eK2eYzwvhpTI+3BB3NDI2D8EsZT1sAVQdOmnyn8VTOsXXkbXD4pp
 pF91CFadSf/A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 15:46:05 -0700
IronPort-SDR: IDYwSVOlT5S23dmNw1M99e1YyXeqXA8zE5/yY7fxNfCTQPDFTYDbJ0efLMNNm04Vf2TruXVfu8
 RytQoxmIIRHg==
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="465751564"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.254.66.2]) ([10.254.66.2])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 15:46:04 -0700
Subject: Re: [PATCH V4 1/4] x86/resctrl: Enable user to view and select thread
 throttling mode
To:     Babu Moger <babu.moger@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>
Cc:     "kuo-lang.tseng@intel.com" <kuo-lang.tseng@intel.com>,
        "ravi.v.shankar@intel.com" <ravi.v.shankar@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1589652468.git.reinette.chatre@intel.com>
 <667e48a36924c1710f6f2dd0116d388170721528.1589652468.git.reinette.chatre@intel.com>
 <d3e9d73b-332e-45c2-5823-8427d11c1f9c@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <e279c3e0-f8f2-25ae-d54c-facd5b33d5d4@intel.com>
Date:   Mon, 18 May 2020 15:46:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <d3e9d73b-332e-45c2-5823-8427d11c1f9c@amd.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 5/18/2020 10:28 AM, Babu Moger wrote:
> Hi Reinette,
>  Looks good most part. Few minor comments.

Thank you very much for taking a look.

> 
>> -----Original Message-----
>> From: Reinette Chatre <reinette.chatre@intel.com>
>> Sent: Saturday, May 16, 2020 1:29 PM
>> To: tglx@linutronix.de; fenghua.yu@intel.com; bp@alien8.de;
>> tony.luck@intel.com
>> Cc: kuo-lang.tseng@intel.com; ravi.v.shankar@intel.com; mingo@redhat.com;
>> Moger, Babu <Babu.Moger@amd.com>; hpa@zytor.com; x86@kernel.org;
>> linux-kernel@vger.kernel.org; Reinette Chatre <reinette.chatre@intel.com>
>> Subject: [PATCH V4 1/4] x86/resctrl: Enable user to view and select thread
>> throttling mode
>>

...

>> +static void mba_cfg_reconfigure_throttle_mode(struct rdt_resource *r)
>> +{
>> +	if (!r->alloc_capable)
>> +		return;
>> +
>> +	if (r == &rdt_resources_all[RDT_RESOURCE_MBA] &&
>> +	    r->membw.arch_throttle_mode == THREAD_THROTTLE_MIN_MAX)
>> +		wrmsrl(MSR_MBA_CFG, mba_cfg_msr);
>> +}
> 
> How about this? It is kind of consistent with other checks that are done.
> 
> If (r->alloc_capable && (r == &rdt_resources_all[RDT_RESOURCE_MBA]) &&
>     (r->membw.arch_throttle_mode == THREAD_THROTTLE_MIN_MAX))
>              wrmsrl(MSR_MBA_CFG, mba_cfg_msr);
> 

Sure. Will do (with fewer parentheses).

>> +
>> +/*
>> + * Model-specific test to determine if platform where memory bandwidth
>> + * control is applied to a core can be configured to apply either the
>> + * maximum or minimum of the per-thread delay values.
>> + * By default, platforms where memory bandwidth control is applied to a
>> + * core will select the maximum delay value of the per-thread CLOS.
>> + *
>> + * NOTE: delay value programmed to hardware is inverse of bandwidth
>> + * percentage configured via user interface.
>> + */
>> +static bool mba_cfg_supports_min_max_intel(void)
>> +{
>> +	switch (boot_cpu_data.x86_model) {
>> +	case INTEL_FAM6_ATOM_TREMONT_D:
>> +	case INTEL_FAM6_ICELAKE_X:
>> +	case INTEL_FAM6_ICELAKE_D:
>> +		return true;
>> +	default:
>> +		return false;
>> +	}
>> +
>> +	return false;
> 
> Is this last return required?  I don't think so.  We will never go here.
> 

Indeed. Thank you for catching this.

Reinette
