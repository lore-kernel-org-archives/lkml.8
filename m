Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB30DC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 12:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43162168B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 12:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbgBMMgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 07:36:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:46217 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729511AbgBMMgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 07:36:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 04:36:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,436,1574150400"; 
   d="scan'208";a="281514566"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Feb 2020 04:36:52 -0800
Received: from [10.125.249.105] (rsudarik-mobl.ccr.corp.intel.com [10.125.249.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 2AF045802C1;
        Thu, 13 Feb 2020 04:36:47 -0800 (PST)
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v5_3/3=5d_perf_x86=3a_Exposing_an_Uncore_u?=
 =?UTF-8?Q?nit_to_PMON_for_Intel_Xeon=c2=ae_server_platform?=
To:     Greg KH <gregkh@linuxfoundation.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>
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
 <323e0892-d34f-a812-4d9a-e7a4bf71afd2@linux.intel.com>
 <20200212225603.GA2489060@kroah.com>
From:   "Sudarikov, Roman" <roman.sudarikov@linux.intel.com>
Message-ID: <79a042c8-b508-a33b-fe69-1c19fc579161@linux.intel.com>
Date:   Thu, 13 Feb 2020 15:36:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200212225603.GA2489060@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.2020 1:56, Greg KH wrote:
> On Wed, Feb 12, 2020 at 03:58:50PM -0500, Liang, Kan wrote:
>>
>> On 2/12/2020 12:31 PM, Sudarikov, Roman wrote:
>>> On 11.02.2020 23:14, Greg KH wrote:
>>>> On Tue, Feb 11, 2020 at 02:59:21PM -0500, Liang, Kan wrote:
>>>>> On 2/11/2020 1:57 PM, Greg KH wrote:
>>>>>> On Tue, Feb 11, 2020 at 10:42:00AM -0800, Andi Kleen wrote:
>>>>>>> On Tue, Feb 11, 2020 at 09:15:44AM -0800, Greg KH wrote:
>>>>>>>> On Tue, Feb 11, 2020 at 07:15:49PM +0300,
>>>>>>>> roman.sudarikov@linux.intel.com wrote:
>>>>>>>>> +static ssize_t skx_iio_mapping_show(struct device *dev,
>>>>>>>>> +                struct device_attribute *attr, char *buf)
>>>>>>>>> +{
>>>>>>>>> +    struct pmu *pmu = dev_get_drvdata(dev);
>>>>>>>>> +    struct intel_uncore_pmu *uncore_pmu =
>>>>>>>>> +        container_of(pmu, struct intel_uncore_pmu, pmu);
>>>>>>>>> +
>>>>>>>>> +    struct dev_ext_attribute *ea =
>>>>>>>>> +        container_of(attr, struct dev_ext_attribute, attr);
>>>>>>>>> +    long die = (long)ea->var;
>>>>>>>>> +
>>>>>>>>> +    return sprintf(buf, "0000:%02x\n",
>>>>>>>>> skx_iio_stack(uncore_pmu, die));
>>>>>>>> If "0000:" is always the "prefix" of the output of
>>>>>>>> this file, why have
>>>>>>>> it at all as you always know it is there?
>>>>> I think Roman only test with BIOS configured as single-segment. So he
>>>>> hard-code the segment# here.
>>>>>
>>>>> I'm not sure if Roman can do some test with multiple-segment
>>>>> BIOS. If not, I
>>>>> think we should at least print a warning here.
>>>>>
>>>>>>>> What is ever going to cause that to change?
>>>>>>> I think it's just to make it a complete PCI address.
>>>>>> Is that what this really is?  If so, it's not a "complete" pci address,
>>>>>> is it?  If it is, use the real pci address please.
>>>>> I think we don't need a complete PCI address here. The attr is
>>>>> to disclose
>>>>> the mapping information between die and PCI BUS. Segment:BUS
>>>>> should be good
>>>>> enough.
>>>> "good enough" for today, but note that you can not change the format of
>>>> the data in the file in the future, you would have to create a new file.
>>>> So I suggest at least try to future-proof it as much as possible if you
>>>> _know_ this could change.
>>>>
>>>> Just use the full pci address, there's no reason not to, otherwise it's
>>>> just confusing.
>>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>> Hi Greg,
>>>
>>> Yes, the "Segment:Bus" pair is enough to distinguish between different
>>> Root ports.
>> I think Greg suggests us to use full PCI address here.
>>
>> Hi Greg,
>>
>> There may be several devices are connected to IIO stack. There is no full
>> PCI address for IIO stack.
> Please define "full" for me.  Please please don't tell me you are just
> using a truncated version of the PCI address.  I thought we got rid of
> all of that nonsense 10 years ago...
>
>> I don't think we can list all of devices in the same IIO stack with full PCI
>> address here either. It's not necessary, and only increase maintenance
>> overhead.
> Then what exactly _IS_ this number, if not the PCI address?
>
> Something made up to look almost like a PCI address, but not quite?
> Somethine else?
>
>> I think we may have two options here.
>>
>> Option 1: Roman's proposal.The format of the file is "Segment:Bus". For the
>> future I can see, the format doesn't need to be changed.
>>      E.g. $ls /sys/devices/uncore_<type>_<pmu_idx>/die0
>>           $0000:7f
> Again, fake PCI address?
Hi Greg,

Actually, there are two reasons why we've chosen the "Segment:Root Bus" 
notion to
represent Root port to IO PMU mapping:
1. it meets feature requirements to uniquely identify each Root Port on 
the system
2. that notion - "Segment:Root Bus" - is already used by the kernel to 
represent
Root ports is sysfs; see commit 37d6a0a6f4700 and example below taken for
Intel Xeon V5 (Skylake Server):

# ls /sys/devices/ | grep pci
pci0000:00
pci0000:17
pci0000:3a
pci0000:5d
pci0000:80
pci0000:85
pci0000:ae
pci0000:d7

Having full conventional PCI address in the form of 
"Segment:Bus:Device.Function"
is just not required to distinguish one Root Bus from the other.
But if there is any other agreement regarding the way how PCI Root ports are
supposed to show up in the sysfs then please let us know.

Thanks,
Roman
>> Option 2: Use full PCI address, but use -1 to indicate invalid address.
>>      E.g. $ls /sys/devices/uncore_<type>_<pmu_idx>/die0
>>           $0000:7f:-1:-1
> "Invalid"?  Why?  Why not just refer to the 0:0 device, as that's the
> bus "root" address (or whatever it's called, I can't remember PCI stuff
> all that well...)
>
>> Should we use the format in option 2?
> What could userspace do with a -1 -1 address?
>
> thanks,
>
> greg k-h


