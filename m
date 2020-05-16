Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF4AC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 18:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B13C1206D4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 18:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgEPSAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 14:00:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:5480 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbgEPSAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 14:00:34 -0400
IronPort-SDR: uEk/vv/NBozba/i9IPbvOIogg+v83LeHju5sLXJPZqf1kHzQPlBtg146IN2fFWVPn7e+Y8Iw9A
 Hper7QXRQu/w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2020 11:00:33 -0700
IronPort-SDR: 6Ncuwp52H3YV7YOKHf0OgxkPcmlJ3eJS6aXB3h1iYaMgz6a1ArvDp0N4iGx1G6WjE7+mTg0VaQ
 LkbjQEKukkNw==
X-IronPort-AV: E=Sophos;i="5.73,400,1583222400"; 
   d="scan'208";a="465311294"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.251.21.145]) ([10.251.21.145])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2020 11:00:32 -0700
Subject: Re: [PATCH V3 1/4] x86/resctrl: Enable user to view and select thread
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
References: <cover.1588808537.git.reinette.chatre@intel.com>
 <56f9ee29b04599cdf502565dc223a70912a449f6.1588808538.git.reinette.chatre@intel.com>
 <0d1fc0a8-7544-861e-a2f6-42c34ad798d9@amd.com>
 <591cfbf0-fe1d-d96c-9842-79e62e76fbfe@intel.com>
 <18d277fd-6523-319c-d560-66b63ff606b8@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <39416f57-f6be-bffe-8971-d1698003797a@intel.com>
Date:   Sat, 16 May 2020 11:00:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <18d277fd-6523-319c-d560-66b63ff606b8@amd.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 5/14/2020 1:06 PM, Babu Moger wrote:
> 
> 
>> -----Original Message-----
>> From: Reinette Chatre <reinette.chatre@intel.com>
>> Sent: Thursday, May 14, 2020 1:11 PM
>> To: Moger, Babu <Babu.Moger@amd.com>; tglx@linutronix.de;
>> fenghua.yu@intel.com; bp@alien8.de; tony.luck@intel.com
>> Cc: kuo-lang.tseng@intel.com; ravi.v.shankar@intel.com; mingo@redhat.com;
>> hpa@zytor.com; x86@kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH V3 1/4] x86/resctrl: Enable user to view and select thread
>> throttling mode
>>
>> Hi Babu,
>>
>> Thank you very much for taking a look.
>>
>> On 5/14/2020 9:45 AM, Babu Moger wrote:
>>> Hi Reinnette,
>>>
>>> The patches did not apply on my tree. I got the latest tree today. You
>>
>> Which tree did you use as baseline? These patches should apply cleanly
>> on top of the other resctrl patches already queued for inclusion into
>> v5.8 as found on the x86/cache branch of the tip repo.
> 
> Oh. Ok. I was using linux master.  Never mind..

My apologies, I neglected to include the repo to which these patches
apply into the cover letter. Will make sure to do it for next version.


>>>> -----Original Message-----
>>>> From: Reinette Chatre <reinette.chatre@intel.com>
>>>> Sent: Wednesday, May 6, 2020 6:50 PM
>>>> To: tglx@linutronix.de; fenghua.yu@intel.com; bp@alien8.de;
>>>> tony.luck@intel.com
>>>> Cc: kuo-lang.tseng@intel.com; ravi.v.shankar@intel.com;
>> mingo@redhat.com;
>>>> Moger, Babu <Babu.Moger@amd.com>; hpa@zytor.com; x86@kernel.org;
>>>> linux-kernel@vger.kernel.org; Reinette Chatre <reinette.chatre@intel.com>
>>>> Subject: [PATCH V3 1/4] x86/resctrl: Enable user to view and select thread
>>>> throttling mode
>>>>
>>
>> ...
>>

...

>>
>>> make it as a property in rdt_resource. Set it only once during the
>>> init(may be in get_mem_config_intel). Then you can use it wherever
>>> required. This also probably help James to make everything architecture
>>> independent. What do you think?
>>
>> If I understand correctly this would require understanding how each
>> architecture behaves in this regard to ensure the property within
>> rdt_resource is initialized correctly. While it could just be set within
>> get_mem_config_intel as you suggest, this property would be present in
>> AMD's resource and thus need a value ... could you please provide
>> guidance what this property should be on AMD? I looked at the bandwidth
>> enforcement section of
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdevelop
>> er.amd.com%2Fwp-
>> content%2Fresources%2F56375.pdf&amp;data=02%7C01%7Cbabu.moger%40a
>> md.com%7C5e7d546489d54002870808d7f8322934%7C3dd8961fe4884e608e11
>> a82d994e183d%7C0%7C0%7C637250766898923893&amp;sdata=hQ6usFmXiUX
>> p%2BZCrM2qdVn2Z3Ggx1c2g4nVwrEqrzG4%3D&amp;reserved=0 but it is not
>> obvious to me where bandwidth is actually enforced and how this
>> enforcement is affected when threads and/or cores are running tasks with
>> different CLOS that have different bandwidth limits assigned.
>>
>> With AMD's properties understood then the new "thread_throttle_mode"
>> file could be visible on all platforms, not just Intel, and display
>> accurate values for all and be architecture independent.
>>
>> Alternatively, the new property could have values: UNDEFINED, MIN, MAX,
>> or PER_THREAD ... with AMD having UNDEFINED and the
>> "thread_throttle_mode" continues to be visible on Intel platforms only.
>>
>> I would appreciate your thoughts on this.
> 
> Here is the text from spec.
> "Platform QOS features are implemented on a logical processor basis.
> Therefore, multiple hardware threads of a single physical CPU core may
> have independent resource monitoring and enforcement configurations."
> 
> So, bandwidth allocation is already at thread level. But AMD does not use
> memory delay throttle model to control the allocation like Intel does. So,
> I would say you can initialize it as UNDEFINED not to cause any confusion.

Will do. The next version intends to follow your guidance and moves to
treating this platform feature as a property of the memory bandwidth
resource using the "arch_.." prefix that James also follows and is
intended to be architecture independent.

Thank you very much for your valuable feedback. I look forward to hear
what you think about the next version.

Reinette
