Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2D8C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E43F20575
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgD2PTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:19:10 -0400
Received: from mga11.intel.com ([192.55.52.93]:31671 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgD2PTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:19:10 -0400
IronPort-SDR: dXZmd7RsbMk+XAuBd3eBmiOE2YjQEct2oeM8S0HspfUg8gF8iGL9asErcyNerVCZJA3pSObkK7
 GW2dnbZ/aA9A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 08:19:09 -0700
IronPort-SDR: /yu9CjJYrcqU+eu/Fik6TgZ7B57IWCzt5+Wf3UnCw37D0tOkMr4KGflaUm8HMkCCYfL/IiLMJg
 vg5g5wIIIocg==
X-IronPort-AV: E=Sophos;i="5.73,332,1583222400"; 
   d="scan'208";a="432592548"
Received: from aslawinx-mobl1.ger.corp.intel.com (HELO [10.249.130.47]) ([10.249.130.47])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 08:19:06 -0700
Subject: Re: [PATCH] ASoC: Intel: sst: ipc command timeout
To:     "Lu, Brent" <brent.lu@intel.com>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     Kate Stewart <kstewart@linuxfoundation.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jie Yang <yang.jie@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Richard Fontana <rfontana@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>
References: <1586506705-3194-1-git-send-email-brent.lu@intel.com>
 <4f495cf1-4740-cf3b-196f-cc850c503b43@linux.intel.com>
 <BN6PR1101MB21328B6F4147640D07F9E40A97DA0@BN6PR1101MB2132.namprd11.prod.outlook.com>
 <c8309abf-cbfb-a3db-5aa7-2e2f748a6d34@intel.com>
 <BN6PR1101MB21328C54E66082227B9F497A97D50@BN6PR1101MB2132.namprd11.prod.outlook.com>
 <5e84c48c-a5d1-b2ff-c197-5efa478c5916@linux.intel.com>
 <BN6PR1101MB2132D23B042284DDA667642A97AC0@BN6PR1101MB2132.namprd11.prod.outlook.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Message-ID: <9d003948-a651-9920-86b6-307e912dd8ed@linux.intel.com>
Date:   Wed, 29 Apr 2020 17:19:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <BN6PR1101MB2132D23B042284DDA667642A97AC0@BN6PR1101MB2132.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/28/2020 7:29 PM, Lu, Brent wrote:
>>
>> I've looked at the code and byt_is_dsp_busy seems suspicious to me.
>> Can you check if following change fixes problem for you:(...)
>>
>> We seem to treat SST_IPCX as 32 bit register instead of 64 one, which may
>> explain wrong behaviour. (Specification says it is 64 bit register).
>>
>> Thanks,
>> Amadeusz
> 
> Hi Amadeusz,
> 
> The patch does not work but I managed to create a workaround just for
> reference. Still don't know why first read in sst_byt_irq_thread returns
> incorrect value.
> 

Hi,
yes that seems bit weird. It is bit better as it does not modify common 
code, but still... Maybe going back to your original idea of replacing 
memcpy, try replacing it with readq? It should generate one instruction 
read (although it is only for x64_64, for 32 bit kernel we would still 
need to do something else).

Thanks,
Amadeusz
