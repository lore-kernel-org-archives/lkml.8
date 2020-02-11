Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16BCC35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 19:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52C821739
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 19:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbgBKT7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:59:25 -0500
Received: from mga01.intel.com ([192.55.52.88]:5496 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727955AbgBKT7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 14:59:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 11:59:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="251661231"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 11 Feb 2020 11:59:24 -0800
Received: from [10.251.4.129] (kliang2-mobl.ccr.corp.intel.com [10.251.4.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id BEEB658045B;
        Tue, 11 Feb 2020 11:59:22 -0800 (PST)
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v5_3/3=5d_perf_x86=3a_Exposing_an_Uncore_u?=
 =?UTF-8?Q?nit_to_PMON_for_Intel_Xeon=c2=ae_server_platform?=
To:     Greg KH <gregkh@linuxfoundation.org>,
        Andi Kleen <ak@linux.intel.com>
Cc:     roman.sudarikov@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, bgregg@netflix.com, alexander.antonov@intel.com
References: <20200211161549.19828-1-roman.sudarikov@linux.intel.com>
 <20200211161549.19828-4-roman.sudarikov@linux.intel.com>
 <20200211171544.GA1933705@kroah.com>
 <20200211184200.GA302770@tassilo.jf.intel.com>
 <20200211185759.GA1941673@kroah.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <25dca8dd-c52d-676d-ffe4-90f3a6ddc915@linux.intel.com>
Date:   Tue, 11 Feb 2020 14:59:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200211185759.GA1941673@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/11/2020 1:57 PM, Greg KH wrote:
> On Tue, Feb 11, 2020 at 10:42:00AM -0800, Andi Kleen wrote:
>> On Tue, Feb 11, 2020 at 09:15:44AM -0800, Greg KH wrote:
>>> On Tue, Feb 11, 2020 at 07:15:49PM +0300, roman.sudarikov@linux.intel.com wrote:
>>>> +static ssize_t skx_iio_mapping_show(struct device *dev,
>>>> +				struct device_attribute *attr, char *buf)
>>>> +{
>>>> +	struct pmu *pmu = dev_get_drvdata(dev);
>>>> +	struct intel_uncore_pmu *uncore_pmu =
>>>> +		container_of(pmu, struct intel_uncore_pmu, pmu);
>>>> +
>>>> +	struct dev_ext_attribute *ea =
>>>> +		container_of(attr, struct dev_ext_attribute, attr);
>>>> +	long die = (long)ea->var;
>>>> +
>>>> +	return sprintf(buf, "0000:%02x\n", skx_iio_stack(uncore_pmu, die));
>>>
>>> If "0000:" is always the "prefix" of the output of this file, why have
>>> it at all as you always know it is there?


I think Roman only test with BIOS configured as single-segment. So he 
hard-code the segment# here.

I'm not sure if Roman can do some test with multiple-segment BIOS. If 
not, I think we should at least print a warning here.

>>>
>>> What is ever going to cause that to change?
>>
>> I think it's just to make it a complete PCI address.
> 
> Is that what this really is?  If so, it's not a "complete" pci address,
> is it?  If it is, use the real pci address please.

I think we don't need a complete PCI address here. The attr is to 
disclose the mapping information between die and PCI BUS. Segment:BUS 
should be good enough.

Thanks,
Kan

> 
>> In theory it might be different on a complex multi node system with
>> custom interconnect and multiple PCI segments, but that would need code
>> changes too.
>>
>> This version of the patchkit only supports standard SKX systems
>> at this point.
> 
> I have no idea what that means, please translate for non-Intel people :)
> 
> greg k-h
> 
