Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5347C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C134E216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgD0S4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 14:56:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:22989 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgD0S4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:56:33 -0400
IronPort-SDR: zlf9d9uYAcSATKoHyYLhhnEoQ1N3h4vEXIIY30uEE/4cv/9Gmr/IJWJm/2WqZys4ogIPJHMRGC
 Wc8hdWEylO9w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 11:56:33 -0700
IronPort-SDR: xS5JlL4vBwEjAeyxOBw1yzPjRI4rbG6eNCk7vvICju1Ms07GnCA27am4N65H/iXU8l9gxoyGGR
 r7Et6egwICCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400"; 
   d="scan'208";a="431879622"
Received: from marshy.an.intel.com (HELO [10.122.105.159]) ([10.122.105.159])
  by orsmga005.jf.intel.com with ESMTP; 27 Apr 2020 11:56:32 -0700
Subject: Re: [PATCH] firmware: stratix10-svc: Drop unnecessary checking for
 and populating /firmware/ node
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org
References: <20200421173256.34897-1-sudeep.holla@arm.com>
 <8ca3666f-8ff1-3c3c-d40b-81c024b37bdd@linux.intel.com>
 <20200423081149.GB18538@bogus>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <2b2e29ec-ebbf-3ee6-acc9-3722a2fabbfb@linux.intel.com>
Date:   Mon, 27 Apr 2020 14:12:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200423081149.GB18538@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

In our dts, firmware is not under root node. You can refer to 
arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi for details.

This is why we need check and populate firmware node.

Regards,
Richard

On 4/23/20 3:11 AM, Sudeep Holla wrote:
> On Wed, Apr 22, 2020 at 04:50:00PM -0500, Richard Gong wrote:
>> Hi Sudeep,
>>
>> I tried and couldn't load stratix10-svc driver with your patch on kernel
>> 5.6.
>>
> 
> What exactly do you mean by not loading stratix10-svc driver ?
> This patch doesn't change that part, the driver should still get loaded.
> The change may affect probing part if for some reason the devices for
> nodes under firmware are not populated which I still can't understand.
> 
> Do you see any change under i/sys/devices/platform/firmware\:* with
> and without this change ?
> 
> Lots of drivers removed the code similar to this patch after the Commit
> 3aa0582fdb82 ("of: platform: populate /firmware/ node from
> of_platform_default_populate_init()") and continue to work fine. I am
> interested to see what is different in stratix10-svc.
> 
> --
> Regards,
> Sudeep
> 
