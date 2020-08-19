Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B16C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E8E7207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgHSIpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:45:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:7822 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbgHSIpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:45:46 -0400
IronPort-SDR: U7fEeUATwtMh7EPJwiVjfW8Xj961FazopHEu9OWjlkWaui7AvxNe1fsbPFKPWK9rkDO9TOS6NI
 AGYQbkHBouEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="142702332"
X-IronPort-AV: E=Sophos;i="5.76,330,1592895600"; 
   d="scan'208";a="142702332"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 01:45:45 -0700
IronPort-SDR: VwlrqZny9UVICsFd8YTot7jwS0XBw2G+Ndf0YU4VE3JP4Liy3gbeYp4cs/3+6eIC2iIaCotwX8
 ATtSbG5/L7SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,330,1592895600"; 
   d="scan'208";a="472153295"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 19 Aug 2020 01:45:45 -0700
Received: from [10.226.38.22] (unknown [10.226.38.22])
        by linux.intel.com (Postfix) with ESMTP id B617A5805A1;
        Wed, 19 Aug 2020 01:45:39 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v1 0/9] extcon: extcon-ptn5150: Add the USB external
 connector support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, thomas.langer@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com
References: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200818084044.GD1891694@smile.fi.intel.com>
 <69e13a74-8b8d-cbc0-915d-ce289e7d4a70@linux.intel.com>
 <CAHp75VfwBnDgR6WR_On1nh+dX4meWrX1Q-CiUKqkV39=o2m5Hg@mail.gmail.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <b9187c39-8d94-6b41-9e1c-b95161b17c1c@linux.intel.com>
Date:   Wed, 19 Aug 2020 16:45:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfwBnDgR6WR_On1nh+dX4meWrX1Q-CiUKqkV39=o2m5Hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 19/8/2020 3:55 pm, Andy Shevchenko wrote:
> On Wed, Aug 19, 2020 at 8:38 AM Ramuthevar, Vadivel MuruganX
> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>> On 18/8/2020 4:40 pm, Andy Shevchenko wrote:
>>> On Tue, Aug 18, 2020 at 02:57:18PM +0800, Ramuthevar,Vadivel MuruganX wrote:
>>>> USB external connector chip PTN5150 used on the Intel LGM SoC
>>>> boards to detect the USB type and connection.
>>> Internally I meant you can send cleanups, but couple of patches here are the
>>> features and were still under discussion... But here we are.
>>
>> you mean asking us to implement the Heikki suggested as below..
>>
>> Heikki Krogerus: register the port and the partner attached to it with
>> the USB Type-C connector class in the driver. Is my understaanding
>> right? if not, please explain it. Thanks!
> 
> When you mention somebody, don't forget to Cc them (now done by me).
Sure, Thank you

Regards
Vadivel
> 
