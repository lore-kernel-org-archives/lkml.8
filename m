Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780C1C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 03:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560752173E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 03:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgCCDh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 22:37:29 -0500
Received: from mga04.intel.com ([192.55.52.120]:27777 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbgCCDh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 22:37:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 19:37:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,509,1574150400"; 
   d="scan'208";a="258229584"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 02 Mar 2020 19:37:27 -0800
Received: from [10.226.38.56] (unknown [10.226.38.56])
        by linux.intel.com (Postfix) with ESMTP id D289B580274;
        Mon,  2 Mar 2020 19:37:24 -0800 (PST)
Subject: Re: [PATCH v5 2/2] clk: intel: Add CGU clock driver for a new SoC
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, mturquette@baylibre.com,
        sboyd@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, qi-ming.wu@intel.com,
        yixin.zhu@linux.intel.com, cheol.yong.kim@intel.com,
        rtanwar <rahul.tanwar@intel.com>
References: <cover.1582096982.git.rahul.tanwar@linux.intel.com>
 <6148b5b25d4a6833f0a72801d569ed97ac6ca55b.1582096982.git.rahul.tanwar@linux.intel.com>
 <e8259928-cb2a-a453-8f2a-1b57c8abdb8c@infradead.org>
 <4fb7a643-cbe1-da82-2629-2dbd0c0d143b@linux.intel.com>
 <20200227100239.GD1224808@smile.fi.intel.com>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <12c16eb0-04aa-79cf-fa76-3f45b8972319@linux.intel.com>
Date:   Tue, 3 Mar 2020 11:37:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200227100239.GD1224808@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/2/2020 6:02 PM, Andy Shevchenko wrote:
> On Thu, Feb 27, 2020 at 03:19:26PM +0800, Tanwar, Rahul wrote:
>> On 19/2/2020 3:59 PM, Randy Dunlap wrote:
>>> On 2/18/20 11:40 PM, Rahul Tanwar wrote:
>>>
>>>> +config CLK_LGM_CGU
>>>> +	depends on (OF && HAS_IOMEM) || COMPILE_TEST
>>> This "depends on" looks problematic to me. I guess we shall see when
>>> all the build bots get to it.
>> At the moment, i am not able to figure out possible problems in this..
> COMPILE_TEST should be accompanied by non-generic dependency.
> There is none.
>
> So, I quite agree with Randy.

I see COMPILE_TEST is mostly ORed with ARCH_xx. How about below?

depends on OF && HAS_IOMEM && (CONFIG_X86 || COMPILE_TEST)

>>>> +	select OF_EARLY_FLATTREE
>>> If OF is not set and HAS_IOMEM is not set, but COMPILE_TEST is set,
>>> I expect that this should not be attempting to select OF_EARLY_FLATTREE.
>>>
>>> Have you tried such a config combination?
>> Agree, that would be a problem. I will change it to
>>
>> select OF_EARLY_FLATTREE if OF
> Nope, I think this is wrong work around.
> See above.

With above proposed change, i can simply switch to
select OF_EARLY_FLATTREE since all dependencies are already
in place..

Thanks.

Regards,
Rahul
