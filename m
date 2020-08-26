Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7708AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 440D92071E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgHZJoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:44:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:7118 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727966AbgHZJoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:44:04 -0400
IronPort-SDR: fHNI1x86HHg5VFhBnykO1lmci23NnDwPlyQRN75IACm9qhk1mtYOMBGeZZGTlyrjxxmWnFdIVZ
 YihvwFOEsqJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="241077830"
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="241077830"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 02:44:02 -0700
IronPort-SDR: DOnpTo82H4i3lUdnK3n4/6Z4zPsQbHI5NFLS4J0/6zZ8cCSFdaSC/IoU/8MDlP2Hefztge5XKV
 Ib2sq3omInjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="331722811"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 26 Aug 2020 02:44:02 -0700
Received: from [10.215.173.55] (vramuthx-MOBL1.gar.corp.intel.com [10.215.173.55])
        by linux.intel.com (Postfix) with ESMTP id A5BC05805EE;
        Wed, 26 Aug 2020 02:43:56 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v1 0/9] extcon: extcon-ptn5150: Add the USB external
 connector support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
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
 <bc66fcec-fa52-71a3-57d1-514a4d716605@linux.intel.com>
 <20200826091804.GF1891694@smile.fi.intel.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <fe112ace-659b-0e7e-fd6f-e34987fc17ed@linux.intel.com>
Date:   Wed, 26 Aug 2020 17:43:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826091804.GF1891694@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 26/8/2020 5:18 pm, Andy Shevchenko wrote:
> On Wed, Aug 26, 2020 at 10:51:37AM +0800, Ramuthevar, Vadivel MuruganX wrote:
>> On 25/8/2020 4:19 pm, Heikki Krogerus wrote:
>>> On Wed, Aug 19, 2020 at 04:45:38PM +0800, Ramuthevar, Vadivel MuruganX wrote:
>>>> On 19/8/2020 3:55 pm, Andy Shevchenko wrote:
>>>>> On Wed, Aug 19, 2020 at 8:38 AM Ramuthevar, Vadivel MuruganX
>>>>> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>>>>>> On 18/8/2020 4:40 pm, Andy Shevchenko wrote:
>>>>>>> On Tue, Aug 18, 2020 at 02:57:18PM +0800, Ramuthevar,Vadivel MuruganX wrote:
>>>>>>>> USB external connector chip PTN5150 used on the Intel LGM SoC
>>>>>>>> boards to detect the USB type and connection.
>>>>>>> Internally I meant you can send cleanups, but couple of patches here are the
>>>>>>> features and were still under discussion... But here we are.
>>>>>>
>>>>>> you mean asking us to implement the Heikki suggested as below..
>>>>>>
>>>>>> Heikki Krogerus: register the port and the partner attached to it with
>>>>>> the USB Type-C connector class in the driver. Is my understaanding
>>>>>> right? if not, please explain it. Thanks!
>>>>>
>>>>> When you mention somebody, don't forget to Cc them (now done by me).
>>>> Sure, Thank you
>>>
>>> So the patches 1-5 are fine. The rest needs to be rewritten.
>> Already Krzysztof submitted all the patches and got approved, so we started
>> sending only one patch which support to Intel LGM SoC based boards, Thanks!
> 
> I'm not sure what you meant by above.
> 
> Krzysztof suggested you to squash all first patches into 1 (or two) and he
> approves it. What you have to do is follow his advise and send v2 where it will
> be one (or two) patch with his tag attached.
Yes, you're right, the above discussion was before Krzysztof reviewed my 
patches, sure will follow his advise, thanks!

Regards
Vadivel
> 
> Krzysztof, is it correct what I'm saying?
> 
