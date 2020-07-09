Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FORGED_MUA_MOZILLA,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B62C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEED52065D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgGIN2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:28:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:64525 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbgGIN2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 09:28:15 -0400
IronPort-SDR: k9RpCPMVYpOyPf5yfgokqH/ZHqXV9LTovVgr17raHSiZP4mD+VGsJVGvlATqbnf35G8aEEriCw
 Ek15ZpJqNCfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="146077737"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="146077737"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 06:28:15 -0700
Message-Id: <537a4c$cobr4j@orsmga004-auth.jf.intel.com>
IronPort-SDR: lbGftqsvxRyXOACOGBHSm1In1Skp/KaIfrSFiKY6OurNhCBCCg5UvS81aWet1lIxbq8nWff6dl
 iJLteg35tBRA==
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="428207258"
Received: from paulmurp-mobl.ger.corp.intel.com (HELO [192.168.153.164]) ([10.213.225.132])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 06:28:12 -0700
Subject: Re: [PATCH 2/7] mailbox: keembay-scmi-mailbox: Add support for Keem
 Bay mailbox
To:     Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Paul Murphy <paul.j.murphy@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20200616155613.121242-1-daniele.alessandrelli@linux.intel.com>
 <20200616155613.121242-3-daniele.alessandrelli@linux.intel.com>
 <20200708203428.GB31671@bogus>
 <491f994c6f87a542e49fe37c8a75ab46f1b3712b.camel@linux.intel.com>
From:   Paul Murphy <paul.j.murphy@linux.intel.com>
Date:   Thu, 9 Jul 2020 14:28:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <491f994c6f87a542e49fe37c8a75ab46f1b3712b.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/9/20 13:23, Daniele Alessandrelli wrote:
> Hi Sudeep,
>
> Thanks for your review.
>
> On Wed, 2020-07-08 at 21:34 +0100, Sudeep Holla wrote:
>> On Tue, Jun 16, 2020 at 04:56:08PM +0100, Daniele Alessandrelli
>> wrote:
>>> From: Paul Murphy <paul.j.murphy@intel.com>
>>>
>>> Keem Bay SoC has a ARM trusted firmware-based secure monitor which
>>> acts
>>> as the SCP for the purposes of power management over SCMI.
>>>
>>> This driver implements the transport layer for SCMI to function.
>>>
>> Please use the smc transport support in
>> driver/firmware/arm_scmi/smc.c
>> for this. You don't need mailbox support for SMC/HVC. Basically you
>> don't need this driver at all and you have everything you need to
>> support
>> what you want.
>>
>> Let me know if you face issues.
>>
> Sorry, we didn't know about the SMC transport support for SCMI. Looks
> like it was added only recently, while our driver was already developed
> and waiting to be upstreamed.
>
> I agree that we can drop this driver and switch to the SMC transport as
> you suggested, but I think we'll have to modify our bootloader SiP
> service slightly. Paul, can you elaborate?
>

Just one question.

In our patch, we pass the shared memory address as the second argument 
of the SiP service, as it means we don't have to hardcode that in our 
firmware. Sudeep, do you know if it was intentional in 
smc_send_message() to leave that out? If we leave it out, we are 
requiring the secure monitor to hardcode the shared memory address.


Regards,
Paul

