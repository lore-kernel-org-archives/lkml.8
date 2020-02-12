Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1D2C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 16:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF372082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 16:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgBLQDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 11:03:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:17620 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgBLQDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 11:03:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 08:03:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,433,1574150400"; 
   d="scan'208";a="313442360"
Received: from gmoralez-mobl.amr.corp.intel.com (HELO [10.252.135.232]) ([10.252.135.232])
  by orsmga001.jf.intel.com with ESMTP; 12 Feb 2020 08:03:41 -0800
Subject: Re: [alsa-devel] [PATCH] ASoC: da7219: check SRM lock in trigger
 callback
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        "Sridharan, Ranjani" <ranjani.sridharan@intel.com>
Cc:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chiang, Mac" <mac.chiang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        "Lu, Brent" <brent.lu@intel.com>,
        "cychiang@google.com" <cychiang@google.com>
References: <1581322611-25695-1-git-send-email-brent.lu@intel.com>
 <AM6PR10MB2263F302A86B17C95B16361280190@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
 <SN6PR11MB26702B2E7E5F705425517F4897180@SN6PR11MB2670.namprd11.prod.outlook.com>
 <855c88fb-4438-aefb-ac9b-a9a5a2dc8caa@linux.intel.com>
 <CAFQqKeWHDyyd_YBBaD6P2sCL5OCNEsiUU6B7eUwtiLv8GZU0yg@mail.gmail.com>
 <2eeca7fe-aec9-c680-5d61-930de18b952b@linux.intel.com>
 <CAFQqKeXK3OG7KXaHGUuC75sxWrdf11xJooC7XsDCOyd6KUgPTQ@mail.gmail.com>
 <c9dbcdd8-b943-94a6-581f-7bbebe8c6d25@linux.intel.com>
 <AM6PR10MB22630C79D08CE74878A6A096801B0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <043c8384-6ce2-c78e-f52c-6a37a4bab3a0@linux.intel.com>
Date:   Wed, 12 Feb 2020 09:48:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <AM6PR10MB22630C79D08CE74878A6A096801B0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Thanks Ranjani. That information closes the door on the idea of playing
>> with the trigger order suggested earlier in the thread, so my guess is
>> that we really need to expose the MCLK/BCLK with the clk API and turn
>> them on/off from the machine driver as needed. I hope is that we don't
>> need the FSYNC as well, that would be rather painful to implement.
> 
> Am not going to make myself popular here. It's MCLK and FSYNC (or WCLK as it's
> termed for our device) that is required for SRM to lock in the PLL.
> 
> So far I've not found a way in the codec driver to be able to get around this.
> I spent a very long time with Sathya in the early days (Apollo Lake) looking at
> options but nothing would fit which is why I have the solution that's in place
> right now. We could probably reduce the number of rechecks before timeout in the
> driver but that's really just papering over the crack and there's still the
> possibility of noise later when SRM finally does lock.

Sorry, you lost me at "the solution that's in place right now". There is 
nothing in the bxt_da7219_max98357a.c code that deals with clocks or 
defines a trigger order?
