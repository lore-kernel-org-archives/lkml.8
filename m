Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1507C4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 07:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82BFD2072D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 07:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgB0HTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 02:19:31 -0500
Received: from mga12.intel.com ([192.55.52.136]:22237 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726999AbgB0HTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 02:19:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 23:19:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,491,1574150400"; 
   d="scan'208";a="238310161"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 26 Feb 2020 23:19:30 -0800
Received: from [10.226.38.56] (unknown [10.226.38.56])
        by linux.intel.com (Postfix) with ESMTP id 50F62580544;
        Wed, 26 Feb 2020 23:19:27 -0800 (PST)
Subject: Re: [PATCH v5 2/2] clk: intel: Add CGU clock driver for a new SoC
To:     Randy Dunlap <rdunlap@infradead.org>, mturquette@baylibre.com,
        sboyd@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, qi-ming.wu@intel.com,
        yixin.zhu@linux.intel.com, cheol.yong.kim@intel.com,
        rtanwar <rahul.tanwar@intel.com>
References: <cover.1582096982.git.rahul.tanwar@linux.intel.com>
 <6148b5b25d4a6833f0a72801d569ed97ac6ca55b.1582096982.git.rahul.tanwar@linux.intel.com>
 <e8259928-cb2a-a453-8f2a-1b57c8abdb8c@infradead.org>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <4fb7a643-cbe1-da82-2629-2dbd0c0d143b@linux.intel.com>
Date:   Thu, 27 Feb 2020 15:19:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <e8259928-cb2a-a453-8f2a-1b57c8abdb8c@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Randy,

On 19/2/2020 3:59 PM, Randy Dunlap wrote:
> On 2/18/20 11:40 PM, Rahul Tanwar wrote:
>> From: rtanwar <rahul.tanwar@intel.com>
>>
>> Clock Generation Unit(CGU) is a new clock controller IP of a forthcoming
>> Intel network processor SoC named Lightning Mountain(LGM). It provides
>> programming interfaces to control & configure all CPU & peripheral clocks.
>> Add common clock framework based clock controller driver for CGU.
>>
>> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
>> ---
>>  drivers/clk/Kconfig           |   1 +
>>  drivers/clk/x86/Kconfig       |   8 +
>>  drivers/clk/x86/Makefile      |   1 +
>>  drivers/clk/x86/clk-cgu-pll.c | 156 +++++++++++
>>  drivers/clk/x86/clk-cgu.c     | 636 ++++++++++++++++++++++++++++++++++++++++++
>>  drivers/clk/x86/clk-cgu.h     | 335 ++++++++++++++++++++++
>>  drivers/clk/x86/clk-lgm.c     | 492 ++++++++++++++++++++++++++++++++
>>  7 files changed, 1629 insertions(+)
>>  create mode 100644 drivers/clk/x86/Kconfig
>>  create mode 100644 drivers/clk/x86/clk-cgu-pll.c
>>  create mode 100644 drivers/clk/x86/clk-cgu.c
>>  create mode 100644 drivers/clk/x86/clk-cgu.h
>>  create mode 100644 drivers/clk/x86/clk-lgm.c
>>
>> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
>> index bcb257baed06..43dab257e7aa 100644
>> --- a/drivers/clk/Kconfig
>> +++ b/drivers/clk/Kconfig
>> @@ -360,6 +360,7 @@ source "drivers/clk/sunxi-ng/Kconfig"
>>  source "drivers/clk/tegra/Kconfig"
>>  source "drivers/clk/ti/Kconfig"
>>  source "drivers/clk/uniphier/Kconfig"
>> +source "drivers/clk/x86/Kconfig"
>>  source "drivers/clk/zynqmp/Kconfig"
>>  
>>  endmenu
> Hi,
>
>> diff --git a/drivers/clk/x86/Kconfig b/drivers/clk/x86/Kconfig
>> new file mode 100644
>> index 000000000000..2e2b9730541f
>> --- /dev/null
>> +++ b/drivers/clk/x86/Kconfig
>> @@ -0,0 +1,8 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +config CLK_LGM_CGU
>> +	depends on (OF && HAS_IOMEM) || COMPILE_TEST
> This "depends on" looks problematic to me. I guess we shall see when
> all the build bots get to it.

At the moment, i am not able to figure out possible problems in this..

>> +	select OF_EARLY_FLATTREE
> If OF is not set and HAS_IOMEM is not set, but COMPILE_TEST is set,
> I expect that this should not be attempting to select OF_EARLY_FLATTREE.
>
> Have you tried such a config combination?

Agree, that would be a problem. I will change it to

select OF_EARLY_FLATTREE if OF

Thanks.

Regards,
Rahul
