Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E61C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 02:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C717B20737
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 02:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgHZCvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 22:51:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:18781 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbgHZCvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 22:51:45 -0400
IronPort-SDR: AasJpHHOBEj02sbPg1uL/0mUmcNsO43ZsnORI6uwn/7wd2qkGlJ4K1rc0xTov9VOg1rhsTDLRN
 N7mvtO2p1OUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="156217402"
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="156217402"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 19:51:44 -0700
IronPort-SDR: JFM28Ox3Mhd7iGJnJpLzR7hZPTe21FVLR3OZHs8OeVrNdX4IhPyCNvv2M7LU8nSGTsUhaVccqm
 zMTC6AkuFo/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="336704207"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Aug 2020 19:51:43 -0700
Received: from [10.215.173.55] (vramuthx-MOBL1.gar.corp.intel.com [10.215.173.55])
        by linux.intel.com (Postfix) with ESMTP id DF3BD5806F0;
        Tue, 25 Aug 2020 19:51:39 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v1 0/9] extcon: extcon-ptn5150: Add the USB external
 connector support
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, thomas.langer@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com,
        krzk@kernel.org
References: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200818084044.GD1891694@smile.fi.intel.com>
 <69e13a74-8b8d-cbc0-915d-ce289e7d4a70@linux.intel.com>
 <CAHp75VfwBnDgR6WR_On1nh+dX4meWrX1Q-CiUKqkV39=o2m5Hg@mail.gmail.com>
 <b9187c39-8d94-6b41-9e1c-b95161b17c1c@linux.intel.com>
 <20200825081935.GE189773@kuha.fi.intel.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <bc66fcec-fa52-71a3-57d1-514a4d716605@linux.intel.com>
Date:   Wed, 26 Aug 2020 10:51:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825081935.GE189773@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

  Thank you very much for the review comment...

On 25/8/2020 4:19 pm, Heikki Krogerus wrote:
> On Wed, Aug 19, 2020 at 04:45:38PM +0800, Ramuthevar, Vadivel MuruganX wrote:
>> Hi Andy,
>>
>> On 19/8/2020 3:55 pm, Andy Shevchenko wrote:
>>> On Wed, Aug 19, 2020 at 8:38 AM Ramuthevar, Vadivel MuruganX
>>> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>>>> On 18/8/2020 4:40 pm, Andy Shevchenko wrote:
>>>>> On Tue, Aug 18, 2020 at 02:57:18PM +0800, Ramuthevar,Vadivel MuruganX wrote:
>>>>>> USB external connector chip PTN5150 used on the Intel LGM SoC
>>>>>> boards to detect the USB type and connection.
>>>>> Internally I meant you can send cleanups, but couple of patches here are the
>>>>> features and were still under discussion... But here we are.
>>>>
>>>> you mean asking us to implement the Heikki suggested as below..
>>>>
>>>> Heikki Krogerus: register the port and the partner attached to it with
>>>> the USB Type-C connector class in the driver. Is my understaanding
>>>> right? if not, please explain it. Thanks!
>>>
>>> When you mention somebody, don't forget to Cc them (now done by me).
>> Sure, Thank you
> 
> So the patches 1-5 are fine. The rest needs to be rewritten.
Already Krzysztof submitted all the patches and got approved, so we 
started sending only one patch which support to Intel LGM SoC based 
boards, Thanks!

Regards
Vadivel
> 
> thanks,
> 
