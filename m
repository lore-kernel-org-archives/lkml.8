Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B130BC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 08:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C13920BED
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 08:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgH3IQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 04:16:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:59117 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgH3IQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 04:16:20 -0400
IronPort-SDR: AfKBnsnUaJZEVvGUw6ZkCSM7WBpQFuTBV+XRbkczRQ+W6db5XEIIiz+5hC3XBIOcbtYQyO3oVz
 LPvtSiKwMYLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9728"; a="156108637"
X-IronPort-AV: E=Sophos;i="5.76,371,1592895600"; 
   d="scan'208";a="156108637"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2020 01:16:18 -0700
IronPort-SDR: /7T2yQCqaQHMU6kes3LeCqjFI7HAEqYM/TLWHePSQltPZm5X8x7mMM8T/Nd2sSVqmH2bLQfBRK
 URK/+FAYpIpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,371,1592895600"; 
   d="scan'208";a="324560999"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by fmsmga004.fm.intel.com with ESMTP; 30 Aug 2020 01:16:15 -0700
Date:   Sun, 30 Aug 2020 16:16:15 +0800
From:   Shuo A Liu <shuo.a.liu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>, <x86@kernel.org>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH 05/17] virt: acrn: Introduce ACRN HSM basic driver
Message-ID: <20200830081615.GG13723@shuo-intel.sh.intel.com>
References: <20200825024516.16766-1-shuo.a.liu@intel.com>
 <20200825024516.16766-6-shuo.a.liu@intel.com>
 <20200828102559.GA1470435@kroah.com>
 <20200829104612.GD13723@shuo-intel.sh.intel.com>
 <58093008-3072-f9df-5245-f74a82906e47@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58093008-3072-f9df-5245-f74a82906e47@intel.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Sat 29.Aug'20 at  9:12:22 -0700, Dave Hansen wrote:
>On 8/29/20 3:46 AM, Shuo A Liu wrote:
>> On Fri 28.Aug'20 at 12:25:59 +0200, Greg Kroah-Hartman wrote:
>>> On Tue, Aug 25, 2020 at 10:45:05AM +0800, shuo.a.liu@intel.com wrote:
>>>> +static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
>>>> +               unsigned long ioctl_param)
>>>> +{
>>>> +    if (cmd == ACRN_IOCTL_GET_API_VERSION) {
>>>> +        if (copy_to_user((void __user *)ioctl_param,
>>>> +                 &api_version, sizeof(api_version)))
>>>> +            return -EFAULT;
>>>
>>> Why are you versioning your api?  Shouldn't that not be a thing and you
>>> either support an ioctl or you do not?
>>
>> The API version here is more for the hypercalls.
>> The hypercalls might evolve later
>
>They might evolve, but the old ones must always keep working.  Right?

Yes, it's right.

>
>> and the version indicates which set of interfaces (include the
>> paramters' format) should be used by user space tools. Currently,
>> it's used rarely.
>Why do you need this when the core kernel doesn't?  We add syscalls,
>ioctl()s and prctl()s all the time, but nothing is versioned.

Indeed. It looks a bit odd.

>
>This sounds like something you need to remove from the series.

OK. I will remove the api version related code.

Thanks
shuo
