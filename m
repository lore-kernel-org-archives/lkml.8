Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA8DC352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDF4246A9
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgBLU6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:58:55 -0500
Received: from mga17.intel.com ([192.55.52.151]:21066 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727420AbgBLU6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:58:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 12:58:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,434,1574150400"; 
   d="scan'208";a="252040035"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 12 Feb 2020 12:58:53 -0800
Received: from [10.251.28.99] (kliang2-mobl.ccr.corp.intel.com [10.251.28.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 646F45803DA;
        Wed, 12 Feb 2020 12:58:52 -0800 (PST)
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v5_3/3=5d_perf_x86=3a_Exposing_an_Uncore_u?=
 =?UTF-8?Q?nit_to_PMON_for_Intel_Xeon=c2=ae_server_platform?=
To:     "Sudarikov, Roman" <roman.sudarikov@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, bgregg@netflix.com, alexander.antonov@intel.com
References: <20200211161549.19828-1-roman.sudarikov@linux.intel.com>
 <20200211161549.19828-4-roman.sudarikov@linux.intel.com>
 <20200211171544.GA1933705@kroah.com>
 <20200211184200.GA302770@tassilo.jf.intel.com>
 <20200211185759.GA1941673@kroah.com>
 <25dca8dd-c52d-676d-ffe4-90f3a6ddc915@linux.intel.com>
 <20200211201427.GA1975593@kroah.com>
 <7a697574-aa76-3eda-d504-1ec72bcb6353@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <323e0892-d34f-a812-4d9a-e7a4bf71afd2@linux.intel.com>
Date:   Wed, 12 Feb 2020 15:58:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <7a697574-aa76-3eda-d504-1ec72bcb6353@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/12/2020 12:31 PM, Sudarikov, Roman wrote:
> On 11.02.2020 23:14, Greg KH wrote:
>> On Tue, Feb 11, 2020 at 02:59:21PM -0500, Liang, Kan wrote:
>>>
>>> On 2/11/2020 1:57 PM, Greg KH wrote:
>>>> On Tue, Feb 11, 2020 at 10:42:00AM -0800, Andi Kleen wrote:
>>>>> On Tue, Feb 11, 2020 at 09:15:44AM -0800, Greg KH wrote:
>>>>>> On Tue, Feb 11, 2020 at 07:15:49PM +0300, 
>>>>>> roman.sudarikov@linux.intel.com wrote:
>>>>>>> +static ssize_t skx_iio_mapping_show(struct device *dev,
>>>>>>> +                struct device_attribute *attr, char *buf)
>>>>>>> +{
>>>>>>> +    struct pmu *pmu = dev_get_drvdata(dev);
>>>>>>> +    struct intel_uncore_pmu *uncore_pmu =
>>>>>>> +        container_of(pmu, struct intel_uncore_pmu, pmu);
>>>>>>> +
>>>>>>> +    struct dev_ext_attribute *ea =
>>>>>>> +        container_of(attr, struct dev_ext_attribute, attr);
>>>>>>> +    long die = (long)ea->var;
>>>>>>> +
>>>>>>> +    return sprintf(buf, "0000:%02x\n", skx_iio_stack(uncore_pmu, 
>>>>>>> die));
>>>>>> If "0000:" is always the "prefix" of the output of this file, why 
>>>>>> have
>>>>>> it at all as you always know it is there?
>>>
>>> I think Roman only test with BIOS configured as single-segment. So he
>>> hard-code the segment# here.
>>>
>>> I'm not sure if Roman can do some test with multiple-segment BIOS. If 
>>> not, I
>>> think we should at least print a warning here.
>>>
>>>>>> What is ever going to cause that to change?
>>>>> I think it's just to make it a complete PCI address.
>>>> Is that what this really is?  If so, it's not a "complete" pci address,
>>>> is it?  If it is, use the real pci address please.
>>> I think we don't need a complete PCI address here. The attr is to 
>>> disclose
>>> the mapping information between die and PCI BUS. Segment:BUS should 
>>> be good
>>> enough.
>> "good enough" for today, but note that you can not change the format of
>> the data in the file in the future, you would have to create a new file.
>> So I suggest at least try to future-proof it as much as possible if you
>> _know_ this could change.
>>
>> Just use the full pci address, there's no reason not to, otherwise it's
>> just confusing.
>>
>> thanks,
>>
>> greg k-h
> Hi Greg,
> 
> Yes, the "Segment:Bus" pair is enough to distinguish between different 
> Root ports.

I think Greg suggests us to use full PCI address here.

Hi Greg,

There may be several devices are connected to IIO stack. There is no 
full PCI address for IIO stack.
I don't think we can list all of devices in the same IIO stack with full 
PCI address here either. It's not necessary, and only increase 
maintenance overhead.

I think we may have two options here.

Option 1: Roman's proposal.The format of the file is "Segment:Bus". For 
the future I can see, the format doesn't need to be changed.
     E.g. $ls /sys/devices/uncore_<type>_<pmu_idx>/die0
          $0000:7f

Option 2: Use full PCI address, but use -1 to indicate invalid address.
     E.g. $ls /sys/devices/uncore_<type>_<pmu_idx>/die0
          $0000:7f:-1:-1

Should we use the format in option 2?

Thanks,
Kan


> Please see the changes below which are to address all previous comments.
> 
> Thanks,
> Roman
> 
> diff --git a/arch/x86/events/intel/uncore_snbep.c 
> b/arch/x86/events/intel/uncore_snbep.c
> index 96fca1ac22a4..f805fbdbbe81 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -3616,15 +3616,22 @@ skx_iio_mapping_visible(struct kobject *kobj, 
> struct attribute *attr, int die)
>   static ssize_t skx_iio_mapping_show(struct device *dev,
>                   struct device_attribute *attr, char *buf)
>   {
> +    struct pci_bus *bus = NULL;
>       struct pmu *pmu = dev_get_drvdata(dev);
>       struct intel_uncore_pmu *uncore_pmu =
>           container_of(pmu, struct intel_uncore_pmu, pmu);
> +    int pmu_idx = uncore_pmu->pmu_idx;
> 
>       struct dev_ext_attribute *ea =
>           container_of(attr, struct dev_ext_attribute, attr);
>       long die = (long)ea->var;
> 
> -    return sprintf(buf, "0000:%02x\n", skx_iio_stack(uncore_pmu, die));
> +    do {
> +        bus = pci_find_next_bus(bus);
> +    } while (pmu_idx--);
> +
> +    return sprintf(buf, "%04x:%02x\n", pci_domain_nr(bus),
> +                       skx_iio_stack(uncore_pmu, die));
>   }
> 
>   static int skx_msr_cpu_bus_read(int cpu, u64 *topology)
> @@ -3691,10 +3698,7 @@ static int skx_iio_get_topology(struct 
> intel_uncore_type *type)
>       return 0;
>   }
> 
> -static struct attribute *uncore_empry_attr;
> -
>   static struct attribute_group skx_iio_mapping_group = {
> -    .attrs        = &uncore_empry_attr,
>       .is_visible    = skx_iio_mapping_visible,
>   };
> 
> @@ -3729,7 +3733,8 @@ static int skx_iio_set_mapping(struct 
> intel_uncore_type *type)
>           return -ENOMEM;
>       }
>       for (die = 0; die < uncore_max_dies(); die++) {
> -        sprintf(buf, "node%ld", die);
> +        sprintf(buf, "die%ld", die);
> +        sysfs_attr_init(&eas[die].attr.attr);
>           eas[die].attr.attr.name = kstrdup(buf, GFP_KERNEL);
>           if (!eas[die].attr.attr.name) {
>               ret = -ENOMEM;
> @@ -3752,6 +3757,7 @@ static int skx_iio_set_mapping(struct 
> intel_uncore_type *type)
>       kfree(eas);
>       kfree(attrs);
>       kfree(type->topology);
> +    type->attr_update = NULL;
> 
>       return ret;
>   }
