Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F52C35249
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F992051A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgBEJKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 04:10:25 -0500
Received: from mga12.intel.com ([192.55.52.136]:3362 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbgBEJKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 04:10:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 01:10:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,405,1574150400"; 
   d="scan'208";a="231654014"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 05 Feb 2020 01:10:24 -0800
Received: from [10.226.38.72] (unknown [10.226.38.72])
        by linux.intel.com (Postfix) with ESMTP id 8B76C5805E9;
        Wed,  5 Feb 2020 01:10:21 -0800 (PST)
Subject: Re: [PATCH v4 2/2] dt-bindings: clk: intel: Add bindings document &
 header file for CGU
To:     Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org,
        robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, qi-ming.wu@intel.com,
        yixin.zhu@linux.intel.com, cheol.yong.kim@intel.com
References: <cover.1580374761.git.rahul.tanwar@linux.intel.com>
 <24933f5f1c48a891f9c05c7292117108fc880932.1580374761.git.rahul.tanwar@linux.intel.com>
 <20200131022541.3853C2067C@mail.kernel.org>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <556c2277-885c-f6be-60b3-564187618ca6@linux.intel.com>
Date:   Wed, 5 Feb 2020 17:10:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200131022541.3853C2067C@mail.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Stephen,

Thanks for taking time out to review.

On 31/1/2020 10:25 AM, Stephen Boyd wrote:
> Quoting Rahul Tanwar (2020-01-30 01:04:03)
>> Clock generation unit(CGU) is a clock controller IP of Intel's Lightning
>> Mountain(LGM) SoC. Add DT bindings include file and document for CGU clock
>> controller driver of LGM.
>>
>> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
>> ---
>>
>> +
>> +/* LJPLL4 */
>> +#define LGM_CLK_PCIE           45
>> +#define LGM_CLK_SATA           LGM_CLK_PCIE
> What is with the aliases?

Aliases are just for code readability when more than one peripherals
share the same clock.

Regards,
Rahul


