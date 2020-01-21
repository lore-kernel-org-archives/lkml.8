Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BD8C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E978217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbgAUQQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:16:05 -0500
Received: from mga18.intel.com ([134.134.136.126]:19468 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728829AbgAUQQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:16:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 08:16:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,346,1574150400"; 
   d="scan'208";a="374634490"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 21 Jan 2020 08:16:04 -0800
Received: from [10.125.249.87] (rsudarik-mobl.ccr.corp.intel.com [10.125.249.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C80C35803C5;
        Tue, 21 Jan 2020 08:16:00 -0800 (PST)
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v4_2/2=5d_perf_x86=3a_Exposing_an_Uncore_u?=
 =?UTF-8?Q?nit_to_PMON_for_Intel_Xeon=c2=ae_server_platform?=
To:     Greg KH <gregkh@linuxfoundation.org>,
        Andi Kleen <ak@linux.intel.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        bgregg@netflix.com, kan.liang@linux.intel.com,
        alexander.antonov@intel.com
References: <20200117133759.5729-1-roman.sudarikov@linux.intel.com>
 <20200117133759.5729-3-roman.sudarikov@linux.intel.com>
 <20200117141944.GC1856891@kroah.com>
 <20200117162357.GK302770@tassilo.jf.intel.com>
 <20200117165406.GA1937954@kroah.com>
From:   "Sudarikov, Roman" <roman.sudarikov@linux.intel.com>
Message-ID: <f62a14a4-4fea-84f7-4cab-8bef74cf9e8a@linux.intel.com>
Date:   Tue, 21 Jan 2020 19:15:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200117165406.GA1937954@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.01.2020 19:54, Greg KH wrote:
> On Fri, Jan 17, 2020 at 08:23:57AM -0800, Andi Kleen wrote:
>>> I thought I was nice and gentle last time and said that this was a
>>> really bad idea and you would fix it up.  That didn't happen, so I am
>>> being explicit here, THIS IS NOT AN ACCEPTABLE FILE OUTPUT FOR A SYSFS
>>> FILE.
>> Could you suggest how such a 1:N mapping should be expressed instead in
>> sysfs?
> I have yet to figure out what it is you all are trying to express here
> given a lack of Documentation/ABI/ file :)
>
> But again, sysfs is ONE VALUE PER FILE.  You have a list of items here,
> that is bounded only by the number of devices in the system at the
> moment.  That number will go up in time, as we all know.  So this is
> just not going to work at all as-is.
>
> greg k-h

Hi Greg,

Technically, the motivation behind this patch is to enable Linux perf tool
to attribute IO traffic to IO device.

Currently, perf tool provides interface to configure IO PMUs only 
without any
context.

Understanding IIO stack concept to find which IIO stack that particular
IO device is connected to, or to identify an IIO PMON block to program
for monitoring specific IIO stack assumes a lot of implicit knowledge
about given Intel server platform architecture.


Please consider the following mapping schema:

1. new "mapping" directory is to be added under each uncore_iio_N directory
2. that "mapping" directory is supposed to contain symlinks named "dieN"
which are pointed to corresponding root bus.
Below is how it looks like for 2S machine:

# ll uncore_iio_0/mapping/
lrwxrwxrwx 1 root root 0 Jan 20 23:55 die0 -> 
../../pci0000:00/pci_bus/0000:00
lrwxrwxrwx 1 root root 0 Jan 20 23:55 die1 -> 
../../pci0000:80/pci_bus/0000:80

# ll uncore_iio_1/mapping/
lrwxrwxrwx 1 root root 0 Jan 20 23:55 die0 -> 
../../pci0000:17/pci_bus/0000:17
lrwxrwxrwx 1 root root 0 Jan 20 23:55 die1 -> 
../../pci0000:85/pci_bus/0000:85

# ll uncore_iio_2/mapping/
lrwxrwxrwx 1 root root 0 Jan 20 23:55 die0 -> 
../../pci0000:3a/pci_bus/0000:3a
lrwxrwxrwx 1 root root 0 Jan 20 23:55 die1 -> 
../../pci0000:ae/pci_bus/0000:ae

# ll uncore_iio_3/mapping/
lrwxrwxrwx 1 root root 0 Jan 20 23:55 die0 -> 
../../pci0000:5d/pci_bus/0000:5d
lrwxrwxrwx 1 root root 0 Jan 20 23:55 die1 -> 
../../pci0000:d7/pci_bus/0000:d7


Thanks,
Roman

