Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73106C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47381214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgA1Oze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:55:34 -0500
Received: from mga01.intel.com ([192.55.52.88]:1148 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgA1Oze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:55:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2020 06:55:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,374,1574150400"; 
   d="scan'208";a="309099261"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 28 Jan 2020 06:55:32 -0800
Received: from [10.125.249.163] (rsudarik-mobl.ccr.corp.intel.com [10.125.249.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id F3D03580277;
        Tue, 28 Jan 2020 06:55:28 -0800 (PST)
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v4_2/2=5d_perf_x86=3a_Exposing_an_Uncore_u?=
 =?UTF-8?Q?nit_to_PMON_for_Intel_Xeon=c2=ae_server_platform?=
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, bgregg@netflix.com, kan.liang@linux.intel.com,
        alexander.antonov@intel.com
References: <20200117133759.5729-1-roman.sudarikov@linux.intel.com>
 <20200117133759.5729-3-roman.sudarikov@linux.intel.com>
 <20200117141944.GC1856891@kroah.com>
 <20200117162357.GK302770@tassilo.jf.intel.com>
 <20200117165406.GA1937954@kroah.com>
 <f62a14a4-4fea-84f7-4cab-8bef74cf9e8a@linux.intel.com>
 <20200121171547.GA632898@kroah.com>
From:   "Sudarikov, Roman" <roman.sudarikov@linux.intel.com>
Message-ID: <db0a1fca-536e-8106-0e7d-fbcca82d7a15@linux.intel.com>
Date:   Tue, 28 Jan 2020 17:55:25 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200121171547.GA632898@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.01.2020 20:15, Greg KH wrote:
> On Tue, Jan 21, 2020 at 07:15:56PM +0300, Sudarikov, Roman wrote:
>> On 17.01.2020 19:54, Greg KH wrote:
>>> On Fri, Jan 17, 2020 at 08:23:57AM -0800, Andi Kleen wrote:
>>>>> I thought I was nice and gentle last time and said that this was a
>>>>> really bad idea and you would fix it up.  That didn't happen, so I am
>>>>> being explicit here, THIS IS NOT AN ACCEPTABLE FILE OUTPUT FOR A SYSFS
>>>>> FILE.
>>>> Could you suggest how such a 1:N mapping should be expressed instead in
>>>> sysfs?
>>> I have yet to figure out what it is you all are trying to express here
>>> given a lack of Documentation/ABI/ file :)
>>>
>>> But again, sysfs is ONE VALUE PER FILE.  You have a list of items here,
>>> that is bounded only by the number of devices in the system at the
>>> moment.  That number will go up in time, as we all know.  So this is
>>> just not going to work at all as-is.
>>>
>>> greg k-h
>> Hi Greg,
>>
>> Technically, the motivation behind this patch is to enable Linux perf tool
>> to attribute IO traffic to IO device.
>>
>> Currently, perf tool provides interface to configure IO PMUs only without
>> any
>> context.
>>
>> Understanding IIO stack concept to find which IIO stack that particular
>> IO device is connected to, or to identify an IIO PMON block to program
>> for monitoring specific IIO stack assumes a lot of implicit knowledge
>> about given Intel server platform architecture.
> Is "IIO" being used here the same way that drivers/iio/ is in the
> kernel, or is this some other term?  If it is the same, why isn't the
> iio developers involved in this?  If it is some other term, please
> always define it and perhaps pick a different name :)
The term "IIO" (Integrated IO) in that context refers to set of PMUs 
which are
responsible for monitoring traffic crossing PCIe domain boundaries. It's 
specific
for Intel Xeon server line and supported by Linux kernel perf tool 
starting v4.9.
So I'm just referring to what's already in the kernel :)
>> Please consider the following mapping schema:
>>
>> 1. new "mapping" directory is to be added under each uncore_iio_N directory
> What is uncore_iio_N?  A struct device?  Or something else?
It's interface to corresponding IIO PMU, should be struct device
>> 2. that "mapping" directory is supposed to contain symlinks named "dieN"
>> which are pointed to corresponding root bus.
>> Below is how it looks like for 2S machine:
>>
>> # ll uncore_iio_0/mapping/
>> lrwxrwxrwx 1 root root 0 Jan 20 23:55 die0 ->
>> ../../pci0000:00/pci_bus/0000:00
> Where did "pci_bus" come from in there?  I don't see under /sys/devices/
> for my pci bridges.
>
>> lrwxrwxrwx 1 root root 0 Jan 20 23:55 die1 ->
>> ../../pci0000:80/pci_bus/0000:80
>>
>> # ll uncore_iio_1/mapping/
>> lrwxrwxrwx 1 root root 0 Jan 20 23:55 die0 ->
>> ../../pci0000:17/pci_bus/0000:17
>> lrwxrwxrwx 1 root root 0 Jan 20 23:55 die1 ->
>> ../../pci0000:85/pci_bus/0000:85
>>
>> # ll uncore_iio_2/mapping/
>> lrwxrwxrwx 1 root root 0 Jan 20 23:55 die0 ->
>> ../../pci0000:3a/pci_bus/0000:3a
>> lrwxrwxrwx 1 root root 0 Jan 20 23:55 die1 ->
>> ../../pci0000:ae/pci_bus/0000:ae
>>
>> # ll uncore_iio_3/mapping/
>> lrwxrwxrwx 1 root root 0 Jan 20 23:55 die0 ->
>> ../../pci0000:5d/pci_bus/0000:5d
>> lrwxrwxrwx 1 root root 0 Jan 20 23:55 die1 ->
>> ../../pci0000:d7/pci_bus/0000:d7
> Why have a subdir here?
Just for convenience. I can put it the same level as other attributes 
(cpumask etc).
Please let me know which layout to choose.
> Anyway, yes, that would make sense, if userspace can actually do
> something with that, can it?
Sure! The linux perf tool will use it to attribute IO traffic to devices.
Initially the feature was sent for review containing both kernel[1] and
user space[2] parts, but later it was decided to finalize kernel part first
and then proceed with user space.

[1] 
https://lore.kernel.org/lkml/20191126163630.17300-2-roman.sudarikov@linux.intel.com/ 

[2] 
https://lore.kernel.org/lkml/20191126163630.17300-5-roman.sudarikov@linux.intel.com/
>
> Also, what tears those symlinks down when you remove those pci devices
> from the system?  Shouldn't you have an entry in the pci device itself
> for this type of thing?  And if so, isn't this really just a "normal"
> class type driver you are writing?  That should handle all of the
> symlinks and stuff for you automatically, right?
The IIO PMUs by design monitors traffic crossing integrated pci root ports.
For each IIO PMU the feature creates symlinks to its  pci root port on 
each node.
Those pci devices, by its nature, can not be "just removed". If the SOC is
designed the way that some integrated root port is not present
then the case will be correctly handled by the feature.
> thanks,
>
> greg k-h


