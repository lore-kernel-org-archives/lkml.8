Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C14BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 13:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 378F020716
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 13:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgFVNqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 09:46:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:29044 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbgFVNqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 09:46:44 -0400
IronPort-SDR: HYs3+2GAiPT/4NEr4bnG3AqIQJvgTLvCNShPp6j4fvsBf3I0T9ZiF9nevPnOWAD5Sc5M60jXB2
 EW0ttgCqE0Eg==
X-IronPort-AV: E=McAfee;i="6000,8403,9659"; a="145269600"
X-IronPort-AV: E=Sophos;i="5.75,267,1589266800"; 
   d="scan'208";a="145269600"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 06:46:43 -0700
IronPort-SDR: 5BHLR7zv99DGglQd5lQNqfshbMhGKIl4USbYSH9SUj1WCI4rZnAw3UBLJ3uDpLeHjQ4aqDImk0
 ckgYOkyM1ymA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,267,1589266800"; 
   d="scan'208";a="262971329"
Received: from agsoto-mobl.amr.corp.intel.com (HELO [10.251.3.142]) ([10.251.3.142])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jun 2020 06:46:42 -0700
Subject: Re: [PATCH 2/3] ALSA: compress: document the compress gapless audio
 state machine
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>
References: <20200619045449.3966868-1-vkoul@kernel.org>
 <20200619045449.3966868-3-vkoul@kernel.org>
 <5c878ccf-43dd-4e13-aa6b-a6cb1e82af72@linux.intel.com>
 <20200622053441.GE2324254@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <248f7bef-c3d4-2d2e-ffa4-0d372879c8ae@linux.intel.com>
Date:   Mon, 22 Jun 2020 08:22:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622053441.GE2324254@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/22/20 12:34 AM, Vinod Koul wrote:
> On 19-06-20, 09:27, Pierre-Louis Bossart wrote:
>>
>>> +For Gapless, we move from running state to partial drain and back, along
>>> +with setting of meta_data and signalling for next track ::
>>> +
>>> +
>>> +                                        +----------+
>>> +                compr_drain_notify()    |          |
>>> +              +------------------------>|  RUNNING |
>>> +              |                         |          |
>>> +              |                         +----------+
>>> +              |                              |
>>> +              |                              |
>>> +              |                              | compr_next_track()
>>> +              |                              |
>>> +              |                              V
>>> +              |                         +----------+
>>> +              |                         |          |
>>> +              |                         |NEXT_TRACK|
>>> +              |                         |          |
>>> +              |                         +----------+
>>> +              |                              |
>>> +              |                              |
>>> +              |                              | compr_partial_drain()
>>> +              |                              |
>>> +              |                              V
>>> +              |                         +----------+
>>> +              |                         |          |
>>> +              +------------------------ | PARTIAL_ |
>>> +                                        |  DRAIN   |
>>> +                                        +----------+
>>
>> May I suggest having a single state machine, not a big one and an additional
>> partial one. It would help explain why in one case compr_drain_notify()
>> triggers a transition to RUNNING while in the other one it goes to SETUP.
>>
>> I realize it's more complicated to edit but it'd be easier on
>> reviewers/users.
> 
> Ell adding stop and transitions would really make it complicated and
> gapless is a bit different handling and it looks cleaner this way IMO,
> so lets stick to this. Feel free to create one if you are up for it.

if you don't want to change the visuals then please add a paragraph 
explaining the different uses of compr_drain_notify().
