Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80C7C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FACB24658
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgANNYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:24:42 -0500
Received: from mga05.intel.com ([192.55.52.43]:12803 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbgANNYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:24:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 05:24:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,432,1571727600"; 
   d="scan'208";a="372577525"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 14 Jan 2020 05:24:41 -0800
Received: from [10.125.249.138] (rsudarik-mobl.ccr.corp.intel.com [10.125.249.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 400BF5802B0;
        Tue, 14 Jan 2020 05:24:38 -0800 (PST)
Subject: Re: [PATCH v3 1/2] perf x86: Infrastructure for exposing an Uncore
 unit to PMON mapping
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        bgregg@netflix.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        alexander.antonov@intel.com
References: <20200113135444.12027-1-roman.sudarikov@linux.intel.com>
 <20200113135444.12027-2-roman.sudarikov@linux.intel.com>
 <20200113143430.GA390411@kroah.com>
From:   "Sudarikov, Roman" <roman.sudarikov@linux.intel.com>
Message-ID: <9bfcc058-8fde-9b24-3d82-255004e7f057@linux.intel.com>
Date:   Tue, 14 Jan 2020 16:24:34 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200113143430.GA390411@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.01.2020 17:34, Greg KH wrote:
> On Mon, Jan 13, 2020 at 04:54:43PM +0300, roman.sudarikov@linux.intel.com wrote:
>> From: Roman Sudarikov <roman.sudarikov@linux.intel.com>
>>
>> Intel® Xeon® Scalable processor family (code name Skylake-SP) makes
>> significant changes in the integrated I/O (IIO) architecture. The new
>> solution introduces IIO stacks which are responsible for managing traffic
>> between the PCIe domain and the Mesh domain. Each IIO stack has its own
>> PMON block and can handle either DMI port, x16 PCIe root port, MCP-Link
>> or various built-in accelerators. IIO PMON blocks allow concurrent
>> monitoring of I/O flows up to 4 x4 bifurcation within each IIO stack.
>>
>> Software is supposed to program required perf counters within each IIO
>> stack and gather performance data. The tricky thing here is that IIO PMON
>> reports data per IIO stack but users have no idea what IIO stacks are -
>> they only know devices which are connected to the platform.
>>
>> Understanding IIO stack concept to find which IIO stack that particular
>> IO device is connected to, or to identify an IIO PMON block to program
>> for monitoring specific IIO stack assumes a lot of implicit knowledge
>> about given Intel server platform architecture.
>>
>> Usage example:
>>      /sys/devices/uncore_<type>_<pmu_idx>/platform_mapping
>>
>> Each Uncore unit type, by its nature, can be mapped to its own context,
>> for example:
>> 1. CHA - each uncore_cha_<pmu_idx> is assigned to manage a distinct slice
>>     of LLC capacity;
>> 2. UPI - each uncore_upi_<pmu_idx> is assigned to manage one link of Intel
>>     UPI Subsystem;
>> 3. IIO - each uncore_iio_<pmu_idx> is assigned to manage one stack of the
>>     IIO module;
>> 4. IMC - each uncore_imc_<pmu_idx> is assigned to manage one channel of
>>     Memory Controller.
>>
>> Implementation details:
>> Two callbacks added to struct intel_uncore_type to discover and map Uncore
>> units to PMONs:
>>      int (*get_topology)(void)
>>      int (*set_mapping)(struct intel_uncore_pmu *pmu)
>>
>> Details of IIO Uncore unit mapping to IIO PMON:
>> Each IIO stack is either DMI port, x16 PCIe root port, MCP-Link or various
>> built-in accelerators. For Uncore IIO Unit type, the platform_mapping file
>> holds bus numbers of devices, which can be monitored by that IIO PMON block
>> on each die.
>>
>> Co-developed-by: Alexander Antonov <alexander.antonov@intel.com>
>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>> Signed-off-by: Alexander Antonov <alexander.antonov@intel.com>
>> Signed-off-by: Roman Sudarikov <roman.sudarikov@linux.intel.com>
>> ---
>>   arch/x86/events/intel/uncore.c | 37 +++++++++++++++++++++++++++++++++-
>>   arch/x86/events/intel/uncore.h |  9 ++++++++-
>>   2 files changed, 44 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
>> index 86467f85c383..2c53ad44b51f 100644
>> --- a/arch/x86/events/intel/uncore.c
>> +++ b/arch/x86/events/intel/uncore.c
>> @@ -905,6 +905,32 @@ static void uncore_types_exit(struct intel_uncore_type **types)
>>   		uncore_type_exit(*types);
>>   }
>>   
>> +static struct attribute *empty_attrs[] = {
>> +	NULL,
>> +};
>> +
>> +static const struct attribute_group empty_group = {
>> +	.attrs = empty_attrs,
>> +};
> What is this for?  Why is it needed?  It doesn't do anything?
>
>> +
>> +static ssize_t platform_mapping_show(struct device *dev,
>> +				struct device_attribute *attr, char *buf)
>> +{
>> +	struct intel_uncore_pmu *pmu = dev_get_drvdata(dev);
>> +
>> +	return snprintf(buf, PAGE_SIZE - 1, "%s\n", pmu->mapping);
>> +}
>> +static DEVICE_ATTR_RO(platform_mapping);
> You are creating new sysfs attributes without any Documentation/ABI
> updates, which is not ok.  Please fix this up for your next round of
> patches.
>
>> +static struct attribute *mapping_attrs[] = {
>> +	&dev_attr_platform_mapping.attr,
>> +	NULL,
>> +};
>> +
>> +static const struct attribute_group uncore_mapping_group = {
>> +	.attrs = mapping_attrs,
>> +};
> ATTRIBUTE_GROUPS()?
>
> Messing around with single attribute_group lists is usually a sign that
> something is really wrong as the driver core should handle arrays of
> attribute group lists instead.
>
>
>> +
>>   static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
>>   {
>>   	struct intel_uncore_pmu *pmus;
>> @@ -950,10 +976,19 @@ static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
>>   			attr_group->attrs[j] = &type->event_descs[j].attr.attr;
>>   
>>   		type->events_group = &attr_group->group;
>> -	}
>> +	} else
>> +		type->events_group = &empty_group;
> Why???
Hi Greg,

Technically, what I'm trying to do is to add an attribute which depends on
the uncore pmu type and BIOS support. New attribute is added to the end of
the attribute groups array. It appears that the events attribute group is
optional for most of the uncore pmus for x86/intel, i.e. events_group = 
NULL.

NULL element in the middle of the attribute groups array "hides" all others
attribute groups which follows that element.

To work around it, embedded NULL elements should be either removed from
the attribute groups array [1] or replaced with empty attribute; see 
implementation above.

If both approaches are incorrect then please advice what would be correct
solution for that case.

[1] 
https://lore.kernel.org/lkml/20191210091451.6054-3-roman.sudarikov@linux.intel.com/

Thanks,
Roman
> Didn't we fix up the x86 attributes to work properly and not mess around
> with trying to merge groups and the like?  Please don't perpetuate that
> more...
>
> thanks,
>
> greg k-h


