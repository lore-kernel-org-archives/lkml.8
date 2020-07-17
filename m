Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FD8C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 238B420717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgGQOAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:00:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:3715 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgGQOAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:00:21 -0400
IronPort-SDR: GnzOEVjkuiEQXiUQqjrgnYwZqa3R0ryCx064clUnyv2IBy8kLq0L00DH6bF49OopUm/AkTtYyR
 qOvfVrb7i0+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="150967788"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="150967788"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 07:00:21 -0700
IronPort-SDR: i/FAwqn6mQcDVNwTNQo1ZPyUsFNo8bNK44NhJq0QPcmArDfLo44GHNN1eyDzDF3mOD1+xMqsbt
 WU1VhRCMoepQ==
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="430846386"
Received: from paulmurp-mobl.ger.corp.intel.com (HELO [192.168.153.165]) ([10.213.219.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 07:00:18 -0700
Subject: Re: [PATCH] firmware: arm_scmi: Pass shmem address to SMCCC call
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Peng Fan <peng.fan@nxp.com>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        linux-kernel@vger.kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>
References: <20200715165518.57558-1-daniele.alessandrelli@linux.intel.com>
 <5f74221b-aec7-7715-19d1-5cbb406f1bdc@gmail.com>
 <b4d22e4a5154a9ad4c224eb2dfaeb61ed1680834.camel@linux.intel.com>
 <faa53c11-3c72-9b9b-85ad-9d234f373b4d@gmail.com>
From:   Paul Murphy <paul.j.murphy@linux.intel.com>
Message-ID: <1117fc3b-3c35-c66c-bf73-cb879a08bde5@linux.intel.com>
Date:   Fri, 17 Jul 2020 15:00:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <faa53c11-3c72-9b9b-85ad-9d234f373b4d@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian


On 7/16/20 20:57, Florian Fainelli wrote:

>>>
>>> Given that the kernel must somehow reserve this memory as a shared
>>> memory area for obvious reasons, and the trusted firmware must also
>>> ensure it treats this memory region with specific permissions in its
>>> translation regime, does it really make sense to give that much
>>> flexibility?
>>
>> Well, the trusted firmware might reserve a bigger region to be used for
>> other service as well. In other words, the MMU of TF-A is not necessary
>> specifically set up for this region, but, possibly, for a bigger
>> general shared region.
> 
> But presumably the Linux shared memory area should be mapped in a
> slightly different way than
> 


Sorry - could you clarify what you mean by that?

Just checking if we are doing everything correctly.

I didn't understand that there is a connection between the TF-A MMU 
tables for this region and the normal world MMU tables?

For example:

TF-A may map physical address range: 0x0 -> 0x400_000 as 'normal' memory 
for various purposes.

Linux SCMI driver could map physical address range, eg: 0x300_000 -> 
0x301_000 as IO memory for mailbox purpose only.

Is there any issue here?

Regards,

Paul
